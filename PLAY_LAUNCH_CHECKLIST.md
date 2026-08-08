# Google Play launch checklist — TOEFLsix

## ✅ Done (in the code / repo)
- Release signing wired (`signingConfigs.release` ← `android/key.properties`); **upload keystore
  created** (`android/app/upload-keystore.jks`, alias `upload`) — keep it + its password backed up.
- Signed release **App Bundle** built: `build/app/outputs/bundle/release/app-release.aab`
  (also copied to Desktop). This is what you upload.
- **Trademark disclaimer** added in-app (Settings footer) + a hostable **PRIVACY_POLICY.md**.
- Unused `BLUETOOTH` permission removed; `flutter analyze` clean (0 errors/0 warnings).
- No hardcoded secrets, no ads/analytics SDKs, mic permission is justified (speaking practice).

## ⚠ You must do (needs your decision / your Play account)

### 1. Decide the app name/brand  ← biggest rejection risk
"TOEFL"/"IELTS" are trademarks (ETS; British Council/IDP/Cambridge). Leading with them in the
**app name** ("TOEFLsix") risks rejection/takedown even with a disclaimer.
- **Safer:** brand it with your OWN name and use the exams *descriptively*, e.g.
  **"Sira Prep — for TOEFL & IELTS"**, **"GlassPrep: English Exam Trainer"**, **"SixScore"**.
- ⚠ The **package id `com.siraprep.app` is permanent** once you publish — pick the final
  identity **before** first upload. (Display name = `android:label` in AndroidManifest.xml;
  I left it unchanged pending your choice.)

### 2. Privacy policy → public URL
Fill the bracketed fields in `PRIVACY_POLICY.md`, host it (GitHub Pages off this repo works),
and paste the URL in **Play Console → App content → Privacy policy**. Required (mic + AI).

### 3. Data Safety form (Play Console → App content → Data safety)
For THIS build (bring-your-own-key AI). Suggested answers:
- **Does the app collect/share user data?** Yes (only via the optional AI feature).
- **Collected by you:** *None* (no analytics, no server of yours).
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
App title (≤30 chars, see #1), short + full description **including the disclaimer line**, ≥2
phone screenshots, 512×512 icon, 1024×500 feature graphic, category (Education), content-rating
questionnaire, target-audience, and news/ads declarations.

### 6. Upload
Create the app in Play Console → **Production/Testing** → upload `app-release.aab` → complete the
above → submit for review. Watch the **pre-launch report** for 16 KB-page-size or policy flags.

## 🔁 Later (your planned rework)
You're replacing the bring-your-own-API-key model. When you do, revisit: the Settings AI section,
the Sira empty-state, this checklist's Data Safety answers, and the privacy policy's AI section.
