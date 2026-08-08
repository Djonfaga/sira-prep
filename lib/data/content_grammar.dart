import 'models.dart';

/// Shared grammar drills covering the academic structures both TOEFL and IELTS
/// reward heavily. Grouped by [rule] so the player can later report per-rule
/// accuracy. Items deliberately span subjunctive, inversion, conditionals,
/// articles, parallelism, subject-verb agreement, and complex sentence types.
const List<GrammarItem> sharedGrammar = [
  GrammarItem(
    rule: 'Subjunctive',
    question: 'It is essential that every student ______ their ID card.',
    options: ['carries', 'carry', 'carrying', 'to carry'],
    answer: 'carry',
    explanation:
        '"It is essential that…" triggers the subjunctive — base form of the verb regardless of subject.',
  ),
  GrammarItem(
    rule: 'Subjunctive',
    question: 'The committee insisted that the report ______ revised.',
    options: ['was', 'is', 'be', 'were'],
    answer: 'be',
    explanation:
        '"Insist that" + subjunctive uses the base form ("be"), not the indicative "was".',
  ),
  GrammarItem(
    rule: 'Inversion',
    question: 'Scarcely had the game started ______ it began to rain.',
    options: ['than', 'when', 'then', 'after'],
    answer: 'when',
    explanation:
        'The fixed pattern is "Scarcely… when" (parallel to "No sooner… than").',
  ),
  GrammarItem(
    rule: 'Inversion',
    question:
        '______ such a complete data set been available, the conclusion would have been different.',
    options: ['Had', 'If', 'Were', 'Should'],
    answer: 'Had',
    explanation:
        'Third-conditional inversion drops "if" and fronts the auxiliary: "Had X happened, Y would have…".',
  ),
  GrammarItem(
    rule: 'Conditional',
    question: 'Had I known about the traffic, I ______ earlier.',
    options: ['would leave', 'will have left', 'would have left', 'left'],
    answer: 'would have left',
    explanation:
        'Third conditional (past unreal): inverted "Had I known" + "would have + past participle".',
  ),
  GrammarItem(
    rule: 'Conditional',
    question:
        'If the policy ______ adopted ten years earlier, emissions would already be lower today.',
    options: ['had been', 'were', 'was', 'is'],
    answer: 'had been',
    explanation:
        'Mixed conditional: past unreal condition ("had been") with present result ("would already be").',
  ),
  GrammarItem(
    rule: 'Subject–verb agreement',
    question: 'Neither the supervisor nor the employees ______ aware of the new policy.',
    options: ['was', 'were', 'is', 'be'],
    answer: 'were',
    explanation:
        'With "neither/nor" the verb agrees with the closer subject — here, the plural "employees".',
  ),
  GrammarItem(
    rule: 'Subject–verb agreement',
    question: 'The data ______ confirmed by multiple independent studies.',
    options: ['was', 'were', 'has been', 'is'],
    answer: 'were',
    explanation:
        'In academic English, "data" is typically treated as the plural of "datum", taking "were".',
  ),
  GrammarItem(
    rule: 'Parallelism',
    question:
        'The professor recommended reading the article, writing notes, and ______ a discussion question.',
    options: ['to prepare', 'preparing', 'prepare', 'prepared'],
    answer: 'preparing',
    explanation:
        'Parallel structure: "reading… writing… preparing" — keep the same -ing form across the list.',
  ),
  GrammarItem(
    rule: 'Parallelism',
    question:
        'She is interested not only in the policy itself but also ______ its long-term effects.',
    options: ['in', 'on', 'with', 'about'],
    answer: 'in',
    explanation:
        '"Not only X but also Y" requires X and Y to be parallel — same preposition on both sides.',
  ),
  GrammarItem(
    rule: 'Articles',
    question:
        'The committee published ______ report on water quality last week; it was widely cited.',
    options: ['a', 'an', 'the', '—'],
    answer: 'a',
    explanation:
        '"A report" introduces a new (indefinite) noun. "The" would assume the reader already knows which report.',
  ),
  GrammarItem(
    rule: 'Articles',
    question:
        '______ best way to learn a language is to use it daily.',
    options: ['A', 'An', 'The', '—'],
    answer: 'The',
    explanation:
        '"Best" is a superlative — it pins down a single thing, so "the" is required.',
  ),
  GrammarItem(
    rule: 'Verb tense',
    question: 'By the time the professor arrived, the students ______ for thirty minutes.',
    options: ['waited', 'were waiting', 'had been waiting', 'have been waiting'],
    answer: 'had been waiting',
    explanation:
        'Past perfect continuous: action ongoing right up to another past moment.',
  ),
  GrammarItem(
    rule: 'Verb tense',
    question:
        'The findings ______ since 2018 in a series of peer-reviewed journals.',
    options: ['have appeared', 'appeared', 'are appearing', 'had appeared'],
    answer: 'have appeared',
    explanation:
        'Present perfect signals a span from past to now — use "have appeared", not the simple past.',
  ),
  GrammarItem(
    rule: 'Concession',
    question:
        '______ the risks, the team decided to proceed with the project.',
    options: ['Despite', 'Although', 'In spite', 'Even though'],
    answer: 'Despite',
    explanation:
        '"Despite" is a preposition + noun phrase ("the risks"). "Although" would need a full clause.',
  ),
  GrammarItem(
    rule: 'Comparison',
    question: 'The more you practice, ______ you will become.',
    options: ['the more confident', 'more confident', 'the most confident', 'confidently'],
    answer: 'the more confident',
    explanation:
        'Double comparative: "The [more/-er], the [more/-er]" — both halves use "the".',
  ),
  GrammarItem(
    rule: 'Relative clauses',
    question:
        'The researchers, ______ findings have been widely cited, presented at the conference.',
    options: ['who', 'whom', 'whose', 'which'],
    answer: 'whose',
    explanation:
        'Possessive relative pronoun: "whose findings" replaces "their findings".',
  ),
  GrammarItem(
    rule: 'Relative clauses',
    question:
        'This is the lab ______ they conducted the breakthrough experiment.',
    options: ['where', 'which', 'that', 'whose'],
    answer: 'where',
    explanation:
        'Relative adverb of place — "where" replaces "in which" inside a location clause.',
  ),
  GrammarItem(
    rule: 'Modals',
    question:
        'The witness ______ have left before the alarm sounded; the time stamps confirm it.',
    options: ['must', 'should', 'might', 'can'],
    answer: 'must',
    explanation:
        '"Must have + past participle" expresses near certainty about a past event based on evidence.',
  ),
  GrammarItem(
    rule: 'Modals',
    question:
        'Students ______ submit hand-written essays — the system now accepts only typed ones.',
    options: ['need not', 'must not', 'should not', 'do not'],
    answer: 'need not',
    explanation:
        '"Need not" expresses the absence of obligation. "Must not" would mean prohibition, which is too strong here.',
  ),

  // ── Set 2 ─────────────────────────────────────────────────────────────
  GrammarItem(
    rule: 'Passive voice',
    question: 'The samples ______ in the laboratory last week.',
    options: ['analyzed', 'were analyzed', 'have analyzed', 'are analyzing'],
    answer: 'were analyzed',
    explanation:
        'Passive past simple: subject + "were" + past participle, with "last week" anchoring the action in the finished past.',
  ),
  GrammarItem(
    rule: 'Reported speech',
    question:
        'She said she ______ studying linguistics for three years.',
    options: ['has been', 'had been', 'is being', 'will be'],
    answer: 'had been',
    explanation:
        'Backshift: direct "have been" → reported "had been" when the reporting verb is past.',
  ),
  GrammarItem(
    rule: 'Reported speech',
    question: 'He asked ______ I lived.',
    options: ['where do', 'where did', 'where', 'when did'],
    answer: 'where',
    explanation:
        'Reported questions take statement word order — no "do/did" and no inversion.',
  ),
  GrammarItem(
    rule: 'Gerund vs infinitive',
    question: 'She avoided ______ her colleagues during the conference.',
    options: ['to meet', 'meeting', 'meet', 'met'],
    answer: 'meeting',
    explanation:
        '"Avoid" is always followed by the gerund (-ing form), never the infinitive.',
  ),
  GrammarItem(
    rule: 'Gerund vs infinitive',
    question: 'They decided ______ for a smaller car after considering fuel costs.',
    options: ['opting', 'to opt', 'opt', 'opted'],
    answer: 'to opt',
    explanation:
        '"Decide" takes the to-infinitive: decide to do, not decide doing.',
  ),
  GrammarItem(
    rule: 'Gerund vs infinitive',
    question: 'I remember ______ the email last night — I checked twice.',
    options: ['to send', 'sending', 'send', 'sent'],
    answer: 'sending',
    explanation:
        '"Remember + -ing" = recall a past action. "Remember + to-infinitive" would mean a future obligation.',
  ),
  GrammarItem(
    rule: 'Articles',
    question: 'My uncle plays ______ guitar professionally.',
    options: ['a', 'an', 'the', '—'],
    answer: 'the',
    explanation:
        'Musical instruments take the definite article: play the guitar, the piano, the violin.',
  ),
  GrammarItem(
    rule: 'Comparison',
    question: 'This project is ______ I have ever managed.',
    options: ['the more complex', 'most complex', 'the most complex', 'more complex'],
    answer: 'the most complex',
    explanation:
        'Superlative with "ever" requires "the most …" for adjectives of three or more syllables.',
  ),
  GrammarItem(
    rule: 'Comparison',
    question: 'The new model is ______ than the previous one.',
    options: ['twice as fast', 'twice faster', 'twice the faster', 'as fast twice'],
    answer: 'twice as fast',
    explanation:
        'Multiplicative comparisons use "X times as + adjective + as", not the comparative form.',
  ),
  GrammarItem(
    rule: 'Quantifiers',
    question: 'There ______ little evidence to support that claim.',
    options: ['are', 'is', 'has', 'were'],
    answer: 'is',
    explanation:
        '"Evidence" is an uncountable noun and takes a singular verb; "little" precedes uncountables.',
  ),
  GrammarItem(
    rule: 'Quantifiers',
    question: '______ of the participants completed the survey.',
    options: ['Few', 'A few', 'Little', 'A little'],
    answer: 'A few',
    explanation:
        '"A few" (small positive number) precedes plural count nouns; "few" alone would suggest "not many".',
  ),
  GrammarItem(
    rule: 'Prepositions',
    question: 'The findings are consistent ______ earlier research.',
    options: ['to', 'with', 'of', 'on'],
    answer: 'with',
    explanation:
        'Fixed collocation: "consistent with" — one of the most-tested verb–preposition pairs in academic English.',
  ),
  GrammarItem(
    rule: 'Prepositions',
    question: 'She is responsible ______ training the new staff.',
    options: ['of', 'for', 'to', 'on'],
    answer: 'for',
    explanation:
        '"Responsible for + noun / -ing" is the fixed pattern; "responsible to" would mean answerable to someone.',
  ),
  GrammarItem(
    rule: 'Punctuation',
    question:
        'Which sentence is correctly punctuated?',
    options: [
      'The data are inconclusive, further studies are needed.',
      'The data are inconclusive; further studies are needed.',
      'The data are inconclusive further, studies are needed.',
      'The data, are inconclusive further studies are needed.',
    ],
    answer: 'The data are inconclusive; further studies are needed.',
    explanation:
        'Two independent clauses joined without a coordinator require a semicolon, not a comma (the comma alone is a "comma splice").',
  ),
  GrammarItem(
    rule: 'Word order',
    question: 'She speaks ______.',
    options: ['always quietly', 'quietly always', 'always quiet', 'quiet always'],
    answer: 'always quietly',
    explanation:
        'Frequency adverbs ("always") precede manner adverbs; manner adverbs use the -ly form modifying the verb.',
  ),
];
