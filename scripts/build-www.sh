#!/usr/bin/env bash
# Builds www/ from src/page.html: wraps it in a full HTML document,
# adds the offline files, and bundles the Excel library so export works with no internet.
set -euo pipefail
cd "$(dirname "$0")/.."

rm -rf www
mkdir -p www/vendor

{
cat <<'HEAD'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<meta name="theme-color" content="#e2611a">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-title" content="Bag Tally">
<link rel="manifest" href="manifest.webmanifest">
<link rel="apple-touch-icon" href="icon-192.png">
<style>
:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}
body{margin:0;font:14px system-ui,-apple-system,sans-serif}
img{max-width:100%}
[hidden]{display:none!important}
</style>
</head>
<body>
HEAD
cat src/page.html
cat <<'TAIL'
<script>
if("serviceWorker" in navigator && location.protocol==="https:" && !(window.Capacitor&&window.Capacitor.isNativePlatform&&window.Capacitor.isNativePlatform())){
  navigator.serviceWorker.register("sw.js").catch(function(){});
}
</script>
</body>
</html>
TAIL
} > www/index.html

cp web/* www/
cp node_modules/xlsx/dist/xlsx.full.min.js www/vendor/

echo "Built www/ ($(du -sh www | cut -f1))"
