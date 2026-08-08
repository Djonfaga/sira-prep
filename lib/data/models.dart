/// Pure data shapes for the practice content. Kept JSON-friendly so we can
/// later move them out of Dart into asset files without touching consumers.

class MCQuestion {
  const MCQuestion({
    required this.question,
    required this.options,
    required this.answer,
    this.explanation,
  });

  final String question;
  final List<String> options;
  final String answer;
  final String? explanation;
}

class Passage {
  const Passage({
    required this.id,
    required this.title,
    required this.body,
    required this.questions,
    this.suggestedMinutes = 18,
  });

  final String id;
  final String title;
  final String body;
  final List<MCQuestion> questions;
  final int suggestedMinutes;
}

class Lecture {
  const Lecture({
    required this.id,
    required this.title,
    required this.transcript,
    required this.questions,
  });

  final String id;
  final String title;
  final String transcript;
  final List<MCQuestion> questions;
}

class SpeakingTask {
  const SpeakingTask({
    required this.id,
    required this.type,
    required this.prompt,
    this.reading,
    this.transcript,
    this.prepSeconds = 15,
    this.speakSeconds = 45,
  });

  final String id;
  final String type;
  final String prompt;
  final String? reading;
  final String? transcript;
  final int prepSeconds;
  final int speakSeconds;
}

class WritingTask {
  const WritingTask({
    required this.id,
    required this.type,
    required this.prompt,
    this.reading,
    this.transcript,
    this.discussionPosts = const [],
    this.minutes = 10,
  });

  final String id;
  final String type;
  final String prompt;
  final String? reading;
  final String? transcript;
  final List<DiscussionPost> discussionPosts;
  final int minutes;
}

class DiscussionPost {
  const DiscussionPost({required this.name, required this.text});
  final String name;
  final String text;
}

class VocabCard {
  const VocabCard({
    required this.word,
    required this.answer,
    required this.options,
    this.partOfSpeech,
    this.definition,
    this.example,
  });
  final String word;
  final String answer;
  final List<String> options;

  /// Optional WordUp-style fields. Defaults are derived at the UI layer so
  /// existing data (just word/answer/options) still renders.
  final String? partOfSpeech;
  final String? definition;
  final String? example;
}

class GrammarItem {
  const GrammarItem({
    required this.rule,
    required this.question,
    required this.options,
    required this.answer,
    required this.explanation,
  });

  /// Short tag — used to group accuracy by rule, e.g. "Inversion".
  final String rule;
  final String question;
  final List<String> options;
  final String answer;
  final String explanation;
}

class MockExam {
  const MockExam({
    required this.id,
    required this.title,
    required this.theme,
    required this.minutes,
    required this.sections,
  });

  final String id;
  final String title;
  final String theme; // e.g. "Climate Adaptation"
  final int minutes;
  final List<MockSection> sections;
}

class MockSection {
  const MockSection({
    required this.module,
    required this.minutes,
    this.itemCount = 1,
  });
  final String module; // 'Reading' | 'Listening' | 'Writing' | 'Speaking'
  final int minutes;

  /// How many items from the content list this section plays through.
  /// TOEFL Reading = 2 passages, TOEFL Listening = 5 (3 lectures + 2 convos),
  /// IELTS Reading = 3, IELTS Listening = 4, etc. The mock player iterates
  /// through `itemCount` items before moving to the next section.
  final int itemCount;
}

class ExamContent {
  const ExamContent({
    required this.reading,
    required this.listening,
    required this.speaking,
    required this.writing,
    required this.vocab,
    required this.mocks,
    this.grammar = const [],
  });

  final List<Passage> reading;
  final List<Lecture> listening;
  final List<SpeakingTask> speaking;
  final List<WritingTask> writing;
  final List<VocabCard> vocab;
  final List<MockExam> mocks;
  final List<GrammarItem> grammar;
}
