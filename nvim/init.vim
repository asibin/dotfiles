set nocompatible

call plug#begin('~/.vim/plugins')

" Sensible vim configuration everyone can agree on.
Plug 'tpope/vim-sensible'

" Essential plugins for collaboration and style.
Plug 'editorconfig/editorconfig-vim' " Support editorconfig file.

" Plugins for colour schemes.
Plug 'altercation/vim-colors-solarized'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'

" Polyglot
Plug 'sheerun/vim-polyglot'

" Nerdtree file explorer and file icons in NerdTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

" Vim statusbar
Plug 'vim-airline/vim-airline'

" Git support
Plug 'tpope/vim-fugitive'

" Language completion suggestions
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Debugging for various languages
Plug 'puremourning/vimspector'

" Lots of mappings such as [<Space> ]<Space>.
Plug 'tpope/vim-unimpaired'

" Surround motions
Plug 'tpope/vim-surround'

" Git gutter icons
Plug 'airblade/vim-gitgutter'

" FZF Vim Integration.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Add easy language aware commenting
Plug 'preservim/nerdcommenter'

" Ctrl + P to open anything
Plug 'kien/ctrlp.vim'

" More usefull start screen
Plug 'mhinz/vim-startify'

" Nicer cursor, tmux interactions.
Plug 'sjl/vitality.vim'

" Navigate seamlessly between vim and tmux splits 
Plug 'christoomey/vim-tmux-navigator'

" Ansible language plugin
Plug 'yaegassy/coc-ansible', {'do': 'yarn install --frozen-lockfile'}

call plug#end()

" --- Simple Vim config.
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set number          " show line numbers
set showcmd         " show command in bottom bar
set cursorline      " highlight current line
set wildmenu        " nicer tab completion 
set updatetime=300  " lower updatetime to make things snappier
" set cmdheight=2     " Better display for messages 
set shortmess+=c    " don't give ins-completion-menu messages.
filetype plugin on

" Ctrl + c sends esc
:ino <C-c> <Esc>

" Highlight the current line.
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

" Break bad habits - no arrow keys!
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" Relative numbers 
set number relativenumber

" Hybrid mode for relative numbers, remove relative when losing focus
augroup auto_toggle_relative_linenumbers
    autocmd FocusLost * :set number norelativenumber
    autocmd FocusGained * :set number relativenumber
    autocmd InsertEnter * :set number norelativenumber
    autocmd InsertLeave * :set number relativenumber
augroup end

set hlsearch        " highlight matches

" Once we are done finding things and we start to edit we don't need highlights
augroup disable_seach_highlights_on_insert
    autocmd InsertEnter * :set nohlsearch
augroup end

" Enable mouse support
set mouse=a
if !has('nvim')
  " Note that this config is not needed in Neovim.
  set ttymouse=xterm2
endif

" Use the system clipboard.
set clipboard=unnamed

" Splits are below/right not above/left
set splitbelow
set splitright


" Use 24bit colors when using nvim
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Use 24bit colors
if (has("termguicolors"))
    set termguicolors
endif


" Theme
syntax on
" let g:onedark_color_overrides = {"comment_grey": { "gui": "#818998", "cterm": "170", "cterm16": "5" }}
colorscheme onedark

" Swap
set swapfile
if !isdirectory($HOME."/.vim/swaps")
    call mkdir($HOME."/.vim/swaps", "", 0700)
endif
set dir=~/.vim/swaps

" Use persistent undo.
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "", 0700)
endif
set undodir=~/.vim/undo
set undofile

" Change working directory and pwd it to status
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>


" --- Coc ---

" Map tab and shift tab to next/previous completion 
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || gsstline('.')[col - 1]  =~# '\s'
endfunction

" Map ctrl + space to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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

" Rename variables / words
nmap <leader>rn <Plug>(coc-rename)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction-line)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Language - file type mappings
let g:coc_filetype_map = {
  \ 'yaml.ansible': 'ansible',
  \ }

" --- Airline ---

" Show the buffers in the tabline.
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.colnr = ' ㏇:'
" let g:airline_symbols.colnr = ' ℅:'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.linenr = ' ␊:'
" let g:airline_symbols.linenr = ' ␤:'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = 'Ɇ'
" let g:airline_symbols.whitespace = 'Ξ'

" " powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.colnr = ' :'
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ' :'
" let g:airline_symbols.maxlinenr = '☰ '
" let g:airline_symbols.dirty='⚡'

" " old vim-powerline symbols
" let g:airline_left_sep = '⮀'
" let g:airline_left_alt_sep = '⮁'
" let g:airline_right_sep = '⮂'
" let g:airline_right_alt_sep = '⮃'
" let g:airline_symbols.branch = '⭠'
" let g:airline_symbols.readonly = '⭤'
" let g:airline_symbols.linenr = '⭡'


" --- NERDTree ---

" Bindings
nnoremap <C-n> :NERDTree<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
map <leader>t :NERDTreeFind<cr> " Show the current file in NERDTree.
" nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

