# Dotfiles

Personal dotfiles - tmux, zsh, vim, git, Claude Code 설정.

## Contents

```
.
├── .tmux.conf              # tmux 설정 (Catppuccin 테마)
├── .zshrc                  # zsh 설정
├── .vimrc                  # vim 설정
├── .gitconfig              # git user 설정
├── claude/
│   ├── CLAUDE.md.template      # Claude Code 지시사항 템플릿
│   ├── settings.json.template  # Claude Code 설정 템플릿
│   └── agents/                 # 서브에이전트 정의 (10개)
├── scripts/
│   └── tmux-sysmon.sh      # tmux 상태바 시스템 모니터
└── setup.sh                # 자동 설치 스크립트
```

## Installation

```bash
git clone https://github.com/welldoingk/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./setup.sh
```

설치 시 Claude Code 설정에 필요한 경로(Obsidian API, Telegram 그룹 ID)를 대화형으로 입력받습니다.

## tmux

### Features

- Dual prefix: `Ctrl-b` / `Ctrl-a`
- 마우스 지원 (클릭, 드래그 복사, 스크롤)
- Vi 스타일 복사 모드
- Vim 스타일 패널 이동 (`h/j/k/l`)
- Catppuccin 테마 기반 상태바
- 시스템 모니터 (CPU / RAM / GPU / VRAM / 온도 / 팬속도)
- TPM 플러그인: tmux-sensible, tmux-prefix-highlight

### Key Bindings

| Key | Action |
|-----|--------|
| `prefix + \|` | 수평 분할 |
| `prefix + -` / `_` | 수직 분할 |
| `prefix + h/j/k/l` | 패널 이동 (vim 스타일) |
| `prefix + H/J/K/L` | 패널 크기 조절 |
| `Alt + Arrow` | 패널 이동 (prefix 없이) |
| `Alt + Shift + Arrow` | 패널 크기 조절 (prefix 없이) |
| `Ctrl + PageUp/Down` | 윈도우 이동 |
| `prefix + r` | 설정 리로드 |

### System Monitor (tmux-sysmon.sh)

tmux 상태바 우측에 실시간 시스템 정보를 표시합니다.

- **C**: CPU 사용률 (%)
- **R**: RAM 사용량 (used/total GB)
- **GPU**: GPU 사용률 (%) - NVIDIA GPU 감지 시
- **V**: VRAM 사용량 (used/total GB)
- 온도 및 팬 속도 (H/M/L)

사용률에 따라 색상이 변합니다: 녹색 (정상) → 주황 (주의) → 빨강 (경고)

## License

MIT
