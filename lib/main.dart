import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'pages/splash_page.dart';
import 'providers/emergency_provider.dart';
import 'providers/settings_provider.dart';
import 'themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Global Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('❌ Flutter Framework Error: ${details.exception}');
  };

  // Unhandled Dart errors (async, isolates)
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('❌ Unhandled Dart Error: $error');
    debugPrintStack(stackTrace: stack);
    return true;
  };

  // Lock orientation to portrait for better UX in emergencies
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Optional: Transparent status bar for modern UI
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()..init()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => EmergencyProvider()),
      ],
      child: const AidLinkApp(),
    ),
  );
}

class AidLinkApp extends StatelessWidget {
  const AidLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'AidLink',
          debugShowCheckedModeBanner: false,

          // Improves performance by removing glow effect
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: const MaterialScrollBehavior().copyWith(
                overscroll: false,
              ),
              child: child!,
            );
          },

          theme: themeProvider.themeData,
          themeMode: ThemeMode.system,

          themeAnimationCurve: Curves.easeInOut,
          themeAnimationDuration: const Duration(milliseconds: 300),

          home: const SplashPage(),
        );
      },
    );
  }
}
