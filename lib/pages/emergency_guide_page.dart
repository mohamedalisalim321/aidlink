import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/emergency_call_dialog.dart';
import '../components/step_progress_indicator.dart';
import '../models/emergency.dart';
import '../providers/emergency_provider.dart';
import '../providers/settings_provider.dart';
import '../themes/theme.dart';

/// Main Emergency Guide Page - displays step-by-step emergency procedures
class EmergencyGuidePage extends StatefulWidget {
  final Emergency emergency;

  const EmergencyGuidePage({
    super.key,
    required this.emergency,
  });

  @override
  State<EmergencyGuidePage> createState() => _EmergencyGuidePageState();
}

class _EmergencyGuidePageState extends State<EmergencyGuidePage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _fadeController;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final guide = context.read<EmergencyProvider>();
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        guide.stopSpeaking();
        break;
      case AppLifecycleState.resumed:
        if (mounted && context.read<SettingsProvider>().voiceGuidanceEnabled) {
          guide.speakCurrentStep();
        }
        break;
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.inactive:
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initializeEmergency();
      _initialized = true;
    }
  }

  void _initializeEmergency() {
    final emergency = widget.emergency;
    final voiceEnabled = context.read<SettingsProvider>().voiceGuidanceEnabled;

    context.read<EmergencyProvider>().startEmergency(
          emergency: emergency,
          voiceEnabled: voiceEnabled,
        );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _fadeController.dispose();
    context.read<EmergencyProvider>().stopSpeaking();
    super.dispose();
  }

  Color get _emergencyColor {
    final provider = context.read<EmergencyProvider>();
    if (provider.emergency == null) return AppColors.primary;

    try {
      final hex = provider.emergency!.color.replaceFirst('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (e) {
      debugPrint('Error parsing emergency color: $e');
      return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Selector<EmergencyProvider, (Emergency?, int, int, bool)>(
      selector: (_, provider) => (
        provider.emergency,
        provider.currentStepIndex,
        provider.totalSteps,
        provider.isSpeaking,
      ),
      builder: (context, data, _) {
        final emergency = data.$1;
        final currentStepIndex = data.$2;

        if (emergency == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final color = _emergencyColor;
        final bgColor =
            isDark ? AppColors.surfaceDark : const Color(0xFFF5F5F5);

        return WillPopScope(
          onWillPop: () async {
            context.read<EmergencyProvider>().stopSpeaking();
            return true;
          },
          child: Scaffold(
            backgroundColor: bgColor,
            appBar: _buildAppBar(context, emergency, color),
            bottomNavigationBar: _BottomControls(color: color),
            body: SafeArea(
              child: _EmergencyContent(
                emergency: emergency,
                color: color,
                bgColor: bgColor,
                key: ValueKey(currentStepIndex),
              ),
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    Emergency emergency,
    Color color,
  ) {
    return AppBar(
      backgroundColor: color,
      elevation: 0,
      title: Text(
        emergency.title,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          context.read<EmergencyProvider>().stopSpeaking();
          Navigator.pop(context);
        },
      ),
    );
  }
}

/// Animated content section for displaying emergency steps
class _EmergencyContent extends StatelessWidget {
  final Emergency emergency;
  final Color color;
  final Color bgColor;

  const _EmergencyContent({
    required Key key,
    required this.emergency,
    required this.color,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final guide = context.watch<EmergencyProvider>();
    final step = guide.currentStep;

    if (step == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.05, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
      ),
      child: SingleChildScrollView(
        key: ValueKey(guide.currentStepIndex),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress indicator with enhanced styling
            _ProgressSection(color: color, guide: guide),

            const SizedBox(height: 24),

            // Illustration with improved error handling
            _IllustrationSection(
              emergency: emergency,
              step: step,
              color: color,
            ),

            const SizedBox(height: 28),

            // Step title
            _StepTitle(title: step.title, color: color),

            const SizedBox(height: 16),

            // Step description
            _StepDescription(
              description: step.description,
              bgColor: bgColor,
            ),

            const SizedBox(height: 28),

            // Navigation buttons
            _NavigationButtons(color: color, guide: guide),
          ],
        ),
      ),
    );
  }
}

/// Progress section widget
class _ProgressSection extends StatelessWidget {
  final Color color;
  final EmergencyProvider guide;

  const _ProgressSection({
    required this.color,
    required this.guide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withOpacity(0.12),
          width: 1,
        ),
      ),
      child: StepProgressIndicator(
        currentStep: guide.currentStepIndex,
        totalSteps: guide.totalSteps,
        activeColor: color,
      ),
    );
  }
}

/// Illustration section with better error handling and loading states
class _IllustrationSection extends StatelessWidget {
  final Emergency emergency;
  final dynamic step;
  final Color color;

  const _IllustrationSection({
    required this.emergency,
    required this.step,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.15),
              color.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: _ImageWithFallback(
          imagePath:
              'assets/images/emergencies/${emergency.id}/${step.image}.jpeg',
          color: color,
        ),
      ),
    );
  }
}

