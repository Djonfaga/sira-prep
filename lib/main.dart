import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: exam),
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider.value(value: user),
      ],
      child: const ToeflSixApp(),
    ),
  );
}
