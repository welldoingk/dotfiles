#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Dotfiles Setup ==="
echo ""

# --- 기본 dotfiles 심볼릭 링크 ---
echo "[1/3] 기본 dotfiles 링크 생성"
ln -sf "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.vimrc" ~/.vimrc
ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig

mkdir -p ~/.local/bin
ln -sf "$DOTFILES_DIR/scripts/tmux-sysmon.sh" ~/.local/bin/tmux-sysmon.sh

echo "  .tmux.conf .zshrc .vimrc .gitconfig tmux-sysmon.sh ✓"

# --- TPM 설치 확인 ---
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  echo "  TPM 설치 중..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "  TPM ✓ (tmux 실행 후 prefix + I 로 플러그인 설치)"
else
  echo "  TPM 이미 설치됨 ✓"
fi

# --- Claude Code 설정 ---
echo ""
echo "[2/3] Claude Code 설정"
read -p "Claude Code 설정을 적용하시겠습니까? (y/N): " apply_claude
if [[ "$apply_claude" =~ ^[yY]$ ]]; then
  mkdir -p ~/.claude

  # HOME_DIR
  home_dir="$HOME"
  echo "  HOME_DIR: $home_dir"

  # Obsidian API 호스트
  read -p "  Obsidian REST API 호스트 (예: 192.168.0.61:27123, 없으면 Enter): " obsidian_host
  obsidian_host="${obsidian_host:-없음}"

  # Telegram 그룹 ID
  read -p "  Telegram 그룹 ID (예: -1003752117919, 없으면 Enter): " telegram_group
  telegram_group="${telegram_group:-없음}"

  # 템플릿 치환
  sed \
    -e "s|{{HOME_DIR}}|$home_dir|g" \
    -e "s|{{OBSIDIAN_API_HOST}}|$obsidian_host|g" \
    -e "s|{{TELEGRAM_GROUP_ID}}|$telegram_group|g" \
    "$DOTFILES_DIR/claude/CLAUDE.md.template" > ~/.claude/CLAUDE.md

  sed \
    -e "s|{{HOME_DIR}}|$home_dir|g" \
    "$DOTFILES_DIR/claude/settings.json.template" > ~/.claude/settings.json

  # 서브에이전트 복사
  if [[ -d "$DOTFILES_DIR/claude/agents" ]]; then
    mkdir -p ~/.claude/agents
    cp "$DOTFILES_DIR/claude/agents/"*.md ~/.claude/agents/
    echo "  agents ($(ls "$DOTFILES_DIR/claude/agents/"*.md | wc -l)개) ✓"
  fi

  echo "  CLAUDE.md, settings.json ✓"
else
  echo "  건너뜀"
fi

# --- 완료 ---
echo ""
echo "[3/3] 완료!"
echo ""
echo "적용하려면:"
echo "  source ~/.zshrc"
echo "  tmux source-file ~/.tmux.conf  (tmux 안에서)"
