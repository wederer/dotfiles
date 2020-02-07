"Bundle Scripts "{{{
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
endif "}}}

"" PLUGINS "{{{
"---------------------------------------------------------------------------
call plug#begin()
""Better Autocompletion and Snippets
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

""Emmet
Plug 'mattn/emmet-vim'
let g:user_emmet_install_global = 0
autocmd FileType html,css,php EmmetInstall
let g:user_emmet_leader_key='<C-E>'

""Indent Guides
Plug 'nathanaelkane/vim-indent-guides'
"set indent guides on and enable in true color
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_color_name_guibg_pattern = "guibg='\?\zs[0-9A-Za-z]\+\ze'\?"

""HTML 5 elemente support
Plug 'othree/html5.vim'

"Better vim Pasting
Plug 'sickill/vim-pasta'

"% Matching for HTML and LaTeX
" Plug 'tmhedberg/matchit'

""Show trailing whitespaces
Plug 'ntpeters/vim-better-whitespace'

""faster navigation""
Plug 'bradford-smith94/quick-scope'
nnoremap <Leader>q :QuickScopeToggle<CR>

""show undo history as tree - <F5>
Plug 'mbbill/undotree'
nnoremap <F5> :UndotreeToggle<cr>

""file tree - <C-n>
Plug 'scrooloose/nerdtree'
nnoremap <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=["node_modules"]
""Icons for NerdTree""
Plug 'ryanoasis/vim-devicons'

""Fuzzy search for files - <leader>f, <leader>b, <leader>ag
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

""makes working with brackets and surrounds easier""
Plug 'tpope/vim-surround'

""makes repeating commands better""
Plug 'tpope/vim-repeat'

""Makes commenting easy""
Plug 'tpope/vim-commentary'

""code formating""
Plug 'Chiel92/vim-autoformat'
nnoremap <F3> :Autoformat<CR>
"alternative
"Plug 'sbdchd/neoformat'


"all kinds of awesome stuff for git
Plug 'tpope/vim-fugitive'

""Status bar at bottom
Plug 'bling/vim-airline'
let g:airline_theme='oceanicnext'
let g:airline_powerline_fonts = 1

""Colorschemes""
Plug 'mhartington/oceanic-next'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'whatyouhide/vim-gotham'

""Unused Plugins "{{{
""javascript stuff
" Plug 'pangloss/vim-javascript'
"
""makes aligning things easier
"Plug 'junegunn/vim-easy-align'

""async job control""
" Plug 'benekastah/neomake'

""syntax checker for multiple langs (now using neomake)
"Plug 'scrooloose/syntastic'

""makes grepping easier - :Grepper
" Plug 'mhinz/vim-grepper'
" let g:grepper = {
"     \ 'tools': ['git', 'grep'],
"     \ 'open':  0,
"     \ 'jump':  1,
"     \ }

""better quickfix window (e.g. grep)""
" Plug 'romainl/vim-qf'

""Plugin to make vim work with slimux
" Plug 'jpalardy/vim-slime'
" let g:slime_target = "tmux"
" let g:slime_python_ipython = 1

""Indentation as Text Object
" Plug 'michaeljsmith/vim-indent-object'

"show vim marks in gutter
" Plug 'kshenoy/vim-signature'

""Vimtex Plugin für Latex
" Plug 'lervag/vimtex'

""FastFold to calculate folds only when told
" Plug 'Konfekt/FastFold'

"Pug Syntax Highlighting
" Plug 'digitaltoad/vim-pug' "}}}

call plug#end() "}}}

"" GENERAL SETTINGS "{{{
"---------------------------------------------------------------------------
" Leader
let mapleader=" "
" let g:mapleader=" "

" System Settings --
" Neovim Settings
set termguicolors

" make vim lag less
set lazyredraw
set ttyfast

hi CursorLineNR guifg=#ffffff " highlight the current line number
hi FoldColumn guifg=#65737e
colorscheme OceanicNext
syntax enable
""unused colorschemes
" colorscheme gruvbox
" colorscheme molokai
" colorscheme solarized
" colorscheme gotham
" colorscheme base16-default-dark
" set background=dark "}}}

"" PLUGIN OPTIONS AND CONFIG "{{{
"---------------------------------------------------------------------------

"fzf options
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>ag :Ag<CR>

""deoplete options auto completion
let g:deoplete#enable_at_startup = 1
" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end
" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<tab>"
" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

