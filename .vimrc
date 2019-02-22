if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
    Plug 'Valloric/YouCompleteMe'
    Plug 'Raimondi/delimitMate'
    Plug 'kien/ctrlp.vim'
    Plug 'vim-syntastic/syntastic'
    Plug 'tomtom/tcomment_vim'
    Plug 'tomasr/molokai'
    Plug 'morhetz/gruvbox'
    Plug 'fatih/vim-go'
    Plug 'rust-lang/rust.vim'
    Plug 'racer-rust/vim-racer'
    " Plug 'vim-powerline'
call plug#end()

" TODO: remove pathogen and use vim-plug for plugin management
execute pathogen#infect()

" Font
if has('gui_running')
  "set guifont=Meslo\ LG\ L\ DZ\ for\ Powerline:h13
  set guifont=Fira\ Code:h12
  set macligatures
endif

" Color scheme
" colorscheme nord
" colorscheme molokai
colorscheme gruvbox

" gruvbox mode
set background=dark
" set background=light

" Enable molokai with original color scheme and 256 color version
"let g:rehash256 = 1
"let g:molokai_original = 1

" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Don't offer to open certain files/directories
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*

" Always show current position
set ruler

" Set line number
set number

" Height of the command bar
"set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Auto save when runing :make
set autowrite

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Hide scrollbar
set guioptions=

" Add a bit extra margin to the left
set foldcolumn=1

" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" plugins expect bash - not fish, zsh, etc
set shell=bash

" which key should be the <leader>
" (\ is the default, but ',' is more common, and easier to reach)
let mapleader=","

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
"set lbr
"set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Switch buffers
map <F9> :bprevious<CR>
map <F10> :bnext<CR>

" Quickfix list
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Clear last search highlighting
map <Space> :noh<cr>

" Easier split navigations
" We can use different key mappings for easy navigation between splits to save a keystroke. So instead of ctrl-w then j, it’s just ctrl-j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" More natural split opening
" Open new split panes to right and bottom, which feels more natural than Vim’s default
set splitbelow
set splitright

"
" // REMINDER //
"
" Resizing splits
" Vim’s defaults are useful for changing split shapes:

"Max out the height of the current split
" ctrl + w _

"Max out the width of the current split
" ctrl + w |

"Normalize all split sizes, which is very handy when resizing terminal
" ctrl + w =

"Swap top/bottom or left/right split
" Ctrl+W R

"Break out current window into a new tabview
" Ctrl+W T

"Close every window in the current tabview but the current one
" Ctrl+W o

" Syntastic
" we want to tell the syntastic module when to run
" we want to see code highlighting and checks when  we open a file
" but we don't care so much that it reruns when we close the file
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" we also want to get rid of accidental trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Omnicomplete
set completeopt+=menuone,noselect,noinsert
inoremap <C-Space> <C-x><C-o>

"
" YouCompleteMe
"
" let g:ycm_add_preview_to_completeopt = 0
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_auto_trigger = 1
" set completeopt-=preview

" Stopping and accepting via <cr> (enter)
" https://github.com/Valloric/YouCompleteMe/issues/232
imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

" tcomment_vim
map <D-/> :TComment<cr>
vmap <D-/> :TComment<cr>gv


" ================
" Language Support
" ================

"
" vim-go
"
let g:go_list_type = "quickfix"
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <Leader>c  <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <Leader>i  <Plug>(go-info)

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" automatically show type info
let g:go_auto_type_info = 1

" automatically highlight matching identifiers
" let g:go_auto_sameids = 1

" use goimports for formatting & auto importing missing packages
let g:go_fmt_command = "goimports"

" turn highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1

" Open go def in vertical window, horizontal, or tab
au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
au Filetype go nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>

"
" Rust
"
let g:rustfmt_autosave = 1

" a basic set up for LanguageClient-Neovim
" << LSP >> {{{
" let g:LanguageClient_autoStart = 1
" nnoremap <leader>lcs :LanguageClientStart<CR>
"
" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['rustup', 'run', 'nightly', 'rls']
"     \ }
"
" noremap <silent> H :call LanguageClient_textDocument_hover()<CR>
" " noremap <silent> Z :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" " nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" noremap <silent> R :call LanguageClient_textDocument_rename()<CR>
" noremap <silent> S :call LanugageClient_textDocument_documentSymbol()<CR>
" }}}

" Rust autocompletion using racer
let g:racer_cmd = "/Users/fani/.cargo/bin/racer"
" Also it's worth turning on 'hidden' mode for buffers otherwise you need to save the current buffer every time you do a goto-definition
set hidden
" show the complete function definition (e.g. its arguments and return type)
let g:racer_experimental_completer = 1
"
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

