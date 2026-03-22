import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/settings_provider.dart';
import '../themes/theme.dart';
import '../themes/theme_provider.dart';
import '../utils/app_constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsProvider>();
    final themeProv = context.read<ThemeProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // ================= DEVELOPER =================

    void showDeveloperDialog() {
      showModalBottomSheet(
        context: context,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        builder: (_) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 96,
                backgroundImage:
                    AssetImage("assets/images/mohamed_ali_salim.jpg"),
              ),
              const SizedBox(height: 12),
              const Text(
                "Mohamed Ali Salim",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialButton(
                    icon: Icons.facebook_rounded,
                    color: Colors.blue,
                    url:
                        "https://www.facebook.com/profile.php?id=61561233540084",
                  ),
                  const SizedBox(width: 22),
                  _socialButton(
                    icon: Icons.code_rounded,
                    color: Colors.black,
                    url: "https://github.com/mohamedalisalim321/quto",
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.surfaceDark : const Color(0xFFF4F7FB),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const _SectionHeader(title: 'Preferences'),
          const SizedBox(height: 12),
          _SettingsCard(
            children: [
              _ToggleTile(
                icon: Icons.dark_mode_rounded,
                iconColor: const Color(0xFF5C6BC0),
                title: 'Dark Mode',
                subtitle: 'Switch between light and dark theme',
                value: themeProv.isDarkMode,
                onChanged: (value) => themeProv.toggleTheme(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionHeader(title: 'Language'),
          const SizedBox(height: 12),
          _SettingsCard(
            children: [
              _DropdownTile(
                icon: Icons.language_rounded,
                iconColor: AppColors.success,
                title: 'Language',
                value: settings.selectedLanguage,
                options: const ['English'],
                onChanged: settings.setLanguage,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionHeader(title: 'Emergency'),
          const SizedBox(height: 12),
          const _SettingsCard(
            children: [
              _InfoTile(
                icon: Icons.phone_rounded,
                iconColor: AppColors.primary,
                title: 'Emergency Number',
                subtitle: AppConstants.defaultEmergencyNumber,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _SectionHeader(title: 'About'),
          const SizedBox(height: 12),
          _SettingsCard(
            children: [
              const _InfoTile(
                icon: Icons.info_outline_rounded,
                iconColor: AppColors.burns,
                title: 'Version',
                subtitle: AppConstants.appVersion,
              ),
              const _Divider(),
              GestureDetector(
                onTap: showDeveloperDialog,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _IconBox(
                        icon: Icons.person_rounded,
                        color: AppColors.heartAttack,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Developer",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontSize: 16)),
                            const SizedBox(height: 3),
                            Text("See The Developer",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 13,
                                      height: 1.5,
                                    )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const _Divider(),
              const _InfoTile(
                icon: Icons.medical_services_rounded,
                iconColor: AppColors.heartAttack,
                title: AppConstants.appName,
                subtitle: AppConstants.appSubtitle,
              ),
              const _Divider(),
              const _InfoTile(
                icon: Icons.warning_amber_rounded,
                iconColor: AppColors.warning,
                title: 'Disclaimer',
                subtitle:
                    'This app provides general first aid guidance only. Always call emergency services in a real emergency.',
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required Color color,
    required String url,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () async {
        final uri = Uri.parse(url);
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      },
      child: CircleAvatar(
        radius: 22,
        backgroundColor: color.withOpacity(.15),
        child: Icon(icon, color: color),
      ),
    );
  }
}

// ================= Section Header =================
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        fontFamily: 'Nunito',
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
        color: AppColors.textSecondary,
      ),
    );
  }
}

// ================= Card Wrapper =================
class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

// ================= Toggle Tile =================
class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          _IconBox(icon: icon, color: iconColor),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 16)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13,
                        )),
              ],
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

// ================= Dropdown Tile =================
class _DropdownTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const _DropdownTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          _IconBox(icon: icon, color: iconColor),
          const SizedBox(width: 14),
          Expanded(
            child: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 16)),
          ),
          DropdownButton<String>(
            value: value,
            underline: const SizedBox(),
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : AppColors.textPrimary,
            ),
            items: options
                .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                .toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
        ],
      ),
    );
  }
}

// ================= Info Tile =================
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconBox(icon: icon, color: iconColor),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 16)),
                const SizedBox(height: 3),
                Text(subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13,
                          height: 1.5,
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= Icon Box =================
class _IconBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _IconBox({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 22),
    );
  }
}

// ================= Divider =================
class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, indent: 72, endIndent: 16);
  }
}
