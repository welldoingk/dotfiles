set mouse=a

if has("termguicolors")
    set termguicolors
endif

set number

" 행 번호 색상 변경 (예: 어두운 회색)
highlight LineNr guibg=NONE ctermbg=NONE guifg=#262626

" 현재 커서가 있는 줄의 번호 색상만 다르게 설정 (옵션)
set cursorline

highlight CursorLine guibg=NONE ctermbg=NONE gui=underline cterm=underline guisp=#F9F1A5

syntax on
