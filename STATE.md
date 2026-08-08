# Sira Prep — current state

Single source of truth for where this project stands. Written 9 August 2026.
Read this first when you come back to it; §8 tells you where to start.

Companion documents: **[PLAY_LAUNCH_CHECKLIST.md](PLAY_LAUNCH_CHECKLIST.md)**
(the step-by-step upload runbook) and **[PRIVACY_POLICY.md](PRIVACY_POLICY.md)**
(needs filling and hosting). Portfolio-level context — where this sits against
your other projects — is in [../../SHIPPING-ORDER.md](../../SHIPPING-ORDER.md).

---

## 1. What the app is

An independent study app for the two big English proficiency exams, **TOEFL iBT**
and **IELTS Academic**. Seven modules: Reading, Listening, Speaking, Writing,
Grammar, Vocabulary, and full-length timed Mock exams — plus **Sira**, an AI
coach. Flutter, Android, light and dark themes, fully local (no backend of
yours to run or pay for).

Package id **`com.siraprep.app`** · display name **Sira Prep** · version
**1.1.0+2**.

---

## 2. Status at a glance

| Thing | State |
| --- | --- |
| Upload artifact | ✅ **Signed AAB ready**, verified |
| Brand / package id | ✅ Decided and applied (permanent after first upload) |
| Release signing | ✅ Working, keystore exists |
| Monetization | ✅ Built — **but no Play products created yet** |
| `flutter analyze` | ✅ 0 errors, 0 warnings |
| Tests | ✅ 16 passing |
| Content | ✅ Real and substantial (see §4) |
| Secrets in repo | ✅ None |
| Git | ✅ 4 commits, 0 uncommitted |
| Privacy policy | ⚠️ Written, **placeholders unfilled, not hosted** |
| Data safety form | ⚠️ Answers drafted, not submitted |
| Store listing assets | ❌ Not created |
| Tested on a real device | ❌ **Never** |
| Content originality | ❓ **Only you can confirm** — see §6 |

**Nothing in the code blocks upload.** What remains is Play Console work.

---

## 3. Where the artifacts are

```
myLinux/siraprep-release/
  SiraPrep-v1.1.0-PLAY-UPLOAD.aab   51.4 MB   ← upload this to Play
  SiraPrep-v1.1.0-arm64-TEST.apk    19.0 MB   ← sideload this to test
```

Both are also in the project at `build/app/outputs/`. Verified by opening the
bundle and reading its manifest, not by trusting the build log:

- package `com.siraprep.app` ✅ · label `Sira Prep` ✅
- `com.android.vending.BILLING` permission present ✅
- no `com.example` placeholder, no leftover `toeflsix` strings ✅
- signed with the real upload key ✅ (`apksigner`, SHA-256
  `d72b218aa575c56ee0af5e44430ff5cd66d1fe0f4ed9d359193a70bf7feb7961`)

**You cannot test purchases from the sideloaded APK.** Play only honours
purchases for builds delivered through Play. Upload to the **internal testing**
track and install from that link, or every purchase errors. The APK is still
useful — it exercises every lock, the paywall UI, and the hearts.

---

## 4. The content

Real, not a skeleton. This was Vocablo's worst defect so it was checked
specifically — 281 populated content fields with full-length passages and
attached multiple-choice questions.

| Module | TOEFL | IELTS |
| --- | --- | --- |
| Reading passages | 30 | 12 |
| Listening lectures | 23 | 10 |
| Speaking tasks | 18 | 13 |
| Writing tasks | 15 | 10 |
| Vocabulary cards | 72 | 40 |
| **Full mock exams** | **30** | **25** |
| Grammar drills | 35 (shared) | 35 (shared) |

Source: `lib/data/content_toefl.dart` (2,787 lines),
`content_ielts.dart` (1,145), `content_grammar.dart`, plus `grammar_guide.dart`
(1,002) and `vocab_guide.dart` (746) for the reading material.

Vocabulary uses a Leitner spaced-repetition schedule (boxes 0–5, intervals
0/1/3/7/14/30 days) in `lib/state/user_state.dart`.

---

## 5. Monetization — how it works

Freemium via Google Play Billing, replicating the model Vocablo uses.