" Config 
let NERDTreeShowHidden=1 " Show or hide hidden files
let g:NERDTreeIgnore=['\.git$[[dir]]', 'node_modules$[[dir]]', '\.nyc_output$[[dir]]', '__pycache__'] " But still ignore some normally not needed files
let NERDTreeRespectWildIgnore=1 " Ignore the files in our 'wildignore' settings (see higher up in the file)

" Get nerdtree to use nerdfonts
let g:NERDTreeGitStatusUseNerdFonts = 1

" --- FZF (Fuzzy Find) configuration ---

" Prevent FZF commands from opening in none modifiable buffers
function! FZFOpen(cmd)
    " If more than 1 window, and buffer is not modifiable or file type is
    " NERD tree or Quickfix type.
    if winnr('$') > 1 && (!&modifiable || &ft == 'nerdtree' || &ft == 'qf')
        " Move one window to the right, then up.
        wincmd l
        wincmd k
    endif
    exe a:cmd
endfunction

" Ctrl-F for find in files. Then some leader commands for finding in buffers etc.
nnoremap <C-f> :call FZFOpen(":Files")<CR> 
nnoremap <silent> <leader>b :call FZFOpen(":Buffers")<CR>
nnoremap <silent> <leader>~ :call FZFOpen(":Files ~")<CR>
nnoremap <silent> <leader>h :call FZFOpen(":History")<CR>
nnoremap <silent> <leader>g :call FZFOpen(":GFiles")<CR>
nnoremap <silent> <leader>f :call FZFOpen(":Ag")<CR>


" --- TERMINAL ---

" Bindings
nnoremap <c-t> :call OpenTerminal()<CR>

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" Open terminal with ZSH shell
function! OpenTerminal()
  split term://zsh
  resize 20
endfunction


" --- ctrlp ---

" Config
" let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" let g:ctrlp_show_hidden = 1

" let g:ctrlp_working_path_mode = 'ra'

" Refresh nerdtree and ctrlp. DISABLED not to clash with <leader>rn 
" nmap <Leader>r :NERDTreeFocus<cr>R<c-w><c-p>:CtrlPClearCache<cr>


" --- The Silver Searcher (ag) ---

" Is 'ag' available?
if executable('ag')
    " For grep, use ag.
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore.
    " let g:ctrlp_user_command = 'ag %s -l --nocolor -g --path-to-ignore ~/.ignore""'
    let g:ctrlp_user_command = 'ag %s -l --nocolor --path-to-ignore ~/.ignore -g ""'
    
    " Check if we can disable caching
   " let g:ctrlp_use_caching = 0
endif


" --- Vimspector ---

" Enable default keybindings
let g:vimspector_enable_mappings = 'HUMAN'

" Define gadgetes for vimspector
let g:vimspector_install_gadgets = [ 'dbugpy' ]

" Inspect variable under cursor
" mnemonic 'di' = 'debug inspect'
" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval


" --- NERDCommenter ---

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1


" --- Startify ---

" Set custom header instead of random quotePlace to add custom header if wanted, each list item is one lines 
let g:startify_custom_header = [
\ ' ___________  ______    _______       ___      ___  __     ___      ___ ',
\ '("     _   ")/    " \  |   __ "\     |"  \    /"  ||" \   |"  \    /"  |',
\ ' )__/  \\__/// ____  \ (. |__) :)     \   \  //  / ||  |   \   \  //   |',
\ '    \\_ /  /  /    ) :)|:  ____/       \\  \/. ./  |:  |   /\\  \/.    |',
\ '    |.  | (: (____/ // (|  /            \.    //   |.  |  |: \.        |',
\ '    \:  |  \        / /|__/ \            \\   /    /\  |\ |.  \    /:  |',
\ '     \__|   \"_____/ (_______)            \__/    (__\_|_)|___|\__/|___|',
\ '                                                                        ',
\ '    I  f e e l  t h e  n e e d  -  t h e  n e e d  f o r  s p e e d!    ',
\ ]                                                                       


" When opening file cd into that directory or vcs root
" let g:startify_change_to_dir = 1
" let g:startify_change_to_vcs_root = 1

" Make indices start at 1 instead of 0
let g:startify_custom_indices = map(range(1,100), 'string(v:val)')

" Get list of folders in ~/workspace folder by recency 
function s:workspace_mru()
    let recent_folders = systemlist("ls -dt ~/workspace/* | head -10")
    
    let results = []

    for item in recent_folders
        call add(results, { 'line': item, 'cmd': 'edit ' . item })
    endfor

    return results
  endfunction

" Sections to show
let g:startify_lists = [
    \ { 'type': function('s:workspace_mru'), 'header': ['   Workspace MRU'] },
    \ { 'type': 'files',     'header': ['   MRU']            },
    \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
    \ { 'type': 'sessions',  'header': ['   Sessions']       },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    \ { 'type': 'commands',  'header': ['   Commands']       }
    \ ]

