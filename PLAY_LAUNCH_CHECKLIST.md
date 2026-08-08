# Google Play launch checklist — Sira Prep

## ✅ Done (in the code / repo)
- Release signing wired (`signingConfigs.release` ← `android/key.properties`); **upload keystore
  created** (`android/app/upload-keystore.jks`, alias `upload`) — keep it + its password backed up.
- Signed release **App Bundle** built: `build/app/outputs/bundle/release/app-release.aab`.
  This is what you upload. Verified to carry `com.siraprep.app`, the label "Sira Prep", the
  `com.android.vending.BILLING` permission, and the real upload signature.
- **Brand decided and applied:** package id `com.siraprep.app`, display name "Sira Prep".
- **Monetization built** — freemium with Google Play Billing. See §1 below for the products you
  must create; the paywall shows nothing to buy until they exist.
- **Trademark disclaimer** added in-app (Settings footer) + a hostable **PRIVACY_POLICY.md**.
- Unused `BLUETOOTH` permission removed; `flutter analyze` clean (0 errors/0 warnings).
- No hardcoded secrets, no ads/analytics SDKs, mic permission is justified (speaking practice).

## ⚠ You must do (needs your decision / your Play account)

### 1. Create the three in-app products  ← nothing is buyable until you do
The paywall reads prices from Play, so it shows an empty state until these exist. The ids must
match `lib/state/entitlements.dart` **exactly** — a mismatched id fails silently.

| Product id                | Type             | Notes                          |
| ------------------------- | ---------------- | ------------------------------ |
| `siraprep_pro_monthly`    | Subscription     | Base plan, monthly, auto-renew |
| `siraprep_pro_yearly`     | Subscription     | Base plan, yearly, auto-renew  |
| `siraprep_pro_lifetime`   | One-time product | Non-consumable                 |

`flutter logs` prints the offending ids on launch (`Billing: products not found…`).

You **cannot test purchases from a locally-built APK**. Upload to the **internal testing** track
first and install from the Play link, or every purchase errors.

On pricing: a brand-new listing with no reviews does not convert at a premium price. Consider
launching low and raising once you have ratings — Play lets you raise prices later, and existing
subscribers keep their original rate.

**What the free tier gives away** (all in `FreeTier`, change it there and nowhere else):
first 3 items of each skill · 1 vocabulary set · 1 grammar set · 1 full mock ·
3 hearts a day, refilled by 20 correct answers · 20 lifetime Sira messages.

### 2. Privacy policy → public URL
Fill the bracketed fields in `PRIVACY_POLICY.md`, host it (GitHub Pages off this repo works),
and paste the URL in **Play Console → App content → Privacy policy**. Required (mic + AI).

### 3. Data Safety form (Play Console → App content → Data safety)
For THIS build (bring-your-own-key AI). Suggested answers:
- **Does the app collect/share user data?** Yes (only via the optional AI feature).
- **Collected by you:** *None* (no analytics, no server of yours). Purchases are handled entirely
  by Google Play — you never see or store payment data, so it is not "collected by you".
- **Shared with third parties:** *"Other user-generated content"* — the text a user sends to the
  AI coach is sent to the AI provider they choose. Purpose: **App functionality**. Not for ads.
- **Encrypted in transit:** Yes.
- **Users can request deletion:** No account data held by you; local data cleared on uninstall / by
  "Reset progress".
- Audio: the app doesn't store/upload audio itself (device speech service does the recognition).
- ⚠ **Re-do this section when you change the AI integration.**

### 4. Confirm content originality
Verify all practice/mock content is **original or AI-generated** — not copied from real ETS/IELTS
exams or other copyrighted material (legal + Play IP risk).

### 5. Store listing assets (Console)
App title (≤30 chars — "Sira Prep"), short + full description **including the disclaimer line**,
≥2 phone screenshots, 512×512 icon, 1024×500 feature graphic, category (Education), content-rating
questionnaire, target-audience, and news/ads declarations.

Because the app now sells subscriptions, the listing must also declare **In-app purchases**, and
the full description should state plainly what is free and what is paid. Play rejects listings
that hide a paywall behind a "free" claim.

### 6. Upload
Create the app in Play Console → **Production/Testing** → upload `app-release.aab` → complete the
above → submit for review. Watch the **pre-launch report** for 16 KB-page-size or policy flags.

## 🔁 Later (your planned rework)
You're replacing the bring-your-own-API-key model. When you do, revisit: the Settings AI section,
the Sira empty-state, this checklist's Data Safety answers, and the privacy policy's AI section.

## 🔧 Known gaps at v1.1

Honest list, so nothing ships by accident:

- **Purchases are validated on-device.** Enough to gate features honestly for ordinary users, but
  spoofable on a rooted device. Move validation server-side before scaling paid users — an
  endpoint that checks the purchase token against the Play Developer API.
- **No account system.** The Account card was removed rather than shipping a sign-in button that
  promised a release it could not deliver. Progress lives in `SharedPreferences` and entitlements
  are tied to the Google Play account, so nothing is lost — but progress does **not** transfer to
  a new device, and the store listing must not imply it does.
- **Hearts apply to Grammar and Vocabulary only.** Reading, Listening, Speaking, Writing and Mocks
  withhold grading until the end by design, so there is no honest moment to spend a heart, and
  interrupting a timed section would corrupt the score. This is deliberate, not an oversight.
