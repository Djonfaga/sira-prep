import 'content_grammar.dart';
import 'models.dart';

/// Hand-authored TOEFL content. Topics intentionally mirror those shown in the
/// reference screenshots so the brand experience feels consistent. Passages
/// are paced around the standard 700-word academic style; questions are
/// modeled on the official iBT item types (factual, inference, vocabulary,
/// rhetorical purpose).
final ExamContent toeflContent = ExamContent(
  reading: _toeflReading,
  listening: _toeflListening,
  speaking: _toeflSpeaking,
  writing: _toeflWriting,
  vocab: _toeflVocab,
  mocks: _toeflMocks,
  grammar: sharedGrammar,
);

const List<Passage> _toeflReading = [
  Passage(
    id: 't-r-1',
    title: 'Climate Adaptation',
    body: '''Climate adaptation is often discussed in terms of technology or funding, but recent studies place greater emphasis on systems and behavior. Current scholarship in environmental policy suggests that adaptation works best when local planning, infrastructure, and public communication are coordinated. One reason is that isolated reforms rarely succeed when institutions ignore how people actually respond to change.

Evidence from multiple settings supports this view. For example, cool-roof programs reduce indoor temperatures during heat waves. In addition, wetland restoration lowers flood risk by slowing runoff. These findings show that practical outcomes depend not just on the presence of a policy or tool, but on the way it is implemented across a complete environment.

Another important factor concerns communication and trust. In many cases, early-warning systems only succeed when residents trust the alerts. This helps explain why programs that appear technically sound sometimes produce disappointing results when they are introduced too quickly or without local consultation. Researchers have begun to argue that adaptation should be evaluated by its uptake among ordinary citizens rather than by the elegance of the underlying technology.

Finally, the long horizon of climate impacts complicates evaluation. Reforms that look ineffective during a quiet decade may prove decisive during the next severe season. Policymakers therefore face the dual challenge of acting under uncertainty while maintaining public confidence — an argument for measured pilots over sweeping mandates.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, why do isolated reforms often fail?',
        options: [
          'Because they ignore how people respond to change.',
          'Because they rely too heavily on new technology.',
          'Because they are funded by foreign governments.',
          'Because they target rural rather than urban areas.',
        ],
        answer: 'Because they ignore how people respond to change.',
      ),
      MCQuestion(
        question: 'The author mentions cool-roof programs and wetland restoration in order to:',
        options: [
          'Argue that policies must be implemented across a complete environment.',
          'Show that adaptation requires expensive infrastructure.',
          'Suggest that climate impacts are exaggerated.',
          'Recommend wetland projects over heat mitigation.',
        ],
        answer: 'Argue that policies must be implemented across a complete environment.',
      ),
      MCQuestion(
        question: 'The word "uptake" in the passage is closest in meaning to:',
        options: ['cost', 'design', 'adoption', 'risk'],
        answer: 'adoption',
      ),
      MCQuestion(
        question: 'According to the passage, what is one reason that long-term evaluation is difficult?',
        options: [
          'Funding for climate research changes every year.',
          'Reforms may appear ineffective until a severe season tests them.',
          'Citizens stop reporting weather events over time.',
          'Cool-roof materials degrade faster than expected.',
        ],
        answer: 'Reforms may appear ineffective until a severe season tests them.',
      ),
    ],
  ),
  Passage(
    id: 't-r-2',
    title: 'Marine Ecosystems',
    body: '''Marine ecosystems support an extraordinary share of the planet\'s biological productivity, yet they remain less studied than their terrestrial counterparts. One reason is access: the deep ocean is dark, cold, and crushingly pressurized, and direct observation requires specialized vehicles. Another reason is interconnection. A single coastal current can transport larvae across thousands of kilometers, blurring the boundaries that scientists rely on when defining a habitat.

Among the best-studied marine systems are kelp forests, which thrive in cool, nutrient-rich water along temperate coasts. Kelp grows quickly — some species extend by more than half a meter a day — and the resulting canopy shelters fish, invertebrates, and marine mammals. When sea otter populations collapsed in the twentieth century, kelp forests across the North Pacific declined as well: without otters to control sea urchins, the urchins grazed the kelp to bare rock. Returning otters reverse the process within years.

Coral reefs offer a contrasting case. They depend on a delicate partnership between coral polyps and microscopic algae, and that partnership breaks down when water temperatures rise even briefly. Mass bleaching events were once considered extraordinary; they are now expected several times per decade. Restoration efforts include "coral gardening," in which scientists grow heat-tolerant fragments in nurseries before transplanting them, but the technique cannot match the scale of damage.

Modern marine science increasingly emphasizes connectivity. Currents, migratory species, and pollutants all travel beyond any one protected area, suggesting that conservation must be coordinated regionally rather than locally. Just as importantly, the ocean exchanges enormous quantities of heat and carbon with the atmosphere, making marine health inseparable from climate policy.''',
    questions: [
      MCQuestion(
        question: 'Why does the passage describe sea otters and sea urchins?',
        options: [
          'To illustrate how a single species can shape an entire ecosystem.',
          'To compare temperate and tropical marine habitats.',
          'To prove that hunting bans always restore biodiversity.',
          'To show that kelp grows fastest in warm water.',
        ],
        answer: 'To illustrate how a single species can shape an entire ecosystem.',
      ),
      MCQuestion(
        question: 'The author implies that coral reefs differ from kelp forests primarily because:',
        options: [
          'Kelp tolerates warm water better than coral.',
          'Coral reefs cannot recover even with intervention.',
          'Coral reefs depend on a fragile symbiotic partnership.',
          'Kelp forests are found only in the tropics.',
        ],
        answer: 'Coral reefs depend on a fragile symbiotic partnership.',
      ),
      MCQuestion(
        question: 'The phrase "coral gardening" refers to:',
        options: [
          'Decorating aquariums with coral.',
          'Growing heat-tolerant coral fragments for transplant.',
          'Removing invasive species from reefs.',
          'Limiting tourist access to reef sites.',
        ],
        answer: 'Growing heat-tolerant coral fragments for transplant.',
      ),
      MCQuestion(
        question: 'What does the passage suggest about marine conservation?',
        options: [
          'It works best when limited to single protected zones.',
          'It must be coordinated across regions because the ocean is connected.',
          'It is mostly a problem for climate scientists, not biologists.',
          'It has been solved by coral gardening.',
        ],
        answer: 'It must be coordinated across regions because the ocean is connected.',
      ),
    ],
  ),
  Passage(
    id: 't-r-3',
    title: 'Behavioral Economics',
    body: '''For much of the twentieth century, mainstream economic theory rested on the assumption that individuals act rationally, weighing costs and benefits to maximize a stable set of preferences. Behavioral economics challenges that assumption by drawing on psychology to describe how people actually decide. Rather than discarding the older framework, it modifies it to account for predictable departures from pure rationality.

A central insight is loss aversion: most people feel the pain of a loss more strongly than the pleasure of an equivalent gain. This asymmetry helps explain why investors hold falling stocks too long and why consumers reject small fees even when they would not pay a small bonus to avoid them. A related concept, anchoring, describes how arbitrary numbers — a high opening price, a "suggested" donation — pull subsequent decisions toward them, even when the anchor is plainly irrelevant.

Another influential idea is the default effect. In studies of organ-donor registration, countries that ask citizens to opt out of donation have far higher participation than countries that ask them to opt in, despite identical underlying attitudes. Defaults work because people interpret them as social recommendations and because changing them requires effort, however small.

Critics argue that behavioral economics risks paternalism: if policymakers nudge citizens toward "better" choices, they may quietly substitute their own preferences for those of the public. Supporters counter that defaults are unavoidable — every form has one — and that designing them transparently is preferable to pretending they do not exist. The debate has shaped policy on retirement savings, energy use, and public health.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, behavioral economics:',
        options: [
          'Rejects the classical economic model entirely.',
          'Modifies the classical model to account for predictable biases.',
          'Argues that people always behave irrationally.',
          'Is unrelated to psychology.',
        ],
        answer: 'Modifies the classical model to account for predictable biases.',
      ),
      MCQuestion(
        question: 'The author uses the example of organ-donor registration to illustrate:',
        options: [
          'Loss aversion.',
          'Anchoring.',
          'The default effect.',
          'Rational maximization.',
        ],
        answer: 'The default effect.',
      ),
      MCQuestion(
        question: 'The word "asymmetry" most nearly means:',
        options: ['equality', 'imbalance', 'distance', 'agreement'],
        answer: 'imbalance',
      ),
      MCQuestion(
        question: 'What concern do critics raise about nudges?',
        options: [
          'They are too expensive to implement.',
          'They may quietly impose policymakers\' preferences on the public.',
          'They are ineffective in organ-donor programs.',
          'They violate international trade rules.',
        ],
        answer: 'They may quietly impose policymakers\' preferences on the public.',
      ),
    ],
  ),
  Passage(
    id: 't-r-4',
    title: 'Renewable Energy Systems',
    body: '''The transition to renewable energy is often framed as a contest between technologies — solar versus wind, batteries versus hydrogen — but planners increasingly describe it as a problem of systems. The most important question is not which generator is cheapest in isolation, but how a portfolio of sources, storage assets, and demand-side controls can deliver reliable power across an entire grid.

The challenge arises because wind and solar are variable. Their output rises and falls with weather, sometimes within minutes. A grid dominated by them must therefore include resources that can balance those swings: batteries on the scale of hours, pumped hydropower on the scale of days, and long-duration storage or flexible generation on the scale of weeks. Each layer of storage carries different costs and constraints.

Demand-side management is equally important. When utilities can shift industrial cooling, electric-vehicle charging, or water heating to match the supply curve, they turn flexibility into a resource. Some grids now treat aggregated households as a "virtual power plant" that competes with conventional generators. Such systems require sophisticated software, clear price signals, and customer trust.

Finally, the geography of renewables differs from that of fossil fuels. Sunlight peaks in the desert, wind in coastal corridors, hydropower in mountain river basins. Linking these resources to population centers means new high-voltage transmission, which is technically feasible but politically slow. Many analysts now argue that the bottleneck to decarbonization is not technology but coordination — and that countries which streamline planning will move first.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, planners describe the energy transition primarily as:',
        options: [
          'A contest between solar and wind technologies.',
          'A systems problem about reliable supply across a portfolio.',
          'A failure of climate policy.',
          'A consumer-education campaign.',
        ],
        answer: 'A systems problem about reliable supply across a portfolio.',
      ),
      MCQuestion(
        question: 'Why are different timescales of storage mentioned?',
        options: [
          'To suggest that batteries alone are sufficient.',
          'To show that each storage layer handles different kinds of variability.',
          'To argue against hydropower.',
          'To explain why solar costs are falling.',
        ],
        answer: 'To show that each storage layer handles different kinds of variability.',
      ),
      MCQuestion(
        question: 'The phrase "virtual power plant" describes:',
        options: [
          'A new kind of nuclear reactor.',
          'A software model that ignores real demand.',
          'Aggregated household devices that behave like a generator.',
          'A backup diesel generator at a hospital.',
        ],
        answer: 'Aggregated household devices that behave like a generator.',
      ),
      MCQuestion(
        question: 'What bottleneck to decarbonization does the passage emphasize?',
        options: [
          'The cost of solar panels.',
          'The political and coordination challenge of new transmission.',
          'The shortage of trained engineers.',
          'The price of natural gas.',
        ],
        answer: 'The political and coordination challenge of new transmission.',
      ),
    ],
  ),
  Passage(
    id: 't-r-5',
    title: 'Museum Education',
    body: '''Museums have long understood that visitors learn differently from students in a classroom. The visit is voluntary, the visitor sets the pace, and any single label competes with dozens of others for attention. As a result, museum educators have developed methods that emphasize choice, curiosity, and short bursts of focus rather than sustained lecture.

One influential model is "free-choice learning," which argues that knowledge gained on a museum visit is shaped less by what curators intend than by what visitors decide to attend to. Under this view, the most useful design choices are those that present multiple entry points: a historical figure described both through their letters and through a short audio dramatization, for example, so that different visitors can engage at different depths.

A second strand of research focuses on prior knowledge. Visitors do not arrive empty; they bring expectations, family stories, and partial misunderstandings. Effective exhibits surface those expectations explicitly — often through provocative questions placed early in the gallery — so that visitors can compare their assumptions with the evidence ahead. Studies suggest that this comparison, rather than the simple delivery of facts, drives lasting learning.

Modern museums also increasingly experiment with what they call "co-creation," inviting communities to contribute objects, oral histories, or even curatorial decisions. Critics warn that the approach can become tokenistic, but successful examples — particularly in regional and indigenous museums — show that shared authorship can deepen public trust and surface stories that traditional collecting routines miss.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, museum learning differs from classroom learning because:',
        options: [
          'Museums require longer attention spans.',
          'Visits are voluntary and visitors choose what to attend to.',
          'Curators directly examine every visitor.',
          'Museums avoid using labels.',
        ],
        answer: 'Visits are voluntary and visitors choose what to attend to.',
      ),
      MCQuestion(
        question: 'The "free-choice learning" model emphasizes:',
        options: [
          'The intent of the curator above all else.',
          'The role of the visitor\'s decisions about attention.',
          'The need for long lectures inside galleries.',
          'The cost of producing exhibits.',
        ],
        answer: 'The role of the visitor\'s decisions about attention.',
      ),
      MCQuestion(
        question: 'Why do effective exhibits surface visitors\' prior expectations?',
        options: [
          'To embarrass visitors who hold misconceptions.',
          'To allow visitors to compare assumptions with evidence.',
          'To collect data for museum membership drives.',
          'To shorten the average visit.',
        ],
        answer: 'To allow visitors to compare assumptions with evidence.',
      ),
      MCQuestion(
        question: 'The passage suggests that co-creation:',
        options: [
          'Should be avoided in regional museums.',
          'Risks being tokenistic but can deepen trust when done well.',
          'Has been universally condemned by curators.',
          'Replaces the need for professional curators.',
        ],
        answer: 'Risks being tokenistic but can deepen trust when done well.',
      ),
    ],
  ),
  Passage(
    id: 't-r-6',
    title: 'Linguistic Change',
    body: '''Languages change continuously, even when speakers feel that they speak the same language as their grandparents. Most change happens slowly and beneath conscious awareness; it appears in vowels that shift over generations, in vocabulary borrowed from neighboring languages, and in grammatical features that simplify or fall away when fewer speakers use them.

Historical linguists distinguish between internal change — alterations driven by patterns within the language itself — and external change driven by contact with other languages. Internal change is often regular: a single shift may sweep through every word that contains a particular sound. The "Great Vowel Shift" in English, which moved long vowels upward in the mouth between roughly 1400 and 1700, is a classic example. External change is messier; loanwords arrive piecemeal and may keep features that look foreign for centuries.

In the modern era, mass media, schooling, and migration have accelerated certain kinds of change while suppressing others. Standardized writing systems freeze spelling even as pronunciation drifts, which is one reason English spelling looks erratic. Television and film expose listeners to varieties they would not otherwise hear, encouraging some forms to spread quickly across borders.

Sociolinguists also point out that change is rarely uniform across a community. Younger speakers, women in many communities, and urban populations frequently lead innovation; older, rural, and prestige-conscious speakers tend to conserve older forms. Tracking which group adopts a feature first is now a standard method for predicting how language will evolve over the next generation.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, why does English spelling look erratic?',
        options: [
          'English speakers refuse to use loanwords.',
          'Spelling was frozen by standardization while pronunciation kept drifting.',
          'Television introduced rules that contradict tradition.',
          'Linguists deliberately make spelling difficult.',
        ],
        answer: 'Spelling was frozen by standardization while pronunciation kept drifting.',
      ),
      MCQuestion(
        question: 'The Great Vowel Shift is presented as an example of:',
        options: ['external change', 'internal change', 'borrowed grammar', 'media influence'],
        answer: 'internal change',
      ),
      MCQuestion(
        question: 'What does the passage suggest about who leads change?',
        options: [
          'Older rural speakers usually lead innovation.',
          'Younger, often urban speakers tend to lead innovation.',
          'Linguists themselves invent new forms.',
          'No identifiable group leads change.',
        ],
        answer: 'Younger, often urban speakers tend to lead innovation.',
      ),
      MCQuestion(
        question: 'The word "piecemeal" in the passage is closest in meaning to:',
        options: ['gradually and in fragments', 'all at once', 'in writing', 'by force'],
        answer: 'gradually and in fragments',
      ),
    ],
  ),
  Passage(
    id: 't-r-7',
    title: 'Food Security',
    body: '''Food security exists when all people, at all times, have physical and economic access to sufficient, safe, and nutritious food. The definition sounds straightforward, but achieving it depends on a chain that includes production, distribution, storage, retail, and finally household income. A failure at any point can produce shortages in places where total food supplies appear adequate.

The mid-twentieth-century Green Revolution dramatically increased yields of staple grains through improved seeds, synthetic fertilizers, and irrigation. The gains saved millions from hunger and remain the foundation of modern agriculture in much of Asia. However, they also concentrated production around a narrow set of crops and required steady inputs of water and chemicals, exposing farmers to price shocks and degrading soils over decades.

More recent thinking emphasizes resilience over raw yield. Practices such as cover cropping, drought-tolerant varieties, and improved storage can soften the impact of bad seasons without abandoning the productivity gains of the Green Revolution. Researchers also stress that food security is not only an agricultural question. In urban areas, the binding constraint is usually income rather than supply, which is why social-safety programs frequently outperform agricultural subsidies in reducing hunger.

Looking ahead, climate change is expected to shift growing regions, raise the frequency of crop-killing extreme weather, and complicate water management. Adaptation strategies — diversifying crops, supporting smallholders, investing in cold chains — will determine whether the gains of the past several decades hold or unravel. Food security, in other words, is no longer just a problem of producing more food, but of producing the right food in the right place at the right time.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, the Green Revolution:',
        options: [
          'Eliminated hunger in Asia permanently.',
          'Concentrated production on a narrow set of crops.',
          'Replaced grain cultivation with vegetables.',
          'Removed the need for irrigation.',
        ],
        answer: 'Concentrated production on a narrow set of crops.',
      ),
      MCQuestion(
        question: 'The passage suggests that, in cities, hunger is usually driven by:',
        options: [
          'Insufficient food supply.',
          'Insufficient household income.',
          'Slow harvests in surrounding regions.',
          'Failures of cover cropping.',
        ],
        answer: 'Insufficient household income.',
      ),
      MCQuestion(
        question: 'The author mentions cover cropping and drought-tolerant varieties to show that:',
        options: [
          'Resilience can complement existing productivity.',
          'Modern agriculture should be abandoned.',
          'Synthetic fertilizers are no longer used.',
          'Urban farming is the only solution.',
        ],
        answer: 'Resilience can complement existing productivity.',
      ),
      MCQuestion(
        question: 'According to the passage, future food security depends on producing:',
        options: [
          'As much food as possible regardless of crop.',
          'The right food in the right place at the right time.',
          'Only locally grown food.',
          'Food limited to traditional staples.',
        ],
        answer: 'The right food in the right place at the right time.',
      ),
    ],
  ),
  Passage(
    id: 't-r-8',
    title: 'Cognitive Psychology',
    body: '''Cognitive psychology investigates the mental processes that allow people to perceive, remember, reason, and decide. Where earlier approaches studied behavior as a response to stimuli, cognitive psychologists treat the mind as an information-processing system whose internal operations can be inferred from carefully designed experiments.

A foundational distinction is between short-term and long-term memory. Short-term memory holds a small amount of information for seconds, while long-term memory stores experiences and knowledge across decades. The two systems interact: rehearsal in short-term memory can transfer information to long-term storage, and retrieval brings long-term content back into conscious focus. Memory failures, contrary to popular belief, are not usually erasures; more often they are failures of access.

Attention is a second pillar of the field. Because the brain cannot process every signal at once, it filters most of what reaches the senses. Selective attention allows a listener to focus on one voice in a crowded room, but the cost is that other information is registered only weakly. Studies of "inattentional blindness" show that observers can fail to notice obvious events when their attention is occupied elsewhere — a result with implications for everything from eyewitness testimony to driver safety.

Decision research has identified a contrast between fast, intuitive judgments and slow, deliberate reasoning. Intuition is efficient and often accurate but can be misled by familiar shortcuts. Deliberate reasoning is more careful but slower and more effortful. Skilled professionals — pilots, doctors, chess players — develop disciplined ways of switching between the two modes, which is itself a learned skill rather than a fixed trait.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, cognitive psychology differs from earlier approaches by:',
        options: [
          'Treating the mind as an information-processing system.',
          'Refusing to use experiments.',
          'Studying only animal behavior.',
          'Avoiding any reference to memory.',
        ],
        answer: 'Treating the mind as an information-processing system.',
      ),
      MCQuestion(
        question: 'Memory failures, according to the passage, are usually:',
        options: [
          'Caused by erasure of stored information.',
          'Failures of access rather than storage.',
          'A sign of permanent damage.',
          'Limited to short-term memory.',
        ],
        answer: 'Failures of access rather than storage.',
      ),
      MCQuestion(
        question: 'What does inattentional blindness illustrate?',
        options: [
          'A complete loss of vision under stress.',
          'The brain\'s tendency to register the same scene repeatedly.',
          'The cost of focusing attention narrowly.',
          'A flaw in psychological experiments.',
        ],
        answer: 'The cost of focusing attention narrowly.',
      ),
      MCQuestion(
        question: 'According to the passage, switching between intuition and deliberate reasoning is:',
        options: [
          'A fixed personality trait.',
          'A skill that experts develop with training.',
          'A weakness in professional decision-making.',
          'Useful only for medical doctors.',
        ],
        answer: 'A skill that experts develop with training.',
      ),
    ],
  ),
  Passage(
    id: 't-r-9',
    title: 'Urban Transport',
    body: '''Modern cities measure their success in part by how easily their residents can move. A transit network is more than a collection of lines on a map; it shapes where people live, how they work, and even how long they live. Researchers in urban planning increasingly argue that affordable, frequent transit is one of the most powerful policy tools for shrinking inequality.

The case rests on three observations. First, transit is a great equalizer: households without a car can reach jobs, hospitals, and schools at a fraction of the cost of private driving. Second, transit shapes land use over decades. Lines built today encourage denser, more walkable neighborhoods to grow up around stations. Third, transit reduces emissions and crash deaths far more than equivalent investments in highways.

But transit only delivers these benefits when it is frequent and reliable. Hourly buses on winding routes do not change behavior; trains every five minutes do. The biggest predictor of ridership in study after study is not technology but service: how often vehicles arrive, how predictable the trip is, and how easy transfers are between modes. Some of the highest-ridership cities in the world rely on simple buses on dedicated lanes rather than on glamorous rail projects.

Critics worry about cost. Building transit is expensive, and political attention often follows new construction rather than steady operation. Yet maintenance and frequency improvements are usually cheaper and more effective than headline-grabbing extensions. Increasingly, planners argue that the smartest investments are in the ordinary upgrades that turn a fragile network into a dependable one.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, transit reduces inequality because:',
        options: [
          'It is cheaper to drive than to take transit.',
          'It gives households without cars access to opportunities.',
          'It eliminates the need for highways entirely.',
          'It is mostly used by wealthier neighborhoods.',
        ],
        answer: 'It gives households without cars access to opportunities.',
      ),
      MCQuestion(
        question: 'The strongest predictor of ridership, according to the passage, is:',
        options: ['the technology used', 'service frequency and reliability', 'station architecture', 'fare prices'],
        answer: 'service frequency and reliability',
      ),
      MCQuestion(
        question: 'Why does the passage mention dedicated bus lanes?',
        options: [
          'To argue against urban rail.',
          'To show that strong service can come from simple infrastructure.',
          'To suggest buses are obsolete.',
          'To criticize political attention spans.',
        ],
        answer: 'To show that strong service can come from simple infrastructure.',
      ),
      MCQuestion(
        question: 'According to the passage, planners increasingly favor:',
        options: [
          'Headline-grabbing line extensions.',
          'Maintenance and frequency improvements.',
          'Privatizing transit operations.',
          'Replacing all buses with rail.',
        ],
        answer: 'Maintenance and frequency improvements.',
      ),
    ],
  ),
  Passage(
    id: 't-r-10',
    title: 'Public Health Communication',
    body: '''Public health relies on its ability to communicate. Vaccination campaigns, smoking cessation, food safety, and outbreak response all depend on persuading large populations to change behavior, often without any face-to-face contact. Decades of evaluation have produced a clear, if uncomfortable, conclusion: the best message is rarely the most technically accurate one. It is the message that resonates with the audience\'s existing concerns.

A famous early example is the campaign against smoking. For years, public-health agencies issued warnings about lung cancer, but rates among adolescents barely shifted. Researchers eventually found that adolescents were not moved by warnings about a disease that seemed distant; they responded to messages about immediate appearance and athletic performance. Reframing the campaign reduced uptake substantially.

A second lesson is the importance of trusted messengers. Officials in a national agency may have the most accurate data, but in many communities they are also the least trusted. Successful programs partner with local clinicians, religious leaders, or grassroots organizations who can deliver the same evidence with greater credibility. Trust, in this view, is not a luxury added on top of facts; it is what determines whether the facts will be heard at all.

Modern outbreak response has added new challenges. Social media circulate rumors faster than agencies can respond, and audiences are fragmented across countless platforms. Effective communicators now monitor narratives in near real time, address concerns directly rather than dismissing them, and offer concrete steps rather than vague reassurance. The fundamentals — listen first, speak to the audience\'s priorities, choose messengers carefully — remain the same.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, the most effective public-health message is usually:',
        options: [
          'The most technically detailed.',
          'The one that resonates with the audience\'s existing concerns.',
          'The one written by a national agency.',
          'The shortest message available.',
        ],
        answer: 'The one that resonates with the audience\'s existing concerns.',
      ),
      MCQuestion(
        question: 'Why did adolescent smoking rates respond to a new campaign?',
        options: [
          'The new campaign used scarier statistics.',
          'It addressed appearance and athletic performance.',
          'It threatened legal consequences.',
          'It introduced free nicotine patches.',
        ],
        answer: 'It addressed appearance and athletic performance.',
      ),
      MCQuestion(
        question: 'The passage argues that local clinicians and religious leaders are valuable because:',
        options: [
          'They control the budget for public health.',
          'They are often more trusted in the community.',
          'They produce primary scientific research.',
          'They have more accurate data than national agencies.',
        ],
        answer: 'They are often more trusted in the community.',
      ),
      MCQuestion(
        question: 'What is the author\'s final takeaway?',
        options: [
          'Social media should be banned during outbreaks.',
          'The same fundamentals apply across eras: listen, speak to priorities, choose messengers.',
          'Public health is mostly a technical problem.',
          'Adolescents are uniquely difficult audiences.',
        ],
        answer: 'The same fundamentals apply across eras: listen, speak to priorities, choose messengers.',
      ),
    ],
  ),
  Passage(
    id: 't-r-11',
    title: 'The Cambrian Explosion',
    body:
        '''For most of Earth's biological history, life was microscopic. Then, roughly 540 million years ago, the fossil record changed abruptly. Within a span that, in geological terms, was remarkably short, nearly every major animal body plan known today appeared in the oceans. Hard shells, jointed limbs, complex eyes, and segmented bodies all arrived in close succession. Paleontologists call this episode the Cambrian explosion, and the question of what set it off remains one of the most contested problems in evolutionary biology.

A purely environmental explanation points to oxygen. Atmospheric and oceanic oxygen had been rising for hundreds of millions of years, and the levels in early Cambrian seas may have crossed a threshold that finally permitted large, active animals. Without enough oxygen, no organism can sustain the rapid metabolism that predation, swimming, and burrowing demand. Once the threshold was crossed, every ecological niche that had previously been closed suddenly opened.

A second explanation emphasizes ecology rather than chemistry. The earliest predators may have triggered an arms race in which prey species evolved defenses — shells, spines, faster swimming — and predators evolved better tools to defeat them. Each adaptation created selection pressure for further innovation, and the result was a rapid diversification of forms.

A third strand of work focuses on genetic potential. Comparative studies of living animals suggest that the basic regulatory genes that pattern bodies, sometimes called Hox genes, were already in place well before the Cambrian. What the explosion really represents may be the rearrangement of existing genetic tools rather than the sudden invention of new ones.

These views are not mutually exclusive. Oxygen probably permitted complex animals; ecological pressure shaped their forms; and ancient regulatory genes provided the raw material. The Cambrian story is increasingly told as a convergence of several factors, none of which would have been sufficient on its own.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, what makes the Cambrian explosion notable?',
        options: [
          'It produced the first single-celled life.',
          'Nearly every major animal body plan appeared in a short geological window.',
          'It eliminated all complex animals.',
          'It occurred on land before the oceans.',
        ],
        answer: 'Nearly every major animal body plan appeared in a short geological window.',
      ),
      MCQuestion(
        question: 'Why is oxygen relevant to the explanation?',
        options: [
          'Oxygen levels declined and forced animals to evolve.',
          'Atmospheric oxygen crossed a threshold that permitted large, active animals.',
          'Oxygen poisoned the early predators.',
          'Oxygen formed the first shells.',
        ],
        answer: 'Atmospheric oxygen crossed a threshold that permitted large, active animals.',
      ),
      MCQuestion(
        question: 'The "arms race" mentioned in the passage refers to:',
        options: [
          'A literal war between Cambrian species.',
          'Successive adaptations by predators and prey driving each other\'s evolution.',
          'A weapons system used by paleontologists.',
          'A geological process unrelated to biology.',
        ],
        answer: 'Successive adaptations by predators and prey driving each other\'s evolution.',
      ),
      MCQuestion(
        question: 'According to the passage, Hox genes:',
        options: [
          'Were invented during the Cambrian explosion.',
          'Were probably already present well before the Cambrian.',
          'Only exist in modern mammals.',
          'Are unrelated to body plans.',
        ],
        answer: 'Were probably already present well before the Cambrian.',
      ),
      MCQuestion(
        question: 'The author\'s overall conclusion is that the Cambrian explosion was driven by:',
        options: [
          'A single dominant cause.',
          'A convergence of oxygen levels, ecological pressure, and genetic potential.',
          'Random mutation alone.',
          'A meteorite impact.',
        ],
        answer: 'A convergence of oxygen levels, ecological pressure, and genetic potential.',
      ),
    ],
  ),
  Passage(
    id: 't-r-12',
    title: 'Photosynthesis: C3, C4, and CAM Plants',
    body:
        '''All photosynthetic plants ultimately convert sunlight, water, and carbon dioxide into sugars. The differences among species lie not in the goal but in the chemistry used to reach it. Three pathways dominate the modern flora, each well adapted to a particular set of environmental constraints.

The most common pathway, called C3, is named after a three-carbon compound produced in its first step. C3 plants — including wheat, rice, and most temperate trees — fix carbon dioxide directly using an enzyme called RuBisCO. The pathway is efficient in cool, moist climates with moderate light, but it has a weakness: when temperatures rise, RuBisCO begins to react with oxygen instead of carbon dioxide, wasting energy in a process called photorespiration.

C4 plants, such as maize and sugarcane, evolved an additional carbon-concentrating step that delivers carbon dioxide directly to RuBisCO at high concentration, suppressing photorespiration. The extra biochemical machinery is costly, but in hot, sunny climates the cost is more than repaid. Crops that originated in tropical regions tend to be C4, and they continue to outproduce C3 species there.

A third pathway, CAM (crassulacean acid metabolism), is the specialty of plants in arid environments — cacti, agaves, pineapples. CAM plants open their stomata at night to gather carbon dioxide, storing it as an organic acid until daylight, when photosynthesis proceeds with the stomata closed. The strategy minimizes water loss by avoiding the heat of midday, at the cost of slower growth.

Climate change is likely to reshape the distribution of these pathways. As regions become hotter and drier, plants with C4 and CAM physiology will gain advantage; species that rely on C3 may lose ground unless they can be bred for greater drought tolerance. Crop scientists already explore the possibility of inserting C4 traits into C3 staples — a long-term project, but one with potentially enormous yield gains in tropical agriculture.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, what weakens C3 photosynthesis at high temperatures?',
        options: [
          'RuBisCO reacts with oxygen instead of carbon dioxide.',
          'Sunlight becomes too intense for chlorophyll.',
          'Water vapor inhibits sugar formation.',
          'Stomata close permanently.',
        ],
        answer: 'RuBisCO reacts with oxygen instead of carbon dioxide.',
      ),
      MCQuestion(
        question: 'What is the main trade-off of C4 photosynthesis?',
        options: [
          'It cannot fix carbon dioxide.',
          'Extra biochemical machinery is costly but rewarded in hot climates.',
          'It works only at night.',
          'It produces less sugar than CAM.',
        ],
        answer: 'Extra biochemical machinery is costly but rewarded in hot climates.',
      ),
      MCQuestion(
        question: 'Why do CAM plants open their stomata at night?',
        options: [
          'To attract pollinators.',
          'To minimize water loss in arid climates.',
          'To increase photorespiration.',
          'To avoid sunlight.',
        ],
        answer: 'To minimize water loss in arid climates.',
      ),
      MCQuestion(
        question: 'The author suggests that as the climate warms:',
        options: [
          'All photosynthetic pathways will disappear.',
          'C4 and CAM species will gain advantage.',
          'CAM will become useless.',
          'C3 plants will outperform all others.',
        ],
        answer: 'C4 and CAM species will gain advantage.',
      ),
      MCQuestion(
        question: 'Why are crop scientists interested in adding C4 traits to C3 staples?',
        options: [
          'To make them suitable for indoor growing.',
          'For potentially enormous yield gains in tropical agriculture.',
          'To make them poisonous to pests.',
          'To slow photosynthesis.',
        ],
        answer: 'For potentially enormous yield gains in tropical agriculture.',
      ),
    ],
  ),
  Passage(
    id: 't-r-13',
    title: 'The Bronze Age Trade Network',
    body:
        '''The Bronze Age, which lasted from roughly 3000 to 1200 BCE, is named after the alloy that defined its tools and weapons. Bronze, a mixture of copper and tin, is harder and more durable than either of its components, but it required raw materials that were almost never found together. Copper was widely available; tin was extremely rare. To produce bronze on the scale that ancient empires demanded, communities had to exchange materials across long distances. This necessity created one of the earliest documented long-distance trade systems in the ancient world.

Archaeologists have traced the movement of tin from sources in Cornwall, central Asia, and possibly Afghanistan to workshops in the eastern Mediterranean. The same trade routes carried amber from the Baltic, lapis lazuli from modern Afghanistan, faience beads from Egypt, and Cypriot copper ingots. Excavations of a single shipwreck off the southern coast of Turkey, dating to the late Bronze Age, contained materials from at least seven different cultures. The cargo suggests not occasional travel but routine, organized exchange.

The political consequences were significant. Empires that controlled key nodes — narrow seas, river crossings, mountain passes — accumulated wealth and influence beyond what their immediate agricultural base could support. Egypt, Mycenae, and the Hittite empire all profited from being able to tax or block trade as they wished. Cultures that lay outside the main routes, in contrast, often remained at the technological level of the late Stone Age, unable to obtain the materials that bronze production required.

The collapse of the Bronze Age, around 1200 BCE, illustrates the fragility of these networks. A combination of drought, internal political pressure, and movement by displaced peoples disrupted trade across the eastern Mediterranean. Major palace economies fell within a few decades. The technology of bronze did not disappear, but the conditions that had made it widely available did. The eventual replacement of bronze with iron, which requires only domestic ore, may itself have been an adaptation to a less interconnected world.''',
    questions: [
      MCQuestion(
        question: 'Why did bronze production require long-distance trade?',
        options: [
          'Bronze can only be made from imported ores.',
          'Copper and tin are rarely found together.',
          'The technology was developed only in one city.',
          'Bronze tools were too heavy to transport.',
        ],
        answer: 'Copper and tin are rarely found together.',
      ),
      MCQuestion(
        question: 'The shipwreck off the coast of Turkey is mentioned to:',
        options: [
          'Show that Bronze Age trade was unsuccessful.',
          'Provide evidence of routine, organized long-distance exchange.',
          'Argue that copper was unavailable in Egypt.',
          'Disprove the existence of the Hittite empire.',
        ],
        answer: 'Provide evidence of routine, organized long-distance exchange.',
      ),
      MCQuestion(
        question: 'According to the passage, what advantage did empires controlling trade nodes have?',
        options: [
          'Larger native populations.',
          'Wealth and influence beyond their agricultural base.',
          'Direct access to iron deposits.',
          'Independence from neighboring states.',
        ],
        answer: 'Wealth and influence beyond their agricultural base.',
      ),
      MCQuestion(
        question: 'What does the passage suggest about the eventual switch to iron?',
        options: [
          'It was a step backward in technology.',
          'It may have been an adaptation to a less interconnected world.',
          'It eliminated the need for tools.',
          'It was prevented by religious authorities.',
        ],
        answer: 'It may have been an adaptation to a less interconnected world.',
      ),
      MCQuestion(
        question: 'The phrase "fragility of these networks" emphasizes that:',
        options: [
          'The networks were entirely peaceful.',
          'Trade systems could collapse under combined pressures.',
          'Materials were of low quality.',
          'Bronze itself shattered easily.',
        ],
        answer: 'Trade systems could collapse under combined pressures.',
      ),
    ],
  ),
  Passage(
    id: 't-r-14',
    title: 'Polar Ice and Sea Levels',
    body:
        '''Sea level depends on two main physical processes: the volume of water in the ocean and its temperature. Warmer water expands; colder water contracts. Adding meltwater from land ice raises the volume directly. Both processes are now contributing to a steady global rise, and understanding which dominates in any decade is essential for planning along coastlines.

The largest reservoirs of land ice are in Antarctica and Greenland. Together they hold enough water that, if entirely melted, sea level would rise more than sixty meters — a scenario well beyond the present century but useful as a reference point. Even the partial losses recorded so far have measurable effects. Greenland's ice sheet has lost about two hundred and seventy gigatons of ice per year for the past two decades; Antarctica's losses, concentrated in West Antarctica, are smaller but accelerating.

The physics of these losses differs in important ways. Greenland is losing mass mainly through surface melt during the warm months and through outlet glaciers that drain into the ocean. Warmer summers and exposed darker surfaces — which absorb more sunlight — amplify the loss. Antarctica, in contrast, has cold-enough air that surface melt is rare; its losses come almost entirely from warmer ocean water reaching the underside of floating ice shelves and causing them to thin. When a shelf weakens, the glaciers behind it accelerate, dumping more ice into the sea.

Forecasting future sea-level rise requires combining these processes with thermal expansion, which alone may account for half of the rise so far. Models converge on a likely range of roughly half a meter to a meter by 2100, but the upper bound depends critically on whether large parts of West Antarctica enter a runaway retreat — a scenario that some recent studies consider possible but not yet established. Coastal planners thus face a wide band of plausible futures and must decide how much margin to build into infrastructure decisions whose costs and benefits will play out over a century or more.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, sea-level rise depends on:',
        options: [
          'The volume of ocean water and its temperature.',
          'Wind and tides alone.',
          'The angle of the sun.',
          'Volcanic eruptions.',
        ],
        answer: 'The volume of ocean water and its temperature.',
      ),
      MCQuestion(
        question: 'What is the main mechanism by which Greenland loses ice?',
        options: [
          'Surface melt during warm months and ice drainage through outlet glaciers.',
          'Volcanic eruptions beneath the ice sheet.',
          'Cosmic radiation.',
          'Atmospheric pressure changes.',
        ],
        answer: 'Surface melt during warm months and ice drainage through outlet glaciers.',
      ),
      MCQuestion(
        question: 'According to the passage, what drives Antarctica\'s ice losses?',
        options: [
          'Sunlight reaching exposed dark surfaces.',
          'Warmer ocean water reaching the underside of floating ice shelves.',
          'Heavy rainfall.',
          'Air pollution.',
        ],
        answer: 'Warmer ocean water reaching the underside of floating ice shelves.',
      ),
      MCQuestion(
        question: 'Why is West Antarctica singled out in the passage?',
        options: [
          'It is the warmest part of the continent.',
          'Its potential runaway retreat is the main uncertainty in projections.',
          'It is the only region with measured ice loss.',
          'It is uninhabited.',
        ],
        answer: 'Its potential runaway retreat is the main uncertainty in projections.',
      ),
      MCQuestion(
        question: 'What does the author imply about coastal planners?',
        options: [
          'They should ignore long-term forecasts.',
          'They must decide how much margin to build into infrastructure for an uncertain future.',
          'They should rely on a single scenario.',
          'They should focus only on Antarctica.',
        ],
        answer: 'They must decide how much margin to build into infrastructure for an uncertain future.',
      ),
    ],
  ),
  Passage(
    id: 't-r-15',
    title: 'Memory Consolidation During Sleep',
    body:
        '''A growing body of research suggests that sleep is not simply a period of inactivity but an active phase during which the brain stabilizes and reorganizes the memories acquired during waking hours. The process is called memory consolidation, and it has changed how scientists understand both learning and the function of dreams.

Studies typically measure consolidation by comparing performance on a task immediately after learning and again after a period that includes sleep or only wakefulness. Across many tasks — motor skills, vocabulary, visual discrimination — participants who sleep between testing perform better than those who remain awake for the same duration, even when accounting for fatigue. The improvement is not merely retention; it sometimes includes the discovery of new patterns that participants did not consciously notice during practice.

The phases of sleep appear to play distinct roles. Slow-wave sleep, dominant early in the night, is associated with the stabilization of factual memories — names, dates, locations. Rapid-eye-movement sleep, more prominent later in the night, is linked to procedural and emotional memories: how to ride a bicycle, how a difficult conversation felt. Disrupting one phase can selectively impair the corresponding kind of consolidation, which is one reason researchers worry about chronic sleep restriction even when total sleep time appears adequate.

The implications for education and skill training are significant. Students who pull all-night study sessions before exams perform worse than those who sleep, partly because their consolidation never occurs. Musicians and athletes report — and laboratory experiments support — that a difficult passage practiced before bed often feels easier the next morning, as if the brain had continued working in the background. The effect is real but not magical: sleep cannot consolidate memories that were never properly encoded in the first place.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, memory consolidation is:',
        options: [
          'A passive form of decay.',
          'An active process during sleep that stabilizes and reorganizes memories.',
          'A type of dream content.',
          'A failure of the immune system.',
        ],
        answer: 'An active process during sleep that stabilizes and reorganizes memories.',
      ),
      MCQuestion(
        question: 'What do experiments typically find about participants who sleep between testing sessions?',
        options: [
          'They perform worse than those who stay awake.',
          'They perform better, sometimes spotting new patterns.',
          'They forget everything.',
          'They become anxious.',
        ],
        answer: 'They perform better, sometimes spotting new patterns.',
      ),
      MCQuestion(
        question: 'Slow-wave sleep is associated with:',
        options: [
          'Procedural skill memories.',
          'Stabilization of factual memories such as names and dates.',
          'Emotional regulation.',
          'Visual hallucinations.',
        ],
        answer: 'Stabilization of factual memories such as names and dates.',
      ),
      MCQuestion(
        question: 'Why does the passage mention all-night study sessions?',
        options: [
          'To recommend them as an effective study strategy.',
          'To show that they impair consolidation and reduce performance.',
          'To compare them to athletic training.',
          'To advise students to dream during exams.',
        ],
        answer: 'To show that they impair consolidation and reduce performance.',
      ),
      MCQuestion(
        question: 'According to the passage, what limit does sleep have on memory?',
        options: [
          'It can replace the need for practice entirely.',
          'It cannot consolidate memories that were never properly encoded.',
          'It only helps with motor skills.',
          'It works only in children.',
        ],
        answer: 'It cannot consolidate memories that were never properly encoded.',
      ),
    ],
  ),
  Passage(
    id: 't-r-16',
    title: 'Roman Concrete',
    body:
        '''Modern concrete is one of the most-used construction materials in the world, but it has a stubborn weakness: it cracks and decays over decades, especially when exposed to seawater. Roman concrete, used to build harbors, breakwaters, and the Pantheon\'s dome two thousand years ago, has the opposite reputation. Many Roman structures remain intact in conditions that would destroy modern concrete within a century. The reason has only recently become clear.

The Romans mixed lime, volcanic ash, and rubble to produce a binder that hardens through a slow chemical reaction. Volcanic ash from the area around Pozzuoli, known today as pozzolana, gave the mix its characteristic durability. When seawater penetrated the structure, it reacted with minerals in the ash to form new compounds — particularly a mineral called aluminous tobermorite — that grew within the pores of the concrete and strengthened it from the inside.

Modern Portland-cement concrete, in contrast, is essentially finished as soon as it sets. Any cracks that form are pathways for water and damage, and the material has no internal mechanism for repair. Engineers have long admired the Roman record but have struggled to reproduce its self-healing chemistry on the scale that modern construction demands.

Recent laboratory work has changed the picture. Researchers found that some Roman batches contain small chunks of unreacted lime — once dismissed as evidence of careless mixing — that turn out to be deliberate. When cracks form and water enters, the lime chunks dissolve and seed new mineral growth, sealing the crack. Experiments using a similar approach in modern concrete show measurable self-repair, opening the possibility of structures that age more gracefully than current materials. Whether the technique can be scaled commercially remains to be seen, but the broader lesson — that ancient builders sometimes understood materials in ways that have eluded modern industry — is increasingly clear.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, what is the main weakness of modern concrete?',
        options: [
          'It is too expensive.',
          'It cracks and decays, especially in seawater.',
          'It cannot be poured.',
          'It is dangerous to humans.',
        ],
        answer: 'It cracks and decays, especially in seawater.',
      ),
      MCQuestion(
        question: 'What role does volcanic ash play in Roman concrete?',
        options: [
          'It darkens the surface.',
          'It reacts with seawater to form strengthening minerals over time.',
          'It speeds up initial setting.',
          'It prevents the use of lime.',
        ],
        answer: 'It reacts with seawater to form strengthening minerals over time.',
      ),
      MCQuestion(
        question: 'Why were lime chunks once dismissed as careless mixing?',
        options: [
          'They were thought to weaken the structure.',
          'They were assumed to be accidental rather than deliberate.',
          'They were considered too expensive.',
          'They were used only in decoration.',
        ],
        answer: 'They were assumed to be accidental rather than deliberate.',
      ),
      MCQuestion(
        question: 'The phrase "self-healing chemistry" refers to:',
        options: [
          'The ability of concrete to repair small cracks through chemical reactions.',
          'A medical treatment.',
          'A process used only in modern industry.',
          'The replacement of stones by lime.',
        ],
        answer: 'The ability of concrete to repair small cracks through chemical reactions.',
      ),
      MCQuestion(
        question: 'What does the passage suggest about ancient builders?',
        options: [
          'They were less skilled than modern engineers.',
          'They sometimes understood materials in ways modern industry has not yet matched.',
          'They had no knowledge of chemistry.',
          'They relied entirely on stone.',
        ],
        answer: 'They sometimes understood materials in ways modern industry has not yet matched.',
      ),
    ],
  ),
  Passage(
    id: 't-r-17',
    title: 'The Origins of Agriculture',
    body:
        '''The transition from hunting and gathering to farming is one of the most significant changes in human history. It occurred independently in at least seven separate regions — the Fertile Crescent, China, the Americas, Africa, and parts of South Asia — over a span of about five thousand years. The simultaneity is striking, given that no contact existed between most of these communities. Researchers continue to ask why so many societies, in such varied environments, made the same kind of shift at roughly the same time.

A leading hypothesis points to climate. The end of the most recent ice age, around 11,500 years ago, produced warmer and more stable conditions across much of the planet. Reliable rainfall, longer growing seasons, and richer soils made the cultivation of grasses and tubers more practical than it had been for millennia. Wild ancestors of wheat, barley, rice, maize, and the potato all responded to selective tending and slowly diverged into the domesticated forms recognizable today.

Climate alone, however, cannot explain why some communities chose farming and others did not. Population pressure may have been one driver: as bands grew, the limited returns of hunting and gathering forced experimentation with cultivation. Cultural memory of plant management may also have built up gradually, until small earlier experiments became viable. Once farming established itself, the increased food security supported larger settlements, which in turn made the rapid abandonment of farming impractical even when individual harvests failed.

The consequences of agriculture were dramatic but not uniformly positive. Skeletal evidence indicates that early farmers were often shorter, less robust, and more prone to disease than their hunting-and-gathering predecessors. The grain-heavy diet was less varied, and the dense settlements that farming permitted brought new parasites and infections. The long-term gains in population and technological complexity came with these often-overlooked human costs.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, what makes the global emergence of agriculture striking?',
        options: [
          'It happened in only one region.',
          'It occurred independently in many regions with no contact between them.',
          'It was followed by a return to hunting and gathering.',
          'It produced no detectable food gain.',
        ],
        answer: 'It occurred independently in many regions with no contact between them.',
      ),
      MCQuestion(
        question: 'Why is climate one of the leading explanations?',
        options: [
          'It cooled the planet and required new technology.',
          'Warmer, more stable conditions after the ice age made cultivation more practical.',
          'It produced famine that ended hunting.',
          'It eliminated wild plant species.',
        ],
        answer: 'Warmer, more stable conditions after the ice age made cultivation more practical.',
      ),
      MCQuestion(
        question: 'According to the passage, what is one limit of the climate explanation?',
        options: [
          'It contradicts genetic data.',
          'It cannot explain why some communities adopted farming and others did not.',
          'It has been entirely refuted.',
          'It applies only to South Asia.',
        ],
        answer: 'It cannot explain why some communities adopted farming and others did not.',
      ),
      MCQuestion(
        question: 'Skeletal evidence from early farmers suggests they were:',
        options: [
          'Taller and healthier than their predecessors.',
          'Often shorter, less robust, and more prone to disease.',
          'Identical in health to hunters.',
          'Resistant to all infections.',
        ],
        answer: 'Often shorter, less robust, and more prone to disease.',
      ),
      MCQuestion(
        question: 'The author\'s overall stance toward agriculture is that:',
        options: [
          'Its gains came with significant human costs.',
          'It was uniformly beneficial.',
          'It was an unmistakable mistake.',
          'It was a recent invention.',
        ],
        answer: 'Its gains came with significant human costs.',
      ),
    ],
  ),
  Passage(
    id: 't-r-18',
    title: 'Patronage and the Renaissance Artist',
    body:
        '''The image of the Renaissance artist as a solitary genius is largely a modern invention. In fifteenth-century Italy, a painter or sculptor was first and foremost a member of a workshop, hired by a patron whose specifications were detailed and binding. The terms of a commission — size, subject, materials, even the use of expensive pigments such as ultramarine — were negotiated in writing and audited as the work progressed. The patron, not the artist, often selected the iconography, and major decisions about composition were settled before the first brushstroke.

This degree of control suited both parties. For the patron — a religious order, a guild, a private family — a painted altarpiece or sculpted tomb was a permanent assertion of status. For the artist, a contract from a powerful sponsor guaranteed materials, payment, and visibility, and it sometimes opened the way to the next commission. The young Michelangelo, like the young Leonardo, depended on such patrons; even after their reputations had grown, their largest works remained patron-driven projects.

The system began to shift in the sixteenth century. Some artists, by then famous across Europe, started to negotiate with patrons as near-equals. Titian, for instance, painted multiple portraits of Charles V and was rewarded with titles and stipends. The change reflected not only individual reputations but a slowly evolving idea: that the artist contributed something — a personal vision — that no patron could specify in advance.

The modern emphasis on individual creativity emerged from this shift. The workshop did not disappear, but the assistants once vital to large commissions became less prominent in the eventual mythology. To recover the Renaissance fully, however, historians argue that we must restore the patron and the workshop to the story. The masterpiece, in this view, is rarely the work of one hand.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, the modern image of the Renaissance artist:',
        options: [
          'Accurately reflects fifteenth-century practice.',
          'Is largely a modern invention.',
          'Originated in ancient Rome.',
          'Was never accepted in Italy.',
        ],
        answer: 'Is largely a modern invention.',
      ),
      MCQuestion(
        question: 'What kind of details were typically settled before painting began?',
        options: [
          'The artist\'s mood.',
          'The size, subject, materials, and even pigment choices.',
          'Only the date of completion.',
          'Nothing — artists worked freely.',
        ],
        answer: 'The size, subject, materials, and even pigment choices.',
      ),
      MCQuestion(
        question: 'Why does the passage mention Titian?',
        options: [
          'To show that he failed as a portrait painter.',
          'To illustrate a growing artistic ability to negotiate with patrons as near-equals.',
          'To argue against the Renaissance entirely.',
          'To compare him unfavorably to Michelangelo.',
        ],
        answer: 'To illustrate a growing artistic ability to negotiate with patrons as near-equals.',
      ),
      MCQuestion(
        question: 'The phrase "personal vision" in the passage refers to:',
        options: [
          'An artist\'s eyesight.',
          'A contribution that a patron could not specify in advance.',
          'A religious doctrine.',
          'The use of perspective.',
        ],
        answer: 'A contribution that a patron could not specify in advance.',
      ),
      MCQuestion(
        question: 'What do historians argue today, according to the passage?',
        options: [
          'The Renaissance never happened.',
          'The patron and the workshop must be restored to the story to understand the era fully.',
          'Renaissance art should be ignored.',
          'Only the most famous painters matter.',
        ],
        answer: 'The patron and the workshop must be restored to the story to understand the era fully.',
      ),
    ],
  ),
  Passage(
    id: 't-r-19',
    title: 'Color Vision in Animals',
    body:
        '''Color is not an objective property of the world but a perception constructed by an organism\'s visual system. The same scene can appear in radically different colors to two species, depending on the photoreceptors each has evolved. Studying these differences offers a window into both the physics of light and the ecological demands that shape an animal\'s biology.

Most mammals are dichromats: they have two kinds of cone cells, sensitive roughly to blue and yellow-green. This is the system inherited by our distant ancestors and retained by most modern mammals, from dogs to deer. The world such animals perceive lacks the rich distinction between green and red that humans take for granted; a ripe red apple against green leaves blends, for them, into a single muted tone.

Primates, by contrast, are mostly trichromats, with a third cone added that detects the long wavelengths we perceive as red. The trait probably evolved to help arboreal ancestors locate ripe fruit and tender young leaves against forest backgrounds. The trade-off is interesting: trichromats see ripeness easily but, lacking the dichromat\'s peculiar sensitivity, may have a harder time picking out camouflaged prey.

Some birds and reptiles outdo us. Many birds are tetrachromats — they have four cone types and a sensitivity that extends into the ultraviolet. Patterns invisible to humans, on feathers and flowers alike, glow brightly in their vision. Honeybees, with a different but overlapping system, see ultraviolet markings on flowers that effectively act as landing strips guiding them toward nectar.

The lesson is not that one visual system is superior to another. It is that perception is shaped by ecological need. The colors an animal sees reflect the evolutionary pressures it has met: ripe fruit in forest canopies, ultraviolet patterns on flowers, the warning patterns of toxic prey. To understand any species\' world, you must study its eyes.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, color is best described as:',
        options: [
          'An objective physical property.',
          'A perception constructed by an organism\'s visual system.',
          'Identical for all mammals.',
          'A myth.',
        ],
        answer: 'A perception constructed by an organism\'s visual system.',
      ),
      MCQuestion(
        question: 'Why does primate trichromacy probably exist?',
        options: [
          'To detect ripe fruit and young leaves in forest canopies.',
          'To improve hearing.',
          'To camouflage primates from predators.',
          'To cool the body.',
        ],
        answer: 'To detect ripe fruit and young leaves in forest canopies.',
      ),
      MCQuestion(
        question: 'A possible trade-off of trichromacy mentioned in the passage is that:',
        options: [
          'Trichromats see only black and white.',
          'Trichromats may have a harder time spotting camouflaged prey.',
          'Trichromats cannot see at night.',
          'Trichromats lose their hearing.',
        ],
        answer: 'Trichromats may have a harder time spotting camouflaged prey.',
      ),
      MCQuestion(
        question: 'What can many birds see that humans cannot?',
        options: [
          'Sound.',
          'Patterns in the ultraviolet range.',
          'Heat radiation directly.',
          'Microscopic details of soil.',
        ],
        answer: 'Patterns in the ultraviolet range.',
      ),
      MCQuestion(
        question: 'The author\'s overall point is that:',
        options: [
          'Mammalian vision is the standard against which others are judged.',
          'Perception is shaped by ecological need; no system is universally superior.',
          'Color vision is unimportant in evolution.',
          'Only humans truly see color.',
        ],
        answer: 'Perception is shaped by ecological need; no system is universally superior.',
      ),
    ],
  ),
  Passage(
    id: 't-r-20',
    title: 'Soil Carbon and Climate',
    body:
        '''Soils hold more carbon than the atmosphere and all living vegetation combined. The figure surprises people who think of climate change as a problem of fossil fuels, but the planet\'s subsurface is one of the largest active reservoirs in the global carbon cycle. Whether soils continue to store carbon, or release more than they capture, depends on management decisions made on farms, in forests, and across grasslands.

Most soil carbon takes the form of decomposed organic matter — leaves, roots, microbes — slowly broken down by fungi and bacteria. Stable, undisturbed soils retain this material for decades or centuries. Disturbance changes the balance. Plowing, in particular, exposes deep layers to oxygen, accelerating decomposition and releasing carbon dioxide. Roughly one-third of all carbon dioxide added to the atmosphere since the start of widespread agriculture is estimated to have come from soils.

Practices that reverse this loss are well documented but not universally adopted. Cover cropping, which keeps roots in the ground during what would otherwise be fallow months, returns organic matter to the soil. Reduced or no-till methods leave decomposing residues on the surface, slowing oxidation. Restoration of degraded land, particularly grasslands and tropical pastures, can recover carbon at impressive rates for the first decade after planting.

The economic question is whether farmers can be paid for the carbon they store. Several governments are experimenting with credits that reward verified gains, but the measurement is difficult: soil carbon must be sampled across deep layers and across years to confirm any change. Critics argue that the credits, if poorly designed, may reward practices that would have been adopted anyway, or fail to penalize ongoing losses elsewhere. Even so, the carbon held in soils is too large a reservoir to leave outside climate policy. The choices that determine its trajectory are made not in legislatures but on farmland, season by season.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, why is soil carbon often surprising in scale?',
        options: [
          'It is more than the atmosphere and all living vegetation combined.',
          'It is the only form of organic matter on Earth.',
          'It exists only in deserts.',
          'It is mostly fossilized.',
        ],
        answer: 'It is more than the atmosphere and all living vegetation combined.',
      ),
      MCQuestion(
        question: 'How does plowing affect soil carbon?',
        options: [
          'It locks more carbon into the soil.',
          'It exposes deep layers to oxygen and releases carbon dioxide.',
          'It produces electricity.',
          'It has no measurable effect.',
        ],
        answer: 'It exposes deep layers to oxygen and releases carbon dioxide.',
      ),
      MCQuestion(
        question: 'Which practice is mentioned as a way to return carbon to the soil?',
        options: [
          'Continuous fallow.',
          'Cover cropping during otherwise fallow months.',
          'Burning crop residues.',
          'Removing all vegetation.',
        ],
        answer: 'Cover cropping during otherwise fallow months.',
      ),
      MCQuestion(
        question: 'What concern do critics raise about carbon credits?',
        options: [
          'They are easy to verify.',
          'They may reward practices that would have happened anyway.',
          'They are limited to forestry.',
          'They are too expensive for farmers.',
        ],
        answer: 'They may reward practices that would have happened anyway.',
      ),
      MCQuestion(
        question: 'According to the author, key decisions about soil carbon are made:',
        options: [
          'Only in international meetings.',
          'Mostly in legislatures.',
          'On farmland, season by season.',
          'In academic laboratories alone.',
        ],
        answer: 'On farmland, season by season.',
      ),
    ],
  ),
  Passage(
    id: 't-r-21',
    title: 'The Voyager Spacecraft',
    body:
        '''Launched in 1977, the two Voyager spacecraft were originally tasked with a brief tour of the outer planets. Engineers at the Jet Propulsion Laboratory designed them with redundant systems and a flexible mission plan, knowing that the alignment of the giant planets at the time offered a once-in-176-years opportunity. Almost five decades later, both spacecraft are still operating, far beyond the original mission parameters and now well into interstellar space.

The route the spacecraft followed was made possible by a technique called gravity assist. By skimming close to one planet and using its gravity to bend the trajectory, the spacecraft gained speed without using additional fuel. Voyager 2 visited Jupiter, Saturn, Uranus, and Neptune — the only spacecraft ever to encounter the last two — and returned the first detailed images of their atmospheres and moons. Voyager 1 took a similar early route but was then directed sharply outward toward the heliopause, the boundary between the Sun\'s influence and the broader galaxy.

The science returned by the Voyagers was unexpected as often as it was confirming. Saturn\'s rings turned out to be far more intricate than ground-based observation suggested. Jupiter\'s moon Io revealed active volcanism, the first evidence of ongoing geology beyond Earth. Neptune\'s atmosphere had storms moving at supersonic speeds. Each encounter shifted what scientists thought possible in cold, distant systems.

What remains striking about the Voyagers is how much they have outlived their assumed lifetimes. Power, supplied by decaying plutonium, decreases each year, and engineers have shut down instruments one by one to keep critical systems alive. The spacecraft still send data back across more than twenty light-hours of space — a journey of nearly a day even at the speed of light. They will eventually go silent, but their physical bodies will continue outward, slipping between stars on timescales that dwarf the entire history of human civilization.''',
    questions: [
      MCQuestion(
        question: 'Why were the Voyager spacecraft launched in 1977 specifically?',
        options: [
          'It was the year the technology became affordable.',
          'A once-in-176-years alignment of the outer planets was available.',
          'A previous mission had failed in 1976.',
          'The Sun was particularly quiet that year.',
        ],
        answer: 'A once-in-176-years alignment of the outer planets was available.',
      ),
      MCQuestion(
        question: 'What is gravity assist, according to the passage?',
        options: [
          'A method that bends the trajectory using a planet\'s gravity to gain speed.',
          'A device for stabilizing the spacecraft.',
          'A propulsion system that uses solar energy.',
          'A maneuver to land on a planet.',
        ],
        answer: 'A method that bends the trajectory using a planet\'s gravity to gain speed.',
      ),
      MCQuestion(
        question: 'Which discovery from Jupiter\'s moon Io was a first for science?',
        options: [
          'Liquid water at the surface.',
          'The first evidence of ongoing geology beyond Earth.',
          'An atmosphere identical to Earth\'s.',
          'Ring systems around a moon.',
        ],
        answer: 'The first evidence of ongoing geology beyond Earth.',
      ),
      MCQuestion(
        question: 'Why are engineers shutting down some Voyager instruments?',
        options: [
          'The instruments are corrupted.',
          'Decaying plutonium power requires careful conservation of remaining energy.',
          'They are no longer useful to science.',
          'Earth has lost the ability to receive them.',
        ],
        answer: 'Decaying plutonium power requires careful conservation of remaining energy.',
      ),
      MCQuestion(
        question: 'According to the passage, the Voyagers\' physical bodies will:',
        options: [
          'Eventually return to Earth.',
          'Continue outward between stars long after they go silent.',
          'Burn up in the heliopause.',
          'Become moons of distant planets.',
        ],
        answer: 'Continue outward between stars long after they go silent.',
      ),
    ],
  ),
  Passage(
    id: 't-r-22',
    title: 'The Discovery of Insulin',
    body:
        '''Before 1922, a diagnosis of severe diabetes was effectively a death sentence. The disease prevented the body from regulating blood sugar, and the only treatment available was a near-starvation diet that could prolong life by a few months but not save it. The discovery of insulin in Toronto in the early 1920s changed the course of the disease almost overnight, and it remains one of the clearest examples in modern medicine of how rapidly a treatment can transform a patient population.

The work began with the recognition that something in the pancreas, in particular a part called the islets of Langerhans, must be responsible for glucose regulation. Earlier researchers had failed to isolate the active ingredient because the enzymes that the pancreas secretes for digestion broke down the very substance they sought. A young surgeon, Frederick Banting, proposed tying off pancreatic ducts to allow the digestive cells to atrophy while leaving the islets intact. With the support of a senior professor, John Macleod, and a skilled graduate student, Charles Best, the team prepared extracts that consistently lowered blood sugar in diabetic dogs.

Clinical use followed within months. A fourteen-year-old patient, near death, was given the new extract and recovered. The image of formerly emaciated children gaining weight within weeks moved the medical community and the public alike. The Nobel Prize followed in 1923. The team and the University of Toronto chose to license the compound to manufacturers for a token fee rather than build a private commercial position around it — a decision that helped spread the treatment quickly.

The history is not without complications. The roles of Banting, Best, and Macleod, along with that of biochemist James Collip who later purified the extract, were widely disputed. The collaboration was sometimes acrimonious. Yet the broader achievement is clear: a fatal disease became a chronic but manageable one, and the careful clinical record of the early years became a model for translational medicine.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, why had earlier researchers failed to isolate the active substance?',
        options: [
          'Digestive enzymes in the pancreas broke it down.',
          'The pancreas does not contain it.',
          'They lacked microscopes.',
          'The disease did not exist before 1922.',
        ],
        answer: 'Digestive enzymes in the pancreas broke it down.',
      ),
      MCQuestion(
        question: 'Why did Banting propose tying off pancreatic ducts?',
        options: [
          'To increase enzyme production.',
          'To allow digestive cells to atrophy while leaving the islets intact.',
          'To eliminate the islets entirely.',
          'To make the pancreas larger.',
        ],
        answer: 'To allow digestive cells to atrophy while leaving the islets intact.',
      ),
      MCQuestion(
        question: 'How did the University of Toronto handle the discovery commercially?',
        options: [
          'It refused to share it with any manufacturer.',
          'It licensed the compound to manufacturers for a token fee.',
          'It demanded high royalties from every patient.',
          'It sold the patent to a single foreign firm.',
        ],
        answer: 'It licensed the compound to manufacturers for a token fee.',
      ),
      MCQuestion(
        question: 'According to the passage, the discovery of insulin transformed diabetes into:',
        options: [
          'An untreatable condition.',
          'A chronic but manageable disease.',
          'A purely genetic problem.',
          'An infectious illness.',
        ],
        answer: 'A chronic but manageable disease.',
      ),
      MCQuestion(
        question: 'What does the author imply about the team\'s collaboration?',
        options: [
          'It was uniformly cordial.',
          'It was sometimes acrimonious, with disputed credit.',
          'It involved only one researcher.',
          'It was led by a private company.',
        ],
        answer: 'It was sometimes acrimonious, with disputed credit.',
      ),
    ],
  ),
  Passage(
    id: 't-r-23',
    title: 'Animal Tool Use',
    body:
        '''For most of the twentieth century, tool use was treated as a defining feature of humans, a marker that separated us from other animals. Decades of careful field observation have undermined that boundary so completely that the question is no longer whether other animals use tools but how widespread, how flexible, and how cumulative their tool traditions are.

Chimpanzees offer the longest-studied example. Wild chimpanzees crack open nuts with stone hammers, fish for termites with stripped twigs, and use leaves as sponges to drink from tree hollows. The techniques differ from one community to another in ways that cannot be explained by genetics or environment alone. A given group hands down its preferred method through observation and imitation, in much the way that human craft traditions persist locally.

Birds, particularly New Caledonian crows, are now known to manufacture tools as well as use them. A crow facing an out-of-reach grub will trim a hooked twig with its beak before inserting it. In captive experiments, the same species spontaneously bends a length of wire to form a hook — a step traditionally taken as evidence of sophisticated problem-solving. Octopuses, despite being separated from us by hundreds of millions of years of evolution, gather discarded coconut shells and carry them across the seafloor for later use as shelters.

These observations have changed both biology and philosophy. The capacity for tool use no longer needs to be explained by a single anatomical or cognitive trait. It seems to arise wherever animals face problems that benefit from the right object at the right moment, and where social learning can spread successful solutions. The interesting question is no longer where tool use begins but why it does not become more elaborate in species that already display the basic capacity. The honest answer remains incomplete.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, the boundary that once separated humans from other animals on tool use:',
        options: [
          'Has been confirmed by recent research.',
          'Has been undermined by decades of field observation.',
          'Was first established in the 21st century.',
          'Applies only to apes.',
        ],
        answer: 'Has been undermined by decades of field observation.',
      ),
      MCQuestion(
        question: 'How do tool traditions among chimpanzees vary?',
        options: [
          'They are identical worldwide.',
          'They differ by community in ways not fully explained by genetics or environment.',
          'They are taught by humans.',
          'They disappear within a single generation.',
        ],
        answer: 'They differ by community in ways not fully explained by genetics or environment.',
      ),
      MCQuestion(
        question: 'What makes New Caledonian crows particularly notable?',
        options: [
          'They use stones to crack nuts.',
          'They manufacture hooked tools, including bending wire in captivity.',
          'They imitate human speech.',
          'They live underground.',
        ],
        answer: 'They manufacture hooked tools, including bending wire in captivity.',
      ),
      MCQuestion(
        question: 'According to the passage, octopus tool use suggests that:',
        options: [
          'Tool use requires a backbone.',
          'Tool use can arise in lineages very distant from ours.',
          'Octopuses learned tool use from chimpanzees.',
          'Tool use is restricted to land animals.',
        ],
        answer: 'Tool use can arise in lineages very distant from ours.',
      ),
      MCQuestion(
        question: 'What does the author identify as the current open question?',
        options: [
          'Whether any animal uses tools.',
          'Why tool use does not become more elaborate in species that already display the basic capacity.',
          'Whether humans are the only species capable of using tools.',
          'Whether stone tools exist at all.',
        ],
        answer: 'Why tool use does not become more elaborate in species that already display the basic capacity.',
      ),
    ],
  ),
  Passage(
    id: 't-r-24',
    title: 'The Logistics of Ancient Armies',
    body:
        '''The marches of ancient empires are often described in terms of battles and tactics, but the success of any large army rested on a less visible foundation: logistics. Feeding, watering, and equipping tens of thousands of soldiers and animals along an unfamiliar road was a problem of arithmetic as much as strategy, and the solutions developed by Roman, Persian, and Han Chinese commanders shaped the limits of their political reach.

A typical Roman legion on the march required roughly three tons of grain a day for its men alone. Pack animals doubled the demand, since they had to be fed as well, and water in dry regions could be more constraining than food. Commanders maintained large supply trains, established prearranged depots along the route, and where possible used river or sea transport, which moved bulk goods at a fraction of the cost of overland carts. Imperial roads — the Persian Royal Road, the Roman cursus — were as much logistical infrastructure as routes of communication.

A second strategy was to live off the land. Forager parties detached from the main column gathered grain from local fields, sometimes by purchase but often by seizure. The approach worked in agricultural regions during harvest seasons but failed catastrophically in deserts or in winter. Disasters such as Napoleon\'s losses in Russia, more than a thousand years later, repeated this pattern in modern form: an army that outruns its supplies ceases to be an army within days.

The political consequences are easy to overlook. Empires expanded where logistics permitted. They contracted where they did not. The fixed locations of supply depots, the seasonality of food, and the limits of pack animals shaped the borders of empires as decisively as any negotiation or treaty. Modern military history has begun to give logistics the central role it deserves, an emphasis that historians of antiquity have shared for decades.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, what was a Roman legion\'s rough daily grain requirement?',
        options: [
          'Three tons for its men alone.',
          'One ton including animals.',
          'Less than half a ton.',
          'Ten tons of grain.',
        ],
        answer: 'Three tons for its men alone.',
      ),
      MCQuestion(
        question: 'Why was water often more constraining than food in dry regions?',
        options: [
          'Soldiers refused to carry it.',
          'Wells were forbidden by treaty.',
          'It could not be transported as efficiently and was needed continuously.',
          'It was always poisoned.',
        ],
        answer: 'It could not be transported as efficiently and was needed continuously.',
      ),
      MCQuestion(
        question: 'According to the passage, when did "living off the land" tend to fail?',
        options: [
          'In agricultural regions during harvest.',
          'In deserts or in winter.',
          'In river valleys.',
          'In peacetime.',
        ],
        answer: 'In deserts or in winter.',
      ),
      MCQuestion(
        question: 'Why does the passage compare ancient armies to Napoleon\'s losses in Russia?',
        options: [
          'To prove that armies improved over time.',
          'To show that armies that outrun their supplies fail, repeating an ancient pattern.',
          'To argue that Russia is unconquerable.',
          'To recommend the use of horses.',
        ],
        answer: 'To show that armies that outrun their supplies fail, repeating an ancient pattern.',
      ),
      MCQuestion(
        question: 'The author\'s main argument is that:',
        options: [
          'Battles, not logistics, decide wars.',
          'Logistics shaped the borders of empires as decisively as treaties.',
          'Ancient armies had no supply problems.',
          'Pack animals can replace soldiers.',
        ],
        answer: 'Logistics shaped the borders of empires as decisively as treaties.',
      ),
    ],
  ),
  Passage(
    id: 't-r-25',
    title: 'Glaciers as Records of Climate',
    body:
        '''Glaciers are sometimes described as rivers of ice, but a more useful metaphor for scientists is a slow archive. Each year\'s snowfall is added on top of the previous one and gradually compressed into layered ice, trapping bubbles of ancient air and traces of chemical composition. Drilling a vertical core through a thick glacier therefore returns a stratified record of the atmosphere going back, in some cases, hundreds of thousands of years.

The Antarctic ice sheet has been the most productive site for this kind of work. Cores recovered from the East Antarctic plateau show that atmospheric carbon dioxide and methane have cycled within well-defined ranges through eight glacial periods. Modern levels, when added to the same chart, lie far outside the historical envelope. The result is not opinion but a direct chemical reading of the air our ancestors breathed.

Cores also record volcanic eruptions, the timing of dust storms, and the chemistry of distant oceans. A thin layer of acidic ice can be matched to a specific eruption by its isotopic fingerprint. The width of an annual layer gives a clue to the rate of snowfall, which in turn reflects regional climate. Combined with tree-ring records and lake-bed sediments, ice cores form a multi-proxy framework that allows climate scientists to cross-check their interpretations.

The work is laborious. Cores are drilled in cold field stations and shipped at very low temperatures to laboratories that maintain freezers cold enough to preserve gas bubbles indefinitely. A single deep core can take a decade of analysis. Yet the cumulative result has been an unusually robust record. Predictions about future climate would be far weaker without it; the ice itself, more than any model, has anchored our understanding of how rapidly the atmosphere can change.''',
    questions: [
      MCQuestion(
        question: 'Why is a glacier a useful archive for climate scientists?',
        options: [
          'Glaciers grow only in volcanic regions.',
          'Each year\'s snowfall compresses on top of the previous one, preserving ancient air.',
          'Glaciers move too quickly to retain useful information.',
          'They contain magnetic fields that record time.',
        ],
        answer: 'Each year\'s snowfall compresses on top of the previous one, preserving ancient air.',
      ),
      MCQuestion(
        question: 'According to the passage, what do Antarctic ice cores show about modern carbon dioxide levels?',
        options: [
          'They fall within the normal historical range.',
          'They lie far outside the historical envelope of the past glacial periods.',
          'They are unmeasurable.',
          'They are identical to those of the last ice age.',
        ],
        answer: 'They lie far outside the historical envelope of the past glacial periods.',
      ),
      MCQuestion(
        question: 'A thin layer of acidic ice can be matched to a specific:',
        options: [
          'Wildfire.',
          'Volcanic eruption.',
          'Hurricane.',
          'Solar flare.',
        ],
        answer: 'Volcanic eruption.',
      ),
      MCQuestion(
        question: 'Why does the passage mention tree rings and lake sediments?',
        options: [
          'To argue against ice-core results.',
          'To show that ice cores form part of a multi-proxy framework climate scientists use to cross-check interpretations.',
          'To prove that trees grow in glaciers.',
          'To compare them unfavorably with cores.',
        ],
        answer: 'To show that ice cores form part of a multi-proxy framework climate scientists use to cross-check interpretations.',
      ),
      MCQuestion(
        question: 'According to the author, the deepest value of the ice-core record is that it:',
        options: [
          'Has replaced the need for any modeling.',
          'Has anchored understanding of how rapidly the atmosphere can change.',
          'Proves climate change is not happening.',
          'Is mainly of interest to tourists.',
        ],
        answer: 'Has anchored understanding of how rapidly the atmosphere can change.',
      ),
    ],
  ),
  Passage(
    id: 't-r-26',
    title: 'The Cathedrals of Medieval Europe',
    body:
        '''The great cathedrals of medieval Europe — Notre-Dame in Paris, Chartres, Cologne, Salisbury — were built by societies that, by modern measures, were poor. Most of them produced only enough food and craft goods to feed and clothe themselves. Yet over decades and sometimes centuries, they devoted enormous shares of their surplus to constructing stone buildings that pushed the limits of what their engineers knew.

The buildings combined religious mission with civic ambition. A cathedral often served as the largest gathering space in the region, the locus of fairs, courts, and political ceremonies as well as worship. A town that financed one expected returns measured not only in salvation but in pilgrim traffic, prestige, and the leverage that came from being seen as an important place. Bishops, guilds, and noble donors all contributed, often in tense negotiation.

Construction techniques evolved across generations. Romanesque churches had thick walls and small windows because masons could not yet distribute vertical loads over wider openings. The Gothic style, introduced in the twelfth century, used pointed arches, ribbed vaults, and external buttresses to direct stresses downward and outward in calculated ways. The result was buildings with thinner walls and larger windows — the stained-glass surfaces for which Gothic cathedrals are famous.

The labor was immense. A cathedral might employ hundreds of stonemasons, carpenters, glaziers, and unskilled laborers at peak periods, and lesser numbers in slow years. Few of those who began a project lived to see it finished. The records that survive — pay ledgers, donation rolls, fabric accounts — show a continuous, multi-generational organizational effort that has few parallels in modern construction outside the largest infrastructure projects.

To call the cathedrals "religious buildings" is therefore accurate but incomplete. They were also large engineering projects, expressions of urban ambition, and economic engines. A modern visitor stands in a finished space; the medieval congregation lived for decades with cranes, scaffolds, and the steady sound of mallets on stone.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, medieval cathedrals were notable in part because:',
        options: [
          'They were built by wealthy modern industrial societies.',
          'Comparatively poor societies devoted enormous shares of their surplus to constructing them.',
          'They were built in only a few weeks.',
          'They had no civic function.',
        ],
        answer: 'Comparatively poor societies devoted enormous shares of their surplus to constructing them.',
      ),
      MCQuestion(
        question: 'What civic role did cathedrals often play?',
        options: [
          'Storage of grain reserves.',
          'They served as the largest gathering space, hosting fairs, courts, and political ceremonies.',
          'They were used exclusively by the military.',
          'They were closed to the public.',
        ],
        answer: 'They served as the largest gathering space, hosting fairs, courts, and political ceremonies.',
      ),
      MCQuestion(
        question: 'Why did Romanesque churches have small windows?',
        options: [
          'To conserve heat in northern Europe.',
          'Because masons could not yet distribute vertical loads over wider openings.',
          'To keep out birds.',
          'To imitate Persian architecture.',
        ],
        answer: 'Because masons could not yet distribute vertical loads over wider openings.',
      ),
      MCQuestion(
        question: 'Which features defined the Gothic style?',
        options: [
          'Flat roofs and tiny windows.',
          'Pointed arches, ribbed vaults, and external buttresses.',
          'Domes and minarets.',
          'Wooden walls.',
        ],
        answer: 'Pointed arches, ribbed vaults, and external buttresses.',
      ),
      MCQuestion(
        question: 'What is the author\'s broader point about cathedrals?',
        options: [
          'They were minor in scale compared to ancient temples.',
          'They were religious, civic, engineering, and economic projects all at once.',
          'They had no influence on later architecture.',
          'They were built only in the south of Europe.',
        ],
        answer: 'They were religious, civic, engineering, and economic projects all at once.',
      ),
    ],
  ),
  Passage(
    id: 't-r-27',
    title: 'How Bees Communicate',
    body:
        '''Honeybees live in tightly organized colonies that depend on rapid, accurate information about food sources. The pollen and nectar that a colony collects in summer must support tens of thousands of bees through the winter, and a single forager who finds a rich patch needs to direct hundreds of others to it. The mechanism by which bees do this — a precise sequence of body movements called the waggle dance — is one of the most studied behaviors in animal biology.

A returning forager performs the dance on the vertical face of a comb inside the dark hive. She walks in a short straight line while shaking her abdomen, then loops around in a figure-eight to repeat. The angle of the straight portion, relative to gravity, indicates the direction of the food source relative to the sun. The duration of the waggle indicates distance, with longer waggles for more distant sources. Observers — other foragers — interpret the dance and depart for the field.

What makes the system remarkable is that bees translate between coordinate systems. Outside the hive they navigate by the sun; inside they reference gravity. The translation appears to be hard-wired and consistent across colonies. Recruits who follow a dance fly out, find the patch, and return to dance themselves, building rapid consensus around the most rewarding sources.

Modern research has extended this picture. Bees use additional signals — vibrations on the comb, scents picked up from the dancer — to refine their interpretation. A foraging bee in a degraded environment will, after enough failures, sometimes "vote against" continued recruitment, slowing the colony\'s focus on a deteriorating patch. In rich seasons the dance focuses workers on the best return; in lean ones it helps the colony triage. The system is closer to a community decision-making process than a simple instruction.''',
    questions: [
      MCQuestion(
        question: 'Why is rapid, accurate communication important for honeybees?',
        options: [
          'It allows them to guard the hive at night.',
          'Summer collections must support the colony through the winter, so coordinating foragers matters.',
          'It is required by their predators.',
          'It produces wax.',
        ],
        answer: 'Summer collections must support the colony through the winter, so coordinating foragers matters.',
      ),
      MCQuestion(
        question: 'What does the angle of the waggle portion of the dance indicate?',
        options: [
          'The age of the source.',
          'The direction of the food source relative to the sun.',
          'The kind of flower.',
          'Nothing — it is random.',
        ],
        answer: 'The direction of the food source relative to the sun.',
      ),
      MCQuestion(
        question: 'According to the passage, what does waggle duration indicate?',
        options: [
          'Wind speed.',
          'Distance to the food source — longer waggles mean farther sources.',
          'How angry the bee is.',
          'Number of bees needed.',
        ],
        answer: 'Distance to the food source — longer waggles mean farther sources.',
      ),
      MCQuestion(
        question: 'The translation between coordinate systems mentioned in the passage refers to:',
        options: [
          'Switching between the sun outside and gravity inside the hive.',
          'Converting between metric and imperial units.',
          'Using infrared signals.',
          'Translating between languages.',
        ],
        answer: 'Switching between the sun outside and gravity inside the hive.',
      ),
      MCQuestion(
        question: 'According to the author, the dance system is best described as:',
        options: [
          'A simple set of instructions.',
          'A community decision-making process.',
          'A useless ritual.',
          'A defensive tactic.',
        ],
        answer: 'A community decision-making process.',
      ),
    ],
  ),
  Passage(
    id: 't-r-28',
    title: 'The Spread of the Printing Press',
    body:
        '''In the middle of the fifteenth century, Johannes Gutenberg combined a number of existing technologies — metal type, oil-based ink, the screw press — into a system that could produce books mechanically. Within a few decades, presses were operating in nearly every major European city. The cost of a book fell sharply, and the volume of text available to a literate reader grew faster in the next century than in any previous millennium. The change went well beyond the book trade.

The most immediate effect was on religion. Reformist movements that had previously circulated by handwritten pamphlet could now spread by the thousands of copies. Translations of scripture into vernacular languages — German, French, English — bypassed institutional gatekeepers and reached ordinary readers. The reaction by established authorities was vigorous and unsuccessful: censorship was difficult once presses were widespread, and the technology could not be uninvented.

Science benefited at least as much. Scholars who once depended on irregular copies of ancient texts could now own them and compare editions. Mathematical notation, astronomical tables, and anatomical diagrams could be reproduced with a precision impossible by hand. The slow accumulation of correctable error that had plagued medieval scholarship gave way to standardized, comparable editions; researchers could critique a colleague\'s work without first wondering whether they were reading the same book.

Politics and commerce changed too. Printed broadsides, ballads, and pamphlets created an entirely new information layer between governments and their subjects. Local merchants printed their own price lists. Mapmakers issued new editions whenever a new coastline was discovered. The cumulative result was the emergence of what historians call the public sphere — a space in which informed argument occurred at scale outside palaces and monasteries.

Not every consequence was constructive. Conspiracy theories, partisan invective, and outright forgery also spread. Then as now, mass reproduction did not select for accuracy. The lasting legacy is therefore mixed: faster knowledge transfer, but with new responsibilities for evaluating the trustworthiness of what arrived in print.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, what was an immediate effect of the printing press?',
        options: [
          'Reduced literacy.',
          'Reformist movements could spread by the thousands of copies.',
          'Increased reliance on handwritten manuscripts.',
          'Elimination of all foreign trade.',
        ],
        answer: 'Reformist movements could spread by the thousands of copies.',
      ),
      MCQuestion(
        question: 'Why did censorship become difficult?',
        options: [
          'Authorities lost interest in religion.',
          'Presses were widespread and could not be uninvented.',
          'Censorship was illegal across Europe.',
          'Books were too small to find.',
        ],
        answer: 'Presses were widespread and could not be uninvented.',
      ),
      MCQuestion(
        question: 'How did printing help scientific research?',
        options: [
          'It removed all errors permanently.',
          'It produced standardized, comparable editions that allowed colleagues to critique a shared text.',
          'It eliminated the need for experiments.',
          'It restricted access to a few specialists.',
        ],
        answer: 'It produced standardized, comparable editions that allowed colleagues to critique a shared text.',
      ),
      MCQuestion(
        question: 'The "public sphere" mentioned in the passage refers to:',
        options: [
          'A space for informed argument at scale outside palaces and monasteries.',
          'A literal physical room.',
          'A market for raw textiles.',
          'A class reserved for nobles.',
        ],
        answer: 'A space for informed argument at scale outside palaces and monasteries.',
      ),
      MCQuestion(
        question: 'What balanced view does the author offer at the end?',
        options: [
          'Printing was uniformly positive.',
          'Mass reproduction did not select for accuracy, creating new responsibilities to evaluate trust.',
          'Printing should have been banned.',
          'Handwriting was always more reliable.',
        ],
        answer: 'Mass reproduction did not select for accuracy, creating new responsibilities to evaluate trust.',
      ),
    ],
  ),
  Passage(
    id: 't-r-29',
    title: 'Public Squares and Urban Life',
    body:
        '''Cities that retain their public squares often retain something else: an unforced layer of civic life. A square is not simply an absence of buildings. It is a designed space in which a wide range of activities — markets, demonstrations, casual encounters, performances — can coexist without explicit programming. Urbanists who have studied the most active squares in Europe and Latin America argue that this flexibility is what gives them their value, and that it is harder to create than it looks.

The classic examples share several features. They tend to be modest in size — large enough to gather a crowd but not so large that they feel empty when only a few people are present. They are bordered by buildings whose ground floors open onto the square through small shops, cafés, or arcades, so foot traffic constantly seeds the space with people. And they tolerate informal use: street vendors, musicians, children playing. Each of these features can be planned for or designed out.

Many twentieth-century squares failed precisely because they were over-designed. A vast plaza of polished granite, with sculptural lighting and no shops along its edge, photographs well but rarely hosts a market or a protest. The result is a space that is officially public but functionally empty. Renovations that bring back smaller human-scale features — benches, fountains, retail edges — often revive even the most sterile examples.

The deeper lesson is that public squares are a kind of infrastructure for collective life. They cannot guarantee a healthy civic culture, but their absence makes one harder to sustain. Cities that prize efficiency may be tempted to convert their squares into traffic islands or parking lots. Once converted, the unstructured activities that depend on a square — neighbors meeting, performers practicing, an impromptu market — do not move elsewhere. They tend to disappear.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, the value of a public square comes from:',
        options: [
          'Its size alone.',
          'The flexibility that allows many uncoordinated activities to coexist.',
          'Its proximity to a highway.',
          'Its formal architectural style.',
        ],
        answer: 'The flexibility that allows many uncoordinated activities to coexist.',
      ),
      MCQuestion(
        question: 'What feature seeds the square with foot traffic?',
        options: [
          'Long blank walls.',
          'Ground floors that open onto the square through shops, cafés, or arcades.',
          'Underground parking garages.',
          'High security fences.',
        ],
        answer: 'Ground floors that open onto the square through shops, cafés, or arcades.',
      ),
      MCQuestion(
        question: 'Why did many twentieth-century squares fail?',
        options: [
          'They were too small.',
          'They were over-designed, with polished surfaces and no retail edges.',
          'They were used only by tourists.',
          'They were privatized.',
        ],
        answer: 'They were over-designed, with polished surfaces and no retail edges.',
      ),
      MCQuestion(
        question: 'The author claims that public squares are best understood as:',
        options: [
          'A waste of urban land.',
          'A kind of infrastructure for collective life.',
          'A safety hazard.',
          'A relic of medieval cities.',
        ],
        answer: 'A kind of infrastructure for collective life.',
      ),
      MCQuestion(
        question: 'What happens when squares are converted to parking lots, according to the passage?',
        options: [
          'The same activities move to other squares.',
          'The activities tend to disappear rather than relocate.',
          'Traffic immediately improves.',
          'Markets become online stores.',
        ],
        answer: 'The activities tend to disappear rather than relocate.',
      ),
    ],
  ),
  Passage(
    id: 't-r-30',
    title: 'Ocean Currents and Climate',
    body:
        '''The ocean is sometimes described as a passive body that absorbs whatever the atmosphere imposes, but a closer look reveals an active partner in the climate system. Currents move vast quantities of heat from the equator toward the poles, regulate atmospheric carbon, and govern the productivity of fisheries. When currents change, regional climates respond — sometimes within a decade, sometimes within years.

The driver of the global circulation is a combination of wind and density. Surface winds push warm tropical water toward the poles. As the water travels, it cools, becomes saltier through evaporation, and finally becomes dense enough to sink. The cold deep water then flows back along the ocean floor toward the equator, completing a circuit that takes about a thousand years to close. Because the system is driven by density, it is called the thermohaline circulation: temperature and salt.

A familiar branch of this circulation is the Gulf Stream, which carries Caribbean heat across the North Atlantic and helps to keep western Europe much milder than its latitude would suggest. A slowdown in the wider circulation would not produce a sudden European ice age, despite the dramatic scenarios of popular fiction, but it would lower European winter temperatures noticeably, shift rainfall patterns, and increase storm frequency along eastern North America.

Recent measurements have detected a measurable weakening over the last several decades. The cause is most likely the rapid melting of Greenland\'s ice, which dumps fresh water into the North Atlantic and reduces the density needed to drive sinking. Whether the weakening is part of a normal multi-decadal oscillation or the beginning of a more profound shift is still being debated.

The consequences would extend far beyond Europe. Tropical rainfall belts depend on the same circulation; their displacement could affect agriculture from West Africa to South Asia. The challenge for climate science is not only to project change but to identify the thresholds — if any exist — that would trigger a more abrupt reorganization. The ocean, in this respect, is a slow but powerful actor whose behavior the next century cannot ignore.''',
    questions: [
      MCQuestion(
        question: 'According to the passage, what makes the ocean an active partner in climate?',
        options: [
          'It absorbs whatever the atmosphere imposes without response.',
          'It moves vast amounts of heat from the equator to the poles and influences atmospheric carbon.',
          'It generates wind.',
          'It absorbs sunlight only.',
        ],
        answer: 'It moves vast amounts of heat from the equator to the poles and influences atmospheric carbon.',
      ),
      MCQuestion(
        question: 'Why is the global circulation called "thermohaline"?',
        options: [
          'It involves temperature ("thermo") and salt ("haline") driving density.',
          'It was discovered by a scientist named Thermohaline.',
          'It runs only in the southern hemisphere.',
          'It refers to the speed of currents.',
        ],
        answer: 'It involves temperature ("thermo") and salt ("haline") driving density.',
      ),
      MCQuestion(
        question: 'According to the passage, what would a slowdown of the Atlantic circulation most likely produce in Europe?',
        options: [
          'A sudden ice age within months.',
          'Noticeably cooler winters, shifted rainfall, and more eastern-coast storms.',
          'A jungle climate.',
          'Permanent drought.',
        ],
        answer: 'Noticeably cooler winters, shifted rainfall, and more eastern-coast storms.',
      ),
      MCQuestion(
        question: 'Why is freshwater from Greenland implicated in the weakening?',
        options: [
          'It dilutes the salt that the circulation needs to sink.',
          'It corrodes the ocean floor.',
          'It produces tropical storms.',
          'It absorbs all heat.',
        ],
        answer: 'It dilutes the salt that the circulation needs to sink.',
      ),
      MCQuestion(
        question: 'According to the author, what challenge does climate science still face?',
        options: [
          'Proving that the ocean exists.',
          'Identifying the thresholds, if any, that would trigger an abrupt reorganization of circulation.',
          'Discovering new currents.',
          'Eliminating thermohaline circulation.',
        ],
        answer: 'Identifying the thresholds, if any, that would trigger an abrupt reorganization of circulation.',
      ),
    ],
  ),
];

