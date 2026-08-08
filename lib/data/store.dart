import '../state/exam_mode.dart';
import 'content_ielts.dart';
import 'content_toefl.dart';
import 'models.dart';

/// Single accessor that returns the appropriate [ExamContent] for the active
/// exam. Keeps consumer screens free of any TOEFL/IELTS branching logic.
ExamContent contentFor(Exam exam) =>
    exam == Exam.ielts ? ieltsContent : toeflContent;
