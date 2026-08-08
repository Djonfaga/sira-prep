import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Exam { toefl, ielts }

extension ExamX on Exam {
  String get label => this == Exam.toefl ? 'TOEFL' : 'IELTS';
  String get fullName => this == Exam.toefl ? 'TOEFL iBT' : 'IELTS Academic';
}

class ExamModeState extends ChangeNotifier {
  ExamModeState(this._prefs);

  final SharedPreferences _prefs;
  static const _key = 'exam_mode';

  Exam _exam = Exam.toefl;
  Exam get exam => _exam;

  void load() {
    final raw = _prefs.getString(_key);
    if (raw == 'ielts') _exam = Exam.ielts;
  }

  void set(Exam next) {
    if (_exam == next) return;
    _exam = next;
    _prefs.setString(_key, next == Exam.ielts ? 'ielts' : 'toefl');
    notifyListeners();
  }

  void toggle() => set(_exam == Exam.toefl ? Exam.ielts : Exam.toefl);
}