""neomake linting
" autocmd! BufWritePost * Neomake " Runs Neomake on every save
" let neomake_verbose = 3
" let g:neomake_logfile = '/home/wolfe/.neomake.log'
" let g:neomake_python_enabled_makers = ['python', 'flake8'] "python and flake8 for python linting
" let g:neomake_scss_enabled_makers = ['scsslint']
"let scsslintargs=[]
"if filereadable("scss-lint.yml")
"    let scsslintargs=['-c', 'scss-lint.yml']
"endif
"let g:neomake_scss_scsslint_maker = {
"    \ 'exe': 'scss-lint',
"    \ 'args': [] + scsslintargs,
"    \ 'errorformat': '%f:%l [%t] %m',
"    \ }
""need to fix errorformat!
" let g:neomake_scss_enabled_makers = ['stylelint']
" let g:neomake_scss_stylelint_maker = {
"     \ 'exe': 'stylelint',
"     \ 'args': ['-f', 'json', '--syntax', 'scss'],
"     \ 'errorformat': '%t:%f:%l:%c:%m'
"     \ }

"   5:4   ✖  Unexpected whitespace at end of line
" \ 'errorformat': '%+P%f, %W%l:%c%*\s%m, %-Q'
" \ 'errorformat': '\    %l:%c\    %*[\✖]\    %m%r'
" \ 'args': ['-f', 'line', '--syntax', 'scss'],
" \ 'errorformat': '%f\,%l\,%c\,%tRROR\,'
" \ 'args': ['-f', 'json', '--syntax', 'scss'],
" \ 'errorformat': '%t:%f:%l:%c:%m'
"}}}

"" USEFUL SHORTCUTS "{{{
"---------------------------------------------------------------------------

" turn off search highlighting until the next search
nnoremap <Leader>h :nohl<CR>
" Use <F4> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F4>

" Toggle line number type
nnoremap <Leader>n :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>
"toggle scrolling
nnoremap <Leader>s :let &scrolloff=999-&scrolloff<CR> "}}}

"" USEFUL OPTIONS "{{{
"---------------------------------------------------------------------------
set encoding=utf8
set scr=5
set mouse=a
set clipboard=unnamedplus
set undofile
set undodir=/home/wolfe/.config/nvim/undo-files
set undolevels=5000         " How many undos

set hidden " necessary

"cycling through buffers
nnoremap <Tab> :bnext<CR>
nnoremap <A-Tab> :bprevious<CR>

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see
" the mapping of <C-L> below)
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Display line numbers on the left
set relativenumber
set number

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

"always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" Stay in same column when using gg or G to jump in file
"set nostartofline

" Save all on focus lost
autocmd BufLeave,FocusLost * silent! wall

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Set the command window height to 2 lines, to avoid many cases of having to
" press <Enter> to continue"
set cmdheight=2

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" tabstop space
set softtabstop=2 expandtab shiftwidth=2 smarttab

" show color column at specific width on insert
augroup ColorcolumnOnlyInInsertMode
  autocmd!
  autocmd InsertEnter * setlocal colorcolumn=80
  autocmd InsertLeave * setlocal colorcolumn=0
augroup END
"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=20      "deepest fold is X levels
" set nofoldenable        "dont fold by default
set foldlevel=99        "this is just what i use
"remember folds persistently
augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END
" Space to toggle folds.
nnoremap <Leader><Leader> za
vnoremap <Leader><Leader> za "}}}

"" FILETYPE SPECIFIC SETTINGS "{{{
"---------------------------------------------------------------------------
" LATEX
let g:tex_flavor = "latex"

let g:vimtex_fold_enabled = 1
autocmd FileType tex setlocal tw=79
" autocmd FileType tex setlocal foldmethod=expr
" autocmd FileType tex setlocal foldcolumn=1
autocmd FileType tex let @c='a~\cite{}\todo[noline]{cite}'
autocmd FileType tex let @m='a~\begin{math}\end{math}F\i'
autocmd FileType tex let @s='/\di\textsubscript{ea}'
autocmd FileType tex set spelllang=en_gb spell

" not being called correctly?
autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}
autocmd BufRead,BufNewFile *.vim setlocal foldmethod=marker foldmarker={{{,}}} "}}}

"" CUSTOM KEYBINDINGS "{{{
"---------------------------------------------------------------------------

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-W>q :close<CR>
nnoremap <C-q> :bd<CR>

" Leave Cursor at same position when yanking
vnoremap y myy`y
vnoremap Y myY`y

"Moves lines and reindents
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" vnoremap <C-j> :m '>+1<CR>gv=gv
" vnoremap <C-k> :m '<-2<CR>gv=gv
" nnoremap <C-j> :m .+1<CR>
" nnoremap <C-k> :m .-2<CR>
vnoremap <C-j> :m '>+1<CR>gv
vnoremap <C-k> :m '<-2<CR>gv

