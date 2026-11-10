#!/usr/bin/env bash
# apply.sh: Installs the already-built package from outside the repository,
# then reloads the extension in the current GNOME session.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ZIP_NAME="fast-translate@tazztone.github.io.shell-extension.zip"
ZIP_PATH="$REPO_ROOT/$ZIP_NAME"

if [ ! -f "$ZIP_PATH" ]; then
    echo "❌ Package not found: $ZIP_PATH"
    echo "   Run: npm run build"
    exit 1
fi

echo "🔍 Checking package freshness and contents..."
(cd "$REPO_ROOT" && bash test/zip-contents.sh)

# Never run `gnome-extensions install` from the repository. Keep the install
# source isolated so GNOME tooling cannot touch project files.
INSTALL_TMP="$(mktemp -d "${TMPDIR:-/tmp}/fast-translate-install-XXXXXX")"
cleanup() { rm -rf -- "$INSTALL_TMP"; }
trap cleanup EXIT

cp "$ZIP_PATH" "$INSTALL_TMP/$ZIP_NAME"

echo "📥 Installing Fast Translate locally..."
(cd "$INSTALL_TMP" && gnome-extensions install --force "$ZIP_NAME")

echo "🔄 Reloading the extension..."
bash "$REPO_ROOT/scripts/reload.sh"

echo "✅ Fast Translate applied to this device."
