#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

ARCHIVE="PTGs-GitHub-backup.tar.xz"
OUTPUT_DIR="PTGs-restored"
EXPECTED_SHA="c61cec57ec85ff1a59240c82659f3f027df9d75898e14bad09249eafbb05fc4c"

PARTS=(
  "bundle_parts/tar-000.b64"
  "bundle_parts/tar-001.b64"
  "bundle_parts/tar-002-003.b64"
  "bundle_parts/tar-004-005.b64"
  "bundle_parts/tar-006-007.b64"
  "bundle_parts/tar-008.b64"
  "bundle_parts/tar-009.b64"
  "bundle_parts/tar-010.b64"
)

for part in "${PARTS[@]}"; do
  if [[ ! -f "$part" ]]; then
    echo "缺少文件：$part"
    exit 1
  fi
done

TMP_B64="$(mktemp -t ptgs-archive).b64"
trap 'rm -f "$TMP_B64"' EXIT

cat "${PARTS[@]}" | tr -d '\r\n' > "$TMP_B64"

if base64 --help 2>&1 | grep -q -- '--decode'; then
  base64 --decode "$TMP_B64" > "$ARCHIVE"
else
  base64 -D "$TMP_B64" > "$ARCHIVE"
fi

ACTUAL_SHA="$(shasum -a 256 "$ARCHIVE" | awk '{print $1}')"
if [[ "$ACTUAL_SHA" != "$EXPECTED_SHA" ]]; then
  echo "校验失败：文件可能损坏。"
  echo "预期：$EXPECTED_SHA"
  echo "实际：$ACTUAL_SHA"
  exit 1
fi

rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"
tar -xf "$ARCHIVE" -C "$OUTPUT_DIR"

echo ""
echo "恢复完成：$OUTPUT_DIR"
echo "SHA-256 校验通过：$ACTUAL_SHA"

if command -v open >/dev/null 2>&1; then
  open "$OUTPUT_DIR"
fi
