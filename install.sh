#!/usr/bin/env bash
# DLSkill 一键安装脚本（macOS / Linux）
# 用法：bash install.sh
set -e

# ===== 改成你自己的 GitHub 仓库地址后再发布 =====
REPO="donlin8964/dlskill"
# ================================================

echo "🚀 开始安装 DLSkill..."

# 优先用 npx skills（支持 WorkBuddy/Claude Code/Cursor 等 50+ 工具）
if command -v npx >/dev/null 2>&1; then
  echo "📦 检测到 npx，使用 skills 工具安装到所有 AI 工具..."
  npx -y skills add "$REPO" -g --all
  echo "✅ 安装完成！新开一轮对话即可使用。"
  exit 0
fi

# 兜底：手动复制到常见技能目录
SKILL_DIR="$HOME/.super_doubao/super-doubao-runtime/workspace/.user_skills/dlskill"
echo "⚠️  未检测到 npx，使用手动安装到：$SKILL_DIR"
mkdir -p "$(dirname "$SKILL_DIR")"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
rm -rf "$SKILL_DIR"
cp -r "$SCRIPT_DIR" "$SKILL_DIR"
# 清理脚本自身和 README，只保留技能文件
rm -f "$SKILL_DIR/install.sh" "$SKILL_DIR/README.md"
echo "✅ 安装完成！重启或新开一轮对话即可使用。"
