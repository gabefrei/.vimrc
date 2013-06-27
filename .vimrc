" First edited at 5/1/2013 by sundeepblue
" Version 1.15 (Based on the commits)

""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin related settings
""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()

" autocmd vimenter * NERDTree
" vim-easymotion
" undotree
" nerdtree
" taglist
" cctree

""""""""""""""""""""""""""""""""""""""""""""""""
" Pre-definitions
""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
let g:mapleader=","

syntax on               " turn syntax highlighting on by default
filetype on             " detect type of file
filetype indent on      " load indent file for specific file type
filetype plugin on 

set autoread 			" auto read when file is changed from outside
set history=100 		" keep 100 lines of command list history 
"auto reload vimrc when editing
autocmd! bufwritepost .vimrc source % 

""""""""""""""""""""""""""""""""""""""""""""""""
" My shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>h :h<space>
nmap <leader>w :w<cr>	" fast saving
nmap <leader>x :q<cr>	" fast quit
" nmap <leader>c :!cd<space>
nmap <leader>e :e<space>
nmap <leader>wq :wq<cr> " save and quit
nmap <leader>qf :q!<cr> " force quit

" count the total number of matches in the latest search
" :%s/./&/gn		count characters
" :%s/\i\+/&/gn		count words
map <leader>ct :%s///gn<cr>

" no need to input ':' manually, but lose the "go to next char" ability
map ; :

" in cmd mode, enter % and ! becomes easier
cmap 55 %
cmap 11 !

" next buffer
map <leader>,bn :bn<cr>
map <leader>,bp :bp<cr>

""""""""""""""""""""""""""""""""""""""""""""""""
" Lightweight Latex editing
""""""""""""""""""""""""""""""""""""""""""""""""
" my CVIU paper related mappings
nmap <leader>l :w<cr>:!pdflatex<space>%<cr>:!open<space>CVIU.pdf<cr><cr>
nmap <leader>o :!open<space>CVIU.pdf<cr><cr>
nmap <leader>ll :w<cr>:!pdflatex<space>%<cr>:!bibtex<space>CVIU.aux<cr>:!pdflatex<space>%<cr>:!pdflatex<space>%<cr>:!open<space>CVIU.pdf<cr><cr>
" nmap <leader>cviu :e<space>~/Dropbox/research/IDEAS/IDEA_cvpr_iccv_tex/latex/CVIUfinal/CVIU.tex<cr>
" comment a latex line 
" vmap <leader>c :norm 0i%<cr>
" uncomment a latex line
" vmap <leader>uc :norm<space>0x<cr>


""""""""""""""""""""""""""""""""""""""""""""""""
" C/C++ file compiling
""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30 

" % means filename plus extension, %< means filename without extension
" compile/build c++ 
"nmap <leader>b :w<cr>:!g++<space>%<space>-o<space>%<<cr>
"nmap <leader>b :w<cr>:!g++ % -g -o %<<cr>

func! Debug()
	if &filetype=='c'
		exec "!gcc % -g -o %<"
		exec "!gdb %<"
	elseif &filetype=='cpp'
		exec "!g++ % -g -o %<"
		exec "!gdb %<"
	endif
endfunc

func! Compile()
	if &filetype=='c'
		exec "!gcc -Wall -enable-auto-import % -g -o %<"
	elseif &filetype=='cpp'
		exec "!g++ -Wall % -g -o %<"
	endif
endfunc

func! Run()
	exec "!./%<"
endfunc

set makeprg=g++\ \"%\"\ -g\ -o\ \"%<\"
" nmap <leader>b :w<CR>:!clear<CR>:make<CR>
nmap <leader>b :w<cr>:call Compile()<cr>
nmap <leader>r :call Run()<cr>
nmap <leader>d :call Debug()<cr>

" jump to next compile error
map <leader>cn :cn<cr>
" jump to previous compile error
map <leader>cp :cp<cr>
" jump to 1st compile error
map <leader>cf :cr<cr>
" jump to the last compile error
map <leader>cl :cla<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Move around
"""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
" map 00 I  " i want to make 00 as I, but it does not work. why?
" disable highlight
map <silent> <leader><cr> :noh<cr> 
map <space> /
" i manually map <Caps> to <Ctrl> in MAC Preference setting
" map <caps> <ctrl>
map <c-space> ?
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l

map <left> <nop>
map <right> <nop>
map <up> <nop>
map <down> <nop>
" move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap<M-j> mz:m+<cr>`z
nmap<M-k> mz:m-2<cr>`z
vmap<M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap<M-k> :m'<-2<cr>`>my`<mzgv`yo`z
if has("mac") || has("macunix")
	nmap <D-j> <M-j>
	nmap <D-k> <M-k>
	vmap <D-j> <M-j>
	vmap <D-k> <M-k>
endif

map <leader>te :tabnew<cr>
map <leader>tn :tabn<cr>
map <leader>tp :tabp<cr>
map <leader>to :tabonly<cr>
map <leader>tq :tabclose<cr>

imap ii <esc>
" map esc to tab for all modes
nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
inoremap <Tab> <Esc>`^
inoremap <Leader><Tab> <Tab>

"""""""""""""""""""""""""""""""""""""""""""""""""
" VIM User interface
"""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible        " use vim defaults
set scrolloff=3         " keep 3 lines when scrolling
set ai                  " set auto-indenting on for programming
set si					" smart indent
set showcmd             " display incomplete commands
set showmode
set laststatus=2 		" always show the status line
" Format the status line
set smarttab			" be smart when using tabs
set shiftwidth=4
set tabstop=4		
set number              " show line numbers
set backspace=eol,start,indent " config backspace so it acts as it should act
set whichwrap+=<,>,h,l
set relativenumber		" show relative line number
set ruler               " show the current row and column
set lazyredraw			" don't redraw while executing macros
set wrap				" line wrap
set linebreak			" do not break a word at end 
set hlsearch            " highlight searches
set incsearch           " do incremental searching
set showmatch           " jump to matches when entering regexp
set magic 				" for regular expression turn magic on
set ignorecase          " ignore case when searching
set smartcase           " no ignorecase if Uppercase char present
set shortmess=atI		" do not show help uganda child message

set noerrorbells
set novisualbell

set laststatus=2
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White

if has("gui_running")
	set guifont=Courier:h14
	set t_Co=256		" 256 color mode
	set cursorline		" highlight current line
endif

set cursorline			" highlight current line

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif