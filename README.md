# Dotfiles

Personal dotfiles - tmux, zsh, vim configuration.

## Contents

```
.
├── .tmux.conf              # tmux 설정 (Catppuccin 테마)
├── .zshrc                  # zsh 설정
├── .vimrc                  # vim 설정
└── scripts/
    └── tmux-sysmon.sh      # tmux 상태바 시스템 모니터
```

## Installation

```bash
# 리포지토리 클론
git clone https://github.com/welldoingk/dotfiles.git ~/dotfiles

# 심볼릭 링크 생성
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# 시스템 모니터 스크립트 링크
mkdir -p ~/.local/bin
ln -sf ~/dotfiles/scripts/tmux-sysmon.sh ~/.local/bin/tmux-sysmon.sh

# TPM (Tmux Plugin Manager) 설치
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# tmux 실행 후 플러그인 설치: prefix + I
```

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
