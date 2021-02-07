" " some of this only runs on Neovim 0.5 so make sure you have that
" Programs Required:
" rg


" " cool ideas to try:

" alt+w/b to move between words in variables, like you have 'unicodeLetter' and pressing alt+w would take you to the L instead of to the next word. use that plugin u used for that

" " todos:

" plugins to try out:

" terminal on the floating popup
" https://github.com/voldikss/vim-floaterm

let g:polyglot_disabled = ['odin', 'python', 'c', 'cpp', 'lua', 'json']

call plug#begin('~/.local/share/nvim/plugged')
" color schemes
Plug 'dracula/vim', {'as':'dracula'}
Plug 'sainnhe/gruvbox-material'
Plug 'gosukiwi/vim-atom-dark'
" rest
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/LeaderF'
Plug 'jremmen/vim-ripgrep'
Plug 'stefandtw/quickfix-reflector.vim'
Plug '~/dev/third_party/odin.vim'
"Plug 'nvim-treesitter/nvim-treesitter' "treesitter is just so buggy now
"Plug 'nvim-treesitter/playground'
Plug 'junegunn/vim-peekaboo'
Plug 'justinmk/vim-dirvish'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rafcamlet/nvim-luapad', { 'branch': '0.2' }
Plug 'tpope/vim-dispatch'
Plug 'skywind3000/asyncrun.vim'
Plug 'hutterm/vim-workspace'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" " gui config (no need for ginit.vim anymore)
set linespace=1
" set guifont=DejaVu\ Sans\ Mono:h15
set guifont=Fira\ Code:h14
" set guifont=Liberation\ Mono:h15

" " neovide config (Windows GUI)
let g:neovide_fullscreen=v:false
let g:neovide_cursor_animation_length=0
let g:neovide_cursor_trail_length=2
let g:neovide_cursor_vfx_mode = "wireframe"
let g:neovide_cursor_antialiasing=v:true

" " close netrw
autocmd FileType netrw setl bufhidden=wipe
let g:netrw_fastbrowse = 0



" " Color theme config
set termguicolors
set background=dark
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_background = 'hard'
let g:dracula_italic = 0
colorscheme gruvbox-material
" colorscheme atom-dark
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

" TODO(lucypero): can you combine the following two lines?
" " indent with tabs on gdscript files
autocmd Filetype gdscript3 setlocal autoindent tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
" " indent python files wth tabs
au FileType python setlocal autoindent tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab

" " save all shortcut
nnoremap <leader>s :wa <cr>

" " so that i don't need to hold shift all the time
nnoremap ; :
vnoremap ; :

" " see tabs and trailing characters
set list
set listchars=tab:>\ ,trail:·

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



" " set scrolloff so that the cursor does not reach the edges of the screen (which is never good)
set scrolloff=10

" unload current buffer
noremap <leader>q :bp\|bd #<cr>

" switch header file <-> implementation file
nnoremap <leader>h :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Disable that annoying swap file warning
set shortmess+=A

" " Plugin Configuration ---

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

" " go to vim config
nnoremap <leader><F3> :e $MYVIMRC<CR>

function! Scratch()
    :execute "e scratch"
    :execute "setlocal buftype=nofile"
    :execute "setlocal bufhidden=hide"
    :execute "setlocal noswapfile"
endfunction

command! Scratch execute Scratch()

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

" LeaderF Config
" I replaced this with vim-clap... except for displaying functions on the current buffer
" I went back to fzf haha

let g:python_host_prog  = 'C:\Python27\python.exe'
let g:python3_host_prog = 'C:\Users\Admin\AppData\Local\Programs\Python\Python39\python.exe'
let g:Lf_PythonVersion = 3
let g:Lf_RootMarkers = ['.git']
let g:Lf_ExternalCommand = 'rg --files --no-ignore "%s"'
let g:Lf_DefaultExternalTool = 'rg'
" let g:Lf_UseVersionControlTool = 0
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
nnoremap <leader>F :Leaderf function<cr>

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

let s:odin_location = 'C:\Users\Admin\dev\third_party\Odin'

" odin errorformat
set errorformat+=%f(%l:%c)\ %m

" odin - go to definition
fun! OdinGoToDef(identif)
  let l:the_command = 'Rg --no-ignore -g "*.odin" ^^\s*' . a:identif . '\s*:: . ' . s:odin_location
  let l:the_command .= ' ' . s:odin_location . '\shared'
  " echo the_command
  execute the_command