### The three products — **you must create these**

The paywall reads prices from Play and shows an empty state until they exist.
Ids must match `lib/state/entitlements.dart` **exactly**; a mismatch fails
silently. `flutter logs` prints the offending ids on launch.

| Product id | Type |
| --- | --- |
| `siraprep_pro_monthly` | Subscription, monthly, auto-renew |
| `siraprep_pro_yearly` | Subscription, yearly, auto-renew |
| `siraprep_pro_lifetime` | One-time product, non-consumable |

### What free gets

Defined in `FreeTier` — change it there and nowhere else.

- First **3 items** of each skill (Reading / Listening / Speaking / Writing)
- **1** vocabulary set · **1** grammar set · **1** full mock exam
- **3 hearts** a day, refilled by **20** correct answers
- **20** lifetime Sira messages

### Why those numbers differ from Vocablo's

The mechanics are identical. Two thresholds had to be re-scaled and it matters
that you know why, so nobody "corrects" them back later:

1. Vocablo gates a 6,035-word dictionary at word 500. That ratio is meaningless
   in an app whose largest module holds 30 reading passages, so the free tier is
   expressed in items per module instead — a complete sample of every module.
2. Vocablo refills hearts after 100 newly learned words. **Here that would be
   unreachable**: the free tier holds only 20 vocabulary cards, so hearts could
   never come back and "practice pauses" would silently become "practice ends" —
   which the paywall copy does not claim. The counter runs on correct answers in
   any module instead. A test pins this threshold to what the free tier can
   actually deliver.

### Two deliberate design calls

- **Hearts apply only to Grammar and Vocabulary.** The other five players are
  timed exam simulations that withhold grading until the end, so there is no
  honest moment to spend a heart, and interrupting a timed section would corrupt
  the score being tracked. Documented in `lib/screens/study/hearts_gate.dart`.
- **Mock gating keys off the canonical list position**, not the filtered one —
  otherwise flipping the To-Do/Done toggle would silently change which exams are
  unlocked.

### Files

| File | Role |
| --- | --- |
| `lib/state/entitlements.dart` | `FreeTier`, `ProProducts`, gating + allowances |
| `lib/state/billing.dart` | Play purchase stream, restore, acknowledgement |
| `lib/screens/paywall_screen.dart` | Paywall, 5 triggers, live Play prices |
| `lib/screens/study/hearts_gate.dart` | Shared heart accounting for the drills |
| `test/entitlements_test.dart` | 15 tests covering every boundary |

Purchases are **validated on-device**. Honest gating for ordinary users, but
spoofable on a rooted device — move validation server-side before scaling paid
users.

---

## 6. YOUR tasks

Everything here needs your Play account or your decision. None of it is code.

1. **Back up the keystore.** `android/app/upload-keystore.jks` (alias `upload`)
   and `android/key.properties`. Both are gitignored and exist only on this
   machine. **Lose them and Sira Prep can never be updated again** — your only
   option would be a new listing under a new package id, abandoning every
   install, rating and review. Copy both somewhere that survives this machine
   dying. Do not email them to yourself.

2. **Create the three in-app products** (§5). Nothing is buyable until you do.

3. **Fill and host the privacy policy.** `PRIVACY_POLICY.md` has three
   placeholders: `[FILL DATE]` and `[FILL YOUR EMAIL]` on line 3, and
   `[FILL YOUR EMAIL]` on line 57. Host it (GitHub Pages is free) and paste the
   URL into Play Console → App content. Required — the app uses the microphone
   and an AI feature.

4. **Complete the Data safety form.** PLAY_LAUNCH_CHECKLIST.md §3 has answers
   written for this exact build. Purchases are handled entirely by Google Play,
   so payment data is not "collected by you".

5. **Confirm the practice content is original.** Verify it is original or
   AI-generated and not lifted from real ETS or IELTS papers. I cannot determine
   authorship from the code — **this is the one genuine legal risk left**, and
   only you know where the material came from.

6. **Install the APK and actually use it.** It has never run on a physical
   device. Check the locks appear where you expect, the paywall reads correctly,
   and the hearts behave.

