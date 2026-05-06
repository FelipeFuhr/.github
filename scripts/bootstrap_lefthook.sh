#!/usr/bin/env bash
set -euo pipefail
VERSION=1.7.10
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m | sed 's/x86_64/x86_64/;s/aarch64/arm64/')
DEST=.bin/lefthook
BINARY="lefthook_${VERSION}_${OS^}_${ARCH}"
CHECKSUMS_URL="https://github.com/evilmartians/lefthook/releases/download/v${VERSION}/lefthook_${VERSION}_checksums.txt"
mkdir -p .bin
echo "Downloading lefthook ${VERSION}..."
curl -sSfL "https://github.com/evilmartians/lefthook/releases/download/v${VERSION}/${BINARY}" -o "$DEST"
echo "Verifying checksum..."
EXPECTED=$(curl -sSfL "$CHECKSUMS_URL" | grep "$BINARY" | awk '{print $1}')
if [ "$OS" = "darwin" ]; then
  ACTUAL=$(shasum -a 256 "$DEST" | awk '{print $1}')
else
  ACTUAL=$(sha256sum "$DEST" | awk '{print $1}')
fi
if [ "$EXPECTED" != "$ACTUAL" ]; then
  echo "ERROR: checksum mismatch for $BINARY" >&2
  echo "  expected: $EXPECTED" >&2
  echo "  actual:   $ACTUAL" >&2
  rm -f "$DEST"
  exit 1
fi
echo "Checksum verified."
chmod +x "$DEST"
"$DEST" install
echo "lefthook $VERSION installed and hooks configured"