endfun
nnoremap <leader>gd yiw:call OdinGoToDef("\\b<c-r>+\\b")<cr>

" odin - search odin code
fun! OdinSearch(thing)
  echo 'hadwhdaw'
  let l:the_command = 'Rg -g "*.odin" ' . a:thing . ' ' . s:odin_location
  echo the_command
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

" I'm not running treesitter at the moment. It spits out errors all the time.
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = {"c", "cpp", "json", "javascript", "go", "python"},
"   highlight = {
"     enable = true,
"   },
"   incremental_selection = {
"     enable = true,
"     keymaps = {
"       init_selection = "gnn",
"       node_incremental = "grn",
"       scope_incremental = "rc",
"       node_decremental = "grm",
"     },
"   },
" }
" EOF


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


" vim-peekaboo config
function! CreateCenteredFloatingWindow()
    let width = float2nr(&columns * 0.6)
    let height = float2nr(&lines * 0.6)
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:peekaboo_window="call CreateCenteredFloatingWindow()"

" dirvish config
nnoremap <leader>d :Dirvish<cr>

" close buffer quickly
nnoremap <c-q> :q<cr>

" quit vim
nnoremap <leader><c-q> :qa<cr>


" ----------- Plugin Config: vim-clap  -----------
" I went back to fzf haha

" vim-clap config
let g:clap_insert_mode_only = v:true
let g:clap_provider_grep_opts = '-H --no-heading --vimgrep --no-ignore --smart-case'
let g:clap_layout = { 'relative': 'editor' }

let g:clap_provider_files_no_ignore = {
   \ 'id': 'files_no_ignore',
   \ 'source': 'rg --files --no-ignore',
   \ 'sink': 'e',
   \ }

" vim-clap mappings
" nnoremap <leader>O :Clap filer<cr>
" nnoremap <leader>o :Clap files_no_ignore<cr>
" nnoremap <leader>b :Clap buffers<cr>
" nnoremap <leader>R :Clap grep<cr>


" ----------- Plugin Config: CoC -----------

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Sign column takes too much space, I don't think I need it.
set signcolumn=no

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Display CoC Diagnostics
" all Coc mapping will start with <leader>c

nnoremap <leader>cd :CocDiagnostics<cr>


" swapping # and * mappings because i want to use * much more often and it is harder to reach
nnoremap # *
nnoremap * #



" searching for rule definitions in tree sitter grammar
function! GetRuleDefinition(rule)
    let l:the_command = '/^\s*' . a:rule . '\s*:'
    execute the_command
endfunction
nnoremap <leader>gR :call GetRuleDefinition("
nnoremap <leader>gr yiw:call GetRuleDefinition("<c-r>+")<cr>


"Compilation config
" for this I use vim-dispatch
set makeprg=odin\ run\ main.odin

function! CompileTest()
  set makeprg=build.bat
  execute 'make'
endfunction

function! s:run_file()
  if &filetype ==# "python"
    " set makeprg=python3\ -u\ %
    compiler pyunit
    set makeprg=python3\ -u\ %
  elseif  &filetype ==# "c" || &filetype ==# "cpp"
    set makeprg=runc\ %
  elseif &filetype ==# "odin"
    set makeprg=odin\ run\ %
  else
    echo "filetype not recognized"
    return
  endif
  execute 'Make'
endfunction

function! s:compile_project()
  if has("win32")
    set makeprg=build.bat
  endif
  if has("unix")
    set makeprg=\.\/build.sh
  endif
  execute 'Make'
endfunction

noremap <silent> <F8> :wa<cr>:call <sid>compile_project()<cr>
noremap <silent> <c-F9> :wa<cr>:call <sid>run_file()<cr>

" " F10 to open quickfix window
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        Copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <F10> :call ToggleQuickFix()<cr>

" " vim-workspace config

" useful commands:
" :CloseHiddenBuffers
" :ToggleWorkspace
let g:workspace_autocreate =1
let g:workspace_session_directory = $HOME . '/.vim/sessions/'
let g:workspace_autosave = 0

" " fzf config
nnoremap <leader>O :Clap filer<cr>
nnoremap <leader>o :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>R :Rg 
let g:fzf_preview_window = []

" " buffer/window navigation
" f9 and f10 to quickly cycle through buffers
nnoremap <f9> :bp<cr>
nnoremap <f10> :bn<cr>
