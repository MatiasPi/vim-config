call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-commentary'
Plug 'skywind3000/asyncrun.vim'
Plug 'Tetralux/odin.vim'
Plug 'tpope/vim-repeat'
Plug 'calviken/vim-gdscript3'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdtree'
" color schemes
Plug 'dracula/vim', {'as':'dracula'}
" Plug 'flrnprz/taffy.vim', {'as':'taffy'}
" Plug 'rainglow/vim'
" Plug 'sainnhe/gruvbox-material'
" /color schemes
call plug#end()

" " Color theme config
set termguicolors
set background=dark
" let g:gruvbox_material_disable_italic_comment = 1
" let g:gruvbox_material_background = 'medium'
let g:dracula_italic = 0
" colorscheme gruvbox-material
colorscheme dracula
let mapleader = "-"

set cursorline

" " line number - relative
set relativenumber

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set hidden
set mouse=a

" " indent with tabs on gdscript files
" autocmd Filetype gdscript3 setlocal tabstop=4 shiftwidth=4 softtabstop=2 noexpandtab

" " save all shortcut
nnoremap <leader>s :wa <cr>

" " so that i don't need to hold shift all the time
nnoremap ; :
vnoremap ; :

nnoremap <leader>w <C-w><C-w>

" " mapping enter and shift+enter to newline insertion
nnoremap <space> O<Esc>
nnoremap <s-space> o<Esc>
nnoremap <c-space> o<Esc>O

set formatoptions-=cro

" " vim-commentary configuration
autocmd FileType c,cpp,java setlocal commentstring=//\ %s

" " delimitMate configuration
let delimitMate_expand_cr = 1

" " Disables automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" " File searching
set path+=**
set wildmenu
" ignore these file extensions when opening file
set wildignore+=*.pdf,*.o,*.so,*.obj,*.jpg,*.png
" ignoring folders
set wildignore+=*/node_modules/*,*/bin/*
" suffixes are for file extension priority when searching files. i don't need them now
" set suffixes+=.pdf

" " case insensitive search as the default (use \C or use a capital letter for case sensitive search)
set ignorecase
set smartcase

" " Splits open at the bottom and right
set splitbelow splitright

" " Shortcutting split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" " generate tags
nnoremap <leader>T :AsyncRun ctags -R .<cr><cr>

" " F10 to toggle quickfix window
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

if has("win32")
noremap <silent> <F9> :wa<cr>:AsyncRun build.bat<cr>
endif
if has("unix")
noremap <silent> <F9> :wa<cr>:AsyncRun \.\/build.sh<cr>
endif

" " set scrolloff so that the cursor does not reach the edges of the screen (which is never good)
set scrolloff=10

" unload current buffer
noremap <leader>q :bp\|bd #<cr>

" switch header file <-> implementation file
nnoremap <leader>h :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Disable that annoying swap file warning
set shortmess+=A

" " Plugin Configuration ---

" " AsyncRun configuration
let g:asyncrun_open = 6
let g:asyncrun_bell = 1

" Smart indent when entering insert mode with i on empty lines
function! IndentWithI()
    if len(getline('.')) == 0
        return "\"_cc"
    else
        return "i"
    endif
endfunction
nnoremap <expr> i IndentWithI()

" " shortcut for searching whatever is in the copy registry
nnoremap <C-3> /<C-R>0<cr>

" " shortcut for setting up 2 windows with the current buffer in both of them
nnoremap <C-s> <C-W>o:vsp<cr>

" " shortcut for going back to prev file
nnoremap <leader>1 <C-^>

" " shortcut for sourcing current file
nnoremap <leader>2 :w<bar>so %<cr>

" " go to previous error
nnoremap <leader>[ :cp<cr>
" " go to next error
nnoremap <leader>] :cn<cr>
" " go to current error
nnoremap <leader>} :cc<cr>

" " run current c/c++ file
nnoremap <leader>5 :w<cr>:AsyncRun runc %<cr>

" " C-c C-v copy and paste
vnoremap <C-c> "+y
" noremap <C-v> "+P

nnoremap <leader><F3> :e $MYVIMRC<CR>

function! Scratch()
    :execute "e scratch"
    :execute "setlocal buftype=nofile"
    :execute "setlocal bufhidden=hide"
    :execute "setlocal noswapfile"
endfunction

command! Scratch execute Scratch()
nnoremap <leader>S :Scratch<cr>

" " sources local file if it exists
" "    in that file, you set up all the configuration that is particular to
" "    the local machine you are using.
let s:local_file_name = "init.local.vim"
let s:path = expand('<sfile>:p:h') . "/" . s:local_file_name
if filereadable(s:path)
  runtime init.local.vim
endif

" " Visual movement by default
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" " Show current function name
fun! ShowFuncName()
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bWn'))
  echohl None
endfun
map <leader>f :call ShowFuncName() <CR>

fun! SaveSession()
  let l:proj_dir = getcwd()
  let l:proj_folder = matchstr(l:proj_dir, '.*\\\zs\(.*\)\ze$')
  let l:session_file = "~/.vim/sessions/" . l:proj_folder . ".vim"
  execute 'mks! ' . l:session_file
endfun

nnoremap <leader>S :call SaveSession()<cr>
