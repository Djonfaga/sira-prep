import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/onboarding_screen.dart';
import 'screens/shell.dart';
import 'state/settings_state.dart';
import 'state/user_state.dart';
import 'theme/app_theme.dart';

class ToeflSixApp extends StatelessWidget {
  const ToeflSixApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsState>();
    final user = context.watch<UserState>();

    return MaterialApp(
      title: 'TOEFLsix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: settings.themeMode,
      locale: settings.locale,
      builder: (context, child) {
        // System status / navigation bar must react to the active theme so the
        // light-mode toggle actually changes the OS chrome too.
        final brightness = Theme.of(context).brightness;
        final isDark = brightness == Brightness.dark;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
            statusBarBrightness: brightness,
            systemNavigationBarColor: context.c.bg,
            systemNavigationBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
            systemNavigationBarDividerColor: Colors.transparent,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: user.onboarded ? const AppShell() : const OnboardingScreen(),
    );
  }
}