7. **Create store listing assets:** title (≤30 chars), short + full description
   including the trademark disclaimer line, ≥2 phone screenshots, 512×512 icon,
   1024×500 feature graphic, Education category, content rating questionnaire.
   Because the app now sells subscriptions you must also declare **In-app
   purchases** and state plainly what is free and what is paid — Play rejects
   listings that hide a paywall behind a "free" claim.

8. **Decide on the AI provider model.** Sira currently requires the user to
   paste their own API key in Settings (defaults to OpenRouter's free Llama
   3.3 70B). You mentioned wanting to replace this. A paid tier that advertises
   "unlimited Sira coaching" while requiring the user to bring their own key is
   defensible but odd — worth resolving before you promote the AI in the
   listing.

---

## 7. MY tasks — the backlog

In rough priority order, for whenever you want them:

1. Fix whatever device testing turns up.
2. **Server-side purchase validation** — an endpoint checking the purchase token
   against the Play Developer API.
4. **Enable R8/minification.** `android/app/build.gradle.kts` has no
   `isMinifyEnabled`, so the 51 MB bundle is unshrunk. Vocablo's proguard rules
   are a good starting point. Needs care — the TTS and speech plugins have
   reflection-sensitive classes.
5. Replace the bring-your-own-key AI model once you decide §6.8.
6. Grow the content bank, especially IELTS (12 passages against TOEFL's 30).
7. Crash reporting.
8. Localisation — a `locale` setting exists but the UI is English-only.
9. **Account system / cloud sync.** The Account card was removed rather than
   ship a sign-in button promising a release it couldn't deliver. The
   consequence is real and now explicit: progress lives only on the device and
   does not transfer to a new phone. Entitlements *do* follow the Google Play
   account, so a paying user who switches devices keeps Pro but loses their
   history. The store listing must not imply otherwise.

---

## 8. START HERE next session

Facts that cost time to establish. Do not re-derive them.

- **Flutter is at `C:\flutter\bin\flutter.bat`.** Not on PATH; call it by full
  path from PowerShell.
- **`keytool` is at**
  `C:\Program Files\Eclipse Adoptium\jdk-17.0.18.8-hotspot\bin\keytool.exe`.
  **`apksigner` is at**
  `C:\Users\Bourama Djonfaga\AppData\Local\Android\Sdk\build-tools\36.0.0\apksigner.bat`.
- **Use `apksigner` for APKs, `keytool -printcert -jarfile` for AABs.** APKs use
  Signature Scheme v2/v3 and keytool reports "Not a signed jar file" on them —
  that is not a signing failure, just the wrong tool.
- ⚠️ **The release build silently falls back to the debug key** when
  `android/key.properties` is missing (`build.gradle.kts:55`). It will not fail
  the build. **Always verify the signature before uploading** — the owner must
  read `CN=TOEFLsix`, not `CN=Android Debug`.
- **The certificate says `CN=TOEFLsix`** — issued before the rebrand. Users never
  see it and Play App Signing re-signs the delivered app, so it has no practical
  effect. If you want it to say Sira Prep, **the only free moment is before your
  first upload**; afterwards the key is locked forever.
- **Every upload needs a higher `versionCode`**, and a code can never be reused —
  even by a build Play rejected. Bump the number after `+` in `pubspec.yaml`.
- **~36 analyzer infos remain and are deliberate.** They are
  `unnecessary_string_escapes` inside the exam content strings. A regex sweep
  across content data is exactly how you silently corrupt a reading passage —
  leave them. 0 errors and 0 warnings is the bar that matters.
- **The Kotlin incremental-compile cache throws a stack trace during
  `bundleRelease`.** The build recovers and succeeds. It is noise, not a failure
  — check for the `√ Built` line, not the absence of stack traces.
- Content lives in Dart source, not asset JSON. `lib/data/models.dart` notes the
  shapes are JSON-friendly so they can move to assets later without touching
  consumers.

### If you have one hour

Do §6.1 (back up the keystore) and §6.2 (create the products). Those two unblock
everything else, and the first one is the only irreversible risk in the project.

### If you have an evening

Add §6.3, §6.4 and §6.7, then upload to the internal testing track. At that point
you can install through Play, test a real purchase end to end, and you are one
review away from being live.
