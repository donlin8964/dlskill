#!/usr/bin/env bash
# DLSkill 一键安装脚本（macOS / Linux）
# 用法：在终端运行  bash install.sh
# 或把本文件发给豆包AI，让它帮你执行

set -e

# ===== 改成你自己的 GitHub 仓库地址后再发布 =====
REPO_ZIP_URL="https://github.com/你的用户名/dlskill/releases/latest/download/dlskill.zip"
# ================================================

SKILL_DIR="$HOME/.super_doubao/super-doubao-runtime/workspace/.user_skills"
TMP_DIR="$(mktemp -d)"

echo "🚀 开始安装 DLSkill..."
echo "技能目录：$SKILL_DIR"
mkdir -p "$SKILL_DIR"

echo "⬇️  下载中..."
if command -v curl >/dev/null 2>&1; then
  curl -L -o "$TMP_DIR/dlskill.zip" "$REPO_ZIP_URL"
elif command -v wget >/dev/null 2>&1; then
  wget -O "$TMP_DIR/dlskill.zip" "$REPO_ZIP_URL"
else
  echo "❌ 未找到 curl 或 wget，请先安装其中一个"; exit 1
fi

echo "📦 解压中..."
unzip -o "$TMP_DIR/dlskill.zip" -d "$TMP_DIR/unzipped" >/dev/null

# 兼容两种压缩结构：dlskill/ 在根目录或在子目录
if [ -d "$TMP_DIR/unzipped/dlskill" ]; then
  SRC="$TMP_DIR/unzipped/dlskill"
else
  SRC="$(find "$TMP_DIR/unzipped" -maxdepth 2 -name SKILL.md -print -quit | xargs dirname)"
fi

if [ ! -f "$SRC/SKILL.md" ]; then
  echo "❌ 压缩包里没找到 SKILL.md，下载可能失败了"; exit 1
fi

rm -rf "$SKILL_DIR/dlskill"
cp -r "$SRC" "$SKILL_DIR/dlskill"
rm -rf "$TMP_DIR"

if [ -f "$SKILL_DIR/dlskill/SKILL.md" ]; then
  echo "✅ DLSkill 安装成功！"
  echo "📂 位置：$SKILL_DIR/dlskill"
  echo "💡 重启或新开一个豆包对话，说「用DLSkill写条口播」即可触发"
else
  echo "❌ 安装失败，请检查权限"; exit 1
fi
