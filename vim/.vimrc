" --- Settings ---
" Leader
let mapleader = " "

set undofile                    " Saves undo history
set undodir=~/.vim/undo-files   " Set save folder
set undolevels=5000             " number of undos saved

" start viminfo stuff
" Tell vim to remember certain things when we exit and jump to previous cursor position
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='20,\"100,:20,%,n~/.viminfo
function! ResCur()
  "Rescue cursor for all files except gitcommit
  if &ft =~ 'gitcommit'
    return
  endif
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
" end viminfo stuff

set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set incsearch                   " do incremental searching
set hlsearch                    " highlight all searched terms
set laststatus=2                " Always display the status line
set autowrite                   " Automatically :write before running commands
filetype plugin indent on       " Correct indentation

" Softtabs, 2 spaces
set autoindent
set noexpandtab
set tabstop=4
set shiftwidth=4

autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype js setlocal ts=2 sw=2 expandtab
autocmd Filetype ts setlocal ts=2 sw=2 expandtab

" Use one space, not two, after punctuation.
set nojoinspaces

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Display line numbers on the left
set relativenumber number


" --- Keybindings ---

" Turn off last search highlight
nnoremap <leader>h :noh<CR>

" Toggle line numbers
nnoremap <leader>n :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>

"Move around in splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Leave Cursor at same position when yanking
vnoremap y myy`y
vnoremap Y myY`y

"Moves lines and reindent
inoremap <C-j> <Esc>:m .+1<CR>gi
inoremap <C-k> <Esc>:m .-2<CR>gi
vnoremap <C-j> :m '>+1<CR>gv
vnoremap <C-k> :m '<-2<CR>gv

" moving through wrapped lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" save file
nnoremap <C-s> :w<CR>"

"cycling through buffers
nnoremap <Tab> :bnext<CR>
nnoremap <A-Tab> :bprevious<CR>

"50 72 formatting for git commit messages
augroup gitsetup
  autocmd!

  " Only set these commands up for git commits
  autocmd FileType gitcommit
    \  hi def link gitcommitOverflow Error
    \| autocmd CursorMoved,CursorMovedI *
      \  let &l:textwidth = line('.') == 1 ? 50 : 72
augroup end
