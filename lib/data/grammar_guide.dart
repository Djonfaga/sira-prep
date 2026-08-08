/// Long-form grammar reference content backing the "Read" tab inside Grammar.
///
/// Authoring principles:
///  - Plain academic English; aimed at C1 readers preparing for TOEFL / IELTS.
///  - Each topic groups multiple rules; rules carry correct *and* incorrect
///    examples so learners see the failure mode, not just the target.
///  - Visuals are reserved for cases where a diagram genuinely clarifies
///    something — tense timelines, conditional flow, parallelism alignment —
///    rather than decorative icons.
///  - Sources are listed per topic. Original explanations are paraphrased
///    from standard references (Swan 2017, Carter & McCarthy 2006, Greenbaum
///    1996, Huddleston & Pullum 2002, Eastwood 2003, the Cambridge Dictionary
///    grammar pages, and the British Council "LearnEnglish" reference). No
///    text is reproduced verbatim from those works.

enum GrammarVisual {
  none,
  tenseTimeline,
  conditionalFlow,
  parallelismLines,
}

class GrammarExample {
  const GrammarExample({
    required this.text,
    required this.correct,
    this.note,
  });
  final String text;
  final bool correct;
  final String? note;
}

class GrammarRule {
  const GrammarRule({
    required this.title,
    required this.explanation,
    this.examples = const [],
    this.visual = GrammarVisual.none,
  });
  final String title;
  final String explanation;
  final List<GrammarExample> examples;
  final GrammarVisual visual;
}

class GrammarTopic {
  const GrammarTopic({
    required this.id,
    required this.section,
    required this.title,
    required this.summary,
    required this.rules,
    required this.sources,
  });
  final String id;
  final String section; // 'Verbs', 'Mood & modality', 'Clauses', 'Cohesion', …
  final String title;
  final String summary;
  final List<GrammarRule> rules;
  final List<String> sources;
}

