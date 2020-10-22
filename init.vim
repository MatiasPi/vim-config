" " some of this only runs on Neovim 0.5 so make sure you have that

" " todos:

" - look into autocompletion:
" -   https://github.com/neoclide/coc.nvim
" -   https://github.com/Shougo/deoplete.nvim
" -   https://github.com/ycm-core/YouCompleteMe
" - check out these videos for setting autocompletion stuff up:
" - https://www.youtube.com/watch?v=Iid1Ms14Om4
" - https://www.youtube.com/watch?v=ICU9OEsNiRA
"

call plug#begin('~/.local/share/nvim/plugged')
" color schemes
Plug 'dracula/vim', {'as':'dracula'}
Plug 'sainnhe/gruvbox-material'
" rest
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/LeaderF'
Plug 'jremmen/vim-ripgrep'
Plug 'stefandtw/quickfix-reflector.vim'
Plug '~/dev/odin.vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'

call plug#end()

" " neovide config (Windows GUI)
let g:neovide_fullscreen=v:false
let g:neovide_cursor_animation_length=0.1
let g:neovide_cursor_trail_length=2

" " close netrw
autocmd FileType netrw setl bufhidden=wipe
let g:netrw_fastbrowse = 0

let g:polyglot_disabled = ['odin', 'python', 'c', 'cpp', 'lua', 'json']

" " Color theme config
set termguicolors
set background=dark
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_background = 'medium'
let g:dracula_italic = 0
colorscheme gruvbox-material
" colorscheme dracula

let mapleader = "-"

set cursorline

" " line number - relative
set relativenumber

" set clipboard register to be the default register. 
" no need for <leader>p or <leader>y anymore
set clipboard=unnamedplus

" " not necessary anymore (read above)
" " " Copy to clipboard
" vnoremap  <leader>y  "+y
" nnoremap  <leader>Y  "+yg_
" nnoremap  <leader>y  "+y
" nnoremap  <leader>yy  "+yy

" " " Paste from clipboard
" nnoremap <leader>p "+p
" nnoremap <leader>P "+P
" vnoremap <leader>p "+p
" vnoremap <leader>P "+P

filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set hidden
set mouse=a

" " indent with tabs on gdscript files
autocmd Filetype gdscript3 setlocal autoindent tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab

" " save all shortcut
nnoremap <leader>s :wa <cr>

" " so that i don't need to hold shift all the time
nnoremap ; :
vnoremap ; :

nnoremap <leader>w <C-w><C-w>

" " mapping enter and ctrl+enter to newline insertion
nnoremap <space> o<Esc>k
nnoremap <c-space> O<Esc>j

" " mapping c-enter to make a newline without going in insert mode
nnoremap <c-cr> o<esc>

set formatoptions-=cro

" " vim-commentary configuration
autocmd FileType c,cpp,java,odin setlocal commentstring=//\ %s
autocmd FileType gdscript3 setlocal commentstring=#\ %s

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
nnoremap <F10> :call asyncrun#quickfix_toggle(15)<cr>

function! s:run_file()
  execute "w"
  let l:ext = expand('%:e')
  if ext ==# "py"
    execute "AsyncRun -raw python -u %"
  elseif  ext ==# "c" || ext ==# "cpp"
    execute "AsyncRun runc %"
  elseif  ext ==# "odin"
    execute "AsyncRun odin run %"
  endif
endfunction

if has("win32")
noremap <silent> <F8> :wa<cr>:AsyncRun build.bat<cr>
endif
if has("unix")
noremap <silent> <F8> :wa<cr>:AsyncRun \.\/build.sh<cr>
endif

noremap <silent> <F9> :wa<cr>:call <sid>run_file()<cr>

noremap <silent> <C-F9> :wa<cr>:AsyncStop<cr>
noremap <silent> <C-F8> :wa<cr>:AsyncStop<cr>

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
let g:asyncrun_open = 15  
let g:asyncrun_bell = 1

" " fzf config
function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code > 0
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction

augroup _fzf
  autocmd!
  autocmd ColorScheme * call <sid>update_fzf_colors()
augroup END

" nnoremap <leader>at :Tags<cr>
" nnoremap <leader>o :Files<cr>

" " vim-ripgrep config
nnoremap <leader>r :Rg --no-ignore 
let g:rg_highlight = 1

" " SkyBison config
" nnoremap <leader>b :<c-u>call SkyBison("b ")<cr>
" nnoremap <leader>t :<c-u>call SkyBison("tag ")<cr>
" nnoremap <leader>o :<c-u>call SkyBison("e ")<cr>

" let g:skybison_fuzz = 2

" " nerdtree configuration
nnoremap <C-n> :NERDTreeToggle<cr>
nnoremap <C-p> :NERDTreeFind<cr>

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

" " run program
" " it runs my script 'runprog.py'
nnoremap <F5> :w<cr>:AsyncRun python -u \%userprofile\%\\path\\runprog.py %<CR>

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

" " Tab completion
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" imap <expr><TAB> "\<C-n>"
" " this does not work for some reason
" imap <expr><S-Tab> "\<C-p>" 

