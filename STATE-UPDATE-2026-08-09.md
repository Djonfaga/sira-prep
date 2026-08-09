# State update — 9 August 2026 (assistant session)

Addendum to **[STATE.md](STATE.md)** (the full source of truth). This note records the
**live git/GitHub situation and the rebrand chain** from this session, which STATE.md
predates. Read STATE.md for content/monetization/upload detail.

---

## Snapshot right now
- Identity: **Sira Prep** · `com.siraprep.app` · **1.1.0+2** · signed release AAB exists & verified.
- Code: `flutter analyze` clean (0 errors/warnings); nothing in code blocks upload (per STATE.md §2).
- Working tree: **billing WIP is present and untouched by me** (paywall / entitlements / hearts).

## What this session did (and pushed)
1. Play-readiness review → found: debug-signed release, no AAB, trademark exposure, missing
   privacy policy, BYO-API-key AI, non-functional Google/Account card.
2. Fixed the release blockers: created **`android/app/upload-keystore.jks`** (alias `upload`),
   wired `signingConfigs.release` ← `android/key.properties`, removed unused `BLUETOOTH`.
3. **Rebranded** TOEFLsix → **Sira Prep** (`applicationId` + `namespace` = `com.siraprep.app`,
   MainActivity moved, `android:label`, 6 in-app brand strings).
4. Added the **trademark disclaimer** (Settings footer), **`PRIVACY_POLICY.md`**,
   **`PLAY_LAUNCH_CHECKLIST.md`**; cleaned the pubspec description.
5. Built + verified the signed AAB; created the GitHub repo and made it **public**.
6. (The concurrent session then added billing, removed the Account card, wrote STATE.md,
   and rebuilt to 1.1.0+2 — see STATE.md.)

Last commit I pushed to GitHub: **`fcf97ff`** (the rebrand). Local is **ahead** of that
(STATE.md commit `f3c31e7` + billing) — see the blocker below.

## ✅ GitHub — RESOLVED (later on 2026-08-09)
- Auth was down earlier (token 401, "Login expired"); it was restored via GCM re-login.
- All local commits **pushed** (through `e26dc50`, incl. billing + Account-card removal + STATE.md).
- Repo **renamed `toeflsix-flutter-ai` → `sira-prep`**; `origin` is now
  `https://github.com/Djonfaga/sira-prep.git` (the old URL auto-redirects).
- **Public repo: https://github.com/Djonfaga/sira-prep** · remote HEAD verified `e26dc50`.

## 🔨 Latest build — release APK (10 Aug 2026)
Built from `ef5669d` (v1.1.0+2), signed, verified with `apksigner` + `aapt` (not the build log):

- **`SiraPrep-v1.1.0-release.apk`** — 52.3 MB, **universal** (all ABIs, installs on any device);
  copied to the Desktop. For **sideload device testing** only.
- signer **`CN=TOEFLsix`** = the real **release** key (not debug) · package **`com.siraprep.app`**
  · versionName **1.1.0** / versionCode **2** · label **Sira Prep**.
- permissions in the APK: `RECORD_AUDIO` + `com.android.vending.BILLING` ✅.
- ⚠ **Purchases will NOT complete from this sideloaded APK** — Play only honours purchases for
  builds delivered through Play. Test purchases via the **internal-testing track** (upload the AAB
  named in [STATE.md](STATE.md) §3), not this file.
- The Play **upload** artifact is still the AAB, not this APK.

## ⚠ Do-not-forget
- **Back up `android/app/upload-keystore.jks` + `android/key.properties`** off this machine
  (gitignored; irreversible if lost). Alias `upload`; the password is intentionally **not**
  written here (public repo) — it lives in `android/key.properties` and the chat where the
  keystore was created. Keep it in your password manager.
- Upload the AAB named in STATE.md §3 (`SiraPrep-v1.1.0-PLAY-UPLOAD.aab`), not the older
  `sira-prep-release.aab` I left on the Desktop.