const List<GrammarTopic> grammarGuide = [
  // ─── 1. Tenses ────────────────────────────────────────────────────────
  GrammarTopic(
    id: 'tenses',
    section: 'Verbs',
    title: 'The English Tense System',
    summary:
        'English encodes time and aspect separately. Time places the event '
        '(past, present, future); aspect describes the speaker\'s view of '
        'the event (completed, ongoing, repeated). Combining the two yields '
        'the familiar twelve tense forms.',
    rules: [
      GrammarRule(
        title: 'Time and aspect are independent',
        explanation:
            'Every English verb form carries two pieces of information. The '
            'first is *time*: past, present, or future. The second is '
            '*aspect*: whether the event is presented as a simple fact '
            '(simple), as ongoing (continuous), as connected to a later '
            'point (perfect), or both connected and ongoing (perfect '
            'continuous). Picking the right tense therefore means picking '
            'the right combination — not memorizing twelve unrelated boxes.',
        visual: GrammarVisual.tenseTimeline,
        examples: [
          GrammarExample(
            text: 'She studies linguistics. — present simple: habitual fact.',
            correct: true,
          ),
          GrammarExample(
            text: 'She is studying linguistics. — present continuous: in '
                'progress now or around now.',
            correct: true,
          ),
          GrammarExample(
            text: 'She has studied linguistics for three years. — present '
                'perfect: started in the past, still relevant.',
            correct: true,
          ),
          GrammarExample(
            text: 'She has been studying linguistics for three years. — '
                'present perfect continuous: ongoing duration up to now.',
            correct: true,
          ),
        ],
      ),
      GrammarRule(
        title: 'Present perfect vs. past simple',
        explanation:
            'Use the present perfect when the time reference is unfinished '
            'or unspecified ("ever / never / so far / this week / since 2018"). '
            'Use the past simple when the time reference is finished or '
            'specified ("yesterday / in 2018 / last week / when I was a '
            'child"). The classic exam trap is using "have done" with a '
            'finished time marker.',
        examples: [
          GrammarExample(
            text: 'I have lived in Berlin since 2018.',
            correct: true,
            note: '"since 2018" reaches to now — present perfect.',
          ),
          GrammarExample(
            text: 'I lived in Berlin in 2018.',
            correct: true,
            note: '"in 2018" is finished — past simple.',
          ),
          GrammarExample(
            text: 'I have lived in Berlin in 2018.',
            correct: false,
            note: 'Mixing a finished time marker with present perfect is '
                'ungrammatical in standard British and US usage.',
          ),
        ],
      ),
      GrammarRule(
        title: 'Continuous forms with state verbs',
        explanation:
            'Verbs of state (know, believe, own, contain, mean, prefer, '
            'understand) usually do not take continuous forms because they '
            'describe a condition, not an event. A handful of dual-class '
            'verbs do allow both — "I think so" vs. "I\'m thinking about it" '
            '— but the meaning changes.',
        examples: [
          GrammarExample(text: 'I know the answer.', correct: true),
          GrammarExample(
            text: 'I am knowing the answer.',
            correct: false,
            note: '"know" is a state verb; it does not take the continuous.',
          ),
          GrammarExample(
            text: 'I\'m thinking about your proposal.',
            correct: true,
            note: 'Here "think" means "consider" — an activity, not a state.',
          ),
        ],
      ),
    ],
    sources: [
      'Swan, M. (2017). Practical English Usage, 4th ed. Oxford UP. §§ 1–60.',
      'Carter, R. & McCarthy, M. (2006). Cambridge Grammar of English.',
      'Cambridge Dictionary grammar: "Verbs: tenses and aspects".',
    ],
  ),

  // ─── 2. Subjunctive ──────────────────────────────────────────────────
  GrammarTopic(
    id: 'subjunctive',
    section: 'Mood & modality',
    title: 'The Subjunctive Mood',
    summary:
        'A small but heavily tested area. The subjunctive uses the bare '
        'form of the verb after certain triggers — "It is essential that '
        'she be informed" — and a fixed past form ("If I were…") in '
        'hypothetical conditions.',
    rules: [
      GrammarRule(
        title: 'Mandative subjunctive (present)',
        explanation:
            'After expressions of necessity, command, recommendation, or '
            'urgency, the verb in the *that*-clause takes the bare '
            'infinitive regardless of subject. Common triggers: "it is '
            'essential / vital / important / advisable / necessary that…"; '
            '"insist that", "recommend that", "demand that", "suggest that".',
        examples: [
          GrammarExample(
            text: 'It is essential that every student carry an ID card.',
            correct: true,
          ),
          GrammarExample(
            text: 'It is essential that every student carries an ID card.',
            correct: false,
            note: 'No third-person -s in the mandative subjunctive.',
          ),
          GrammarExample(
            text: 'The committee insisted that the report be revised.',
            correct: true,
          ),
        ],
      ),
      GrammarRule(
        title: 'Past subjunctive in hypotheticals',
        explanation:
            'Hypothetical conditions use "were" for all persons of the verb '
            '"to be" — including singular "I" and "he/she". In informal '
            'speech "was" is heard, but formal exam-style writing requires '
            '"were".',
        examples: [
          GrammarExample(text: 'If I were the policymaker, I would…',
              correct: true),
          GrammarExample(
            text: 'If I was the policymaker, I would…',
            correct: false,
            note: 'Acceptable in casual speech, but penalised in formal '
                'writing tasks.',
          ),
          GrammarExample(text: 'She speaks as if she were an expert.',
              correct: true),
        ],
      ),
    ],
    sources: [
      'Huddleston, R. & Pullum, G. (2002). The Cambridge Grammar of the '
          'English Language, §3.4 (Mood).',
      'Swan (2017), §§ 567–571.',
    ],
  ),

  // ─── 3. Conditionals ─────────────────────────────────────────────────
  GrammarTopic(
    id: 'conditionals',
    section: 'Clauses',
    title: 'Conditionals',
    summary:
        'Conditional sentences pair an if-clause (the condition) with a '
        'main clause (the result). The five main types — zero, first, '
        'second, third, mixed — encode different distances from reality.',
    rules: [
      GrammarRule(
        title: 'The five core patterns',
        explanation:
            'Zero conditional: general truths — "If water reaches 100°C, it '
            'boils." First conditional: realistic future — "If it rains '
            'tomorrow, we will cancel." Second conditional: present unreal '
            '— "If I knew the answer, I would tell you." Third conditional: '
            'past unreal — "If I had known, I would have told you." Mixed '
            'conditional: past condition with present result — "If I had '
            'studied medicine, I would be a doctor today."',
        visual: GrammarVisual.conditionalFlow,
        examples: [
          GrammarExample(text: 'If water reaches 100°C, it boils.',
              correct: true, note: 'Zero — general truth.'),
          GrammarExample(text: 'If it rains tomorrow, we will cancel.',
              correct: true, note: 'First — realistic future.'),
          GrammarExample(text: 'If I knew the answer, I would tell you.',
              correct: true, note: 'Second — present unreal.'),
          GrammarExample(
              text: 'If I had known, I would have told you.',
              correct: true,
              note: 'Third — past unreal.'),
          GrammarExample(
              text: 'If I had studied medicine, I would be a doctor today.',
              correct: true,
              note: 'Mixed — past cause, present consequence.'),
        ],
      ),
      GrammarRule(
        title: 'Common errors',
        explanation:
            'The most penalized error is using "would" inside the if-clause: '
            '"If I would have known…" is not standard. The auxiliary '
            '"would" belongs only in the main clause.',
        examples: [
          GrammarExample(text: 'If I had known…', correct: true),
          GrammarExample(
              text: 'If I would have known…',
              correct: false,
              note: '"Would" never appears in the if-clause of a standard '
                  'third conditional.'),
        ],
      ),
    ],
    sources: [
      'Swan (2017), §§ 256–266.',
      'Eastwood, J. (2003). Oxford Practice Grammar, units 113–117.',
      'British Council LearnEnglish: "Conditionals 1, 2, 3 and mixed".',
    ],
  ),

  // ─── 4. Inversion ────────────────────────────────────────────────────
  GrammarTopic(
    id: 'inversion',
    section: 'Word order',
    title: 'Inversion for Emphasis',
    summary:
        'When a negative or restrictive expression is fronted, the subject '
        'and the auxiliary swap places — the same shape as a question. '
        'Inversion is a high-yield TOEFL / IELTS topic because it is '
        'register-marked: it signals formal, often written, English.',
    rules: [
      GrammarRule(
        title: 'After negative or restrictive adverbials',
        explanation:
            'Triggers include "never", "rarely", "seldom", "hardly… when", '
            '"scarcely… when", "no sooner… than", "not only… but also", '
            '"under no circumstances", "in no way", "at no point", "only '
            'then", "only later". When any of these begins the sentence, '
            'invert subject and auxiliary in the following clause.',
        examples: [
          GrammarExample(
              text: 'Rarely have we seen such accurate data.',
              correct: true),
          GrammarExample(
              text: 'No sooner had the rain stopped than the match resumed.',
              correct: true),
          GrammarExample(
              text: 'Not only did she finish first, but she also broke the '
                  'record.',
              correct: true),
          GrammarExample(
              text: 'Rarely we have seen such accurate data.',
              correct: false,
              note: 'After a fronted negative adverbial, the subject must '
                  'follow the auxiliary.'),
        ],
      ),
      GrammarRule(
        title: 'Conditional inversion',
        explanation:
            'In formal style, conditional sentences may drop "if" and '
            'invert. "If I had known…" becomes "Had I known…"; "If she '
            'were to apply…" becomes "Were she to apply…"; "If you should '
            'need…" becomes "Should you need…".',
        examples: [
          GrammarExample(
              text: 'Had the policy been adopted earlier, emissions would '
                  'already be lower.',
              correct: true),
          GrammarExample(
              text: 'Should you have any questions, please write to us.',
              correct: true),
        ],
      ),
    ],
    sources: [
      'Swan (2017), §§ 302–306.',
      'Greenbaum, S. (1996). The Oxford English Grammar, §17.7.',
    ],
  ),

  // ─── 5. Articles ─────────────────────────────────────────────────────
  GrammarTopic(
    id: 'articles',
    section: 'Noun phrase',
    title: 'Articles (a / an / the / ∅)',
    summary:
        'The article system encodes definiteness — whether the speaker '
        'assumes the listener can identify the noun being referred to.',
    rules: [
      GrammarRule(
        title: 'Indefinite "a / an"',
        explanation:
            'Use "a" or "an" before a singular count noun when introducing '
            'it for the first time, or when any member of a class will do. '
            'Use "an" before a vowel *sound*, not a vowel *letter*: "an '
            'honest mistake", "a university".',
        examples: [
          GrammarExample(text: 'I saw a film yesterday.', correct: true),
          GrammarExample(text: 'It was an unforgettable evening.',
              correct: true),
          GrammarExample(
              text: 'It was a unforgettable evening.',
              correct: false,
              note: 'The sound of "unforgettable" begins with a vowel — use '
                  '"an".'),
        ],
      ),
      GrammarRule(
        title: 'Definite "the"',
        explanation:
            'Use "the" when the listener can identify the noun: previously '
            'mentioned things, unique entities ("the moon", "the President"), '
            'superlatives ("the best"), ordinals ("the first"), and shared '
            'context ("could you pass the salt").',
        examples: [
          GrammarExample(text: 'The best way to learn a language is to use '
              'it.', correct: true),
          GrammarExample(
              text: 'Best way to learn a language is to use it.',
              correct: false,
              note: 'Superlatives require "the".'),
        ],
      ),
      GrammarRule(
        title: 'Zero article (∅)',
        explanation:
            'Generic plural and uncountable nouns take no article: "Books '
            'are expensive", "Water freezes at zero". Proper nouns also '
            'usually take ∅: "Paris", "Mount Fuji" — except institutions, '
            'rivers, oceans, mountain *ranges*, plural country names ("the '
            'United States", "the Alps", "the Nile").',
        examples: [
          GrammarExample(text: 'Books are an underrated investment.',
              correct: true),
          GrammarExample(text: 'The books are an underrated investment.',
              correct: false,
              note: 'Generic plural reference takes the zero article, not '
                  '"the".'),
        ],
      ),
    ],
    sources: [
      'Swan (2017), §§ 64–110.',
      'Quirk et al. (1985). Comprehensive Grammar of the English Language, '
          'ch. 5.',
      'Cambridge Dictionary grammar: "Articles".',
    ],
  ),

  // ─── 6. Modals ───────────────────────────────────────────────────────
  GrammarTopic(
    id: 'modals',
    section: 'Mood & modality',
    title: 'Modal Verbs',
    summary:
        'Modals (can, could, may, might, must, shall, should, will, would, '
        'ought to, need not) signal the speaker\'s judgement about '
        'possibility, ability, obligation, or permission. They take the '
        'bare infinitive and have no -s for the third person.',
    rules: [
      GrammarRule(
        title: 'Degree of certainty',
        explanation:
            'For present or future possibility: must > should > may > '
            'might / could. "She must be home" expresses near certainty; '
            '"she could be home" expresses a real but lower probability. '
            'For past speculation, add "have + past participle": "She '
            'must have left" / "She might have left".',
        examples: [
          GrammarExample(
              text: 'The witness must have left before the alarm sounded.',
              correct: true,
              note: 'Strong evidence-based conclusion about the past.'),
          GrammarExample(
              text: 'The witness should have left before the alarm sounded.',
              correct: true,
              note: 'Expectation: that was the reasonable action.'),
        ],
      ),
      GrammarRule(
        title: 'Obligation and prohibition',
        explanation:
            '"Must" expresses internal obligation ("I must finish this"); '
            '"have to" expresses external obligation ("I have to renew my '
            'visa"). The negative split is critical: "must not" = '
            'prohibition; "need not / don\'t have to" = absence of '
            'obligation.',
        examples: [
          GrammarExample(
              text: 'Students must not bring phones into the exam.',
              correct: true,
              note: 'Prohibition.'),
          GrammarExample(
              text: 'Students need not bring a calculator — one is provided.',
              correct: true,
              note: 'No obligation, not a prohibition.'),
          GrammarExample(
              text: 'Students must not bring a calculator — one is provided.',
              correct: false,
              note: '"Must not" forbids; here we only want to say it is '
                  'unnecessary.'),
        ],
      ),
    ],
    sources: [
      'Palmer, F. (1990). Modality and the English Modals, 2nd ed.',
      'Swan (2017), §§ 326–369.',
      'British Council LearnEnglish: "Modal verbs".',
    ],
  ),

  // ─── 7. Passive voice ────────────────────────────────────────────────
  GrammarTopic(
    id: 'passive',
    section: 'Verbs',
    title: 'The Passive Voice',
    summary:
        'The passive promotes the patient of an action to subject position '
        'and demotes the agent — often dropping it entirely. Academic '
        'writing favors the passive when the agent is unknown, irrelevant, '
        'or institutional ("the experiment was conducted").',
    rules: [
      GrammarRule(
        title: 'Form and use',
        explanation:
            'Form: subject + form of "be" + past participle. The agent, if '
            'mentioned, follows "by". The passive is used (a) when the '
            'agent is unknown ("My bike was stolen"); (b) when the agent '
            'is obvious or unimportant ("English is spoken here"); (c) for '
            'academic neutrality ("the data were collected over five '
            'years"); (d) to keep given information at the start of the '
            'sentence and new information at the end.',
        examples: [
          GrammarExample(
              text: 'The data were collected over five years.',
              correct: true),
          GrammarExample(
              text: 'The data was collected over five years.',
              correct: true,
              note: 'Acceptable; "data" is treated as singular in many modern '
                  'corpora. Formal academic style still prefers "were".'),
        ],
      ),
      GrammarRule(
        title: 'Verbs with two objects',
        explanation:
            'Verbs like give, offer, send, show, tell, teach allow either '
            'object to become the passive subject. "We gave her the prize" '
            '→ "She was given the prize" (preferred) or "The prize was '
            'given to her".',
        examples: [
          GrammarExample(text: 'She was given the prize.', correct: true),
          GrammarExample(text: 'The prize was given to her.', correct: true),
        ],
      ),
      GrammarRule(
        title: 'When *not* to use the passive',
        explanation:
            'Overuse weakens prose. Style guides for IELTS Task 2 and '
            'academic writing prefer the active when the agent is known and '
            'matters — "Researchers identified three risk factors" rather '
            'than "Three risk factors were identified".',
        examples: [
          GrammarExample(
              text: 'Researchers identified three risk factors.',
              correct: true,
              note: 'Clearer and more concise than the passive equivalent.'),
        ],
      ),
    ],
    sources: [
      'Biber et al. (1999). Longman Grammar of Spoken and Written English, '
          'ch. 6.',
      'Swan (2017), §§ 412–423.',
    ],
  ),

  // ─── 8. Subject-verb agreement ────────────────────────────────────────
  GrammarTopic(
    id: 'agreement',
    section: 'Verbs',
    title: 'Subject–Verb Agreement',
    summary:
        'The verb must agree with the *grammatical* subject in number — '
        'not necessarily with the noun closest to it. Long noun phrases, '
        'quantifiers, and coordinated subjects are the most common pitfalls.',
    rules: [
      GrammarRule(
        title: 'Find the head of the subject',
        explanation:
            'In a long noun phrase, the verb agrees with the head noun, '
            'not with a modifier between the head and the verb.',
        examples: [
          GrammarExample(
              text: 'The list of items is on the desk.',
              correct: true,
              note: 'Head: "list" (singular).'),
          GrammarExample(
              text: 'The list of items are on the desk.',
              correct: false,
              note: '"Items" is part of a prepositional modifier, not the '
                  'subject.'),
        ],
      ),
      GrammarRule(
        title: 'Either / Neither / Or — proximity rule',
        explanation:
            'With "either … or", "neither … nor", and "not only … but also", '
            'the verb agrees with the closer subject.',
        examples: [
          GrammarExample(
              text: 'Neither the supervisor nor the employees were aware.',
              correct: true,
              note: 'Closer subject: "employees" (plural).'),
          GrammarExample(
              text: 'Neither the employees nor the supervisor was aware.',
              correct: true,
              note: 'Closer subject: "supervisor" (singular).'),
        ],
      ),
      GrammarRule(
        title: 'Collective nouns and indefinites',
        explanation:
            'Collective nouns (team, government, family) take a singular '
            'verb when treated as a unit and a plural verb when treated as '
            'individuals — usage that is more variable in British than '
            'American English. Indefinite pronouns ending in "-body", '
            '"-one", "-thing" are singular: "Everybody is welcome", not '
            '"Everybody are welcome".',
        examples: [
          GrammarExample(text: 'Everybody is welcome.', correct: true),
          GrammarExample(text: 'The team has won.', correct: true,
              note: 'Treated as a unit.'),
          GrammarExample(text: 'The team have not agreed.', correct: true,
              note: 'British usage when emphasizing the members.'),
        ],
      ),
    ],
    sources: [
      'Quirk et al. (1985), §10.34–10.43.',
      'Swan (2017), §§ 504–520.',
    ],
  ),

  // ─── 9. Parallelism ──────────────────────────────────────────────────
  GrammarTopic(
    id: 'parallelism',
    section: 'Style & structure',
    title: 'Parallel Structure',
    summary:
        'Items joined by coordinators (and, or, but, nor, not only … but '
        'also) must share the same grammatical shape. Parallelism is a '
        'cohesion device as much as a rule; broken parallelism is one of '
        'the easiest writing errors for a rater to spot.',
    rules: [
      GrammarRule(
        title: 'Match the form in a list',
        explanation:
            'When you join three or more items with "and" or "or", every '
            'item should be in the same grammatical form — all gerunds, '
            'all infinitives, all noun phrases, all adjectives.',
        visual: GrammarVisual.parallelismLines,
        examples: [
          GrammarExample(
              text: 'The professor recommended reading the article, writing '
                  'notes, and preparing a discussion question.',
              correct: true,
              note: 'All three items are gerunds.'),
          GrammarExample(
              text: 'The professor recommended reading the article, to '
                  'write notes, and preparing a discussion question.',
              correct: false,
              note: 'Mixing -ing forms with an infinitive breaks parallelism.'),
        ],
      ),
      GrammarRule(
        title: 'Correlative pairs',
        explanation:
            'Correlatives like "not only … but also", "both … and", '
            '"either … or", "neither … nor", and "whether … or" require '
            'parallel grammatical shape on either side of the pair.',
        examples: [
          GrammarExample(
              text: 'She is interested not only in the policy itself but '
                  'also in its long-term effects.',
              correct: true,
              note: 'Both sides begin with the preposition "in".'),
          GrammarExample(
              text: 'She is interested not only in the policy itself but '
                  'also its long-term effects.',
              correct: false,
              note: 'The preposition "in" must be repeated to keep both '
                  'sides parallel.'),
        ],
      ),
    ],
    sources: [
      'Strunk & White (2000). The Elements of Style, §15.',
      'Williams, J. (2014). Style: Lessons in Clarity and Grace, ch. 7.',
      'Purdue OWL: "Parallel Structure".',
    ],
  ),

  // ─── 10. Relative clauses ────────────────────────────────────────────
  GrammarTopic(
    id: 'relatives',
    section: 'Clauses',
    title: 'Relative Clauses',
    summary:
        'Relative clauses add information about a noun. They are introduced '
        'by relative pronouns (who, whom, whose, which, that) and relative '
        'adverbs (where, when, why). The split between defining (no commas) '
        'and non-defining (commas) is critical for both accuracy and style.',
    rules: [
      GrammarRule(
        title: 'Defining vs. non-defining',
        explanation:
            'A defining clause restricts the noun — it identifies *which* '
            'one. It is *not* set off by commas, and "that" can replace '
            '"who" or "which". A non-defining clause adds extra information '
            'about a noun that is already identified, is set off by commas '
            '(or dashes), and never uses "that".',
        examples: [
          GrammarExample(
              text: 'The students who finished early left the room.',
              correct: true,
              note: 'Defining — only the ones who finished early.'),
          GrammarExample(
              text: 'The students, who finished early, left the room.',
              correct: true,
              note: 'Non-defining — all the students finished early; that\'s '
                  'extra information.'),
          GrammarExample(
              text: 'The students, that finished early, left the room.',
              correct: false,
              note: '"That" is not allowed in non-defining clauses.'),
        ],
      ),
      GrammarRule(
        title: 'Whose, whom, where, when',
        explanation:
            '"Whose" is possessive (people *and* things). "Whom" replaces '
            'an object pronoun and is largely formal. "Where" replaces "in '
            'which" or "at which" for places. "When" replaces "on which" '
            'for times.',
        examples: [
          GrammarExample(
              text: 'The researchers whose findings have been widely cited '
                  'presented at the conference.',
              correct: true),
          GrammarExample(
              text: 'This is the lab where they conducted the experiment.',
              correct: true),
        ],
      ),
    ],
    sources: [
      'Huddleston & Pullum (2002), ch. 12.',
      'Swan (2017), §§ 472–490.',
    ],
  ),

  // ─── 11. Gerund vs. infinitive ───────────────────────────────────────
  GrammarTopic(
    id: 'gerund-infinitive',
    section: 'Verbs',
    title: 'Gerunds and Infinitives',
    summary:
        'Some verbs are followed by a gerund (-ing), some by an infinitive '
        '(to + base form), some by either, and a small group changes '
        'meaning depending on which one follows.',
    rules: [
      GrammarRule(
        title: 'Verbs that take a gerund',
        explanation:
            'Common verbs followed by -ing include: enjoy, avoid, deny, '
            'finish, suggest, recommend, mind, consider, postpone, admit, '
            'risk, practice, miss.',
        examples: [
          GrammarExample(text: 'She enjoys reading non-fiction.',
              correct: true),
          GrammarExample(
              text: 'She enjoys to read non-fiction.',
              correct: false,
              note: '"Enjoy" never takes the infinitive.'),
        ],
      ),
      GrammarRule(
        title: 'Verbs that take an infinitive',
        explanation:
            'Common verbs followed by "to + base form": decide, hope, plan, '
            'promise, refuse, expect, agree, manage, intend, offer, fail.',
        examples: [
          GrammarExample(text: 'She decided to apply for the grant.',
              correct: true),
          GrammarExample(
              text: 'She decided applying for the grant.',
              correct: false,
              note: '"Decide" only takes the infinitive.'),
        ],
      ),
      GrammarRule(
        title: 'Verbs that change meaning',
        explanation:
            'A small set changes meaning depending on which complement they '
            'take. "Stop doing X" means cease X; "stop to do X" means '
            'interrupt one activity in order to do X. "Remember to lock '
            'the door" is the obligation; "remember locking the door" is '
            'recalling a past action. The same pattern holds for "forget", '
            '"regret", "try", and "go on".',
        examples: [
          GrammarExample(
              text: 'I stopped smoking last year.',
              correct: true,
              note: '"Stopped doing X" = ceased X.'),
          GrammarExample(
              text: 'I stopped to smoke a cigarette.',
              correct: true,
              note: '"Stopped to do X" = paused in order to do X.'),
          GrammarExample(
              text: 'Remember to send the email — it\'s due today.',
              correct: true,
              note: 'Future obligation.'),
          GrammarExample(
              text: 'I remember sending the email last night.',
              correct: true,
              note: 'Past recollection.'),
        ],
      ),
    ],
    sources: [
      'Swan (2017), §§ 297–315.',
      'Eastwood (2003), units 67–69.',
    ],
  ),

  // ─── 12. Reported speech ─────────────────────────────────────────────
  GrammarTopic(
    id: 'reported-speech',
    section: 'Clauses',
    title: 'Reported (Indirect) Speech',
    summary:
        'When direct quotations are turned into reported speech, several '
        'shifts apply: tenses move back one step (the "backshift"), '
        'pronouns adjust to the speaker, and time and place expressions '
        'often change.',
    rules: [
      GrammarRule(
        title: 'Backshift of tense',
        explanation:
            'Present simple → past simple; present continuous → past '
            'continuous; present perfect → past perfect; past simple → past '
            'perfect; "will" → "would"; "can" → "could"; "may" → "might"; '
            '"must" (obligation) → "had to". The backshift can be skipped '
            'when the reported statement is still currently true.',
        examples: [
          GrammarExample(
              text: 'Direct: "I am studying linguistics." → Reported: She '
                  'said (that) she was studying linguistics.',
              correct: true),
          GrammarExample(
              text: 'Direct: "Water boils at 100°C." → Reported: He said '
                  '(that) water boils at 100°C.',
              correct: true,
              note: 'Backshift skipped — the fact is still true.'),
        ],
      ),
      GrammarRule(
        title: 'Reporting questions',
        explanation:
            'Reported questions take statement word order — no inversion, '
            'no question mark, no "do/does/did". Yes/no questions add '
            '"if" or "whether"; wh-questions keep the wh-word.',
        examples: [
          GrammarExample(
              text: 'Direct: "Where do you live?" → Reported: He asked '
                  'where I lived.',
              correct: true),
          GrammarExample(
              text: 'He asked where did I live.',
              correct: false,
              note: 'Reported questions take statement word order.'),
        ],
      ),
    ],
    sources: [
      'Swan (2017), §§ 433–457.',
      'British Council LearnEnglish: "Reported speech".',
    ],
  ),

  // ─── 13. Connectors ──────────────────────────────────────────────────
  GrammarTopic(
    id: 'connectors',
    section: 'Cohesion',
    title: 'Linking Words and Connectors',
    summary:
        'Cohesion devices link ideas across sentences and paragraphs. They '
        'are scored explicitly in IELTS Task 2 and in TOEFL Writing — but '
        'overuse drags scores down as much as underuse.',
    rules: [
      GrammarRule(
        title: 'Logical relations',
        explanation:
            'Addition: moreover, furthermore, in addition. Contrast: '
            'however, on the other hand, by contrast, nevertheless. Cause '
            '/ effect: therefore, consequently, as a result, thus. '
            'Example: for instance, for example, such as. Conclusion: in '
            'conclusion, to sum up, overall. Concession: although, even '
            'though, despite, in spite of.',
        examples: [
          GrammarExample(
              text: 'The technology is promising; however, costs remain high.',
              correct: true),
          GrammarExample(
              text: 'Despite the costs are high, the technology is promising.',
              correct: false,
              note: '"Despite" + noun phrase. Use "Although the costs are '
                  'high" if you need a clause.'),
        ],
      ),
      GrammarRule(
        title: 'Despite vs. although',
        explanation:
            '"Despite" and "in spite of" are prepositions: they take a noun '
            'phrase or "-ing" form. "Although" and "even though" are '
            'conjunctions: they take a full clause.',
        examples: [
          GrammarExample(text: 'Despite the costs, the project went ahead.',
              correct: true),
          GrammarExample(text: 'Although the costs were high, the project '
              'went ahead.', correct: true),
          GrammarExample(
              text: 'Although the costs, the project went ahead.',
              correct: false,
              note: '"Although" requires a clause.'),
        ],
      ),
    ],
    sources: [
      'Halliday, M. A. K. & Hasan, R. (1976). Cohesion in English.',
      'Hinkel, E. (2004). Teaching Academic ESL Writing, ch. 7.',
      'British Council LearnEnglish: "Linking words".',
    ],
  ),

  // ─── 14. Punctuation ─────────────────────────────────────────────────
  GrammarTopic(
    id: 'punctuation',
    section: 'Mechanics',
    title: 'Sentence-Level Punctuation',
    summary:
        'Punctuation is part of grammar — it signals clause boundaries and '
        'pacing. Three errors are penalized most consistently in academic '
        'writing: comma splices, missing Oxford commas in ambiguous lists, '
        'and dangling modifiers.',
    rules: [
      GrammarRule(
        title: 'Comma splice',
        explanation:
            'Two independent clauses cannot be joined by a comma alone. '
            'Use a semicolon, a period, or a comma + coordinator (and, '
            'but, or, so, yet, for, nor).',
        examples: [
          GrammarExample(
              text: 'The data are inconclusive; further studies are needed.',
              correct: true),
          GrammarExample(
              text: 'The data are inconclusive, further studies are needed.',
              correct: false,
              note: 'Comma splice — use a semicolon or add "and".'),
        ],
      ),
      GrammarRule(
        title: 'Restrictive vs. non-restrictive (commas)',
        explanation:
            'Restrictive elements identify which one — no commas. '
            'Non-restrictive elements add extra information — commas. The '
            'distinction is the same one that governs "that" vs. "which" '
            'in many style guides.',
        examples: [
          GrammarExample(
              text: 'The book that won the prize is on the table.',
              correct: true,
              note: 'Defining — identifies which book.'),
          GrammarExample(
              text: 'Her latest book, which won the prize, is on the table.',
              correct: true,
              note: 'Non-defining — extra information.'),
        ],
      ),
    ],
    sources: [
      'Truss, L. (2003). Eats, Shoots & Leaves.',
      'Chicago Manual of Style, 17th ed., §§ 6.16–6.42.',
      'Purdue OWL: "Commas".',
    ],
  ),

  // ─── 15. Word order ──────────────────────────────────────────────────
  GrammarTopic(
    id: 'word-order',
    section: 'Word order',
    title: 'Adjective Order and Position',
    summary:
        'English orders multiple adjectives in a fairly fixed sequence — '
        'native speakers feel it intuitively, learners often need the '
        'pattern made explicit. Mistakes here read as obviously non-native.',
    rules: [
      GrammarRule(
        title: 'Royal order of adjectives',
        explanation:
            'The conventional order is: determiner → opinion → size → '
            'age → shape → color → origin → material → purpose → noun. '
            'It is rare to chain all of these; two or three is more typical. '
            'When in doubt, opinion goes first and material goes last.',
        examples: [
          GrammarExample(text: 'a lovely little old square brown French '
              'wooden writing desk', correct: true,
              note: 'opinion · size · age · shape · color · origin · '
                  'material · purpose.'),
          GrammarExample(
              text: 'a French old wooden writing little desk',
              correct: false,
              note: 'Order is jumbled — sounds wrong even though every word '
                  'is correct.'),
        ],
      ),
      GrammarRule(
        title: 'Adverb placement',
        explanation:
            'Adverbs of frequency (always, often, usually, sometimes, '
            'rarely, never) sit before the main verb but after "to be". '
            'Adverbs of manner usually follow the verb or the object. '
            'Don\'t split the verb-object bond if you can avoid it.',
        examples: [
          GrammarExample(text: 'She always arrives early.', correct: true),
          GrammarExample(text: 'She is always early.', correct: true,
              note: 'After "to be".'),
          GrammarExample(text: 'She arrives always early.', correct: false,
              note: 'Frequency adverb sits before the main verb, not after.'),
        ],
      ),
    ],
    sources: [
      'Quirk et al. (1985), §7.40 (adjective ordering).',
      'Swan (2017), §§ 13–18.',
    ],
  ),
];
