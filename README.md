# Bag Tally

Ties each person's unique ID to their bag number. Bag numbers are typed twice to catch slips, repeated IDs and bags are flagged, and the list exports to Excel. Everything is stored on the phone and works with no signal.

## Get it on your iPhone (Sideloadly)

1. Push this repo to GitHub. The **Build iOS app** action runs on every push to `main` (about 5–10 minutes).
2. Open the repo's **Releases** and download `BagTally.ipa` from the latest one.
   Stable link: `https://github.com/<you>/<repo>/releases/latest/download/BagTally.ipa`
3. In Sideloadly, drop in the IPA, enter your Apple ID, and install.
4. On the phone: Settings › General › VPN & Device Management › trust your Apple ID.

A free Apple ID signature lasts 7 days, so re-sideload if you install it more than a week before you need it. SideStore also takes the same IPA and refreshes it for you.

## Or use it in the browser (GitHub Pages)

In the repo: Settings › Pages › Source: **GitHub Actions**. After the next push it's live at `https://<you>.github.io/<repo>/`. Open it once with signal, then Share › Add to Home Screen; it keeps working offline after that.

## Making changes

Edit `src/page.html` (the whole app is in that one file) and push. Both the IPA and the Pages site rebuild. If you change the app, bump `VERSION` in `web/sw.js` so home-screen copies refresh.

Run locally: `npm install && npm run build`, then open `www/index.html` or serve the `www` folder.

## Files

| Path | What it is |
| --- | --- |
| `src/page.html` | The app |
| `scripts/build-www.sh` | Wraps the app into `www/` and bundles the Excel library for offline use |
| `web/` | Home-screen manifest, offline service worker, icons |
| `assets/icon.png` | 1024×1024 iOS app icon |
| `.github/workflows/build-ipa.yml` | Builds the unsigned IPA on a Mac runner and attaches it to a release |
| `.github/workflows/pages.yml` | Deploys the browser version |

## Notes

- Data lives on the device that recorded it: the app and the browser version keep separate lists, and deleting the app deletes its list. Export to Excel before you uninstall.
- "Save Excel" opens the iOS share sheet: pick **Save to Files**, or send it straight to WhatsApp, Mail, etc.
- Bag numbers and IDs are written to Excel as text, so leading zeros are kept.