" Indenting lines in visual mode
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Search Replace current word or current selection (with and without
" confirmation)
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nnoremap <Leader>gr :%s/\<<C-r><C-w>\>//g<Left><Left>
vnoremap <Leader>r "hy:%s/<C-r>h//gc<left><left><left>
vnoremap <Leader>gr "hy:%s/<C-r>h//g<left><left>

"saves file
nnoremap <C-s> :w<CR>

" moving through wrapped lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" prints current date
nnoremap <leader>d :r !LC_ALL=de_DE.utf8 date "+\#\%A \%d.\%m.\%Y \%H:\%M:\%S"<CR>

nnoremap <up>    :cprev<CR>
nnoremap <down>  :cnext<CR>
nnoremap <left>  :cprev<CR>
nnoremap <right> :cnext<CR> "}}}

"" CUSTOM FUNCTIONS "{{{
"---------------------------------------------------------------------------
"
"
"
"
"
"
"
"
"OLD
" function! WC()
" let filename = expand("%")
" let cmd = "detex " . filename . " | wc -w | tr -d \\n | tr -d \\[:space:\\]"
" let result = system(cmd)
" echo result . " words"
" endfunction

" command WC call WC()


" function! CC()
" let filename = expand("%")
" let cmd = "detex " . filename . " | wc -c | tr -d \\n | tr -d \\[:space:\\]"
" let result = system(cmd)
" echo result . " characters"
" endfunction

" command CC call CC()
"Calls Google Scholar and pastes result back into line
"Google Scholar will block this after like 50 requests though
" function ScholarCrawl()
"   let curr_line = getline('.')
"   let output = system('wget -U "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20070802 SeaMonkey/1.1.4" "'.curr_line.'" -q -S -O - 2>&1 | grep -o -E "\w* result|not match" | grep -o "[0-9]*"')
"   let output = substitute(output, '\%x00', '', 'g')
"   if !output
"     let output = 0
"   endif
"   let year = strpart(curr_line, strlen(curr_line)-4)
"   echom(year)
"   call setline('.', year .';'. output)
" endfunction

" Create parent directory if not exists
" function s:MkNonExDir(file, buf)
"   if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
"     let dir=fnamemodify(a:file, ':h')
"     if !isdirectory(dir)
"       call mkdir(dir, 'p')
"     endif
"   endif
" endfunction
" augroup BWCCreateDir
"   autocmd!
"   autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
" augroup END
"


"Tag stuff
" This should make classes work with ctags
"set iskeyword+=.
" set iskeyword+=-

" alternative to <C-]>
"lace your cursor on an id or class and hit <leader>]
"" to jump to the definition
"nnoremap <leader>t :tag /<c-r>=expand('<cword>')<cr><cr>

" alternative to <C-w>}
" "lace your cursor on an id or class and hit <leader>}
" to show areview of the definition. This doesn't seem to be
" " very useful for CSS but it rocks for JavaScript
"nnoremap <leader>d :ptag /<c-r>=expand('<cword>')<cr><cr>
"
"nnoremap <leader>t :Tags <c-r>=expand('<cword>')<cr><cr>

""nnoremap <leader>c :call search("class") <bar> Tags <c-r>=expand('<cword>')<cr><cr>
"nnoremap <leader>c :call SearchClassTag()<cr>
"nnoremap <leader>i :call SearchIDTag()<cr>

"" auto completion with ctags
"inoremap <c-x><c-t> <c-x><c-]>
"inoremap <c-t> <c-x><c-]>

"function SearchClassTag()
"    normal mz
"    call cursor(line("."), 1)
"    "check if search returns 0; then stop and echom error message
"    let classFound =search("class", "", line("."))
"    if classFound == 0
"        echom "No Class found!"
"        normal `z
"        return 0
"    endif

"    "echom class
"    normal el
"    let test =expand('<cword>')
"    normal `z
"    execute ':Tags ' . test
"    "echom test
"endfunction

"function SearchIDTag()
"    normal mz
"    call cursor(line("."), 1)
"    "check if search returns 0; then stop and echom error message
"    let idFound =search("id", "", line("."))
"    if idFound == 0
"        echom "No ID found!"
"        normal `z
"        return 0
"    endif

"    "echom class
"    normal el
"    let test =expand('<cword>')
"    normal `z
"    execute ':Tags ' . test
"    "echom test
"endfunction
"
"}}}