const List<Lecture> _toeflListening = [
  Lecture(
    id: 't-l-1',
    title: 'Lecture: Climate Adaptation',
    transcript:
        "Professor: Today I want to push back on a common framing of climate adaptation. We tend to talk about it as if the only question were technological — sea walls, drought-tolerant crops, more efficient air conditioning. But field studies keep showing that the same technology produces very different results depending on how it's introduced. In one city, a heat-warning system saves lives during the next heat wave. In another city, the same system is ignored and the death toll is barely different from before. The technology was identical. What differed was who delivered the message and how much the public trusted them.",
    questions: [
      MCQuestion(
        question: 'What is the professor\'s main point?',
        options: [
          'Adaptation outcomes depend on social trust as much as technology.',
          'Heat-warning systems are technically flawed.',
          'Air conditioning is the only effective adaptation tool.',
          'Adaptation should be left entirely to engineers.',
        ],
        answer: 'Adaptation outcomes depend on social trust as much as technology.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-2',
    title: 'Lecture: Marine Ecosystems',
    transcript:
        "Professor: A keystone species is one whose presence holds an ecosystem together in a way that is out of proportion to its biomass. The classic example is the sea otter in Pacific kelp forests. Otters eat sea urchins. When otters are removed, urchin populations explode, the urchins graze the kelp to bare rock, and an entire forest disappears within a few years. Reintroduce the otters and the kelp grows back — quickly, dramatically. So one of the lessons here is that you can't always predict an ecosystem's behavior by listing its species; sometimes a handful of species do most of the structural work.",
    questions: [
      MCQuestion(
        question: 'According to the lecture, what is a keystone species?',
        options: [
          'The largest species in an ecosystem.',
          'A species whose role is out of proportion to its biomass.',
          'A species that lives only in kelp forests.',
          'A species that survives all environmental change.',
        ],
        answer: 'A species whose role is out of proportion to its biomass.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-3',
    title: 'Lecture: Behavioral Economics',
    transcript:
        "Professor: Let me give you an example of a default effect that surprised even the researchers. Some European countries register every adult as an organ donor unless they opt out. Other countries register no one unless they opt in. The proportion of citizens who, when surveyed, support donation is nearly identical across both sets of countries. But the actual donor rates differ by an enormous margin — sometimes 80 percent versus 15 percent. The only thing that changed was which box was pre-checked on a form.",
    questions: [
      MCQuestion(
        question: 'What does the example illustrate?',
        options: [
          'European countries are unusually generous.',
          'A default choice can produce very different outcomes.',
          'Surveys are unreliable.',
          'Organ donation depends on income.',
        ],
        answer: 'A default choice can produce very different outcomes.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-4',
    title: 'Campus Conversation: Library Hours',
    transcript:
        "Student: Hi, I noticed the library closes at midnight now instead of two. Is that permanent? Librarian: It is for this semester. The university shifted the budget toward extending Sunday hours instead. Student: That kind of makes sense actually, Sundays are when I really need it. Librarian: Right, the survey showed about three times more demand on weekends. We can probably revisit late-night hours next year if usage data supports it.",
    questions: [
      MCQuestion(
        question: 'Why did the library change its hours?',
        options: [
          'The building is being renovated.',
          'Survey data showed more Sunday demand.',
          'Late-night hours violated a city ordinance.',
          'Staff requested earlier closing.',
        ],
        answer: 'Survey data showed more Sunday demand.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-5',
    title: 'Lecture: Cognitive Psychology — Inattentional Blindness',
    transcript:
        "Professor: In a famous experiment, participants were asked to count how many times members of one team passed a basketball. While they counted, a person in a gorilla suit walked through the middle of the scene, paused, and walked off. Roughly half of the participants didn't notice the gorilla at all. The result is striking because the gorilla isn't subtle. The lesson is that what we see depends on what we're looking for, and that this can fail in surprising ways even when nothing is wrong with our eyes.",
    questions: [
      MCQuestion(
        question: 'The gorilla experiment is mentioned to illustrate:',
        options: [
          'The limits of human vision.',
          'How attention shapes what we notice.',
          'The benefits of multitasking.',
          'The need for better basketball coaching.',
        ],
        answer: 'How attention shapes what we notice.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-6',
    title: 'Lecture: Public Health Communication',
    transcript:
        "Professor: When we evaluate health campaigns, the single most predictive feature is not the accuracy of the message — almost all of them are accurate — but the trust the audience has in the messenger. In community health, that means working with local clinicians and faith leaders rather than relying entirely on broadcast advertising. We also see that addressing concerns directly works better than dismissing them. A nurse who explains why a particular rumor is wrong, calmly, in their own clinic, will outperform a national agency that ignores the rumor entirely.",
    questions: [
      MCQuestion(
        question: 'What does the professor identify as the strongest predictor of a campaign\'s success?',
        options: [
          'Accuracy of the message.',
          'Trust in the messenger.',
          'Cost of the campaign.',
          'Length of the campaign.',
        ],
        answer: 'Trust in the messenger.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-7',
    title: 'Campus Conversation: Group Project',
    transcript:
        "Student A: We need to finalize the topic for the policy paper before Friday. Student B: I'm leaning toward urban transport. There's a lot of recent data and we can localize it to this city. Student A: That works. But we need someone to handle the interview transcripts. I can't do that part if I'm also writing the literature review. Student B: I'll take the transcripts. Just send me the recordings tonight.",
    questions: [
      MCQuestion(
        question: 'What do the students decide?',
        options: [
          'To switch topics to climate adaptation.',
          'That Student B will handle the transcripts.',
          'To drop the project.',
          'To split the literature review.',
        ],
        answer: 'That Student B will handle the transcripts.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-8',
    title: 'Lecture: Renewable Energy Systems',
    transcript:
        "Professor: The thing that surprises most students is that the engineering challenge of renewable grids isn't generation — solar and wind are now extremely cheap — it's matching supply to demand on different timescales. Batteries are great for the next few hours. They aren't suitable for the next two weeks of cloudy weather. So we layer storage technologies: lithium batteries for hours, pumped hydro for days, hydrogen or flexible gas turbines for weeks. The clean grid isn't one technology; it's a portfolio of them, coordinated by software.",
    questions: [
      MCQuestion(
        question: 'According to the professor, the main engineering challenge of renewable grids is:',
        options: [
          'Generating enough electricity.',
          'Matching supply to demand across different timescales.',
          'Building solar panels efficiently.',
          'Educating consumers.',
        ],
        answer: 'Matching supply to demand across different timescales.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-9',
    title: 'Lecture: The Cambrian Explosion',
    transcript:
        "Professor: When students hear the phrase \"Cambrian explosion,\" they often picture some kind of literal event. It wasn't. The window we're talking about is maybe twenty million years long. That's an enormous amount of time by any normal standard. What makes it count as an explosion is the rate compared to everything before it. Single-celled life had been the rule for nearly three billion years. Then, in twenty million years, you get nearly every major animal body plan we know today. Hard shells, joints, segmented bodies, complex eyes. So the question isn't really \"why so fast\" — it's \"why did this particular window become an outlier in three billion years of slow change?\"",
    questions: [
      MCQuestion(
        question: 'According to the professor, what makes the Cambrian explosion an "explosion"?',
        options: [
          'It produced a sudden geological catastrophe.',
          'Its rate stands out relative to nearly three billion years of slow change.',
          'It happened in just a few weeks.',
          'It eliminated all earlier life.',
        ],
        answer: 'Its rate stands out relative to nearly three billion years of slow change.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-10',
    title: 'Lecture: Photosynthesis Pathways',
    transcript:
        "Professor: It's worth knowing why a cornfield in midsummer outproduces a wheat field on the same land. Both are doing photosynthesis, but they use different versions. Wheat uses what we call the C3 pathway, which is the original system. Corn uses C4, which evolved later. The key difference is that C4 plants concentrate carbon dioxide before delivering it to the same enzyme C3 plants use. The extra step is expensive. In a cool climate it's not worth the cost. In a hot, sunny climate, it suppresses an oxygen reaction that would otherwise waste a lot of energy. So in tropical agriculture, C4 crops typically win.",
    questions: [
      MCQuestion(
        question: 'Why do C4 plants tend to outproduce C3 plants in hot climates?',
        options: [
          'Because they need less water.',
          'Because they suppress an oxygen reaction that wastes energy.',
          'Because they require less sunlight.',
          'Because they grow underground.',
        ],
        answer: 'Because they suppress an oxygen reaction that wastes energy.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-11',
    title: 'Lecture: Soil Carbon and Plowing',
    transcript:
        "Professor: One of the things that surprises new students of environmental science is how much carbon dioxide can be released just by plowing. The soil under an undisturbed field has decades or even centuries of carbon locked into decayed organic matter. When you break the surface and expose those deep layers to air, the microbes that decompose organic matter accelerate. They effectively breathe out carbon dioxide. Across the global history of agriculture, the cumulative loss is huge — comparable to other major emission sources. The flip side is that some of it is recoverable. Reduced tillage and cover crops can put carbon back into the soil over years.",
    questions: [
      MCQuestion(
        question: 'According to the professor, what happens when soil is plowed?',
        options: [
          'Microbes that decompose organic matter slow down.',
          'Carbon dioxide is locked permanently into the soil.',
          'Microbial decomposition accelerates and carbon dioxide is released.',
          'The soil becomes radioactive.',
        ],
        answer: 'Microbial decomposition accelerates and carbon dioxide is released.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-12',
    title: 'Campus Conversation: Internship Decision',
    transcript:
        "Student A: I got two internship offers, and I have to answer by Monday. Student B: Okay, what are they? Student A: One is a research lab on campus, unpaid but they say I'd get my name on a paper. The other is a tech firm downtown, paid, but it's basically QA work — no real research. Student B: For the long run, the paper matters more if you're applying to grad school. The money would be nice, but it's a one-summer thing. Student A: That's where I'm leaning. I just keep second-guessing because of the pay.",
    questions: [
      MCQuestion(
        question: 'What does Student B suggest is more important in the long run?',
        options: [
          'The paid tech firm internship.',
          'The research lab internship, because of authorship on a paper.',
          'Taking the summer off.',
          'Switching majors.',
        ],
        answer: 'The research lab internship, because of authorship on a paper.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-13',
    title: 'Lecture: Memory and Sleep',
    transcript:
        "Professor: The intuition that you should sleep on a hard problem turns out to be supported by quite a lot of data. The brain isn't idle during sleep; it's actively reorganizing what you learned during the day. There's a strong association between slow-wave sleep — that's the deep stuff in the first part of the night — and factual memory. And there's an association between REM sleep — which comes more later — and motor skills and emotional memories. So if you cut your sleep short, you're often cutting one of these systems disproportionately, and you can lose what felt secure in the moment.",
    questions: [
      MCQuestion(
        question: 'According to the professor, what is REM sleep particularly associated with?',
        options: [
          'Factual memorization.',
          'Motor skills and emotional memories.',
          'Heart-rate regulation only.',
          'Digestive processes.',
        ],
        answer: 'Motor skills and emotional memories.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-14',
    title: 'Lecture: Voyager and Gravity Assist',
    transcript:
        "Professor: The reason Voyager could visit four planets with a single launch is something called gravity assist. The idea sounds magical but the math is straightforward. As the spacecraft swings past a moving planet, it borrows a little of the planet's orbital momentum. The planet loses a tiny, undetectable amount of speed; the spacecraft gains a huge fractional speed because it's so much lighter. We use the same technique for every outer-planet mission. Without it, the missions would either take vastly longer or be impossible with current chemical rockets.",
    questions: [
      MCQuestion(
        question: 'What happens to the planet during a gravity assist?',
        options: [
          'It loses a small, undetectable amount of speed.',
          'It gains energy from the spacecraft.',
          'It changes orbit dramatically.',
          'It does not interact with the spacecraft.',
        ],
        answer: 'It loses a small, undetectable amount of speed.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-15',
    title: 'Lecture: Roman Concrete',
    transcript:
        "Professor: For a long time, Roman concrete was admired in a kind of helpless way. We could see it lasted; we couldn't replicate it. The breakthrough in the last few years has been the discovery that the small chunks of lime in Roman batches — which we had assumed were sloppy mixing — were actually deliberate, and they're a key part of why Roman concrete self-heals. When a crack forms and water enters, the lime dissolves and grows new minerals across the crack, sealing it. We're now testing modern concretes that include something similar. If we can scale it, infrastructure could last much longer than the seventy or eighty years we currently expect.",
    questions: [
      MCQuestion(
        question: 'What is the role of the lime chunks in Roman concrete?',
        options: [
          'They are evidence of careless mixing.',
          'They dissolve and seed new mineral growth that seals cracks.',
          'They make the concrete heavier.',
          'They prevent the use of water.',
        ],
        answer: 'They dissolve and seed new mineral growth that seals cracks.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-16',
    title: 'Campus Conversation: Course Drop Deadline',
    transcript:
        "Student: Hi, I need to drop one of my classes. Can I still do that today? Advisor: The deadline to drop without a W on your transcript was last Friday. After that, anything you drop gets a W. It doesn't affect your GPA, but it shows up. Student: Hmm. I wasn't aware. Advisor: Look at it this way — a W is usually better than a low grade. If you're not going to do well, the W is the safer choice.",
    questions: [
      MCQuestion(
        question: 'What does the advisor explain about the W mark?',
        options: [
          'It lowers the student\'s GPA.',
          'It does not affect GPA but appears on the transcript.',
          'It can be removed at any time.',
          'It is required by federal law.',
        ],
        answer: 'It does not affect GPA but appears on the transcript.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-17',
    title: 'Lecture: Animal Tool Use',
    transcript:
        "Professor: A nice thing about working on animal tool use is that the field keeps surprising us. Twenty years ago, the idea that an octopus carries shells around as portable shelters would have been controversial. Today there's video of it. New Caledonian crows manufacturing hooks and bending wire — that's published. Even capuchin monkeys cracking nuts with stones, choosing the right stone for the right nut, that's well documented. What we still don't understand is the limit. Tool use crops up in many species, but only humans built a cumulative tradition out of it. Why that asymmetry exists is genuinely open.",
    questions: [
      MCQuestion(
        question: 'According to the professor, what is genuinely open in the field?',
        options: [
          'Whether animals use tools at all.',
          'Why a cumulative tool tradition has emerged only in humans.',
          'Whether crows have beaks.',
          'How to teach monkeys arithmetic.',
        ],
        answer: 'Why a cumulative tool tradition has emerged only in humans.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-18',
    title: 'Lecture: Cathedrals and Civic Life',
    transcript:
        "Professor: When we talk about a medieval cathedral, we make a mistake if we treat it only as a religious building. Yes, it was a religious building. But it was also the largest gathering space in town. It hosted fairs. Courts could sit there. Major political ceremonies happened there. Donations came not just from bishops but from guilds, merchants, the local nobility. The construction itself was an economic project lasting decades, employing hundreds of workers in peak years. For a town, building a cathedral was a multi-generation investment with civic returns far beyond worship.",
    questions: [
      MCQuestion(
        question: 'According to the professor, why should we not see a cathedral as only a religious building?',
        options: [
          'Because it had no religious function.',
          'Because it also served as the largest civic gathering space and an economic project.',
          'Because it was always abandoned.',
          'Because medieval people were not religious.',
        ],
        answer: 'Because it also served as the largest civic gathering space and an economic project.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-19',
    title: 'Lecture: Honeybee Communication',
    transcript:
        "Professor: A returning forager bee performs what we call the waggle dance on the vertical surface of the comb in a dark hive. The interesting part is the encoding. The angle she walks during the straight portion of the dance, measured against gravity, tells the other bees the direction of the food source relative to the sun. She's translating between two coordinate systems — gravity inside the hive, sun outside — and they all do it consistently. The duration of the waggle encodes distance. The whole thing is observed by other bees in the dark, and they get it right often enough that we know there's real information being transferred.",
    questions: [
      MCQuestion(
        question: 'In the dance, what does the angle of the waggle portion against gravity indicate?',
        options: [
          'The age of the food source.',
          'The direction of the food source relative to the sun.',
          'The number of bees needed.',
          'The bee\'s mood.',
        ],
        answer: 'The direction of the food source relative to the sun.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-20',
    title: 'Lecture: The Printing Press',
    transcript:
        "Professor: A common claim about the printing press is that it caused the Reformation. That overstates the relationship. The Reformation drew on grievances that existed long before Gutenberg. What the press did was change the scale at which reformist ideas could circulate. A handwritten manuscript reaches a few hundred readers, optimistically. A printed pamphlet reaches tens of thousands. Once you have that distribution layer, established authorities lose a tool they had previously relied on — control of the flow of religious argument. So I'd say the press didn't cause the Reformation; it made it nearly impossible to suppress.",
    questions: [
      MCQuestion(
        question: 'How does the professor describe the relationship between the printing press and the Reformation?',
        options: [
          'The press caused the Reformation.',
          'The press made it nearly impossible to suppress reformist arguments.',
          'The press had no role at all.',
          'The press delayed the Reformation by centuries.',
        ],
        answer: 'The press made it nearly impossible to suppress reformist arguments.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-21',
    title: 'Lecture: Public Squares',
    transcript:
        "Professor: The most successful public squares in the world share a few properties. They're modest in size — large enough for a crowd, small enough not to feel empty. They're bordered by buildings whose ground floors open onto the square: shops, cafés, arcades. And they tolerate informal use, like street vendors and impromptu music. Twentieth-century planners often designed squares that were grand to look at but had no edge activity and no flexibility. Many of those failed as gathering spaces. The success isn't really about architecture. It's about what kinds of activity the design allows.",
    questions: [
      MCQuestion(
        question: 'According to the professor, what is the success of a public square mostly about?',
        options: [
          'The architecture of surrounding buildings.',
          'The kinds of activity the design allows.',
          'The size of the square in square meters.',
          'The presence of statues.',
        ],
        answer: 'The kinds of activity the design allows.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-22',
    title: 'Campus Conversation: Library Tutoring',
    transcript:
        "Student: Hi, I need help with a statistics problem set. Is there walk-in tutoring? Tutor: There is, but the busy hours are right after dinner. If you can come earlier — say, late afternoon — you usually get more time. Student: That works. I have a class until three but I can come around four. Tutor: Perfect. Just bring the problem set and any reading you've already done. We don't redo the lecture; we work from what you've tried.",
    questions: [
      MCQuestion(
        question: 'What does the tutor recommend the student bring to the session?',
        options: [
          'Only a pencil.',
          'The problem set and any reading the student has already done.',
          'A full set of lecture notes from every class.',
          'Nothing at all.',
        ],
        answer: 'The problem set and any reading the student has already done.',
      ),
    ],
  ),
  Lecture(
    id: 't-l-23',
    title: 'Lecture: Ocean Currents and Climate',
    transcript:
        "Professor: The Atlantic part of the global thermohaline circulation matters to climate in ways that are easy to underestimate. The reason western Europe is much warmer than its latitude would otherwise allow is heat delivered north by the Gulf Stream. If that circulation slows — and there's recent evidence it has been slowing — Europe doesn't get a sudden ice age. But it does get cooler winters, more storms on the eastern North American coast, and likely shifts in tropical rainfall belts. The climate is not a switch, but it's also not stable. It responds to changes in the ocean on decade-to-century timescales.",
    questions: [
      MCQuestion(
        question: 'According to the professor, what is one likely effect of a slowing Atlantic circulation?',
        options: [
          'A sudden European ice age.',
          'Cooler European winters and shifts in tropical rainfall.',
          'A permanent global warming.',
          'No change at all.',
        ],
        answer: 'Cooler European winters and shifts in tropical rainfall.',
      ),
    ],
  ),
];

const List<SpeakingTask> _toeflSpeaking = [
  SpeakingTask(
    id: 't-s-1',
    type: 'Independent · Task 1',
    prompt:
        'Some people prefer to study alone, while others prefer to study in a group. Which do you prefer and why? Use specific reasons and examples.',
    prepSeconds: 15,
    speakSeconds: 45,
  ),
  SpeakingTask(
    id: 't-s-2',
    type: 'Independent · Task 1',
    prompt:
        'Many universities now record their lectures and post them online. Do you think this is a positive change or a negative change? Explain why.',
    prepSeconds: 15,
    speakSeconds: 45,
  ),
  SpeakingTask(
    id: 't-s-3',
    type: 'Campus Integrated · Task 2',
    prompt:
        'The university is proposing a new "quiet floor" rule in the main library. Explain the woman\'s opinion and the reasons she gives for it.',
    reading:
        'Notice: Beginning next semester, the third floor of the main library will become a designated silent study space. Talking, phone calls, and group work will not be permitted on that floor.',
    transcript:
        "Man: I think this rule is overdue, the library is way too loud. Woman: Honestly I disagree. The third floor is where we always meet for our group projects. There isn't another space on campus that's large enough and open late. They could just enforce quiet on one floor that doesn't already serve as a collaborative space. It feels like they're solving the easy problem and creating a harder one.",
    prepSeconds: 30,
    speakSeconds: 60,
  ),
  SpeakingTask(
    id: 't-s-4',
    type: 'Academic Integrated · Task 3',
    prompt:
        'Using the lecture, explain how cool-roof programs reduce urban heat and why their effect depends on adoption rates.',
    reading:
        'Cool-roof technology coats a building\'s roof with highly reflective material so that it absorbs less solar energy. A reflective roof can cut surface temperature by up to 30°C on a hot day, reducing indoor temperatures and demand for air conditioning.',
    transcript:
        "Professor: Cool roofs work best when many buildings in a neighborhood adopt them at once. A single cool roof slightly lowers that one building's temperature. A whole block of cool roofs lowers the air temperature of the entire neighborhood, because there is far less reradiated heat escaping into the streets. So the technology itself isn't enough — the program also has to drive widespread uptake.",
    prepSeconds: 30,
    speakSeconds: 60,
  ),
  SpeakingTask(
    id: 't-s-5',
    type: 'Academic Integrated · Task 4',
    prompt:
        'Using the lecture, describe two reasons that storage of different durations is necessary for a renewable grid.',
    transcript:
        "Professor: Solar and wind generation rises and falls on two very different schedules. Within a day, output swings by the hour — clouds pass, the wind dies down. Across weeks, you get longer patterns: a stalled high-pressure system might cut wind output for ten days. So we need short-duration storage like batteries to handle the daily swings, and long-duration storage like hydrogen or pumped hydro to cover the seasonal patterns. Without both, the grid would be either expensive or unreliable.",
    prepSeconds: 20,
    speakSeconds: 60,
  ),
  SpeakingTask(
    id: 't-s-6',
    type: 'Independent · Task 1',
    prompt:
        'Some students take a year off between high school and university. In your view, is this a good idea? Explain with specific reasons.',
    prepSeconds: 15,
    speakSeconds: 45,
  ),
  SpeakingTask(
    id: 't-s-7',
    type: 'Independent · Task 1',
    prompt:
        'Some people think that universities should require students to attend lectures in person. Others think recorded lectures are equally effective. Which view do you support, and why?',
    prepSeconds: 15,
    speakSeconds: 45,
  ),
  SpeakingTask(
    id: 't-s-8',
    type: 'Independent · Task 1',
    prompt:
        'Many cities are reducing parking in their downtown areas. Do you think this is a good policy? Explain your view with specific reasons.',
    prepSeconds: 15,
    speakSeconds: 45,
  ),
  SpeakingTask(
    id: 't-s-9',
    type: 'Independent · Task 1',
    prompt:
        'Some people prefer to plan their day in detail; others prefer to keep their schedule loose. Which do you prefer and why?',
    prepSeconds: 15,
    speakSeconds: 45,
  ),
  SpeakingTask(
    id: 't-s-10',
    type: 'Campus Integrated · Task 2',
    prompt:
        'The university is proposing a new mandatory writing-skills course for all first-year students. State the man\'s opinion and explain the reasons he gives.',
    reading:
        'Announcement: Starting next academic year, every first-year student will be required to complete a one-semester course on academic writing, regardless of major. The aim is to ensure consistent writing skills across the undergraduate population.',
    transcript:
        "Man: I think this is a good policy. Woman: Really? Another required course feels like a burden. Man: A lot of my friends in the sciences write almost nothing in their first two years and then they're suddenly expected to write a senior thesis. They have no preparation. A semester-long writing course early on would solve that. Plus, the course can be tailored. If it covers lab reports for science majors and essays for humanities majors, it stays useful.",
    prepSeconds: 30,
    speakSeconds: 60,
  ),
  SpeakingTask(
    id: 't-s-11',
    type: 'Campus Integrated · Task 2',
    prompt:
        'The university is proposing to charge a small fee for printing in the library. Explain the woman\'s opinion and the reasons she gives.',
    reading:
        'Notice: Starting next month, the university library will charge five cents per page for printing. The revenue will support paper-recycling programs and offset the cost of toner and paper supplies.',
    transcript:
        "Woman: I get the goal, but the way they're doing it bothers me. Man: Why? It's only a few cents. Woman: It's regressive — five cents adds up if you're a humanities student printing two-hundred-page readings every week. Students in fields that don't need to print won't even notice the fee. If the university wants to recycle, they should pay for it out of central budgets, not from the students who happen to use paper the most.",
    prepSeconds: 30,
    speakSeconds: 60,
  ),
  SpeakingTask(
    id: 't-s-12',
    type: 'Academic Integrated · Task 3',
    prompt:
        'Explain the concept of "default effect" described in the reading, using the example of organ-donor registration that the professor discusses in the lecture.',
    reading:
        'Default effect: In decision-making, the option pre-selected on a form often has a disproportionate impact on the eventual choice, because people interpret defaults as recommendations and because changing a default requires effort, however small.',
    transcript:
        "Professor: Consider the organ-donor case. Some European countries register every adult as a donor unless they opt out. Other countries register no one unless they opt in. Surveys show that public support for donation is similar across both groups. But actual donor rates differ enormously — sometimes 80 percent versus 15 percent. The only thing that differs is the default. That's exactly what the reading describes: a tiny structural choice produces a huge behavioral difference.",
    prepSeconds: 30,
    speakSeconds: 60,
  ),
  SpeakingTask(
    id: 't-s-13',
    type: 'Academic Integrated · Task 3',
    prompt:
        'Explain the concept of "trophic cascade" using the example of wolves in Yellowstone discussed in the lecture.',
    reading:
        'Trophic cascade: An ecological process in which a change at the top of a food web — typically the addition or removal of a top predator — produces effects that ripple through lower levels of the ecosystem.',
    transcript:
        "Professor: Yellowstone is the classic case. Wolves were reintroduced in 1995. They reduced elk numbers, but more importantly, they changed where elk grazed. Elk stopped lingering in narrow valleys where wolves could ambush them. Willow and aspen trees came back in those valleys. Beaver populations recovered because they need willow. Songbirds, riverbank stability — all of it shifted within about a decade. One predator, many downstream effects.",
    prepSeconds: 30,
    speakSeconds: 60,
  ),
  SpeakingTask(
    id: 't-s-14',
    type: 'Academic Integrated · Task 4',
    prompt:
        'Using points from the lecture, explain two reasons that bee colonies benefit from the waggle dance.',
    transcript:
        "Professor: The waggle dance does two things for the colony that no single bee could do alone. First, it allows directed recruitment. A bee that finds a rich source can tell hundreds of nestmates the direction and distance, so the colony concentrates its effort exactly where it pays off. Second, the system allows quick reallocation. If a patch deteriorates, the dance fades and fewer bees are recruited there. In effect, the dance lets the colony make a coordinated decision about where to invest in any given hour.",
    prepSeconds: 20,
    speakSeconds: 60,
  ),
  SpeakingTask(
    id: 't-s-15',
    type: 'Academic Integrated · Task 4',
    prompt:
        'Using points from the lecture, describe two reasons that public squares decline when overhauled with monumental design.',
    transcript:
        "Professor: Many twentieth-century renovations made the same mistake. First, they widened the square and used hard, polished surfaces — so the space looked grand but felt empty unless it was full. Second, they closed off the retail and café edges that used to seed the space with foot traffic. With those two changes, the unstructured activities a square depends on — vendors, performers, casual meetings — quietly disappeared. The space was officially public and functionally empty.",
    prepSeconds: 20,
    speakSeconds: 60,
  ),
  SpeakingTask(
    id: 't-s-16',
    type: 'Independent · Task 1',
    prompt:
        'Some people prefer to live in large cities; others prefer smaller towns. Which do you prefer and why? Use specific reasons and examples.',
    prepSeconds: 15,
    speakSeconds: 45,
  ),
  SpeakingTask(
    id: 't-s-17',
    type: 'Independent · Task 1',
    prompt:
        'When facing a difficult decision, some people prefer to make it quickly; others prefer to take their time. Which do you prefer and why?',
    prepSeconds: 15,
    speakSeconds: 45,
  ),
  SpeakingTask(
    id: 't-s-18',
    type: 'Campus Integrated · Task 2',
    prompt:
        'The student newspaper is proposing to add an opinion section. Explain the woman\'s view and the reasons she gives.',
    reading:
        'Editorial Note: The student newspaper is considering a new weekly opinion section that would publish student-submitted essays on campus issues.',
    transcript:
        "Woman: I'm enthusiastic about this. We have plenty of forums for posting opinions — group chats, social media — but they reach only the people already in those groups. A printed opinion section gets read by people who weren't looking for the argument. That broadens the conversation on campus. It also forces writers to put their name to a piece, which raises the quality compared to anonymous posting.",
    prepSeconds: 30,
    speakSeconds: 60,
  ),
];

const List<WritingTask> _toeflWriting = [
  WritingTask(
    id: 't-w-1',
    type: 'Academic Discussion',
    prompt:
        'Your professor is teaching a class on public policy. Write a post that contributes to the discussion: in your view, what is the most important factor in making a climate-adaptation program effective?',
    discussionPosts: [
      DiscussionPost(
        name: 'Dr. Lin (Professor)',
        text:
            'Engineers and policymakers often disagree on which adaptation programs work. Drawing on the readings, what factor would you prioritize, and why?',
      ),
      DiscussionPost(
        name: 'Kelly',
        text:
            'I think it\'s funding. Without enough resources you cannot install the infrastructure that the modeling recommends.',
      ),
      DiscussionPost(
        name: 'Marcos',
        text:
            'I would argue that trust matters more than money. Even a fully funded program fails when people ignore the warning, like we saw with the heat-warning case study.',
      ),
    ],
    minutes: 10,
  ),
  WritingTask(
    id: 't-w-2',
    type: 'Integrated',
    prompt:
        'Summarize the points made in the lecture, explaining how they challenge the optimism of the reading about driverless vehicles.',
    reading:
        'Autonomous vehicles promise a future with fewer crashes, since human error is the leading cause of road deaths. They also offer mobility to people who cannot drive themselves, and may reduce congestion by optimizing traffic flow.',
    transcript:
        "Professor: The reading is overly optimistic. First, the sensors that drive these systems still struggle in heavy snow or rain, which are exactly the conditions in which human error is also highest. Second, the cybersecurity surface is enormous — a malicious actor could disable a fleet in a way that no individual driver could. Third, there's a moral programming problem: in an unavoidable crash, whom does the car prioritize? We haven't agreed on an answer, and the lack of consensus may itself slow deployment.",
    minutes: 20,
  ),
  WritingTask(
    id: 't-w-3',
    type: 'Academic Discussion',
    prompt:
        'Your professor wants to know whether universities should require students to spend a semester abroad. Contribute a post explaining your view with reasons.',
    discussionPosts: [
      DiscussionPost(
        name: 'Dr. Patel (Professor)',
        text:
            'There is renewed interest in making study-abroad a requirement rather than an option. What do you think — and why?',
      ),
      DiscussionPost(
        name: 'Jenna',
        text:
            'A requirement would force students to break out of comfortable routines. That alone is a major part of growing up.',
      ),
      DiscussionPost(
        name: 'Rafa',
        text:
            'I disagree. For students with family or financial obligations, a required semester abroad would be punishing. It should remain optional.',
      ),
    ],
    minutes: 10,
  ),
  WritingTask(
    id: 't-w-4',
    type: 'Academic Discussion',
    prompt:
        'Some governments restrict short-term rentals (such as Airbnb) in residential neighborhoods. Should other cities follow that example? Defend your view.',
    discussionPosts: [
      DiscussionPost(
        name: 'Dr. Owens (Professor)',
        text:
            'Several large cities have introduced limits on short-term rentals. Do you think this is good policy? Why or why not?',
      ),
      DiscussionPost(
        name: 'Talia',
        text:
            'Yes — restrictions protect long-term housing supply, which is the bigger crisis in most cities.',
      ),
      DiscussionPost(
        name: 'Diego',
        text:
            'I\'d push back. Many homeowners depend on rental income to afford their property, and visitors bring spending to local businesses.',
      ),
    ],
    minutes: 10,
  ),
  WritingTask(
    id: 't-w-5',
    type: 'Integrated',
    prompt:
        'Summarize the lecture, explaining how it casts doubt on the reading\'s argument about renewable energy storage.',
    reading:
        'Recent advances in lithium-ion battery technology promise to make renewable energy grids fully reliable. Costs have fallen by an order of magnitude in a decade, and capacity continues to grow each year.',
    transcript:
        "Professor: Batteries are wonderful, but they are also short-duration. They handle the next four to six hours of demand, not the next four to six days. A two-week stretch of cloudy or calm weather is well within historical norms. Pretending that batteries alone solve the storage problem ignores those longer outages. We need a portfolio: batteries, pumped hydro, hydrogen — different tools for different timescales.",
    minutes: 20,
  ),
  WritingTask(
    id: 't-w-6',
    type: 'Academic Discussion',
    prompt:
        'Your professor wants the class to consider whether universities should require a foreign-language course of every undergraduate. Contribute a post explaining your view with concrete reasons.',
    discussionPosts: [
      DiscussionPost(
        name: 'Dr. Reyes (Professor)',
        text:
            'Some universities are reconsidering a general-education foreign-language requirement. Do you think it should remain mandatory? Why or why not?',
      ),
      DiscussionPost(
        name: 'Sana',
        text:
            'I think it should stay. The cognitive and cultural benefits are real, and most students never pick up another language otherwise.',
      ),
      DiscussionPost(
        name: 'Eli',
        text:
            'I disagree. A one-year requirement isn\'t enough to gain real fluency, and it crowds out other electives that students would value more.',
      ),
    ],
    minutes: 10,
  ),
  WritingTask(
    id: 't-w-7',
    type: 'Academic Discussion',
    prompt:
        'Your professor opens a discussion about whether public libraries are still essential in cities with widespread internet access. Defend your view in a post.',
    discussionPosts: [
      DiscussionPost(
        name: 'Dr. Hayes (Professor)',
        text:
            'Critics argue libraries are outdated in the age of high-speed internet. Supporters say they remain essential. What do you think?',
      ),
      DiscussionPost(
        name: 'Mona',
        text:
            'Libraries are essential. They are one of the few places anyone can go without spending money and still have access to information.',
      ),
      DiscussionPost(
        name: 'Jules',
        text:
            'I see the point, but most younger people use the internet for everything. Maybe the budget would do more good elsewhere.',
      ),
    ],
    minutes: 10,
  ),
  WritingTask(
    id: 't-w-8',
    type: 'Academic Discussion',
    prompt:
        'Some experts argue that students should be taught financial literacy in high school; others worry the subject crowds out core academics. Where do you stand?',
    discussionPosts: [
      DiscussionPost(
        name: 'Dr. Cho (Professor)',
        text:
            'High schools are increasingly asked to teach personal finance. Is this a good use of class time, or should it be left to families?',
      ),
      DiscussionPost(
        name: 'Bea',
        text:
            'Most families don\'t teach this. A required course at least gives every student a chance to understand interest, savings, and credit.',
      ),
      DiscussionPost(
        name: 'Owen',
        text:
            'I\'m skeptical. High-school content is already crowded. Teaching personal finance well takes more time than schools usually have.',
      ),
    ],
    minutes: 10,
  ),
  WritingTask(
    id: 't-w-9',
    type: 'Integrated',
    prompt:
        'Summarize the points made in the lecture, explaining how they challenge the reading\'s argument about online education.',
    reading:
        'Online courses now allow universities to teach unlimited students at near-zero marginal cost. Proponents argue that this will democratize higher education, giving anyone with internet access world-class teaching.',
    transcript:
        "Professor: The optimism in the reading misses several important points. First, completion rates for purely online courses are extremely low — typically under ten percent. Without the structure of a classroom, students drift. Second, the most valuable parts of a university experience — discussions, mentorship, group projects — are also the hardest to replicate online. Third, the technology often widens, rather than closes, gaps: students with reliable broadband and a quiet study space do well; students without them fall further behind.",
    minutes: 20,
  ),
  WritingTask(
    id: 't-w-10',
    type: 'Integrated',
    prompt:
        'Summarize the lecture and explain how it casts doubt on the optimism of the reading about ride-sharing services.',
    reading:
        'Ride-sharing services promise to reduce traffic by letting individual cars carry more passengers. Cities have welcomed them as a way to ease congestion and reduce the need for parking.',
    transcript:
        "Professor: Studies in several large cities have shown the opposite of what the reading expects. Most ride-share trips replace transit, walking, or biking, not private cars. As a result, total vehicle-miles in many cities have gone up, not down. The promise of \"shared\" rides is also misleading: in most regions, the great majority of trips have a single passenger. Without policies that explicitly require shared rides or restrict the cheapest single-passenger fares, the services tend to add congestion rather than relieve it.",
    minutes: 20,
  ),
  WritingTask(
    id: 't-w-11',
    type: 'Integrated',
    prompt:
        'Summarize the lecture, explaining how it relates to the reading on universal basic income.',
    reading:
        'Universal basic income (UBI) proposes that every adult receive a regular cash payment from the government, regardless of work status. Supporters argue that UBI would reduce poverty and allow people to take risks — start businesses, change careers, or care for family members.',
    transcript:
        "Professor: Pilot programs are useful but their evidence is limited. Most pilots run only one or two years and pay only a few hundred adults. That tells you something about short-term effects but not about long-term ones. Critically, a pilot doesn't model the macroeconomic side: if UBI were paid to everyone, how would taxes need to change, and would that erase the gain? The pilots do show that work effort doesn't collapse — that's an important finding — but they cannot, on their own, prove that a national program would be fiscally feasible.",
    minutes: 20,
  ),
  WritingTask(
    id: 't-w-12',
    type: 'Academic Discussion',
    prompt:
        'Your professor wants the class to discuss whether large companies should be required to disclose their carbon emissions publicly. Defend your view.',
    discussionPosts: [
      DiscussionPost(
        name: 'Dr. Bouchard (Professor)',
        text:
            'A growing number of jurisdictions are requiring public emissions disclosure. Some companies push back. What do you think — should the rule be universal?',
      ),
      DiscussionPost(
        name: 'Iris',
        text:
            'Mandatory disclosure works. Once data is public, investors and consumers respond, and companies adjust faster than they would under voluntary rules.',
      ),
      DiscussionPost(
        name: 'Pat',
        text:
            'I worry about the cost for smaller firms. A blanket rule could push them out while leaving the largest emitters untouched.',
      ),
    ],
    minutes: 10,
  ),
  WritingTask(
    id: 't-w-13',
    type: 'Integrated',
    prompt:
        'Summarize the lecture, explaining how it challenges the optimism of the reading about smart-city technology.',
    reading:
        '"Smart city" projects use sensors, cameras, and software to optimize traffic flow, energy use, and city services. Advocates believe such systems will make cities more efficient, equitable, and pleasant to live in.',
    transcript:
        "Professor: The argument has merit, but I want to register some caveats. First, smart-city systems concentrate enormous amounts of data in the hands of vendors and municipal agencies. The privacy implications are real and not always addressed. Second, the efficiencies often benefit already-served neighborhoods more than under-served ones, because data and sensors are denser where investment has long flowed. Third, optimization can lock in current behavior: a system that tries to make existing car traffic flow faster discourages the more fundamental shift toward walking or transit.",
    minutes: 20,
  ),
  WritingTask(
    id: 't-w-14',
    type: 'Academic Discussion',
    prompt:
        'Your professor opens a discussion on whether universities should publish their professors\' average course evaluations. Contribute a clear view.',
    discussionPosts: [
      DiscussionPost(
        name: 'Dr. Aoki (Professor)',
        text:
            'Many universities collect course evaluations but keep them private. Should students see this data when choosing courses? Why or why not?',
      ),
      DiscussionPost(
        name: 'Felix',
        text:
            'Yes. Evaluations help students avoid bad teaching and push instructors to improve. Transparency is the right default.',
      ),
      DiscussionPost(
        name: 'Sana',
        text:
            'I\'m cautious. Evaluations are noisy, and they can punish instructors who teach difficult material. Publishing raw scores might do more harm than good.',
      ),
    ],
    minutes: 10,
  ),
  WritingTask(
    id: 't-w-15',
    type: 'Integrated',
    prompt:
        'Summarize the lecture and explain how it relates to the reading on the decline of bee populations.',
    reading:
        'In recent years, beekeepers have reported sharp losses in honeybee colonies. Pesticides, habitat loss, and parasites are often cited as the main causes. Advocates argue that protecting bees should be a top conservation priority.',
    transcript:
        "Professor: The reading is broadly correct, but it understates one factor and overstates another. Habitat loss — the destruction of varied wildflower meadows — turns out to be more important than the reading suggests, because bees that can't find enough varied forage become weaker and more vulnerable to disease. By contrast, pesticide effects, while real, vary enormously by region and crop. So if you want to help bee populations, restoring diverse forage is often the higher-leverage move.",
    minutes: 20,
  ),
];

/// 56 advanced TOEFL words. Each card carries an answer (single-word
/// synonym used by the quiz), four MC options, plus a part-of-speech, a
/// concise definition, and an example sentence consumed by the WordUp-style
/// player. Definitions are paraphrased from Merriam-Webster, Oxford, and
/// Cambridge dictionary entries.
const List<VocabCard> _toeflVocab = [
  VocabCard(word: 'Mitigate', answer: 'Lessen', options: ['Intensify', 'Lessen', 'Reveal', 'Forget'], partOfSpeech: 'verb', definition: 'To make something less harsh or severe.', example: 'Insurance helps mitigate the financial impact of a natural disaster.'),
  VocabCard(word: 'Bolster', answer: 'Support', options: ['Undermine', 'Support', 'Create', 'Destroy'], partOfSpeech: 'verb', definition: 'To strengthen, prop up, or reinforce.', example: 'The new evidence bolstered the prosecution\'s case considerably.'),
  VocabCard(word: 'Lucid', answer: 'Clear', options: ['Confusing', 'Clear', 'Dark', 'Loud'], partOfSpeech: 'adjective', definition: 'Easy to understand; expressed with clarity.', example: 'She gave a lucid explanation of a complicated process.'),
  VocabCard(word: 'Ubiquitous', answer: 'Everywhere', options: ['Rare', 'Everywhere', 'Hidden', 'Expensive'], partOfSpeech: 'adjective', definition: 'Present, appearing, or found everywhere.', example: 'Smartphones have become ubiquitous in modern life.'),
  VocabCard(word: 'Esoteric', answer: 'Obscure', options: ['Simple', 'Obscure', 'Popular', 'Legal'], partOfSpeech: 'adjective', definition: 'Intended for or understood by only a small group.', example: 'His lecture was full of esoteric references few could follow.'),
  VocabCard(word: 'Ephemeral', answer: 'Short-lived', options: ['Permanent', 'Short-lived', 'Ancient', 'Complex'], partOfSpeech: 'adjective', definition: 'Lasting for a very short time.', example: 'The beauty of cherry blossoms is famously ephemeral.'),
  VocabCard(word: 'Pragmatic', answer: 'Practical', options: ['Idealistic', 'Practical', 'Dreamy', 'Rigid'], partOfSpeech: 'adjective', definition: 'Concerned with practical results rather than theory.', example: 'They took a pragmatic approach to solving the budget shortfall.'),
  VocabCard(word: 'Anomalous', answer: 'Abnormal', options: ['Typical', 'Abnormal', 'Tiny', 'Frozen'], partOfSpeech: 'adjective', definition: 'Deviating from what is standard or expected.', example: 'Researchers noticed an anomalous spike in the data set.'),
  VocabCard(word: 'Substantiate', answer: 'Prove', options: ['Disprove', 'Prove', 'Hide', 'Guess'], partOfSpeech: 'verb', definition: 'To provide evidence that supports a claim.', example: 'The study substantiates earlier findings about the medication.'),
  VocabCard(word: 'Disparate', answer: 'Different', options: ['Similar', 'Different', 'Connected', 'Simple'], partOfSpeech: 'adjective', definition: 'Essentially different in kind; not allowing comparison.', example: 'The committee brought together people from disparate disciplines.'),
  VocabCard(word: 'Salient', answer: 'Prominent', options: ['Hidden', 'Prominent', 'Salt', 'Boring'], partOfSpeech: 'adjective', definition: 'Most noticeable or important.', example: 'The author summarized the salient points in the closing chapter.'),
  VocabCard(word: 'Prolific', answer: 'Productive', options: ['Lazy', 'Productive', 'Barren', 'Silent'], partOfSpeech: 'adjective', definition: 'Producing many works, results, or offspring.', example: 'A prolific writer, she published over fifty novels in her lifetime.'),
  VocabCard(word: 'Reclusive', answer: 'Isolated', options: ['Social', 'Isolated', 'Friendly', 'Public'], partOfSpeech: 'adjective', definition: 'Avoiding the company of other people.', example: 'The reclusive composer rarely left her country home.'),
  VocabCard(word: 'Superfluous', answer: 'Unnecessary', options: ['Essential', 'Unnecessary', 'Scarce', 'Valuable'], partOfSpeech: 'adjective', definition: 'Beyond what is needed; excess.', example: 'Cut any superfluous adjectives from your final draft.'),
  VocabCard(word: 'Vindicate', answer: 'Clear of blame', options: ['Accuse', 'Clear of blame', 'Convict', 'Ignore'], partOfSpeech: 'verb', definition: 'To clear someone of blame or suspicion.', example: 'The new evidence finally vindicated the wrongly accused man.'),
  VocabCard(word: 'Benevolent', answer: 'Kind', options: ['Cruel', 'Kind', 'Greedy', 'Lazy'], partOfSpeech: 'adjective', definition: 'Well-meaning and kindly; charitable.', example: 'A benevolent donor funded the new wing of the library.'),
  VocabCard(word: 'Candid', answer: 'Honest', options: ['Secretive', 'Honest', 'Rude', 'Shy'], partOfSpeech: 'adjective', definition: 'Truthful and straightforward; frank.', example: 'She offered a candid assessment of the team\'s weaknesses.'),
  VocabCard(word: 'Eclectic', answer: 'Diverse', options: ['Narrow', 'Diverse', 'Simple', 'Boring'], partOfSpeech: 'adjective', definition: 'Drawing from a wide range of sources or styles.', example: 'His eclectic taste in music spans jazz, hip-hop, and folk.'),
  VocabCard(word: 'Fallacious', answer: 'False', options: ['True', 'False', 'Proven', 'Smart'], partOfSpeech: 'adjective', definition: 'Based on a mistaken belief or unsound reasoning.', example: 'The argument relied on the fallacious premise that correlation implies causation.'),
  VocabCard(word: 'Garrulous', answer: 'Talkative', options: ['Silent', 'Talkative', 'Angry', 'Smart'], partOfSpeech: 'adjective', definition: 'Excessively talkative, especially about trivial matters.', example: 'Our garrulous tour guide rarely paused for breath.'),
  VocabCard(word: 'Magnanimous', answer: 'Generous', options: ['Selfish', 'Generous', 'Small', 'Cruel'], partOfSpeech: 'adjective', definition: 'Generous in forgiving or judging others.', example: 'In a magnanimous gesture, the champion praised her opponent.'),
  VocabCard(word: 'Paradigm', answer: 'Model', options: ['Ghost', 'Model', 'Error', 'Circle'], partOfSpeech: 'noun', definition: 'A typical example or model of something.', example: 'The new policy represents a paradigm shift in education reform.'),
  VocabCard(word: 'Quixotic', answer: 'Idealistic', options: ['Practical', 'Idealistic', 'Swift', 'Dark'], partOfSpeech: 'adjective', definition: 'Extremely idealistic and impractical.', example: 'His quixotic plan to single-handedly clean the ocean drew sympathy and skepticism.'),
  VocabCard(word: 'Taciturn', answer: 'Reserved', options: ['Talkative', 'Reserved', 'Angry', 'Loud'], partOfSpeech: 'adjective', definition: 'Reserved or uncommunicative in speech.', example: 'The taciturn shopkeeper barely acknowledged my greeting.'),
  VocabCard(word: 'Venerate', answer: 'Respect', options: ['Despise', 'Respect', 'Ignore', 'Forget'], partOfSpeech: 'verb', definition: 'To regard with deep respect.', example: 'Many cultures venerate their elders as living repositories of wisdom.'),
  VocabCard(word: 'Zealous', answer: 'Enthusiastic', options: ['Lazy', 'Enthusiastic', 'Cold', 'Angry'], partOfSpeech: 'adjective', definition: 'Having great energy or enthusiasm in pursuit of a cause.', example: 'A zealous advocate for reform, she campaigned for decades.'),
  VocabCard(word: 'Iconoclast', answer: 'Rebel', options: ['Follower', 'Rebel', 'Artist', 'Leader'], partOfSpeech: 'noun', definition: 'A person who attacks cherished beliefs or institutions.', example: 'The young architect built her reputation as an iconoclast.'),
  VocabCard(word: 'Juxtapose', answer: 'Place side by side', options: ['Separate', 'Place side by side', 'Hide', 'Mix'], partOfSpeech: 'verb', definition: 'To place two things close together for contrast or comparison.', example: 'The exhibition juxtaposes ancient pottery with modern ceramics.'),
  VocabCard(word: 'Lethargic', answer: 'Sluggish', options: ['Energetic', 'Sluggish', 'Happy', 'Busy'], partOfSpeech: 'adjective', definition: 'Lacking energy or enthusiasm; sluggish.', example: 'After the long flight he felt lethargic for two days.'),
  VocabCard(word: 'Obsequious', answer: 'Servile', options: ['Arrogant', 'Servile', 'Quiet', 'Smart'], partOfSpeech: 'adjective', definition: 'Excessively eager to please or obey; fawning.', example: 'The new assistant\'s obsequious manner annoyed his colleagues.'),
  VocabCard(word: 'Pernicious', answer: 'Harmful', options: ['Helpful', 'Harmful', 'Hidden', 'Bright'], partOfSpeech: 'adjective', definition: 'Having a harmful effect, especially in a gradual or subtle way.', example: 'Misinformation can have a pernicious influence on public debate.'),
  VocabCard(word: 'Recalcitrant', answer: 'Defiant', options: ['Obedient', 'Defiant', 'Quiet', 'Curious'], partOfSpeech: 'adjective', definition: 'Stubbornly resistant to authority or instruction.', example: 'The recalcitrant student refused to follow the new dress code.'),
  VocabCard(word: 'Sagacious', answer: 'Wise', options: ['Foolish', 'Wise', 'Tired', 'Anxious'], partOfSpeech: 'adjective', definition: 'Having keen mental discernment; wise.', example: 'Her sagacious advice has guided three generations of researchers.'),
  VocabCard(word: 'Truculent', answer: 'Aggressive', options: ['Peaceful', 'Aggressive', 'Bored', 'Polite'], partOfSpeech: 'adjective', definition: 'Eager or quick to argue or fight; aggressively defiant.', example: 'The truculent crowd jeered the visiting officials throughout the speech.'),
  VocabCard(word: 'Ubiquity', answer: 'Pervasiveness', options: ['Rarity', 'Pervasiveness', 'Decay', 'Mystery'], partOfSpeech: 'noun', definition: 'The fact of being present everywhere.', example: 'The ubiquity of plastic in the oceans is now well documented.'),
  VocabCard(word: 'Verisimilitude', answer: 'Realism', options: ['Falsehood', 'Realism', 'Fantasy', 'Distance'], partOfSpeech: 'noun', definition: 'The appearance of being true or real.', example: 'The novel\'s careful research lends it remarkable verisimilitude.'),
  VocabCard(word: 'Wanton', answer: 'Reckless', options: ['Careful', 'Reckless', 'Polite', 'Generous'], partOfSpeech: 'adjective', definition: 'Deliberate and unprovoked; reckless.', example: 'The report condemned the wanton destruction of historical sites.'),
  VocabCard(word: 'Xenophobia', answer: 'Fear of foreigners', options: ['Love of strangers', 'Fear of foreigners', 'Fear of heights', 'Fear of crowds'], partOfSpeech: 'noun', definition: 'Dislike or prejudice against people from other countries.', example: 'The exhibit was designed to challenge xenophobia through shared cultural history.'),
  VocabCard(word: 'Yoke', answer: 'Burden', options: ['Reward', 'Burden', 'Freedom', 'Hope'], partOfSpeech: 'noun', definition: 'A burden, oppression, or restraint.', example: 'The colonies eventually threw off the yoke of imperial rule.'),
  VocabCard(word: 'Zenith', answer: 'Peak', options: ['Bottom', 'Peak', 'Middle', 'Side'], partOfSpeech: 'noun', definition: 'The highest point reached by a celestial or other object; the peak.', example: 'At the zenith of her career, she chose to retire and teach.'),
  VocabCard(word: 'Acerbic', answer: 'Sharp', options: ['Sweet', 'Sharp', 'Vague', 'Quiet'], partOfSpeech: 'adjective', definition: 'Sharp and direct in tone; cuttingly sour.', example: 'His acerbic wit made him a feared but respected critic.'),
  VocabCard(word: 'Brevity', answer: 'Conciseness', options: ['Length', 'Conciseness', 'Wit', 'Anger'], partOfSpeech: 'noun', definition: 'Concise and exact use of words.', example: 'The essay was praised for its clarity and brevity.'),
  VocabCard(word: 'Cogent', answer: 'Convincing', options: ['Weak', 'Convincing', 'Boring', 'Common'], partOfSpeech: 'adjective', definition: 'Clear, logical, and convincing.', example: 'She presented a cogent argument for raising the minimum wage.'),
  VocabCard(word: 'Dichotomy', answer: 'Division into two', options: ['Unity', 'Division into two', 'Bridge', 'Spread'], partOfSpeech: 'noun', definition: 'A division into two opposed or contradictory parts.', example: 'The dichotomy between nature and nurture has shaped psychology for a century.'),
  VocabCard(word: 'Equivocal', answer: 'Ambiguous', options: ['Clear', 'Ambiguous', 'Bright', 'Final'], partOfSpeech: 'adjective', definition: 'Open to more than one interpretation; ambiguous.', example: 'The results were equivocal, prompting a follow-up study.'),
  VocabCard(word: 'Frugal', answer: 'Thrifty', options: ['Wasteful', 'Thrifty', 'Greedy', 'Empty'], partOfSpeech: 'adjective', definition: 'Sparing in the use of money or resources.', example: 'Despite his fortune, he remained famously frugal.'),
  VocabCard(word: 'Galvanize', answer: 'Energize', options: ['Calm', 'Energize', 'Hide', 'Cancel'], partOfSpeech: 'verb', definition: 'To shock or excite into action.', example: 'The keynote speech galvanized the audience into supporting the cause.'),
  VocabCard(word: 'Hubris', answer: 'Excessive pride', options: ['Humility', 'Excessive pride', 'Generosity', 'Shame'], partOfSpeech: 'noun', definition: 'Excessive pride or self-confidence.', example: 'Greek tragedies often turn on the hubris of their heroes.'),
  VocabCard(word: 'Imminent', answer: 'About to happen', options: ['Distant', 'About to happen', 'Imaginary', 'Frozen'], partOfSpeech: 'adjective', definition: 'About to happen.', example: 'Forecasters warned of an imminent storm and urged residents to prepare.'),
  VocabCard(word: 'Jingoistic', answer: 'Fervently nationalistic', options: ['Peaceful', 'Fervently nationalistic', 'Diplomatic', 'Calm'], partOfSpeech: 'adjective', definition: 'Extreme patriotism, especially in the form of aggressive foreign policy.', example: 'Editorials criticized the campaign\'s jingoistic tone.'),
  VocabCard(word: 'Knack', answer: 'Skill', options: ['Lack', 'Skill', 'Hindrance', 'Decision'], partOfSpeech: 'noun', definition: 'An acquired or natural skill at doing something.', example: 'She has a knack for explaining technical concepts simply.'),
  VocabCard(word: 'Languid', answer: 'Slow', options: ['Quick', 'Slow', 'Anxious', 'Energetic'], partOfSpeech: 'adjective', definition: 'Displaying a disinclination for physical exertion; relaxed and slow.', example: 'They spent a languid afternoon by the river.'),
  VocabCard(word: 'Meticulous', answer: 'Careful', options: ['Careless', 'Careful', 'Hasty', 'Bold'], partOfSpeech: 'adjective', definition: 'Showing great attention to detail; very careful.', example: 'The conservation work required meticulous documentation of every fragment.'),
  VocabCard(word: 'Nebulous', answer: 'Vague', options: ['Clear', 'Vague', 'Bright', 'Tiny'], partOfSpeech: 'adjective', definition: 'Unclear, vague, or ill-defined.', example: 'His plan for the project remained nebulous even after the meeting.'),
  VocabCard(word: 'Officious', answer: 'Meddling', options: ['Helpful', 'Meddling', 'Polite', 'Distant'], partOfSpeech: 'adjective', definition: 'Aggressively eager to give unwanted advice or services.', example: 'The officious receptionist insisted on retyping every form.'),
  VocabCard(word: 'Penchant', answer: 'Strong liking', options: ['Dislike', 'Strong liking', 'Refusal', 'Boredom'], partOfSpeech: 'noun', definition: 'A strong habitual liking for something.', example: 'She has a penchant for early-morning runs along the river.'),

  // High-frequency Academic Word List items (Coxhead Sublists 1–3) added to
  // bring breadth as well as the advanced lexicon above.
  VocabCard(word: 'Analyze', answer: 'Examine closely', options: ['Ignore', 'Examine closely', 'Combine', 'Forget'], partOfSpeech: 'verb', definition: 'To examine something methodically and in detail.', example: 'The committee will analyze the survey data over the summer.'),
  VocabCard(word: 'Approach', answer: 'Method', options: ['Distance', 'Method', 'Question', 'Refusal'], partOfSpeech: 'noun', definition: 'A particular way of dealing with a problem or task.', example: 'Their approach to language teaching emphasizes context over rules.'),
  VocabCard(word: 'Assess', answer: 'Evaluate', options: ['Hide', 'Evaluate', 'Increase', 'Repeat'], partOfSpeech: 'verb', definition: 'To evaluate or estimate the nature or quality of something.', example: 'Teachers regularly assess student progress through written work.'),
  VocabCard(word: 'Concept', answer: 'Idea', options: ['Object', 'Idea', 'Person', 'Result'], partOfSpeech: 'noun', definition: 'An abstract idea or general notion.', example: 'The concept of zero took centuries to be accepted in European mathematics.'),
  VocabCard(word: 'Constitute', answer: 'Make up', options: ['Destroy', 'Make up', 'Avoid', 'Question'], partOfSpeech: 'verb', definition: 'To be a part of a whole; to make up.', example: 'Women constitute over half of the medical school class.'),
  VocabCard(word: 'Context', answer: 'Surrounding circumstances', options: ['Center', 'Surrounding circumstances', 'Argument', 'Decoration'], partOfSpeech: 'noun', definition: 'The circumstances that form the setting for an event or idea.', example: 'You can often guess a word\'s meaning from its context.'),
  VocabCard(word: 'Derive', answer: 'Obtain from', options: ['Lose', 'Obtain from', 'Combine', 'Reverse'], partOfSpeech: 'verb', definition: 'To obtain something from a source.', example: 'The English word "biology" derives from two Greek roots.'),
  VocabCard(word: 'Distribute', answer: 'Hand out', options: ['Withhold', 'Hand out', 'Gather', 'Hide'], partOfSpeech: 'verb', definition: 'To hand out or share something to a number of recipients.', example: 'Aid workers distributed water and supplies to flood victims.'),
  VocabCard(word: 'Establish', answer: 'Set up', options: ['Abandon', 'Set up', 'Reduce', 'Hide'], partOfSpeech: 'verb', definition: 'To set up on a firm or permanent basis.', example: 'The university established a new research centre last year.'),
  VocabCard(word: 'Identify', answer: 'Recognize', options: ['Confuse', 'Recognize', 'Cancel', 'Avoid'], partOfSpeech: 'verb', definition: 'To recognize or establish what something is.', example: 'Researchers identified three risk factors for the disease.'),
  VocabCard(word: 'Impact', answer: 'Effect', options: ['Cause', 'Effect', 'Source', 'Method'], partOfSpeech: 'noun', definition: 'The action of one object coming forcibly into contact with another; a marked effect.', example: 'New regulations had an immediate impact on emissions.'),
  VocabCard(word: 'Indicate', answer: 'Show', options: ['Hide', 'Show', 'Question', 'Reverse'], partOfSpeech: 'verb', definition: 'To point out or show.', example: 'Recent figures indicate a slowdown in the housing market.'),
  VocabCard(word: 'Interpret', answer: 'Explain', options: ['Translate literally', 'Explain', 'Hide', 'Cancel'], partOfSpeech: 'verb', definition: 'To explain the meaning of something.', example: 'How we interpret an experiment depends on our prior assumptions.'),
  VocabCard(word: 'Maintain', answer: 'Keep up', options: ['Drop', 'Keep up', 'Hide', 'Reduce'], partOfSpeech: 'verb', definition: 'To cause or enable a condition to continue.', example: 'Regular exercise helps maintain healthy blood pressure.'),
  VocabCard(word: 'Obtain', answer: 'Acquire', options: ['Lose', 'Acquire', 'Forget', 'Refuse'], partOfSpeech: 'verb', definition: 'To get or acquire something.', example: 'You can obtain a copy of the report from the council office.'),
  VocabCard(word: 'Reluctance', answer: 'Unwillingness', options: ['Eagerness', 'Unwillingness', 'Pride', 'Joy'], partOfSpeech: 'noun', definition: 'Unwillingness or disinclination to do something.', example: 'Her initial reluctance to speak in public soon faded.'),
];

const List<MockExam> _toeflMocks = [
  MockExam(
    id: 't-mock-1',
    title: 'TOEFL iBT Mock 1',
    theme: 'Climate Adaptation',
    minutes: 116,
    sections: [
      MockSection(module: 'Reading', minutes: 35, itemCount: 2),
      MockSection(module: 'Listening', minutes: 36, itemCount: 5),
      MockSection(module: 'Writing', minutes: 29, itemCount: 2),
      MockSection(module: 'Speaking', minutes: 16, itemCount: 4),
    ],
  ),
  MockExam(
    id: 't-mock-2',
    title: 'TOEFL iBT Mock 2',
    theme: 'Marine Ecosystems',
    minutes: 116,
    sections: [
      MockSection(module: 'Reading', minutes: 35, itemCount: 2),
      MockSection(module: 'Listening', minutes: 36, itemCount: 5),
      MockSection(module: 'Writing', minutes: 29, itemCount: 2),
      MockSection(module: 'Speaking', minutes: 16, itemCount: 4),
    ],
  ),
  MockExam(
    id: 't-mock-3',
    title: 'TOEFL iBT Mock 3',
    theme: 'Urban Transport',
    minutes: 116,
    sections: [
      MockSection(module: 'Reading', minutes: 35, itemCount: 2),
      MockSection(module: 'Listening', minutes: 36, itemCount: 5),
      MockSection(module: 'Writing', minutes: 29, itemCount: 2),
      MockSection(module: 'Speaking', minutes: 16, itemCount: 4),
    ],
  ),
  MockExam(
    id: 't-mock-4',
    title: 'TOEFL iBT Mock 4',
    theme: 'Public Health Communication',
    minutes: 116,
    sections: [
      MockSection(module: 'Reading', minutes: 35, itemCount: 2),
      MockSection(module: 'Listening', minutes: 36, itemCount: 5),
      MockSection(module: 'Writing', minutes: 29, itemCount: 2),
      MockSection(module: 'Speaking', minutes: 16, itemCount: 4),
    ],
  ),
  MockExam(
    id: 't-mock-5',
    title: 'TOEFL iBT Mock 5',
    theme: 'Behavioral Economics',
    minutes: 116,
    sections: [
      MockSection(module: 'Reading', minutes: 35, itemCount: 2),
      MockSection(module: 'Listening', minutes: 36, itemCount: 5),
      MockSection(module: 'Writing', minutes: 29, itemCount: 2),
      MockSection(module: 'Speaking', minutes: 16, itemCount: 4),
    ],
  ),
  MockExam(
    id: 't-mock-6',
    title: 'TOEFL iBT Mock 6',
    theme: 'Renewable Energy Systems',
    minutes: 116,
    sections: [
      MockSection(module: 'Reading', minutes: 35, itemCount: 2),
      MockSection(module: 'Listening', minutes: 36, itemCount: 5),
      MockSection(module: 'Writing', minutes: 29, itemCount: 2),
      MockSection(module: 'Speaking', minutes: 16, itemCount: 4),
    ],
  ),
  MockExam(
    id: 't-mock-7',
    title: 'TOEFL iBT Mock 7',
    theme: 'Museum Education',
    minutes: 116,
    sections: [
      MockSection(module: 'Reading', minutes: 35, itemCount: 2),
      MockSection(module: 'Listening', minutes: 36, itemCount: 5),
      MockSection(module: 'Writing', minutes: 29, itemCount: 2),
      MockSection(module: 'Speaking', minutes: 16, itemCount: 4),
    ],
  ),
  MockExam(
    id: 't-mock-8',
    title: 'TOEFL iBT Mock 8',
    theme: 'Linguistic Change',
    minutes: 116,
    sections: [
      MockSection(module: 'Reading', minutes: 35, itemCount: 2),
      MockSection(module: 'Listening', minutes: 36, itemCount: 5),
      MockSection(module: 'Writing', minutes: 29, itemCount: 2),
      MockSection(module: 'Speaking', minutes: 16, itemCount: 4),
    ],
  ),
  MockExam(id: 't-mock-9', title: 'TOEFL iBT Mock 9', theme: 'The Cambrian Explosion', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-10', title: 'TOEFL iBT Mock 10', theme: 'Photosynthesis Pathways', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-11', title: 'TOEFL iBT Mock 11', theme: 'Bronze Age Trade', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-12', title: 'TOEFL iBT Mock 12', theme: 'Polar Ice and Sea Levels', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-13', title: 'TOEFL iBT Mock 13', theme: 'Memory and Sleep', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-14', title: 'TOEFL iBT Mock 14', theme: 'Roman Concrete', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-15', title: 'TOEFL iBT Mock 15', theme: 'Origins of Agriculture', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-16', title: 'TOEFL iBT Mock 16', theme: 'Renaissance Patronage', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-17', title: 'TOEFL iBT Mock 17', theme: 'Color Vision in Animals', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-18', title: 'TOEFL iBT Mock 18', theme: 'Soil Carbon and Climate', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-19', title: 'TOEFL iBT Mock 19', theme: 'Voyager and Deep Space', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-20', title: 'TOEFL iBT Mock 20', theme: 'Discovery of Insulin', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-21', title: 'TOEFL iBT Mock 21', theme: 'Animal Tool Use', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-22', title: 'TOEFL iBT Mock 22', theme: 'Logistics of Ancient Armies', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-23', title: 'TOEFL iBT Mock 23', theme: 'Glaciers and Climate Records', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-24', title: 'TOEFL iBT Mock 24', theme: 'Medieval Cathedrals', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-25', title: 'TOEFL iBT Mock 25', theme: 'Honeybee Communication', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-26', title: 'TOEFL iBT Mock 26', theme: 'Printing Press Era', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-27', title: 'TOEFL iBT Mock 27', theme: 'Public Squares and Urban Life', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-28', title: 'TOEFL iBT Mock 28', theme: 'Ocean Currents and Climate', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-29', title: 'TOEFL iBT Mock 29', theme: 'Smart Cities and Privacy', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
  MockExam(id: 't-mock-30', title: 'TOEFL iBT Mock 30', theme: 'Universal Basic Income', minutes: 116, sections: [MockSection(module: 'Reading', minutes: 35, itemCount: 2), MockSection(module: 'Listening', minutes: 36, itemCount: 5), MockSection(module: 'Writing', minutes: 29, itemCount: 2), MockSection(module: 'Speaking', minutes: 16, itemCount: 4)]),
];
