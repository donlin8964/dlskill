#!/usr/bin/env bash
# 版本号同步脚本：确保 VERSION 文件与 SKILL.md 中的版本号一致
# 用法：bash scripts/sync-version.sh
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
VERSION_FILE="$ROOT_DIR/VERSION"
SKILL_FILE="$ROOT_DIR/SKILL.md"

if [ ! -f "$VERSION_FILE" ]; then
  echo "❌ 未找到 VERSION 文件：$VERSION_FILE"
  exit 1
fi

VERSION=$(cat "$VERSION_FILE" | tr -d '[:space:]')
echo "📌 当前版本：v$VERSION"

# 检查 SKILL.md 中的版本号
if grep -q "version: $VERSION" "$SKILL_FILE"; then
  echo "✅ SKILL.md 版本号一致"
else
  echo "⚠️  SKILL.md 版本号不一致，正在更新..."
  sed -i '' "s/version: [0-9.]*/version: $VERSION/" "$SKILL_FILE" 2>/dev/null || \
    sed -i "s/version: [0-9.]*/version: $VERSION/" "$SKILL_FILE"
  echo "✅ SKILL.md 已更新为 v$VERSION"
fi

# 检查 README.md 中的最新版本
if grep -q "最新版本：v$VERSION" "$ROOT_DIR/README.md"; then
  echo "✅ README.md 版本号一致"
else
  echo "⚠️  README.md 最新版本号不一致，请手动更新更新日志"
fi

echo ""
echo "🎉 版本同步完成"