/// Reusable image with fallback
class _ImageWithFallback extends StatelessWidget {
  final String imagePath;
  final Color color;

  const _ImageWithFallback({
    required this.imagePath,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Failed to load image: $imagePath, Error: $error');
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_not_supported_rounded,
                size: 64,
                color: color.withOpacity(0.4),
              ),
              const SizedBox(height: 8),
              Text(
                'Image not available',
                style: TextStyle(
                  color: color.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Step title widget
class _StepTitle extends StatelessWidget {
  final String title;
  final Color color;

  const _StepTitle({
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w900,
            height: 1.2,
            letterSpacing: 0.3,
          ),
    );
  }
}

/// Step description widget
class _StepDescription extends StatelessWidget {
  final String description;
  final Color bgColor;

  const _StepDescription({
    required this.description,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: SelectableText(
        description,
        style: const TextStyle(
          fontSize: 18,
          height: 1.75,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

/// Navigation buttons section
class _NavigationButtons extends StatelessWidget {
  final Color color;
  final EmergencyProvider guide;

  const _NavigationButtons({
    required this.color,
    required this.guide,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _NavButton(
            onPressed: guide.isFirstStep ? null : guide.previousStep,
            label: '← Previous',
            color: color,
            outline: true,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _NavButton(
            onPressed: guide.isLastStep ? null : guide.nextStep,
            label: 'Next →',
            color: color,
            outline: false,
          ),
        ),
      ],
    );
  }
}

/// Bottom controls bar
class _BottomControls extends StatelessWidget {
  final Color color;

  const _BottomControls({required this.color});

  @override
  Widget build(BuildContext context) {
    final guide = context.watch<EmergencyProvider>();

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              onPressed: guide.toggleReadAloud,
              icon: guide.isSpeaking
                  ? Icons.stop_rounded
                  : Icons.volume_up_rounded,
              label: guide.isSpeaking ? 'Stop' : 'Read Aloud',
              color: color.withOpacity(0.12),
              textColor: color,
              semanticLabel: guide.isSpeaking
                  ? 'Stop reading guide'
                  : 'Start reading guide',
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _ActionButton(
              onPressed: () => EmergencyCallDialog.show(context),
              icon: Icons.phone_rounded,
              label: 'Call Emergency',
              color: AppColors.primary,
              textColor: Colors.white,
              semanticLabel: 'Call emergency services',
            ),
          ),
        ],
      ),
    );
  }
}

/// Navigation button widget
class _NavButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color color;
  final bool outline;

  const _NavButton({
    required this.onPressed,
    required this.label,
    required this.color,
    required this.outline,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;

    if (outline) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide(
            color: disabled ? Colors.grey.withOpacity(0.3) : color,
            width: 2,
          ),
          foregroundColor: disabled ? Colors.grey : color,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w800,
            fontSize: 15,
            letterSpacing: 0.5,
          ),
        ),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 54),
        backgroundColor: disabled ? Colors.grey.shade300 : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w800,
          fontSize: 15,
          letterSpacing: 0.5,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Action button widget
class _ActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;
  final String semanticLabel;

  const _ActionButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
    required this.semanticLabel,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.semanticLabel,
      child: MouseRegion(
        onEnter: (_) => _controller.forward(),
        onExit: (_) => _controller.reverse(),
        child: GestureDetector(
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) => _controller.reverse(),
          onTapCancel: () => _controller.reverse(),
          onTap: widget.onPressed,
          child: ScaleTransition(
            scale: Tween<double>(begin: 1.0, end: 0.95).animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.icon, color: widget.textColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    widget.label,
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      letterSpacing: 0.3,
                      color: widget.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
