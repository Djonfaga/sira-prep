/// Long-form vocabulary reference content backing the "Read" tab inside the
/// Vocabulary section.
///
/// Authoring principles match the grammar guide:
///  - Plain academic English, written for C1 candidates.
///  - Each topic groups multiple lessons; lessons carry concrete examples
///    and, where helpful, a diagram.
///  - Original explanations paraphrased from standard references — no text
///    is reproduced verbatim from those works.
///
/// The pedagogical spine here is the *word-formation* curriculum (prefixes,
/// suffixes, Greek and Latin roots, word families) plus *lexical relations*
/// (synonyms, register, collocations, phrasal verbs) — the two areas that
/// move the needle most on TOEFL Reading and IELTS Writing scoring rubrics.

enum VocabVisual {
  none,
  wordBuilder,
  familyTree,
  collocationWeb,
  registerScale,
  prefixGrid,
}

class VocabExample {
  const VocabExample({required this.text, this.note});
  final String text;
  final String? note;
}

class VocabLesson {
  const VocabLesson({
    required this.title,
    required this.explanation,
    this.examples = const [],
    this.visual = VocabVisual.none,
  });
  final String title;
  final String explanation;
  final List<VocabExample> examples;
  final VocabVisual visual;
}

class VocabTopic {
  const VocabTopic({
    required this.id,
    required this.section,
    required this.title,
    required this.summary,
    required this.lessons,
    required this.sources,
  });
  final String id;
  final String section; // 'Word formation', 'Lexical relations', 'Strategy'…
  final String title;
  final String summary;
  final List<VocabLesson> lessons;
  final List<String> sources;
}