" " Show current function name
fun! ShowFuncName()
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bWn'))
  echohl None
endfun
map <leader>f :call ShowFuncName() <CR>

" " LanguageClient configuration
" " NOTE: requires cquery to be installed
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
    \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
    \ 'py': ['pyls', '--log-file=/tmp/cq.log']
    \ }
let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
" let g:LanguageClient_settingsPath = '/home/YOUR_USERNAME/.config/nvim/settings.json'
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_hoverPreview = "Never"
if has('win32')
  let g:LanguageClient_settingsPath = '\%userprofile\%\\AppData\\Local\\nvim\\settings.json'
endif
if has('unix')
  let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'
endif
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

" nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
" nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" UltiSnips Config
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" LeaderF Config
" LeaderF cheatsheet:
" LeaderF function to see function in buffer - mapped to <leader>F

" don't show the help in normal mode
let g:Lf_PythonVersion = 3
let g:Lf_RootMarkers = ['.git']
let g:Lf_ExternalCommand = 'rg --files --no-ignore "%s"'
let g:Lf_DefaultExternalTool = 'rg'
" let g:Lf_UseVersionControlTool = 0
let g:Lf_WindowPosition = 'bottom'
let g:Lf_PreviewInPopup = 1
nnoremap <leader>at :Tags<cr>
" nnoremap <leader>o :Files<cr>
nnoremap <leader>o :Leaderf file<cr>
" nnoremap <leader>r :Leaderf rg --no-ignore 
nnoremap <leader>b :Leaderf buffer<cr>
nnoremap <leader>F :Leaderf function<cr>


fun! SaveSession()
  let l:proj_dir = getcwd()
  let l:proj_folder = matchstr(l:proj_dir, '.*\\\zs\(.*\)\ze$')
  let l:session_file = "~/.vim/sessions/" . l:proj_folder . ".vim"
  execute 'mks! ' . l:session_file
endfun

nnoremap <leader>S :call SaveSession()<cr>

" type todo - //TODO(lucypero): blabla
nmap <leader>9 oTODO(lucypero):<ESC>gccA 
" type note - //NOTE(lucypero): blabla
nmap <leader>0 oNOTE(lucypero):<ESC>gccA 

" unload buffer
nnoremap <leader>D :bd<cr>

" source current file (vimscript)
nnoremap <leader><c-S> :w<cr>:source %<cr>

" disable netrw (it is bad)
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1


" ----------- Odin stuff -----------

" odin errorformat
set errorformat+=%f(%l:%c)\ %m

" odin - go to definition
fun! OdinGoToDef(identif)
  let l:the_command = 'Rg --no-ignore ^^\s*' . a:identif . '\s*:: . C:\Users\Admin\dev\Odin'
  let l:the_command .= ' C:\Users\Admin\dev\Odin\shared'
  " echo the_command
  execute the_command
endfun
nnoremap <leader>gd yiw:call OdinGoToDef("\\b<c-r>+\\b")<cr>

" odin - search odin code
fun! OdinSearch(thing)
  let l:the_command = 'Rg ' . a:thing . ' C:\Users\Admin\dev\Odin'
  " echo the_command
  execute the_command
endfun
nnoremap <leader>go :call OdinSearch("")<left><left>

" odin - list all proc definitions in buffer
fun! OdinProcs(only_in_buffer)
    let l:the_command = 'Rg --no-ignore ^^\s*\w*\s*::\s*(?:inline)?\s*proc\('
    if a:only_in_buffer
      let l:the_command .= ' %'
    endif
    " echo the_command
    execute the_command
endfun
" keymap done in the language dependent mappings section

" odin - list all structs definitions in buffer
fun! OdinStructs(only_in_buffer)
    let l:the_command = 'Rg --no-ignore ^^\s*\w*\s*::\s*struct'
    if a:only_in_buffer
      let l:the_command .= ' %'
    endif
    " echo the_command
    execute the_command
endfun
nnoremap <leader>gs :call OdinStructs(1)<cr>
nnoremap <leader>gS :call OdinStructs(0)<cr>


" ----------- / Odin stuff -----------

" super comment - code area separator
nmap <leader>GC o ----------- CODEAREA -----------<esc>gccfCce

" list all code area separators
fun! ListCodeSeparators()
    let l:the_command = 'Rg --no-ignore "// ----------- .* -----------" %'
    " echo the_command
    execute the_command
endfun
nnoremap <leader>ca : call ListCodeSeparators()<cr>


au VimResized * wincmd =

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp", "json", "go", "python"},
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "rc",
      node_decremental = "grm",
    },
  },
}
EOF


" ----------- Filetype specific bindings -----------

" odin
au FileType odin nnoremap <buffer> <leader>gf :call OdinProcs(1)<cr>
au FileType odin nnoremap <buffer> <leader>gF :call OdinProcs(0)<cr>

" cpp
" this is temporary.. i will set up CoC.. eventually
au FileType cpp,c,python,vim nnoremap <buffer> <leader>gf :Leaderf function<cr>


" code fold config:
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" to get rid of the ^M's that sometimes show up for some reason
nnoremap <leader>Rm :e ++ff=dos<cr>
