import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'state/billing.dart';
import 'state/entitlements.dart';
import 'state/exam_mode.dart';
import 'state/settings_state.dart';
import 'state/user_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // The system bar overlay style is set dynamically inside [ToeflSixApp] so
  // it reacts to the active theme.
  final prefs = await SharedPreferences.getInstance();
  final exam = ExamModeState(prefs)..load();
  final settings = SettingsState(prefs)..load();
  final user = UserState(prefs)..load();
  final entitlements = Entitlements(prefs)..load();

  // Talks to Play in the background. Deliberately not awaited: a slow or
  // missing Play Services must never delay first paint, and the app is fully
  // usable on the free tier while this resolves.
  final billing = BillingService(entitlements: entitlements);
  unawaited(billing.init());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: exam),
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider.value(value: user),
        ChangeNotifierProvider.value(value: entitlements),
        ChangeNotifierProvider.value(value: billing),
      ],
      child: const ToeflSixApp(),
    ),
  );
}