const List<VocabTopic> vocabGuide = [
  // ─── 1. Prefixes ─────────────────────────────────────────────────────
  VocabTopic(
    id: 'prefixes',
    section: 'Word formation',
    title: 'Prefixes — Front-loaded Meaning',
    summary:
        'A prefix is a meaningful unit attached to the front of a base word. '
        'Recognising prefixes lets you guess thousands of unfamiliar words '
        'without reaching for a dictionary — a critical skill for TOEFL '
        'Reading and IELTS Reading where you encounter vocabulary you have '
        'never met.',
    lessons: [
      VocabLesson(
        title: 'Negation: un-, in-, im-, il-, ir-, dis-, non-',
        explanation:
            'These all mean "not" — but they are not interchangeable. The '
            'choice usually depends on the first sound of the base: il- '
            'before "l" (illegal), ir- before "r" (irregular), im- before '
            '"m" or "p" (impossible, immobile), in- before most others '
            '(incorrect). "Un-" attaches to most adjectives (unhappy) and '
            'reverses verbs (undo, unlock). "Dis-" reverses or removes '
            '(disagree, dislike, disconnect). "Non-" is the most neutral '
            'and attaches freely (non-fiction, non-stop).',
        visual: VocabVisual.wordBuilder,
        examples: [
          VocabExample(
              text: 'un- + happy → unhappy',
              note: 'un- attaches to adjectives.'),
          VocabExample(
              text: 'in- + accurate → inaccurate',
              note: 'in- with most consonants.'),
          VocabExample(
              text: 'im- + possible → impossible',
              note: 'im- before "p" or "m".'),
          VocabExample(
              text: 'il- + legal → illegal',
              note: 'il- before "l".'),
          VocabExample(
              text: 'ir- + responsible → irresponsible',
              note: 'ir- before "r".'),
          VocabExample(
              text: 'dis- + agree → disagree',
              note: 'dis- often reverses or removes.'),
        ],
      ),
      VocabLesson(
        title: 'Position and direction',
        explanation:
            'pre- = before (preview, predict); post- = after (postpone, '
            'postgraduate); sub- = under (submarine, subordinate); super- '
            '= above or beyond (supervisor, superhuman); inter- = between '
            '(international, interactive); trans- = across (transport, '
            'transmit); ex- = out of or former (export, ex-president).',
        examples: [
          VocabExample(
              text: 'pre + history → prehistory',
              note: 'Before recorded history.'),
          VocabExample(text: 'sub + marine → submarine', note: 'Under sea.'),
          VocabExample(
              text: 'inter + national → international',
              note: 'Between nations.'),
          VocabExample(
              text: 'trans + parent → transparent',
              note: 'Light passes "across" → see-through.'),
        ],
      ),
      VocabLesson(
        title: 'Quantity and repetition',
        explanation:
            're- = again or back (rewrite, return); over- = too much '
            '(overeat, overestimate); under- = too little (undervalue, '
            'underrate); mono- = one (monorail, monologue); bi- = two '
            '(bicycle, bilingual); tri- = three (triangle, trilogy); '
            'multi- = many (multimedia, multinational); semi- = half or '
            'partly (semicircle, semi-final); auto- = self (autobiography, '
            'automatic).',
        examples: [
          VocabExample(
              text: 're + cycle → recycle',
              note: 'Cycle through the system again.'),
          VocabExample(
              text: 'over + estimate → overestimate',
              note: 'Estimate too high.'),
          VocabExample(
              text: 'auto + biography → autobiography',
              note: 'A biography of oneself.'),
        ],
      ),
    ],
    sources: [
      'Nation, I. S. P. (2013). Learning Vocabulary in Another Language, '
          '2nd ed. Cambridge UP, ch. 11.',
      'Bauer, L. & Nation, I. S. P. (1993). "Word families". '
          'International Journal of Lexicography 6(4).',
      'McCarthy, M. & O\'Dell, F. (2008). English Vocabulary in Use: '
          'Advanced. Cambridge UP, units 5–7.',
    ],
  ),

  // ─── 2. Suffixes ─────────────────────────────────────────────────────
  VocabTopic(
    id: 'suffixes',
    section: 'Word formation',
    title: 'Suffixes — Shifting Word Class',
    summary:
        'Where prefixes mostly change *meaning*, suffixes mostly change '
        '*word class* — turning verbs into nouns, nouns into adjectives, '
        'and so on. Mastering them lets you take one base word and produce '
        'an entire family of related forms.',
    lessons: [
      VocabLesson(
        title: 'Noun-forming suffixes',
        explanation:
            '-tion / -sion (verb → noun of action: act → action; decide '
            '→ decision); -ment (verb → noun: develop → development); '
            '-ity (adjective → noun: able → ability); -ness (adjective '
            '→ noun: kind → kindness); -ance / -ence (verb → noun: '
            'important → importance); -er / -or (verb → person who: '
            'teach → teacher, act → actor); -ist (person who: artist, '
            'pianist); -ism (system or belief: capitalism, realism).',
        examples: [
          VocabExample(text: 'develop → development'),
          VocabExample(text: 'kind → kindness'),
          VocabExample(text: 'capital → capitalism'),
          VocabExample(
              text: 'employ → employer / employee',
              note: '"-er" = agent doing the action; "-ee" = patient '
                  'receiving it.'),
        ],
      ),
      VocabLesson(
        title: 'Adjective-forming suffixes',
        explanation:
            '-al (noun → adjective: nation → national); -ful (full of: '
            'helpful, careful); -less (without: useless, hopeless); -able '
            '/ -ible (able to be: readable, visible); -ous (full of: '
            'famous, dangerous); -ive (tending to: active, creative); '
            '-ic (of: scientific, specific); -ish (somewhat: childish, '
            'reddish).',
        examples: [
          VocabExample(text: 'help + ful → helpful',
              note: '"Full of help".'),
          VocabExample(text: 'use + less → useless',
              note: '"Without use".'),
          VocabExample(text: 'read + able → readable',
              note: '"Able to be read".'),
        ],
      ),
      VocabLesson(
        title: 'Verb- and adverb-forming suffixes',
        explanation:
            '-ize / -ise = make X (modernize, prioritize); -ify = make X '
            '(simplify, justify); -en = make / become X (strengthen, '
            'shorten); -ate = make X (motivate, activate). For adverbs, '
            '-ly turns adjectives into adverbs (quickly, gradually).',
        examples: [
          VocabExample(text: 'modern → modernize',
              note: 'Make modern.'),
          VocabExample(text: 'simple → simplify',
              note: 'Make simple.'),
          VocabExample(text: 'strong → strengthen',
              note: 'Make stronger.'),
        ],
      ),
    ],
    sources: [
      'Nation (2013), ch. 11.',
      'Bauer, L. (1983). English Word-Formation. Cambridge UP.',
      'McCarthy & O\'Dell (2008), units 1–4.',
    ],
  ),

  // ─── 3. Greek & Latin roots ──────────────────────────────────────────
  VocabTopic(
    id: 'roots',
    section: 'Word formation',
    title: 'Greek and Latin Roots',
    summary:
        'A surprising share of academic English is built on a small number '
        'of Greek and Latin roots. Memorising forty of them gives you '
        'access to hundreds of advanced words.',
    lessons: [
      VocabLesson(
        title: 'High-yield Latin roots',
        explanation:
            'port = carry (transport, export, portable); mit / mis = send '
            '(transmit, missile, mission); dict = say (predict, dictate, '
            'contradict); scrib / script = write (describe, manuscript, '
            'transcript); spec / spect = look (inspect, perspective, '
            'spectator); duc / duct = lead (produce, conduct, introduce); '
            'struct = build (construct, structure, instruction); cred = '
            'believe (credit, credible, incredible); ven / vent = come '
            '(convene, prevent, event); ten / tain = hold (contain, '
            'sustain, retain).',
        examples: [
          VocabExample(
              text: 'in + spect → inspect',
              note: '"Look into" — the literal Latin sense survives.'),
          VocabExample(
              text: 'manu + script → manuscript',
              note: '"Hand-written".'),
          VocabExample(
              text: 'con + duct → conduct',
              note: '"Lead together" — to guide, to behave.'),
        ],
      ),
      VocabLesson(
        title: 'High-yield Greek roots',
        explanation:
            'bio = life (biology, biography); geo = earth (geology, '
            'geography); chron = time (chronology, chronic); auto = self '
            '(autonomy, automatic); tele = far (telephone, telescope); '
            'photo = light (photograph, photosynthesis); phon = sound '
            '(phonetics, symphony); psych = mind (psychology, psyche); '
            'soph = wisdom (philosophy, sophisticated); ped = child '
            '(pediatric — note Latin ped also means "foot", as in '
            'pedestrian).',
        examples: [
          VocabExample(
              text: 'bio + logy → biology',
              note: '"Study of life".'),
          VocabExample(
              text: 'auto + bio + graphy → autobiography',
              note: 'Three roots: self + life + writing.'),
          VocabExample(
              text: 'tele + scope → telescope',
              note: '"Far + see".'),
        ],
      ),
      VocabLesson(
        title: 'Decoding strategy',
        explanation:
            'When you meet an unfamiliar academic word, peel the prefix, '
            'find the root, and check the suffix for word class. The '
            'result usually points to the meaning closely enough for the '
            'sentence to disambiguate the rest.',
        visual: VocabVisual.wordBuilder,
        examples: [
          VocabExample(
              text: 'in- + cred + -ible → incredible',
              note: '"Not + believe + able to be" → unbelievable.'),
          VocabExample(
              text: 'trans- + port + -ation → transportation',
              note: '"Across + carry + noun of action".'),
          VocabExample(
              text: 'photo + syn + thesis → photosynthesis',
              note: '"Light + together + placing" → the process where '
                  'plants put energy together using light.'),
        ],
      ),
    ],
    sources: [
      'Ayers, D. M. (1986). English Words from Latin and Greek Elements. '
          'University of Arizona Press.',
      'Pinker, S. (1999). Words and Rules. Basic Books, ch. 2.',
      'McCarthy & O\'Dell (2008), unit 6.',
    ],
  ),

  // ─── 4. Word families ────────────────────────────────────────────────
  VocabTopic(
    id: 'word-families',
    section: 'Word formation',
    title: 'Word Families',
    summary:
        'A *word family* is the set of forms built around the same base — '
        'for example, *analyse* generates analysis, analyst, analytic, '
        'analytical, analytically. Learning a word as a family roughly '
        'triples the value of the time you put in.',
    lessons: [
      VocabLesson(
        title: 'The four-form rule',
        explanation:
            'Most academic words exist in four canonical forms: a verb, '
            'a noun of action, an agent noun, and an adjective — plus an '
            'adverb form for many adjectives. Picking the right *form* is '
            'half of writing well; using one form when the sentence asks '
            'for another is a frequent IELTS Task 2 error.',
        visual: VocabVisual.familyTree,
        examples: [
          VocabExample(
              text: 'analyse · analysis · analyst · analytical · '
                  'analytically'),
          VocabExample(
              text: 'create · creation · creator · creative · creatively'),
          VocabExample(
              text: 'innovate · innovation · innovator · innovative · '
                  'innovatively'),
        ],
      ),
      VocabLesson(
        title: 'Errors to watch for',
        explanation:
            'A common mistake is mixing word classes within a single noun '
            'phrase — using an adjective where a noun is needed, or a '
            'verb where a noun is needed. Read the sentence aloud: does '
            'the slot ask for a noun, a verb, or an adjective?',
        examples: [
          VocabExample(
              text: '✓ The analysis was thorough.',
              note: '"Analysis" — a noun fills the subject slot.'),
          VocabExample(
              text: '✗ The analyse was thorough.',
              note: '"Analyse" is a verb; the noun is "analysis".'),
          VocabExample(
              text: '✓ She analysed the results carefully.',
              note: 'Verb in the main-verb slot.'),
        ],
      ),
    ],
    sources: [
      'Bauer & Nation (1993), International Journal of Lexicography 6(4).',
      'Schmitt, N. (2010). Researching Vocabulary. Palgrave, ch. 4.',
      'Cambridge English: Advanced Vocabulary in Use.',
    ],
  ),

  // ─── 5. Collocations ─────────────────────────────────────────────────
  VocabTopic(
    id: 'collocations',
    section: 'Lexical relations',
    title: 'Collocations',
    summary:
        'Collocations are the word partners that habitually occur together '
        'in natural English: "make a decision", "do research", "heavy '
        'rain". Knowing the verb that goes with a noun is the single '
        'biggest sign of advanced vocabulary in writing.',
    lessons: [
      VocabLesson(
        title: 'Make vs. do — the classic divide',
        explanation:
            '"Make" usually goes with creation or production: make a '
            'decision, make a mistake, make progress, make an effort, '
            'make money. "Do" usually goes with activity or duty: do '
            'research, do homework, do business, do exercise, do the '
            'dishes. The rule is fuzzy; the patterns are learned word by '
            'word.',
        visual: VocabVisual.collocationWeb,
        examples: [
          VocabExample(text: 'make a decision · make a mistake · make '
              'progress · make an effort'),
          VocabExample(text: 'do research · do homework · do business · '
              'do exercise'),
          VocabExample(
              text: '✗ "make research" / "do a decision"',
              note: 'Both wrong — and immediately marked down on TOEFL '
                  'Speaking and IELTS Speaking.'),
        ],
      ),
      VocabLesson(
        title: 'Adjective + noun collocations',
        explanation:
            'Strong = "heavy rain", "heavy traffic", "strong evidence", '
            '"strong argument". Soft = "light wind", "light shower", '
            '"weak evidence". The mismatch sounds wrong to a native '
            'reader even when the meaning is preserved.',
        examples: [
          VocabExample(text: '✓ heavy rain · heavy traffic · strong evidence '
              '· strong tea'),
          VocabExample(
              text: '✗ strong rain · big traffic · powerful evidence',
              note: 'Not how the words pair in real English.'),
        ],
      ),
      VocabLesson(
        title: 'Verb + adverb / verb + preposition',
        explanation:
            'Some verbs only collocate with a specific adverb intensifier '
            '("strongly believe", "deeply regret", "fully aware") and '
            'most verbs require a fixed preposition ("depend on", "rely '
            'on", "consist of", "result in", "deal with"). These are '
            'memorised, not derived.',
        examples: [
          VocabExample(text: 'strongly believe · deeply regret · fully aware'),
          VocabExample(text: 'depend on · rely on · consist of · result in'),
        ],
      ),
    ],
    sources: [
      'Lewis, M. (2000). Teaching Collocation. LTP.',
      'McCarthy, M. & O\'Dell, F. (2017). English Collocations in Use: '
          'Advanced. Cambridge UP.',
      'Hill, J. (2000). "Revising priorities: from grammatical failure to '
          'collocational success".',
    ],
  ),

  // ─── 6. Phrasal verbs ────────────────────────────────────────────────
  VocabTopic(
    id: 'phrasal-verbs',
    section: 'Lexical relations',
    title: 'Phrasal Verbs',
    summary:
        'A phrasal verb is a multi-word verb whose meaning is not the sum '
        'of its parts: *look up* a word ≠ look in an upward direction. '
        'They are most frequent in spoken English; using them in writing '
        'sounds natural in IELTS Speaking but can lower register in '
        'academic essays.',
    lessons: [
      VocabLesson(
        title: 'Separable vs. inseparable',
        explanation:
            'Separable: an object pronoun must split the verb and particle '
            '— "I looked the word up" or "I looked it up" (✓) but never '
            '"I looked up it" (✗). Inseparable: object stays after the '
            'particle — "I ran into her" (✓), never "I ran her into".',
        examples: [
          VocabExample(text: '✓ I looked the word up. / I looked it up.'),
          VocabExample(text: '✗ I looked up it.'),
          VocabExample(text: '✓ I ran into her at the conference.'),
          VocabExample(text: '✗ I ran her into at the conference.'),
        ],
      ),
      VocabLesson(
        title: 'High-frequency phrasal verbs',
        explanation:
            'pick up = collect, learn casually; take off = remove, '
            'depart; turn down = refuse; come up with = invent; put off = '
            'postpone; figure out = solve; get over = recover from; bring '
            'up = mention, raise (a child); break down = stop working, '
            'lose composure; look up to = admire.',
        examples: [
          VocabExample(text: 'She picked up Italian during her year abroad.'),
          VocabExample(text: 'They turned down the offer.'),
          VocabExample(text: 'He came up with a clever solution.'),
        ],
      ),
      VocabLesson(
        title: 'Register: phrasal verb vs. one-word equivalent',
        explanation:
            'In academic writing, prefer the one-word Latinate equivalent: '
            'find out → discover, put off → postpone, get rid of → '
            'eliminate, bring about → cause, set up → establish, look '
            'into → investigate. In speaking, the phrasal verb is usually '
            'more natural.',
        visual: VocabVisual.registerScale,
        examples: [
          VocabExample(
              text: 'put off → postpone',
              note: 'Formal essays prefer "postpone"; speaking tolerates '
                  '"put off".'),
          VocabExample(
              text: 'look into → investigate',
              note: 'Same.'),
          VocabExample(
              text: 'set up → establish',
              note: 'Same.'),
        ],
      ),
    ],
    sources: [
      'McCarthy & O\'Dell (2017). English Phrasal Verbs in Use: Advanced. '
          'Cambridge UP.',
      'Biber, D. et al. (1999). Longman Grammar of Spoken and Written '
          'English, §5.10.',
      'Oxford Phrasal Verbs Dictionary, 2nd ed.',
    ],
  ),

  // ─── 7. Synonyms & register ──────────────────────────────────────────
  VocabTopic(
    id: 'synonyms-register',
    section: 'Lexical relations',
    title: 'Synonyms and Register',
    summary:
        'Two words almost never mean exactly the same thing. *Slim* and '
        '*skinny* both mean thin — but one is a compliment and the other '
        'often is not. Picking a synonym that does not match the register '
        'or connotation is a common high-band IELTS issue.',
    lessons: [
      VocabLesson(
        title: 'Register: formal vs. informal',
        explanation:
            'Latin- or Greek-origin words usually feel formal; '
            'Anglo-Saxon words usually feel neutral or informal. Compare '
            'commence vs. start; assist vs. help; sufficient vs. enough; '
            'purchase vs. buy; reside vs. live; numerous vs. many. In '
            'academic writing, the formal half is preferred; in '
            'conversation, the informal half is.',
        visual: VocabVisual.registerScale,
        examples: [
          VocabExample(text: 'commence ←→ begin ←→ start ←→ kick off'),
          VocabExample(text: 'inquire ←→ ask ←→ check ←→ poke around'),
          VocabExample(text: 'purchase ←→ buy ←→ pick up'),
        ],
      ),
      VocabLesson(
        title: 'Connotation: positive, neutral, negative',
        explanation:
            'Among near-synonyms, connotation often differs even when '
            'denotation matches. "Childlike" is positive (innocent, '
            'wondering); "childish" is negative (immature). "Confident" '
            'is positive; "arrogant" is negative; "assertive" is roughly '
            'neutral. Picking the wrong shading is the single fastest '
            'way to sound unintentionally rude in writing.',
        examples: [
          VocabExample(
              text: 'childlike (positive) vs. childish (negative)',
              note: 'Same denotation, opposite shading.'),
          VocabExample(
              text: 'slim (positive) vs. skinny (often negative)'),
          VocabExample(
              text: 'thrifty (positive) vs. stingy (negative)'),
        ],
      ),
    ],
    sources: [
      'Cruse, D. A. (2011). Meaning in Language, 3rd ed. Oxford UP, ch. 8.',
      'Schmitt & Schmitt (2014). "A reassessment of frequency and '
          'vocabulary size in L2 learning". Language Teaching 47(4).',
      'Cambridge Dictionary: thesaurus notes on register.',
    ],
  ),

  // ─── 8. Academic Word List ───────────────────────────────────────────
  VocabTopic(
    id: 'awl',
    section: 'Strategy',
    title: 'The Academic Word List (AWL)',
    summary:
        'Coxhead\'s 570-word Academic Word List captures the vocabulary '
        'that recurs across academic texts in every discipline. Mastering '
        'the AWL is, by a wide margin, the highest-leverage vocabulary '
        'investment for TOEFL and IELTS Reading.',
    lessons: [
      VocabLesson(
        title: 'What the AWL is',
        explanation:
            'Built in 2000 by Averil Coxhead from a 3.5-million-word '
            'corpus of academic English, the AWL contains 570 word '
            'families that are *not* in the most common 2,000 general '
            'words but *do* appear with high frequency in academic '
            'writing. The list is organised into 10 sublists by '
            'frequency.',
        examples: [
          VocabExample(
              text: 'Sublist 1 (most frequent): analysis, approach, '
                  'concept, evidence, factor, role, theory, research'),
          VocabExample(
              text: 'Sublist 5: definition, draft, generation, modify, '
                  'paragraph, prime'),
          VocabExample(
              text: 'Sublist 10 (least frequent but still academic-core): '
                  'adjacent, albeit, bulk, ongoing, persistent'),
        ],
      ),
      VocabLesson(
        title: 'How to study it',
        explanation:
            'Treat the AWL as 570 *families*, not 570 isolated words. '
            'Learn "analyse" together with "analysis, analyst, '
            'analytical, analytically" in a single sitting. Then look '
            'for those words in your reading practice — recognition in '
            'context is what consolidates the learning.',
        examples: [
          VocabExample(
              text: 'analyse → analysis · analyst · analytical · '
                  'analytically'),
          VocabExample(
              text: 'evidence → evident · evidently · evidenced'),
        ],
      ),
    ],
    sources: [
      'Coxhead, A. (2000). "A new Academic Word List". TESOL Quarterly '
          '34(2): 213–238.',
      'Coxhead, A. (2011). "The Academic Word List 10 years on: research '
          'and teaching implications". TESOL Quarterly 45(2).',
      'Schmitt (2010), ch. 6.',
    ],
  ),

  // ─── 9. Context clues ────────────────────────────────────────────────
  VocabTopic(
    id: 'context-clues',
    section: 'Strategy',
    title: 'Inferring Meaning from Context',
    summary:
        'TOEFL Reading routinely tests words you may not have met. Knowing '
        '*how to guess* from context is therefore as important as knowing '
        'the words themselves. Researchers identify four main types of '
        'in-text clue.',
    lessons: [
      VocabLesson(
        title: 'The four clue types',
        explanation:
            '(1) Definition or restatement — the text defines the word in '
            'apposition: "Cyanobacteria, microscopic organisms that '
            'produce oxygen…". (2) Contrast — a signal word like "but", '
            '"however", "unlike", "although" sets the unknown word '
            'against something known: "The first attempt was clumsy; the '
            'second was deft." (3) Example — "such as", "for instance", '
            '"like" enumerates instances: "Predators such as lions and '
            'wolves…". (4) Cause-effect — surrounding logic makes the '
            'meaning fit: "Because the soil was depleted, crops failed."',
        examples: [
          VocabExample(
              text: '"Cyanobacteria — microscopic organisms that produce '
                  'oxygen via photosynthesis — appeared 2.4 billion years '
                  'ago."',
              note: 'Definition in apposition gives "cyanobacteria" away.'),
          VocabExample(
              text: '"The first version was clumsy; the second was deft '
                  'and precise."',
              note: 'Contrast — "deft" must mean roughly the opposite of '
                  '"clumsy".'),
        ],
      ),
      VocabLesson(
        title: 'When not to guess',
        explanation:
            'If the sentence does not contain a clue and the word is '
            'central to the paragraph\'s argument, do not bluff — answer '
            'the questions you can and come back. Two unhelpful guesses '
            'in a row burn more time than one careful reread.',
        examples: [
          VocabExample(
              text: 'A word in a topic sentence with no surrounding '
                  'context is high-risk to guess.'),
        ],
      ),
    ],
    sources: [
      'Nation (2013), ch. 12.',
      'Grabe, W. & Stoller, F. (2011). Teaching and Researching Reading, '
          '2nd ed. Pearson.',
      'Paribakht, T. S. & Wesche, M. (1997). "Vocabulary enhancement '
          'activities and reading for meaning in second language '
          'vocabulary acquisition".',
    ],
  ),

  // ─── 10. Confused pairs ──────────────────────────────────────────────
  VocabTopic(
    id: 'confused-pairs',
    section: 'Precision',
    title: 'Commonly Confused Word Pairs',
    summary:
        'These are the words exam markers consistently flag — pairs that '
        'sound or look alike but mean different things. Mixing them up is '
        'usually treated as a content error, not a typo.',
    lessons: [
      VocabLesson(
        title: 'Affect vs. effect',
        explanation:
            '"Affect" is almost always a verb meaning "to influence". '
            '"Effect" is almost always a noun meaning "result". Mnemonic: '
            '*A*ffect = *A*ction (verb); *E*ffect = *E*nd result (noun).',
        examples: [
          VocabExample(text: '✓ Higher rainfall affects crop yields.',
              note: 'Verb.'),
          VocabExample(text: '✓ The effect of rainfall on crops is well '
              'documented.', note: 'Noun.'),
          VocabExample(text: '✗ The affect was severe.',
              note: 'Wrong — should be "effect" (noun).'),
        ],
      ),
      VocabLesson(
        title: 'Principal vs. principle',
        explanation:
            '"Principal" = chief, main; or the head of a school. '
            '"Principle" = a rule, law, or fundamental idea. Mnemonic: '
            'the schoo*l* princip*al* is your p*al*.',
        examples: [
          VocabExample(text: '✓ The principal cause of the failure was '
              'budget cuts.', note: 'Main cause.'),
          VocabExample(text: '✓ The principle of fairness underlies the '
              'policy.', note: 'A fundamental rule.'),
        ],
      ),
      VocabLesson(
        title: 'Other frequent traps',
        explanation:
            'complement (complete, go well with) vs. compliment (praise); '
            'further (more, beyond) vs. farther (greater physical '
            'distance); fewer (count nouns) vs. less (mass nouns); '
            'who\'s (who is) vs. whose (possessive); their / there / '
            'they\'re; lose (verb) vs. loose (adjective); ensure (make '
            'certain) vs. insure (provide insurance).',
        examples: [
          VocabExample(text: '✓ Fewer cars on the road meant less '
              'congestion.',
              note: '"Fewer" with count noun "cars"; "less" with mass '
                  'noun "congestion".'),
          VocabExample(text: '✓ The new flavour complements the wine.',
              note: '"Complement" — completes.'),
          VocabExample(text: '✓ She paid him a compliment.',
              note: '"Compliment" — praise.'),
        ],
      ),
    ],
    sources: [
      'Garner, B. A. (2016). Garner\'s Modern English Usage, 4th ed. '
          'Oxford UP.',
      'Merriam-Webster, "Usage Notes" archive.',
      'Cambridge Dictionary: confusing word entries.',
    ],
  ),
];
