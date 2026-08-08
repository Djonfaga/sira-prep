import 'content_grammar.dart';
import 'models.dart';

/// Hand-authored IELTS Academic content. The IELTS reading test is closer in
/// length and tone to the TOEFL passages here, with similar academic topics.
/// Speaking is structured around Parts 1–3 of the IELTS interview, and Writing
/// covers Task 1 (data description) and Task 2 (argumentative essay).
final ExamContent ieltsContent = ExamContent(
  reading: _ieltsReading,
  listening: _ieltsListening,
  speaking: _ieltsSpeaking,
  writing: _ieltsWriting,
  vocab: _ieltsVocab,
  mocks: _ieltsMocks,
  grammar: sharedGrammar,
);

const List<Passage> _ieltsReading = [
  Passage(
    id: 'i-r-1',
    title: 'The Spread of Tea',
    body:
        '''Tea is the most widely consumed beverage in the world after water, but its journey from a single region of southwestern China to a global staple reveals more about trade and culture than about agriculture. Wild tea plants probably evolved in what is today the border region of China, Myanmar, and India. Local communities used the leaves medicinally for centuries before formal cultivation began in the early dynasties of China.

By the eighth century, tea had become a Chinese cultural institution. Buddhist monks adopted it during long meditations, scholars wrote on its preparation, and rulers taxed it. Carrying the leaves north along the Silk Road and east to Japan turned tea into a commodity with religious, medical, and political weight. The Japanese tea ceremony, which emerged later, drew on this Chinese inheritance but transformed it into an art of restraint and presence.

The European story is more abrupt. Dutch traders introduced tea to the Netherlands in the seventeenth century, and English consumption exploded after the British East India Company began direct imports. Heavy taxes and chronic trade deficits eventually prompted the British to cultivate tea in their Indian colonies, ending the Chinese monopoly. The plantation system that grew up in Assam and Sri Lanka reorganized vast landscapes and labor markets.

Today, tea cultivation supports millions of smallholders worldwide. Yet the legacy of its long history is visible in everything from packaging conventions to the global commodity exchanges that set its prices. The leaf that began as a wild plant on a single hillside now exists in dozens of national styles, each carrying centuries of borrowing and reinvention.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, tea was first used by local communities for:',
        options: ['ceremony', 'fuel', 'medicine', 'trade'],
        answer: 'medicine',
      ),
      MCQuestion(
        question: 'The British began cultivating tea in India because:',
        options: [
          'Chinese tea was banned.',
          'They wanted to end their dependence on Chinese supply.',
          'Indian climate was unsuitable for other crops.',
          'European demand had collapsed.',
        ],
        answer: 'They wanted to end their dependence on Chinese supply.',
      ),
      MCQuestion(
        question: 'The Japanese tea ceremony is described as:',
        options: [
          'A purely Chinese tradition.',
          'A transformation of Chinese inheritance into an art of restraint.',
          'A modern invention.',
          'A medical practice.',
        ],
        answer: 'A transformation of Chinese inheritance into an art of restraint.',
      ),
      MCQuestion(
        question: 'The word "monopoly" most nearly means:',
        options: ['ownership', 'exclusive control', 'shortage', 'sale'],
        answer: 'exclusive control',
      ),
    ],
  ),
  Passage(
    id: 'i-r-2',
    title: 'Sleep and the Modern Worker',
    body:
        '''Researchers have spent decades documenting what most adults already suspect: modern work and modern life conspire against sleep. The average adult sleeps roughly one to two hours less than recommended, and the gap is largest in countries where employment is most intense. The consequences are not only economic, in the form of lost productivity, but personal — slower reflexes, reduced memory consolidation, higher long-term disease risk.

Several conditions of contemporary work fuel the problem. Shift schedules disrupt circadian rhythms, forcing the body to work against its natural cycle. Bright artificial light, especially the blue light of screens used late at night, suppresses melatonin and delays sleep onset. Many workplaces also reward visible long hours, regardless of whether those hours produce results. The cumulative effect is a culture in which sleep itself is treated as optional.

Sleep research, by contrast, increasingly treats sleep as a critical part of work, not a deduction from it. Studies in transportation, medicine, and the military show that well-rested workers make fewer errors, recover faster from mistakes, and sustain attention longer. Some hospitals have shortened resident shifts. Some long-haul carriers schedule mandatory rest. Even certain technology firms now monitor late-night messaging as a warning signal of overwork.

Individual habits matter too. Consistent bedtimes, cool dark rooms, and reduced screen exposure before sleep are reliable interventions backed by research. But the deeper change has to come from organizations. As long as productivity is measured in hours present rather than work delivered, sleep deprivation will remain a structural feature of modern professional life.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, modern workplaces tend to:',
        options: [
          'Reward visible long hours regardless of output.',
          'Encourage afternoon naps.',
          'Forbid the use of artificial light.',
          'Provide compulsory sleep training.',
        ],
        answer: 'Reward visible long hours regardless of output.',
      ),
      MCQuestion(
        question: 'Why does the passage mention hospitals and long-haul carriers?',
        options: [
          'To criticize their hiring practices.',
          'To show that some industries treat rest as essential to performance.',
          'To argue against night work in any field.',
          'To complain about regulation.',
        ],
        answer: 'To show that some industries treat rest as essential to performance.',
      ),
      MCQuestion(
        question: 'According to the author, the deeper change in sleep culture must come from:',
        options: ['individuals', 'organizations', 'governments', 'app developers'],
        answer: 'organizations',
      ),
      MCQuestion(
        question: 'The word "structural" in the passage is closest in meaning to:',
        options: ['temporary', 'built-in', 'visible', 'expensive'],
        answer: 'built-in',
      ),
    ],
  ),
  Passage(
    id: 'i-r-3',
    title: 'The Return of the Wolf',
    body:
        '''When wolves were reintroduced to Yellowstone National Park in 1995, the project had a narrow goal: to restore a top predator that had been hunted out of the region almost seventy years earlier. The biologists involved expected ecological effects, but few anticipated how dramatic those effects would be, or how visible they would become to ordinary park visitors within just a decade.

The most striking changes involved elk. Wolves directly reduced their numbers, but they also changed elk behavior. Elk stopped lingering in narrow valleys where escape routes were poor, allowing willow and aspen trees in those valleys to grow back. The recovering vegetation in turn supported beaver, songbirds, and even riverbank stability. The Yellowstone story became one of the most-cited examples of a "trophic cascade," in which a single change at the top of the food web rearranges much of what lies below.

Yet researchers caution against simple narratives. Some of the changes observed at Yellowstone may also reflect climate variability, reduced human pressure, and the rebound of other predators. Disentangling these factors requires careful long-term study, and not every reintroduction will produce comparable results elsewhere.

Even so, the political effect has been profound. Conservationists point to Yellowstone when arguing for the restoration of large carnivores in Europe and Asia. Communities that share landscapes with wolves continue to negotiate the costs — to livestock, to safety — alongside the benefits. The wolf, in this sense, has returned not only as a biological actor but as a focal point for how societies imagine wild landscapes.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, the most surprising aspect of the wolf reintroduction was:',
        options: [
          'How quickly the changes spread through the ecosystem.',
          'That elk numbers did not change at all.',
          'That wolves had to be brought from Asia.',
          'That the program was over budget.',
        ],
        answer: 'How quickly the changes spread through the ecosystem.',
      ),
      MCQuestion(
        question: 'Recovering vegetation in valleys was driven primarily by:',
        options: [
          'Direct planting by park staff.',
          'Changes in elk behavior.',
          'Increased rainfall.',
          'Tourist activity.',
        ],
        answer: 'Changes in elk behavior.',
      ),
      MCQuestion(
        question: 'A "trophic cascade" refers to:',
        options: [
          'A waterfall in a forest.',
          'A chain of ecological effects triggered by a change at the top of the food web.',
          'A loss of predators leading to grassland.',
          'The migration of large mammals.',
        ],
        answer: 'A chain of ecological effects triggered by a change at the top of the food web.',
      ),
      MCQuestion(
        question: 'What caution do researchers offer about Yellowstone\'s story?',
        options: [
          'It cannot easily be transferred to every other ecosystem.',
          'The wolves were never reintroduced.',
          'The elk population is now extinct.',
          'Climate variability has no effect on parks.',
        ],
        answer: 'It cannot easily be transferred to every other ecosystem.',
      ),
    ],
  ),
  Passage(
    id: 'i-r-4',
    title: 'Why Cities Are Hot',
    body:
        '''Anyone who has walked from a city park into a sun-baked plaza on a summer afternoon knows that cities feel hotter than the countryside around them. This effect, called the urban heat island, can raise nighttime temperatures by several degrees and add significantly to the cost of cooling in buildings. The physics behind it is straightforward, even if the solutions are not.

Dark surfaces — asphalt streets and tar rooftops — absorb solar radiation during the day and re-emit it as heat well after sunset. Tall buildings trap that radiation in narrow street canyons, slowing nocturnal cooling. Vehicles, air conditioners, and industrial activity each contribute their own waste heat directly into the local atmosphere. Vegetation, which would normally cool the air by evapotranspiration, is often scarce.

Counterintuitively, the worst health effects of heat islands appear at night. Daytime temperatures may be only slightly higher than in nearby rural areas, but the inability of cities to cool down after dark deprives residents of recovery time. Vulnerable groups — older adults, those without air conditioning, outdoor workers — bear the heaviest burden.

Mitigation involves a familiar toolkit. Lighter-colored roofs and pavements reflect more sunlight back into space. Tree canopy and pocket parks lower local temperatures by shade and transpiration. Even simple measures, like requiring reflective material on new construction, can shift the trajectory of a neighborhood over a decade. The challenge is rarely technological; it is convincing many small actors to coordinate.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, the worst health effects of urban heat islands occur:',
        options: ['at midday', 'at night', 'in winter', 'underground'],
        answer: 'at night',
      ),
      MCQuestion(
        question: 'Why does vegetation reduce urban heat?',
        options: [
          'It reflects light into buildings.',
          'It cools the air through evapotranspiration.',
          'It absorbs carbon dioxide.',
          'It physically blocks asphalt.',
        ],
        answer: 'It cools the air through evapotranspiration.',
      ),
      MCQuestion(
        question: 'The author concludes that the main obstacle to mitigation is:',
        options: [
          'Lack of technology.',
          'Convincing many small actors to coordinate.',
          'The expense of new pavement.',
          'Restrictions on rooftop construction.',
        ],
        answer: 'Convincing many small actors to coordinate.',
      ),
      MCQuestion(
        question: 'The word "transpiration" in the passage is closest in meaning to:',
        options: ['photosynthesis', 'release of water from plants', 'shade', 'pollination'],
        answer: 'release of water from plants',
      ),
    ],
  ),
  Passage(
    id: 'i-r-5',
    title: 'Beyond GDP',
    body:
        '''For most of the twentieth century, the gross domestic product (GDP) of a country served as the dominant measure of its economic success. GDP captures the total value of goods and services produced within a country and is easy to compare across borders. Yet for decades, economists and policymakers have argued that GDP measures the wrong things — and misses important ones entirely.

The complaints fall into several categories. GDP includes economic activity that is not socially desirable, such as the cleanup costs of an oil spill or the medical bills generated by car accidents. It excludes important activity that has no market price, such as unpaid caregiving and most volunteer work. It also ignores how income is distributed: two countries can have identical GDP per person while one has broad shared prosperity and the other extreme concentration of wealth.

Alternative indices have proliferated. The Human Development Index combines income with measures of education and life expectancy. The Genuine Progress Indicator subtracts environmental and social costs from production. The OECD\'s Better Life Index lets users weight indicators such as work-life balance and civic engagement according to their own values.

None of these has displaced GDP, in part because no single index can serve every purpose. But the conversation has shifted. Major statistical agencies now publish a wider range of indicators, and policymakers increasingly speak of "well-being" rather than growth alone. The question is no longer whether GDP is enough, but which combination of measures gives the most useful picture of how a society is doing.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, one criticism of GDP is that it:',
        options: [
          'Cannot be compared across countries.',
          'Misses unpaid activity like caregiving.',
          'Includes only government spending.',
          'Excludes oil-spill cleanup costs.',
        ],
        answer: 'Misses unpaid activity like caregiving.',
      ),
      MCQuestion(
        question: 'The Genuine Progress Indicator differs from GDP by:',
        options: [
          'Including the value of leisure.',
          'Subtracting environmental and social costs from production.',
          'Ignoring international trade.',
          'Counting only manufacturing.',
        ],
        answer: 'Subtracting environmental and social costs from production.',
      ),
      MCQuestion(
        question: 'According to the passage, alternative indices have:',
        options: [
          'Replaced GDP in most countries.',
          'Proliferated but not replaced GDP.',
          'Been abandoned by major agencies.',
          'Only existed in academic papers.',
        ],
        answer: 'Proliferated but not replaced GDP.',
      ),
      MCQuestion(
        question: 'The author suggests that the current question is:',
        options: [
          'Whether to keep GDP at all.',
          'Which combination of measures is most useful.',
          'How to standardize a single global index.',
          'Whether economics is a real science.',
        ],
        answer: 'Which combination of measures is most useful.',
      ),
    ],
  ),
  Passage(
    id: 'i-r-6',
    title: 'How Cinema Spread Across the World',
    body:
        '''When motion pictures first emerged in the 1890s, no one expected the rapidity with which the medium would take hold. The first short films were curiosities at fairs and music halls — a moving train, a worker leaving a factory, a horse galloping. Within a single generation, dedicated theaters had appeared in every major city in Europe and North America, and the new industry employed hundreds of thousands of people.

The spread depended on technology that crossed borders easily. A reel of celluloid film could be shipped from Paris to Cairo or from Hollywood to Tokyo and projected, with translation provided by intertitles or, later, dubbing. Local markets adapted quickly: silent films were almost universal, since the absence of spoken dialogue removed the language barrier; the arrival of synchronized sound in the late 1920s briefly disrupted this, forcing studios in countries with their own languages to invest in dubbing and parallel productions.

Cinema also reorganized urban life. Theaters became a new kind of public space, drawing audiences from different classes and neighborhoods. Newsreels, shown before main features, were many citizens\' primary source of moving footage from the rest of the world for decades. In countries with restrictive political environments, the same theaters served as venues for state propaganda; in others, they were comparatively free spaces where new ideas could circulate.

The industry today looks unlike the small workshops of its earliest years, but the underlying mechanics persist. A successful film is a globally distributed product, and the choice of language, casting, and theme is shaped accordingly. Local industries — in India, Nigeria, South Korea — have grown enormous, sometimes producing more titles per year than Hollywood itself. The medium that began as a fairground curiosity is now one of the most globally consumed art forms in history.''',
    questions: [
      MCQuestion(
        question: 'What allowed early cinema to spread quickly across borders?',
        options: [
          'Government subsidies in every country.',
          'A medium that was largely silent and easily shipped on reels.',
          'A common spoken language.',
          'Free distribution by Hollywood.',
        ],
        answer: 'A medium that was largely silent and easily shipped on reels.',
      ),
      MCQuestion(
        question: 'What briefly disrupted international film distribution?',
        options: [
          'The introduction of color.',
          'The arrival of synchronized sound in the late 1920s.',
          'The Great Depression.',
          'The decline of intertitles.',
        ],
        answer: 'The arrival of synchronized sound in the late 1920s.',
      ),
      MCQuestion(
        question: 'According to the passage, theaters in cities served as:',
        options: [
          'Restaurants for the wealthy.',
          'A new kind of public space drawing audiences from different classes.',
          'Sites only for state propaganda.',
          'Strictly private institutions.',
        ],
        answer: 'A new kind of public space drawing audiences from different classes.',
      ),
      MCQuestion(
        question: 'What does the passage say about local film industries today?',
        options: [
          'They have disappeared.',
          'Some produce more titles per year than Hollywood itself.',
          'They depend entirely on European funding.',
          'They make only documentaries.',
        ],
        answer: 'Some produce more titles per year than Hollywood itself.',
      ),
      MCQuestion(
        question: 'The word "celluloid" most nearly refers to:',
        options: [
          'A type of theater seat.',
          'The flexible film stock used in early cinema.',
          'A film festival.',
          'A camera lens.',
        ],
        answer: 'The flexible film stock used in early cinema.',
      ),
    ],
  ),
  Passage(
    id: 'i-r-7',
    title: 'The Domestication of the Horse',
    body:
        '''The horse was one of the last large mammals to be domesticated. Cattle, sheep, and goats had all been brought under human care thousands of years earlier, but the horse, fast and powerful, resisted close handling. Recent genetic and archaeological work has narrowed the origin of modern domestic horses to the steppe regions of what is today southern Russia and Kazakhstan, around 4,500 years ago. From that single homeland the new horses spread with extraordinary speed.

The transformation that followed reshaped human societies in several ways. Tame horses gave their riders a previously unmatched advantage in mobility. A mounted rider could cover seventy or eighty kilometers in a day; an unmounted traveler could manage perhaps twenty. The implications for trade, communication, and military activity were obvious almost immediately, and grasslands across Eurasia became corridors of unprecedented movement.

Horses also reshaped agriculture. Where conditions allowed, they replaced oxen in plowing because they pulled faster and could work on terrain that had been marginal before. Settled farming communities and pastoral herding societies, which once had little to do with each other, began to interact along contested borders. Some of the earliest written records from Mesopotamia, the Indus Valley, and ancient China make sense only when read against the backdrop of these long-range encounters.

Modern researchers studying ancient DNA have shown that the horses bred in this initial expansion were unusually docile and capable of carrying weight on their backs. These traits, once thought to have emerged slowly, appear to have been selected for very rapidly. The evidence reinforces a broader pattern in domestication: when humans need a useful trait quickly, selection can move at a pace far closer to that of plant breeding than was once imagined.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, when and where were modern domestic horses first developed?',
        options: [
          'Western Europe, around 1000 BCE.',
          'The Eurasian steppe, around 4,500 years ago.',
          'East Asia, in the medieval period.',
          'North Africa, around 10,000 years ago.',
        ],
        answer: 'The Eurasian steppe, around 4,500 years ago.',
      ),
      MCQuestion(
        question: 'What advantage did mounted riders have over those on foot?',
        options: [
          'They could carry no goods.',
          'They could travel three or four times faster per day.',
          'They needed less food than walkers.',
          'They were immune to disease.',
        ],
        answer: 'They could travel three or four times faster per day.',
      ),
      MCQuestion(
        question: 'How did horses affect agriculture in some regions?',
        options: [
          'They forced farmers to abandon plowing.',
          'They replaced oxen in plowing because they pulled faster and could handle more terrain.',
          'They eliminated the need for crops.',
          'They were used only ceremonially.',
        ],
        answer: 'They replaced oxen in plowing because they pulled faster and could handle more terrain.',
      ),
      MCQuestion(
        question: 'What recent finding does the author highlight?',
        options: [
          'Domestication is always a slow process.',
          'Selection for useful traits can occur at a much faster pace than once thought.',
          'Horses are descended from cattle.',
          'Wild horses never existed in Eurasia.',
        ],
        answer: 'Selection for useful traits can occur at a much faster pace than once thought.',
      ),
      MCQuestion(
        question: 'The passage describes pre-domestication horses as:',
        options: [
          'Naturally tame.',
          'Fast, powerful animals that resisted close handling.',
          'Smaller than modern dogs.',
          'Found only in deserts.',
        ],
        answer: 'Fast, powerful animals that resisted close handling.',
      ),
    ],
  ),
  Passage(
    id: 'i-r-8',
    title: 'Why Birds Migrate',
    body:
        '''Each year, billions of birds travel between breeding grounds and winter ranges, sometimes crossing entire continents. The behavior is so familiar that it can feel like a simple instinct, but the underlying biology is among the most intricate problems in animal physiology. Birds migrate because doing so increases the odds that they will eat, reproduce, and avoid the worst conditions of seasonal climates. Why they migrate the specific routes they follow is harder to explain.

Some species, like the Arctic tern, breed in the high Arctic and winter in the Antarctic — a return trip of more than 70,000 kilometers a year, the longest known annual migration. Others move only as far as the next valley or stay where they are when winters are mild. The variation suggests that migration is not a single behavior but a flexible response to local conditions, fine-tuned by selection over generations.

Navigation poses the central puzzle. Birds use several systems in parallel. They can read the position of the sun and the stars, sense the earth\'s magnetic field through specialized cells in their eyes, and remember landmarks along familiar routes. Young birds on their first migration sometimes use innate cues that have been genetically inherited from their parents; older birds incorporate experience. Disabling any one of these systems usually does not stop a bird from arriving, but a combination of disruptions can.

The seasonal calendar is also under fine biological control. Hormonal changes triggered by day length prepare birds for the energetic demands of flight: feathers regrow, fat reserves are built up, and behavior shifts toward restlessness. In recent decades, climate change has disrupted this calendar in measurable ways. Some species now arrive at breeding grounds before the insects on which they depend have hatched. The mismatch is one of the clearest contemporary examples of how a changing environment can outpace evolution.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, why do birds migrate?',
        options: [
          'To experience new landscapes.',
          'To increase their odds of eating, reproducing, and avoiding bad conditions.',
          'Because their feathers force them to.',
          'To escape predators.',
        ],
        answer: 'To increase their odds of eating, reproducing, and avoiding bad conditions.',
      ),
      MCQuestion(
        question: 'Which navigation system is mentioned in the passage?',
        options: [
          'GPS chips inherited from parents.',
          'Sensing the earth\'s magnetic field through specialized cells in the eyes.',
          'Following the smell of the ocean.',
          'Listening for the calls of other species.',
        ],
        answer: 'Sensing the earth\'s magnetic field through specialized cells in the eyes.',
      ),
      MCQuestion(
        question: 'What does the variation in migration distances suggest?',
        options: [
          'That migration is a single, fixed behavior.',
          'That migration is a flexible response to local conditions.',
          'That all birds travel the same distance.',
          'That migration is purely random.',
        ],
        answer: 'That migration is a flexible response to local conditions.',
      ),
      MCQuestion(
        question: 'Why is the mismatch with hatching insects significant?',
        options: [
          'It proves that birds prefer cold weather.',
          'It demonstrates how environmental change can outpace evolutionary adjustment.',
          'It shows that birds do not need insects.',
          'It eliminates the need for migration.',
        ],
        answer: 'It demonstrates how environmental change can outpace evolutionary adjustment.',
      ),
      MCQuestion(
        question: 'According to the passage, what triggers seasonal preparation for migration?',
        options: [
          'Rainfall patterns.',
          'Hormonal changes triggered by day length.',
          'Volcanic activity.',
          'The behavior of other species.',
        ],
        answer: 'Hormonal changes triggered by day length.',
      ),
    ],
  ),
  Passage(
    id: 'i-r-9',
    title: 'Bicycles and the City',
    body:
        '''For most of the twentieth century, urban planning in Europe and North America assumed that the private car was the future. Streets were widened to admit more traffic, parking was mandated for nearly every new building, and bicycles were treated as recreational tools rather than serious transport. The result, in many cities, was congestion that no amount of additional road space could relieve. A growing number of planners now treat the bicycle as part of the answer rather than a curiosity.

The change has been most visible in northern Europe. Cities such as Copenhagen and Utrecht built networks of separated bicycle lanes over several decades. The infrastructure made cycling feel safe for people who would not otherwise have considered it — children, older adults, the cautious. Once a critical mass of riders existed, the political pressure to maintain and expand the network became self-reinforcing.

The same approach has begun to spread elsewhere. Paris, long dominated by cars, doubled its bicycle network within a few years and reported significant drops in car traffic. New York added protected lanes to bridges and avenues that had been unusable to most cyclists. The benefits — lower emissions, less noise, healthier residents, easier access to local commerce — were repeatedly larger than projections.

Yet bicycles are not a complete answer. Long distances, heavy loads, and harsh weather still limit ridership. The most successful cities combine cycling with frequent transit, restricted private-car traffic in dense areas, and walkable neighborhoods. The bicycle works best as one part of a portfolio. Cities that have built that portfolio find that the streets are quieter, less polluted, and used by a wider range of people than at any time since the automobile became dominant.''',
    questions: [
      MCQuestion(
        question: 'For most of the twentieth century, urban planning assumed that:',
        options: [
          'The bicycle would dominate transport.',
          'The private car was the future.',
          'Cities would all become pedestrian-only.',
          'Public transit would replace all other modes.',
        ],
        answer: 'The private car was the future.',
      ),
      MCQuestion(
        question: 'According to the passage, why did separated bicycle lanes matter in northern Europe?',
        options: [
          'They eliminated bicycle traffic.',
          'They made cycling feel safe for groups that would not otherwise have considered it.',
          'They were required by EU law.',
          'They were originally built for trains.',
        ],
        answer: 'They made cycling feel safe for groups that would not otherwise have considered it.',
      ),
      MCQuestion(
        question: 'What outcome did Paris report after expanding its bicycle network?',
        options: [
          'No change in car traffic.',
          'Significant drops in car traffic.',
          'A return to horse-drawn carriages.',
          'A doubling of subway fares.',
        ],
        answer: 'Significant drops in car traffic.',
      ),
      MCQuestion(
        question: 'The author argues that cycling is most effective when:',
        options: [
          'It is the only allowed mode of transport.',
          'It is combined with transit, walkability, and restricted private-car traffic.',
          'It is limited to recreational riders.',
          'It replaces all roads with bike paths.',
        ],
        answer: 'It is combined with transit, walkability, and restricted private-car traffic.',
      ),
      MCQuestion(
        question: 'According to the passage, the modern shift toward cycling was driven partly by:',
        options: [
          'Falling car prices.',
          'Congestion that no amount of additional road space could relieve.',
          'A shortage of asphalt.',
          'A ban on driving for the elderly.',
        ],
        answer: 'Congestion that no amount of additional road space could relieve.',
      ),
    ],
  ),
  Passage(
    id: 'i-r-10',
    title: 'The Coffee Plant',
    body:
        '''Coffee is now the second most-traded commodity in the world, but its global story began with a single small region in the highlands of what is today southwestern Ethiopia. The plant that produces commercial coffee, Coffea arabica, grows naturally in shaded forests there. Local traditions of roasting and brewing the beans are at least a thousand years old, and possibly much older.

The plant\'s spread depended on a sequence of historical accidents. By the fifteenth century, coffee had crossed the Red Sea to Yemen, where Sufi orders adopted it as an aid to nightlong devotional practice. From Yemeni ports it travelled along the Ottoman trade network. Coffeehouses appeared first in Mecca, then in Istanbul, and finally in seventeenth-century Vienna and London. Each city adapted the drink and the social setting around it.

Cultivation eventually escaped the Arabian peninsula. The Dutch carried seedlings to their Asian colonies and to South America; Brazil, in particular, became the world\'s dominant producer by the nineteenth century. The price of coffee fell as supply scaled up, and a drink once consumed only in religious or elite contexts became a daily commodity for hundreds of millions of people.

The contemporary coffee economy is sometimes described in terms of distance: a producer in rural Ethiopia, Vietnam, or Colombia is separated by many intermediaries from the cup served in a café in Berlin or Seoul. Fair-trade and specialty-coffee movements try to compress that distance — paying producers more, telling customers where the beans were grown — but the structural challenges remain. Climate change adds another layer: arabica thrives only in a narrow temperature band, and warming highlands are pushing cultivation higher year by year, sometimes off the available land entirely.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, where did Coffea arabica originate?',
        options: [
          'Yemen.',
          'The highlands of what is today southwestern Ethiopia.',
          'Vietnam.',
          'Colombia.',
        ],
        answer: 'The highlands of what is today southwestern Ethiopia.',
      ),
      MCQuestion(
        question: 'Why did Sufi orders adopt coffee in Yemen?',
        options: [
          'It was cheaper than tea.',
          'As an aid to nightlong devotional practice.',
          'It was required by trade law.',
          'They cultivated it themselves.',
        ],
        answer: 'As an aid to nightlong devotional practice.',
      ),
      MCQuestion(
        question: 'Which country became the world\'s dominant producer by the nineteenth century?',
        options: [
          'Indonesia.',
          'Brazil.',
          'Ethiopia.',
          'Vietnam.',
        ],
        answer: 'Brazil.',
      ),
      MCQuestion(
        question: 'What new challenge does climate change pose to coffee production?',
        options: [
          'Arabica grows everywhere now.',
          'Warming highlands are pushing cultivation higher and sometimes off the available land.',
          'Coffee no longer sells.',
          'Coffeehouses are illegal.',
        ],
        answer: 'Warming highlands are pushing cultivation higher and sometimes off the available land.',
      ),
      MCQuestion(
        question: 'The author describes the modern coffee economy in terms of:',
        options: [
          'Distance between producers and consumers, with many intermediaries.',
          'Direct face-to-face sales between farmers and drinkers.',
          'A single global marketplace with no intermediaries.',
          'A government monopoly.',
        ],
        answer: 'Distance between producers and consumers, with many intermediaries.',
      ),
    ],
  ),
  Passage(
    id: 'i-r-11',
    title: 'The Cinematic City',
    body:
        '''Cities and films have an unusual relationship. A great deal of what audiences imagine when they think of cities — neon streets, narrow alleys, late-night cafés — comes from movies, not from any actual urban experience. Architects sometimes complain that cinema has trained the public to expect a kind of urban scenery that nobody actually inhabits.

The relationship runs in both directions. Filmmakers borrow from the city as much as they shape it. Postwar Italian cinema, often shot on real streets in Rome, made stones and rubble into characters. Hong Kong\'s crowded skyline and rain-soaked nights became a signature visual style copied by directors worldwide. New York in the 1970s, depicted as both dangerous and exhilarating, fed an entire generation\'s idea of the city.

Cities also use their cinematic image strategically. Tourism boards highlight the buildings audiences have seen on screen. Municipal authorities offer tax credits to film crews because the on-screen exposure is, in effect, a long-form advertisement. Some districts that became famous through film have permanently shifted their character as a result, drawing new residents and businesses oriented around the image.

The most attentive students of cinema, however, note a tension. The city on film is always selective; it shows what the camera can frame, while leaving out the routine, the unphotogenic, the in-between. A viewer who later visits the place often experiences mild disappointment — the streets are shorter, the lighting flatter, the noise harsher than the screen suggested. Cinema, in this view, produces not only a kind of love for cities but also a built-in dissatisfaction with the real one.''',
    questions: [
      MCQuestion(
        question: 'What complaint do architects sometimes make about cinema?',
        options: [
          'That it ignores cities altogether.',
          'That it has trained the public to expect a kind of urban scenery nobody actually inhabits.',
          'That films are too short.',
          'That set design is too expensive.',
        ],
        answer: 'That it has trained the public to expect a kind of urban scenery nobody actually inhabits.',
      ),
      MCQuestion(
        question: 'Why does the passage mention postwar Italian cinema?',
        options: [
          'To argue that Rome should ban filming.',
          'As an example of films borrowing directly from real streets to shape a city\'s image.',
          'To prove that all good films are Italian.',
          'To criticize the use of color.',
        ],
        answer: 'As an example of films borrowing directly from real streets to shape a city\'s image.',
      ),
      MCQuestion(
        question: 'How do cities use their cinematic image, according to the passage?',
        options: [
          'They forbid all filming.',
          'Tourism boards highlight on-screen locations and crews receive tax credits.',
          'They charge tourists to walk on streets.',
          'They produce their own films exclusively.',
        ],
        answer: 'Tourism boards highlight on-screen locations and crews receive tax credits.',
      ),
      MCQuestion(
        question: 'Why might a viewer feel disappointed when visiting a famous filmed city?',
        options: [
          'Streets and lighting are less dramatic than on screen.',
          'No tourists are allowed.',
          'There are no buildings.',
          'Cinema audiences are pickier than travelers.',
        ],
        answer: 'Streets and lighting are less dramatic than on screen.',
      ),
      MCQuestion(
        question: 'The author\'s overall point is that:',
        options: [
          'Cinema and cities have no influence on each other.',
          'Cinema produces both love for cities and a built-in dissatisfaction with the real one.',
          'Real cities are perfect.',
          'Filmmaking should be banned.',
        ],
        answer: 'Cinema produces both love for cities and a built-in dissatisfaction with the real one.',
      ),
    ],
  ),
  Passage(
    id: 'i-r-12',
    title: 'The Lifespans of Trees',
    body:
        '''Some trees live for thousands of years. A bristlecone pine in the White Mountains of California has been verified at over 4,800 years; a colony of quaking aspen in Utah, all genetically identical and connected by a single root system, may be older still. To put the durations in perspective: the oldest individual bristlecones germinated before the Egyptian pyramids were built and were already mature when the Roman empire fell.

Researchers studying tree longevity have asked what distinguishes the long-lived species. The answer turns out to be not a single trait but a combination. Many of the oldest trees grow in harsh sites — high altitudes, exposed ridges, thin soils — where they grow slowly. Slow growth produces wood that is dense and resinous, resistant to fungal attack and able to seal off injuries. The same conditions deter many of the competitors and herbivores that shorten the lives of trees in richer environments.

Other species achieve longevity through different routes. Sequoias and giant redwoods on the Pacific coast grow large and tall, with thick fire-resistant bark and a chemistry that discourages most decomposers. Olive trees in the Mediterranean can be reduced repeatedly to a hollow shell and still continue to grow. The colony of aspen mentioned above survives because individual stems live for only about a century, but the underlying root system reproduces them indefinitely.

The conservation lessons are significant. The wood from old trees is often valuable, and many of the longest-lived populations are within reach of logging or development. Once cut, a 4,000-year-old organism cannot meaningfully be replaced; even an aspen colony, with its underground continuity, depends on intact roots to persist. Saving these populations requires the recognition that a single tree, in some cases, encodes more accumulated history than entire cultures around it.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, why do many of the oldest individual trees grow in harsh sites?',
        options: [
          'They are unable to compete elsewhere.',
          'Slow growth produces dense, resinous wood, and harsh sites deter competitors and herbivores.',
          'Such sites have the best soil.',
          'Local people only allow trees there.',
        ],
        answer: 'Slow growth produces dense, resinous wood, and harsh sites deter competitors and herbivores.',
      ),
      MCQuestion(
        question: 'How do sequoias achieve longevity?',
        options: [
          'They produce many small offspring each year.',
          'They grow large with thick fire-resistant bark and chemistry that discourages decomposers.',
          'They prevent any fire from ever touching them.',
          'They reproduce only through human cultivation.',
        ],
        answer: 'They grow large with thick fire-resistant bark and chemistry that discourages decomposers.',
      ),
      MCQuestion(
        question: 'Why does the passage mention the aspen colony in Utah?',
        options: [
          'To show that aspen leaves are blue.',
          'As an example of longevity achieved through an underground root system that reproduces stems indefinitely.',
          'To argue against tree conservation.',
          'Because it is the tallest tree on record.',
        ],
        answer: 'As an example of longevity achieved through an underground root system that reproduces stems indefinitely.',
      ),
      MCQuestion(
        question: 'What conservation concern is highlighted?',
        options: [
          'Old trees are too short for lumber.',
          'A 4,000-year-old organism cannot meaningfully be replaced once cut.',
          'Aspens are common and cannot be lost.',
          'The market for tree wood has collapsed.',
        ],
        answer: 'A 4,000-year-old organism cannot meaningfully be replaced once cut.',
      ),
      MCQuestion(
        question: 'The author\'s underlying claim about old trees is that:',
        options: [
          'They are biologically unimportant.',
          'A single tree may encode more accumulated history than entire cultures around it.',
          'Tree lifespans are exaggerated.',
          'Old trees produce no seeds.',
        ],
        answer: 'A single tree may encode more accumulated history than entire cultures around it.',
      ),
    ],
  ),
];

const List<Lecture> _ieltsListening = [
  Lecture(
    id: 'i-l-1',
    title: 'IELTS Section 1: Booking a Course',
    transcript:
        "Receptionist: Hi, welcome to the language center. How can I help you? Student: I'd like to register for the evening course in business English. Receptionist: Of course. The course runs twice a week — Tuesday and Thursday — and lasts ten weeks. The fee is two hundred and forty pounds. Student: Is there a discount for students? Receptionist: Yes, if you bring a valid student ID you get fifteen percent off, so it would be two hundred and four pounds.",
    questions: [
      MCQuestion(
        question: 'What is the discounted fee for the course?',
        options: ['£240', '£204', '£180', '£300'],
        answer: '£204',
      ),
    ],
  ),
  Lecture(
    id: 'i-l-2',
    title: 'IELTS Section 4: Lecture on Urban Greening',
    transcript:
        "Professor: Today I want to look at three strategies for cooling cities. The first is increasing tree canopy. Trees provide shade and also release water vapor that cools the surrounding air. The second strategy is reflective surfaces — so we paint roofs and pavements in light colors that bounce sunlight back rather than absorbing it. The third strategy is denser, mixed-use development that reduces the distance people need to travel by car, since waste heat from vehicles is itself a major contributor to the urban heat island effect.",
    questions: [
      MCQuestion(
        question: 'Which is NOT mentioned as a cooling strategy?',
        options: [
          'Reflective roofs.',
          'Tree canopy expansion.',
          'Indoor air conditioning subsidies.',
          'Denser mixed-use development.',
        ],
        answer: 'Indoor air conditioning subsidies.',
      ),
    ],
  ),
  Lecture(
    id: 'i-l-3',
    title: 'IELTS Section 2: Museum Tour Briefing',
    transcript:
        "Guide: Welcome to the National Museum. Before we start, a few quick notes. The cloakroom is straight ahead on your left. Photography is allowed in all galleries except the new South Asia exhibition, where flash and tripods are forbidden. Our café on the second floor closes at four o'clock, so if you want a coffee, plan accordingly. The bookshop is open until six.",
    questions: [
      MCQuestion(
        question: 'In which area is photography NOT allowed?',
        options: ['the café', 'the South Asia exhibition', 'the cloakroom', 'the bookshop'],
        answer: 'the South Asia exhibition',
      ),
    ],
  ),
  Lecture(
    id: 'i-l-4',
    title: 'IELTS Section 3: Tutorial on Research Design',
    transcript:
        "Tutor: Right, so the main weakness in your draft is the sampling. You\'ve interviewed only people who already use the app. Student: I see, so the responses skew positive. Tutor: Exactly. To improve the design, you'd want to include some non-users for comparison, or at least former users who stopped. Otherwise you can't tell whether the features matter or whether you've just found people who would have liked anything.",
    questions: [
      MCQuestion(
        question: 'What does the tutor identify as the main weakness?',
        options: [
          'The literature review.',
          'The sampling design.',
          'The chosen software.',
          'The length of the interviews.',
        ],
        answer: 'The sampling design.',
      ),
    ],
  ),
  Lecture(
    id: 'i-l-5',
    title: 'IELTS Section 1: Booking a Tour',
    transcript:
        "Agent: Hello, you've reached Lake District Tours. Caller: Hi, I'd like to book the half-day walking tour for two adults next Saturday. Agent: That's twenty-five pounds per person, so fifty pounds total. We meet outside the Keswick visitor center at nine sharp. Caller: Okay. Do we need to bring anything? Agent: Sturdy shoes, a waterproof jacket, and water. Lunch is included. Caller: Great — please book it under the name Singh, that's S-I-N-G-H.",
    questions: [
      MCQuestion(
        question: 'What is included in the price of the tour?',
        options: ['Hotel pickup', 'Lunch', 'Waterproof jacket rental', 'A souvenir map'],
        answer: 'Lunch',
      ),
    ],
  ),
  Lecture(
    id: 'i-l-6',
    title: 'IELTS Section 4: Lecture on Bicycle Networks',
    transcript:
        "Lecturer: When cities expand their bicycle infrastructure, they tend to overestimate the importance of any single new lane and underestimate the importance of the network as a whole. A single lane that doesn't connect to anything is rarely used. The same lane, once connected to a wider network, often sees ridership several times higher within months. The lesson is that the network effect dominates. Cities that want results should plan and fund the whole network from the start, even if construction is staged.",
    questions: [
      MCQuestion(
        question: 'What is the lecturer\'s main point?',
        options: [
          'Individual lanes matter more than networks.',
          'Network effects dominate, so cities should plan the whole network from the start.',
          'Bicycle lanes should be abandoned.',
          'Riders prefer disconnected routes.',
        ],
        answer: 'Network effects dominate, so cities should plan the whole network from the start.',
      ),
    ],
  ),
  Lecture(
    id: 'i-l-7',
    title: 'IELTS Section 2: Festival Information',
    transcript:
        "Host: Welcome to the city food festival. A few quick notes before you head into the stalls. Cash machines are at the main entrance and behind the music stage. The festival is cashless this year, so you'll need to use a card or your phone. Lost items go to the information tent near the south gate. Last orders at the food stalls are at nine, but the main stage runs music until eleven.",
    questions: [
      MCQuestion(
        question: 'Until what time is music available on the main stage?',
        options: ['Nine', 'Ten', 'Eleven', 'Midnight'],
        answer: 'Eleven',
      ),
    ],
  ),
  Lecture(
    id: 'i-l-8',
    title: 'IELTS Section 3: Group Project Planning',
    transcript:
        "Tutor: How are you splitting the work? Student A: We thought I'd do the literature review and Sara the data analysis. Tutor: Who is writing the introduction and the conclusion? Student A: We hadn't decided yet. Tutor: Those two sections are where examiners look first. Have one person draft both, and have the rest of the group respond to that draft. It keeps the voice consistent.",
    questions: [
      MCQuestion(
        question: 'What does the tutor recommend for the introduction and conclusion?',
        options: [
          'Splitting them between every group member.',
          'Having one person draft both and others respond.',
          'Leaving them blank.',
          'Asking the tutor to write them.',
        ],
        answer: 'Having one person draft both and others respond.',
      ),
    ],
  ),
  Lecture(
    id: 'i-l-9',
    title: 'IELTS Section 4: Lecture on Coffee Cultivation',
    transcript:
        "Lecturer: One concern in the modern coffee industry that gets less attention than it deserves is the narrow temperature range required by arabica plants. Most cultivation happens at elevations between about 1,200 and 2,200 meters. As temperatures rise, the lower band becomes too hot and the upper band becomes too high to expand into. Producers are reacting in two ways. Some are shifting plantings uphill where land remains. Others are switching to more heat-tolerant robusta varieties, which sell at a lower price.",
    questions: [
      MCQuestion(
        question: 'What is one response producers are making to rising temperatures?',
        options: [
          'Eliminating coffee production entirely.',
          'Shifting plantings uphill or switching to robusta varieties.',
          'Importing arabica from outside the tropics.',
          'Refusing to harvest.',
        ],
        answer: 'Shifting plantings uphill or switching to robusta varieties.',
      ),
    ],
  ),
  Lecture(
    id: 'i-l-10',
    title: 'IELTS Section 3: Choosing a Topic',
    transcript:
        "Tutor: You're proposing a paper on horse domestication. That's an interesting topic, but the scope is enormous. Student: Right. We thought maybe we'd narrow it to a single region. Tutor: That's the right instinct, but go further. Pick one specific question — say, what does the genetic evidence say about the speed of selection — and structure the paper around that. The narrower the question, the stronger the argument tends to be.",
    questions: [
      MCQuestion(
        question: 'What advice does the tutor give about the paper\'s scope?',
        options: [
          'Cover the whole world.',
          'Pick one specific question and structure the paper around that.',
          'Avoid genetics entirely.',
          'Stop the project.',
        ],
        answer: 'Pick one specific question and structure the paper around that.',
      ),
    ],
  ),
];

const List<SpeakingTask> _ieltsSpeaking = [
  SpeakingTask(
    id: 'i-s-1',
    type: 'IELTS Part 1 · Introduction',
    prompt:
        'Tell me a little about yourself. Where do you live, and what do you usually do during your free time?',
    prepSeconds: 5,
    speakSeconds: 30,
  ),
  SpeakingTask(
    id: 'i-s-2',
    type: 'IELTS Part 1 · Familiar Topic',
    prompt:
        'How important is reading in your life? Do you prefer reading on paper or on a screen, and why?',
    prepSeconds: 5,
    speakSeconds: 45,
  ),
  SpeakingTask(
    id: 'i-s-3',
    type: 'IELTS Part 2 · Long Turn',
    prompt:
        'Describe a journey you took that was important to you. You should say where you went, who you went with, what happened, and why it was important. You will have 1 minute to prepare and should speak for 1–2 minutes.',
    prepSeconds: 60,
    speakSeconds: 120,
  ),
  SpeakingTask(
    id: 'i-s-4',
    type: 'IELTS Part 3 · Discussion',
    prompt:
        'In your country, do people travel more than they used to? What effects does increased travel have on local communities? Should governments encourage or restrict tourism, and why?',
    prepSeconds: 10,
    speakSeconds: 90,
  ),
  SpeakingTask(
    id: 'i-s-5',
    type: 'IELTS Part 3 · Discussion',
    prompt:
        'Many cities are trying to reduce car use. What measures do you think are most effective, and what are the social trade-offs of restricting cars?',
    prepSeconds: 10,
    speakSeconds: 90,
  ),
  SpeakingTask(
    id: 'i-s-6',
    type: 'IELTS Part 1 · Familiar Topic',
    prompt:
        'Tell me about a meal you cook well. How did you learn to cook it, and how often do you cook it now?',
    prepSeconds: 5,
    speakSeconds: 45,
  ),
  SpeakingTask(
    id: 'i-s-7',
    type: 'IELTS Part 1 · Familiar Topic',
    prompt:
        'Do you prefer to listen to music while you work or in silence? Which kinds of music do you enjoy most, and why?',
    prepSeconds: 5,
    speakSeconds: 45,
  ),
  SpeakingTask(
    id: 'i-s-8',
    type: 'IELTS Part 2 · Long Turn',
    prompt:
        'Describe a book that has influenced you. You should say what it is about, when you read it, what you remember most, and why it influenced you. You will have 1 minute to prepare and should speak for 1–2 minutes.',
    prepSeconds: 60,
    speakSeconds: 120,
  ),
  SpeakingTask(
    id: 'i-s-9',
    type: 'IELTS Part 2 · Long Turn',
    prompt:
        'Describe a place you have visited that you would recommend to a friend. You should say where it is, what makes it interesting, who you went with, and what your friend would enjoy. You will have 1 minute to prepare and should speak for 1–2 minutes.',
    prepSeconds: 60,
    speakSeconds: 120,
  ),
  SpeakingTask(
    id: 'i-s-10',
    type: 'IELTS Part 3 · Discussion',
    prompt:
        'Do people in your country read as much as they used to? What role does reading play in education today, and how could schools encourage more reading among younger students?',
    prepSeconds: 10,
    speakSeconds: 90,
  ),
  SpeakingTask(
    id: 'i-s-11',
    type: 'IELTS Part 3 · Discussion',
    prompt:
        'Many universities offer online degrees. Do you think online study is as effective as on-campus study? Who benefits most, and who might lose out?',
    prepSeconds: 10,
    speakSeconds: 90,
  ),
  SpeakingTask(
    id: 'i-s-12',
    type: 'IELTS Part 2 · Long Turn',
    prompt:
        'Describe a person who has been an important influence on your studies. You should say who the person is, how you met, what they taught you, and how this has shaped your goals. You will have 1 minute to prepare and should speak for 1–2 minutes.',
    prepSeconds: 60,
    speakSeconds: 120,
  ),
  SpeakingTask(
    id: 'i-s-13',
    type: 'IELTS Part 1 · Introduction',
    prompt:
        'What do you enjoy most about the area where you live? Are there things you would like to change about it?',
    prepSeconds: 5,
    speakSeconds: 45,
  ),
];

const List<WritingTask> _ieltsWriting = [
  WritingTask(
    id: 'i-w-1',
    type: 'IELTS Task 1 · Data Description',
    prompt:
        'The chart below shows electricity generation by source in three countries in 2025. Summarise the main features, and make comparisons where relevant. Write at least 150 words.',
    reading:
        'Imagine a bar chart for Country A, Country B, and Country C. Country A: coal 55%, gas 20%, renewables 25%. Country B: coal 10%, gas 30%, renewables 60%. Country C: coal 35%, gas 35%, renewables 30%.',
    minutes: 20,
  ),
  WritingTask(
    id: 'i-w-2',
    type: 'IELTS Task 2 · Essay',
    prompt:
        'Some people believe that universities should focus on preparing students for the job market, while others think they should emphasize personal and intellectual development. Discuss both views and give your own opinion. Write at least 250 words.',
    minutes: 40,
  ),
  WritingTask(
    id: 'i-w-3',
    type: 'IELTS Task 1 · Process',
    prompt:
        'The diagram below shows the stages of recycling a glass bottle. Describe the process. Write at least 150 words.',
    reading:
        'Imagine a process diagram: 1) Collection at curbside bins. 2) Sorting at facility. 3) Crushing into "cullet". 4) Melting in a furnace at 1500°C. 5) Moulding into new bottles. 6) Distribution to retailers.',
    minutes: 20,
  ),
  WritingTask(
    id: 'i-w-4',
    type: 'IELTS Task 2 · Essay',
    prompt:
        'Some argue that international travel makes people more tolerant; others think it mainly damages local cultures and the environment. Discuss both views and give your own opinion. Write at least 250 words.',
    minutes: 40,
  ),
  WritingTask(
    id: 'i-w-5',
    type: 'IELTS Task 2 · Essay',
    prompt:
        'In many cities, the use of private cars is being discouraged. To what extent do you agree or disagree with this policy? Support your view with examples. Write at least 250 words.',
    minutes: 40,
  ),
  WritingTask(
    id: 'i-w-6',
    type: 'IELTS Task 1 · Data Description',
    prompt:
        'The line graph below shows the number of international tourists visiting three countries between 2010 and 2025. Summarise the main features and make comparisons where relevant. Write at least 150 words.',
    reading:
        'Imagine a line graph with three lines. Country X: rises steadily from 4 million to 12 million. Country Y: flat at around 7 million until 2018, then a sharp drop to 3 million in 2020, then recovery to 6 million by 2025. Country Z: gentle rise from 2 million to 5 million.',
    minutes: 20,
  ),
  WritingTask(
    id: 'i-w-7',
    type: 'IELTS Task 1 · Map',
    prompt:
        'The two maps below show the centre of a small town in 1995 and today. Summarise the changes that have taken place. Write at least 150 words.',
    reading:
        'Imagine map 1 (1995): a market square, a small church, three rows of houses, a single road running east–west. Map 2 (today): the square has been pedestrianised, the church remains, the houses on the south side have been replaced by a library and a cinema, and the road has been narrowed for buses only.',
    minutes: 20,
  ),
  WritingTask(
    id: 'i-w-8',
    type: 'IELTS Task 2 · Essay',
    prompt:
        'Some people believe that governments should invest more in public transport rather than in roads. To what extent do you agree or disagree? Give reasons and examples. Write at least 250 words.',
    minutes: 40,
  ),
  WritingTask(
    id: 'i-w-9',
    type: 'IELTS Task 2 · Essay',
    prompt:
        'Many young people now choose to live with their parents for longer than previous generations did. What are the main reasons for this trend, and is it a positive or negative development? Write at least 250 words.',
    minutes: 40,
  ),
  WritingTask(
    id: 'i-w-10',
    type: 'IELTS Task 2 · Essay',
    prompt:
        'Some argue that traditional skills and knowledge — cooking, sewing, gardening — should be required parts of the school curriculum. Others believe schools should focus only on academic subjects. Discuss both views and give your own opinion. Write at least 250 words.',
    minutes: 40,
  ),
];

/// 40 IELTS-targeted Academic Word List items. Every card carries the
/// quiz answer, four MC options, plus part-of-speech, definition, and an
/// example sentence consumed by the WordUp-style player. Definitions
/// paraphrased from Cambridge, Oxford, and Collins dictionary entries.
const List<VocabCard> _ieltsVocab = [
  VocabCard(word: 'Substantial', answer: 'Considerable', options: ['Trivial', 'Considerable', 'Brief', 'Vague'], partOfSpeech: 'adjective', definition: 'Of considerable size, value, or importance.', example: 'The charity made a substantial donation to the disaster fund.'),
  VocabCard(word: 'Detrimental', answer: 'Harmful', options: ['Helpful', 'Harmful', 'Neutral', 'Costly'], partOfSpeech: 'adjective', definition: 'Tending to cause harm.', example: 'Lack of sleep is detrimental to long-term health.'),
  VocabCard(word: 'Pertinent', answer: 'Relevant', options: ['Irrelevant', 'Relevant', 'Outdated', 'Hidden'], partOfSpeech: 'adjective', definition: 'Relevant or applicable to a particular matter.', example: 'The lawyer asked only pertinent questions during the interview.'),
  VocabCard(word: 'Tangible', answer: 'Concrete', options: ['Abstract', 'Concrete', 'Imagined', 'Spoken'], partOfSpeech: 'adjective', definition: 'Perceptible by touch; real and definite.', example: 'After months of work, they finally had tangible results to show.'),
  VocabCard(word: 'Implement', answer: 'Carry out', options: ['Plan only', 'Carry out', 'Stop', 'Discuss'], partOfSpeech: 'verb', definition: 'To put a decision or plan into effect.', example: 'The school will implement the new policy from September.'),
  VocabCard(word: 'Vital', answer: 'Essential', options: ['Optional', 'Essential', 'Decorative', 'Familiar'], partOfSpeech: 'adjective', definition: 'Absolutely necessary; essential.', example: 'Clean drinking water is vital to public health.'),
  VocabCard(word: 'Diverse', answer: 'Varied', options: ['Uniform', 'Varied', 'Limited', 'Singular'], partOfSpeech: 'adjective', definition: 'Showing a great deal of variety; very different.', example: 'The city has a diverse population from over sixty countries.'),
  VocabCard(word: 'Persistent', answer: 'Continuing', options: ['Brief', 'Continuing', 'Hidden', 'Unstable'], partOfSpeech: 'adjective', definition: 'Continuing firmly or obstinately despite difficulty.', example: 'A persistent cough should be checked by a doctor.'),
  VocabCard(word: 'Inhabit', answer: 'Live in', options: ['Visit', 'Live in', 'Abandon', 'Avoid'], partOfSpeech: 'verb', definition: 'To live in or occupy a place.', example: 'Sea otters inhabit the kelp forests of the Pacific coast.'),
  VocabCard(word: 'Notable', answer: 'Remarkable', options: ['Ordinary', 'Remarkable', 'Silent', 'Cheap'], partOfSpeech: 'adjective', definition: 'Worthy of attention or notice; remarkable.', example: 'The most notable feature of the design is its sloping roof.'),
  VocabCard(word: 'Reluctant', answer: 'Unwilling', options: ['Eager', 'Unwilling', 'Strong', 'Confused'], partOfSpeech: 'adjective', definition: 'Unwilling and hesitant.', example: 'She was reluctant to leave the meeting before it ended.'),
  VocabCard(word: 'Robust', answer: 'Strong', options: ['Frail', 'Strong', 'Distant', 'Loud'], partOfSpeech: 'adjective', definition: 'Strong and healthy; able to withstand difficult conditions.', example: 'The new bridge is built with robust steel cables.'),
  VocabCard(word: 'Strive', answer: 'Try hard', options: ['Give up', 'Try hard', 'Wander', 'Refuse'], partOfSpeech: 'verb', definition: 'To make great efforts to achieve or obtain something.', example: 'The company strives to improve its environmental record each year.'),
  VocabCard(word: 'Confine', answer: 'Restrict', options: ['Expand', 'Restrict', 'Forget', 'Hide'], partOfSpeech: 'verb', definition: 'To keep within certain limits; to restrict.', example: 'Please confine your remarks to the topic at hand.'),
  VocabCard(word: 'Enhance', answer: 'Improve', options: ['Reduce', 'Improve', 'Avoid', 'Ignore'], partOfSpeech: 'verb', definition: 'To increase or improve the quality of something.', example: 'A second monitor can significantly enhance productivity.'),
  VocabCard(word: 'Plausible', answer: 'Believable', options: ['Far-fetched', 'Believable', 'Public', 'Empty'], partOfSpeech: 'adjective', definition: 'Seeming reasonable or believable.', example: 'Her explanation sounded plausible, but the data did not support it.'),
  VocabCard(word: 'Mitigation', answer: 'Reduction', options: ['Increase', 'Reduction', 'Repetition', 'Avoidance'], partOfSpeech: 'noun', definition: 'The action of reducing the severity of something.', example: 'Climate mitigation requires both policy and individual action.'),
  VocabCard(word: 'Substantive', answer: 'Meaningful', options: ['Trivial', 'Meaningful', 'Loose', 'Fancy'], partOfSpeech: 'adjective', definition: 'Having a firm basis in reality; meaningful.', example: 'The talks produced substantive progress on the trade dispute.'),
  VocabCard(word: 'Threshold', answer: 'Limit', options: ['Centre', 'Limit', 'Ceiling', 'Source'], partOfSpeech: 'noun', definition: 'A point at which something changes or begins.', example: 'Income above this threshold is taxed at a higher rate.'),
  VocabCard(word: 'Reciprocal', answer: 'Mutual', options: ['One-sided', 'Mutual', 'Empty', 'Hidden'], partOfSpeech: 'adjective', definition: 'Given or done in return; mutual.', example: 'The two universities have a reciprocal exchange programme.'),
  VocabCard(word: 'Discernible', answer: 'Noticeable', options: ['Invisible', 'Noticeable', 'Repeated', 'Painful'], partOfSpeech: 'adjective', definition: 'Able to be perceived or recognized.', example: 'There was no discernible difference between the two samples.'),
  VocabCard(word: 'Predominant', answer: 'Main', options: ['Minor', 'Main', 'Stale', 'Sudden'], partOfSpeech: 'adjective', definition: 'Most common or strongest; main.', example: 'The predominant view in the field is now well established.'),
  VocabCard(word: 'Cohesive', answer: 'Unified', options: ['Split', 'Unified', 'Hidden', 'Loose'], partOfSpeech: 'adjective', definition: 'Forming a united whole; well integrated.', example: 'A cohesive team consistently outperforms a group of talented individuals.'),
  VocabCard(word: 'Trigger', answer: 'Cause', options: ['Prevent', 'Cause', 'Ignore', 'Mute'], partOfSpeech: 'verb', definition: 'To cause something to start; to set off.', example: 'A small change in temperature can trigger an avalanche.'),
  VocabCard(word: 'Foster', answer: 'Encourage', options: ['Block', 'Encourage', 'Reject', 'Repeat'], partOfSpeech: 'verb', definition: 'To encourage the development of something.', example: 'The programme fosters collaboration between universities and industry.'),
  VocabCard(word: 'Concise', answer: 'Brief', options: ['Long', 'Brief', 'Wordy', 'Empty'], partOfSpeech: 'adjective', definition: 'Giving a lot of information clearly in few words.', example: 'A good summary is concise but complete.'),
  VocabCard(word: 'Underlying', answer: 'Fundamental', options: ['Trivial', 'Fundamental', 'Surface', 'Recent'], partOfSpeech: 'adjective', definition: 'Basic or fundamental, though not immediately obvious.', example: 'The underlying cause of the problem turned out to be funding.'),
  VocabCard(word: 'Comprehensive', answer: 'Thorough', options: ['Partial', 'Thorough', 'Brief', 'Random'], partOfSpeech: 'adjective', definition: 'Complete; including all or nearly all elements.', example: 'The report offers a comprehensive review of the past decade.'),
  VocabCard(word: 'Adverse', answer: 'Negative', options: ['Helpful', 'Negative', 'Hidden', 'Random'], partOfSpeech: 'adjective', definition: 'Preventing success or development; harmful.', example: 'The medication can have adverse side effects in rare cases.'),
  VocabCard(word: 'Allocate', answer: 'Assign', options: ['Refuse', 'Assign', 'Forget', 'Spend'], partOfSpeech: 'verb', definition: 'To distribute resources for a particular purpose.', example: 'The government allocated additional funds for rural schools.'),
  VocabCard(word: 'Anticipate', answer: 'Expect', options: ['Ignore', 'Expect', 'Refuse', 'Hide'], partOfSpeech: 'verb', definition: 'To expect or predict that something will happen.', example: 'Analysts anticipate stronger growth in the second half of the year.'),
  VocabCard(word: 'Demonstrate', answer: 'Show clearly', options: ['Hide', 'Show clearly', 'Question', 'Forget'], partOfSpeech: 'verb', definition: 'To clearly show that something exists or is true.', example: 'The study demonstrates a clear link between exercise and mood.'),
  VocabCard(word: 'Emerge', answer: 'Appear', options: ['Disappear', 'Appear', 'Hide', 'Refuse'], partOfSpeech: 'verb', definition: 'To come out into view; to become apparent.', example: 'New evidence emerged that changed the direction of the investigation.'),
  VocabCard(word: 'Facilitate', answer: 'Make easier', options: ['Hinder', 'Make easier', 'Forget', 'Ignore'], partOfSpeech: 'verb', definition: 'To make an action or process easier.', example: 'Online tools facilitate communication between remote team members.'),
  VocabCard(word: 'Inevitable', answer: 'Unavoidable', options: ['Optional', 'Unavoidable', 'Brief', 'Sudden'], partOfSpeech: 'adjective', definition: 'Certain to happen; unavoidable.', example: 'Some friction in a new team is almost inevitable.'),
  VocabCard(word: 'Mutual', answer: 'Shared', options: ['Private', 'Shared', 'Hidden', 'Solo'], partOfSpeech: 'adjective', definition: 'Felt or done by two or more parties equally.', example: 'They share a mutual interest in early Renaissance art.'),
  VocabCard(word: 'Prominent', answer: 'Important', options: ['Tiny', 'Important', 'Faint', 'Lost'], partOfSpeech: 'adjective', definition: 'Important; famous; standing out.', example: 'She is a prominent figure in international science policy.'),
  VocabCard(word: 'Significant', answer: 'Important', options: ['Trivial', 'Important', 'Late', 'Soft'], partOfSpeech: 'adjective', definition: 'Sufficiently great or important to merit attention.', example: 'The change in temperature was small but statistically significant.'),
  VocabCard(word: 'Sustainable', answer: 'Long-lasting', options: ['Brief', 'Long-lasting', 'Wasteful', 'Sudden'], partOfSpeech: 'adjective', definition: 'Able to be maintained at a certain rate or level over time.', example: 'Sustainable agriculture protects soil and water for future generations.'),
  VocabCard(word: 'Vague', answer: 'Unclear', options: ['Sharp', 'Unclear', 'Bold', 'Specific'], partOfSpeech: 'adjective', definition: 'Of uncertain, indefinite, or unclear character or meaning.', example: 'His answer was so vague that no one knew what he actually thought.'),
];

const List<MockExam> _ieltsMocks = [
  MockExam(
    id: 'i-mock-1',
    title: 'IELTS Academic Mock 1',
    theme: 'Sleep and Society',
    minutes: 165,
    sections: [
      MockSection(module: 'Listening', minutes: 30, itemCount: 4),
      MockSection(module: 'Reading', minutes: 60, itemCount: 3),
      MockSection(module: 'Writing', minutes: 60, itemCount: 2),
      MockSection(module: 'Speaking', minutes: 15, itemCount: 3),
    ],
  ),
  MockExam(
    id: 'i-mock-2',
    title: 'IELTS Academic Mock 2',
    theme: 'Urban Heat',
    minutes: 165,
    sections: [
      MockSection(module: 'Listening', minutes: 30, itemCount: 4),
      MockSection(module: 'Reading', minutes: 60, itemCount: 3),
      MockSection(module: 'Writing', minutes: 60, itemCount: 2),
      MockSection(module: 'Speaking', minutes: 15, itemCount: 3),
    ],
  ),
  MockExam(
    id: 'i-mock-3',
    title: 'IELTS Academic Mock 3',
    theme: 'The Return of the Wolf',
    minutes: 165,
    sections: [
      MockSection(module: 'Listening', minutes: 30, itemCount: 4),
      MockSection(module: 'Reading', minutes: 60, itemCount: 3),
      MockSection(module: 'Writing', minutes: 60, itemCount: 2),
      MockSection(module: 'Speaking', minutes: 15, itemCount: 3),
    ],
  ),
  MockExam(
    id: 'i-mock-4',
    title: 'IELTS Academic Mock 4',
    theme: 'Beyond GDP',
    minutes: 165,
    sections: [
      MockSection(module: 'Listening', minutes: 30, itemCount: 4),
      MockSection(module: 'Reading', minutes: 60, itemCount: 3),
      MockSection(module: 'Writing', minutes: 60, itemCount: 2),
      MockSection(module: 'Speaking', minutes: 15, itemCount: 3),
    ],
  ),
  MockExam(
    id: 'i-mock-5',
    title: 'IELTS Academic Mock 5',
    theme: 'Tea & Trade',
    minutes: 165,
    sections: [
      MockSection(module: 'Listening', minutes: 30, itemCount: 4),
      MockSection(module: 'Reading', minutes: 60, itemCount: 3),
      MockSection(module: 'Writing', minutes: 60, itemCount: 2),
      MockSection(module: 'Speaking', minutes: 15, itemCount: 3),
    ],
  ),
  MockExam(id: 'i-mock-6', title: 'IELTS Academic Mock 6', theme: 'Cinema Across the World', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-7', title: 'IELTS Academic Mock 7', theme: 'Horse Domestication', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-8', title: 'IELTS Academic Mock 8', theme: 'Bird Migration', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-9', title: 'IELTS Academic Mock 9', theme: 'Bicycles and the City', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-10', title: 'IELTS Academic Mock 10', theme: 'The Coffee Plant', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-11', title: 'IELTS Academic Mock 11', theme: 'The Cinematic City', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-12', title: 'IELTS Academic Mock 12', theme: 'Lifespans of Trees', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-13', title: 'IELTS Academic Mock 13', theme: 'Urban Heat', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-14', title: 'IELTS Academic Mock 14', theme: 'Sleep and the Modern Worker', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-15', title: 'IELTS Academic Mock 15', theme: 'Beyond GDP', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-16', title: 'IELTS Academic Mock 16', theme: 'The Return of the Wolf', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-17', title: 'IELTS Academic Mock 17', theme: 'Travel and Tolerance', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-18', title: 'IELTS Academic Mock 18', theme: 'Public Transport vs Roads', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-19', title: 'IELTS Academic Mock 19', theme: 'Living with Family', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-20', title: 'IELTS Academic Mock 20', theme: 'Traditional Skills in Schools', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-21', title: 'IELTS Academic Mock 21', theme: 'Renewable Energy Mix', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-22', title: 'IELTS Academic Mock 22', theme: 'Smart Cities and Privacy', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-23', title: 'IELTS Academic Mock 23', theme: 'Recycling and Waste', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-24', title: 'IELTS Academic Mock 24', theme: 'Aging Populations', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
  MockExam(id: 'i-mock-25', title: 'IELTS Academic Mock 25', theme: 'Globalization and Language', minutes: 165, sections: [MockSection(module: 'Listening', minutes: 30, itemCount: 4), MockSection(module: 'Reading', minutes: 60, itemCount: 3), MockSection(module: 'Writing', minutes: 60, itemCount: 2), MockSection(module: 'Speaking', minutes: 15, itemCount: 3)]),
];
