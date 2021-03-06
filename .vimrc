" ultimate vimrc configuration: https://github.com/skwp/dotfiles
" ultimate vimrc configuration 2: https://github.com/amix/vimrc
" http://vimawesome.com/
" http://benmccormick.org/2014/08/04/learning-vim-in-2014-search/
"
" do not change the following, they are required by vundle plugin manager

"""""""""""""""""""""""""""""""""""""""""""""""
" First edited at 5/1/2013 by sundeepblue
" Version 1.9 (Based on the commits) 9/10/2013

""""""""""""""""""""""""""""""""""""""""""""""""
" Pre-definitions
""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
let g:mapleader=","
"auto reload vimrc when editing
autocmd! bufwritepost .vimrc source % 

set nocompatible              " be iMproved, required
filetype off                  " required
set noswapfile


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

""""""""""""""""""""""""""""" my favorate """""""""""""""""""""""
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'airblade/vim-gitgutter'
Plugin 'mhinz/vim-startify'
Plugin 'bling/vim-bufferline'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'rking/ag.vim'
Plugin 'nvie/vim-flake8'
Plugin 'ervandew/supertab'
Plugin 'szw/vim-maximizer'
Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'
Plugin 'justincampbell/vim-eighties'
Plugin 'google/vim-colorscheme-primary'
Plugin 'luochen1990/rainbow'
Plugin 'mattn/gist-vim'

"""""""""""""""""""""""""""" trying """"""""""""""""""""

Plugin 'sjl/gundo.vim'
""" Plugin 'Bling/vim-airline'
 
" Plugin 'python-rope/ropevim'
"Plugin 'matze/vim-move'   
"Plugin 'klen/python-mode'
Plugin 'scrooloose/syntastic'


" had not figure out how to use yet
"Plugin 'christoomey/vim-tmux-navigator'
" useful when in the future want to run make or compile code
" need to run tmux first, then vim
"Plugin 'benmills/vimux'
"Plugin 'terryma/vim-multiple-cursors'
"Plugin 'terryma/vim-expand-region'
"Plugin 'Shougo/unite.vim'
" Plugin 'taglist'
"Plugin 'yegappan/mru'
" Plugin 'mileszs/ack.vim'
"Plugin 'SirVer/ultisnips'

"""""""""""""""""""""""""""" has issue """""""""""
"Plugin 'Valloric/YouCompleteMe'

call vundle#end()

filetype plugin indent on

let g:gitgutter_sign_column_always = 1
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn



let g:nerdtree_tabs_open_on_console_startup=1
let g:SuperTabDefaultCompletionType = "context"

""""let g:airline#extensions#tabline#enabled = 1
""""let g:airline#extensions#tabline#show_buffers = 1
""""let g:airline#extensions#bufferline#enabled = 1
""""let g:airline#extensions#tabline#buffer_nr_show = 0

let g:bookmark_auto_save = 1
let g:bookmark_manage_per_buffer = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_auto_close = 1

let g:bookmark_no_default_key_mappings = 1
function! BookmarkMapKeys()
    nmap mm :BookmarkToggle<CR>
    nmap mi :BookmarkAnnotate<CR>
    nmap mn :BookmarkNext<CR>
    nmap mp :BookmarkPrev<CR>
    nmap ma :BookmarkShowAll<CR>
    nmap mc :BookmarkClear<CR>
    nmap mx :BookmarkClearAll<CR>
endfunction
function! BookmarkUnmapKeys()
    unmap mm
    unmap mi
    unmap mn
    unmap mp
    unmap ma
    unmap mc
    unmap mx
endfunction
autocmd BufEnter * :call BookmarkMapKeys()
autocmd BufEnter NERD_tree_* :call BookmarkUnmapKeys()


let g:rainbow_active = 1


""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin related settings
""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_leader_key="e"
" Disable 'r' when it is used as leader key
"map r <Nop>
" hi link EasyMotionTarget ErrorMsg
" hi link EasyMotionShade Comment
nmap <leader>n :NERDTree<cr>
let NERDTreeShowBookmarks=1
" autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"nmap <leader>c :CtrlP<cr>

let g:ctrlp_working_path_mode = 'ra'
" MacOSX/Linux
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pdf    
" Windows
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  
let g:aghighlight=1
let g:agprg="ag --column --smart-case"

if executable('ag')
	" Use ag over grep
	set grepprg=ag 
	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	" ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor, for now, does not work very good! 
" nnoremap K :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>

"map <leader>s :Ag!<space>
map <space><space> :Ag!<space>

map <leader>1 :1b<cr>
map <leader>2 :2b<cr>
map <leader>3 :3b<cr>
map <leader>4 :4b<cr>
map <leader>5 :5b<cr>
map <leader>6 :6b<cr>
map <leader>7 :7b<cr>
map <leader>8 :8b<cr>
map <leader>9 :9b<cr>
let g:bufferline_echo = 1
let g:bufferline_show_bufnr = 1

map 88 *
nmap <leader>tt :TagbarToggle<cr>

"let g:pymode_options_colorcolumn = 0
" let g:showmarks_enable=1
" let g:showmarks_include="abcdefzx1234"

" show undo history tree by Gundo plugin
nnoremap <leader>ut :GundoToggle<cr>
nmap <leader>j :%!python -m json.tool<cr>
nmap <leader>ev :tabe<space>~/.vimrc<cr>

""""""""""""""""" auto highlight words under cursor """""""""
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.

nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=2000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=200
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""
" My shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""
" set working directory to the current file. Each time when run
" a program, run this command to change working directory. Otherwise
" the program won't run
nnoremap <leader>d :cd %:p:h<CR>:pwd<CR>
" nmap <leader>h :h<space>
" fast saving
" nmap <leader>w :w<cr>	
" fast quit
" nmap <leader>x :q<cr>	
" save and quit
" nmap <leader>wq :wq<cr> 
" force quit
"nmap <leader>qf :q!<cr>


"nnoremap <silent> n nzz
"nnoremap <silent> N Nzz
"nnoremap <silent> * *zz
"nnoremap <silent> # #zz
"nnoremap <silent> g* g*zz



" count the total number of matches in the latest search
" :%s/./&/gn		count characters
" :%s/\i\+/&/gn		count words
""nmap <leader>ct :%s///gn<cr>
" no need to input ':' manually, but lose the "go to next char" ability
nmap ; :
vmap ; :norm<space>
" nmap ;; :norm<space>

" in cmd mode, enter %, !, ^, @ becomes easier
"cmap 55 %
"cmap 66 ^
"cmap 11 !
"cmap 22 @

" select all contents
map <leader>al ggVG
" easily select all contents using left-hand
" map fa ggVG
" left-hand fast quit
 map fq :q<cr>
" left-hand fast saving
 nmap fw :w<cr>
" map fww :w!<cr>
" map fwq :w!<cr>:q<cr>
" left-hand list all matches, 'fs' means 'Fast Search list'
" map fs :g//<cr>
" fast move to last and next edit positions
map ga g;
map gs g,

" super convenient and super quick :)
" first press 'fa', then press 'fd', you can quickly enter command mode to process all lines at once, 
" without leave left-hand off keyboard
" vmap fd :norm<space>
" quickly launch a bash inside vim
" map gc :ConqueTermVSplit<space>bash<cr> 

" since 't' is barely used, why not map it to the frequently used 'top'?
" map t gg
" map 't' to 'page up'
"map t <PageUp>
" scroll half page up
noremap U <c-u>
" scroll half page down
noremap M <c-d>

" since 'q' is rarely used, so i match it to a frequent operation
" map 'q' to 'page down'
" sometimes q is used to quit a window. so better use another one.
" map q <PageDown>
" map g <PageDown>
" next buffer
map <leader>bn :bn<cr>
map <leader>bp :bp<cr>
map <leader>bb :Startify<cr>

"----map <leader>f :call<space>Flake8()<cr>
"----"let g:flake8_show_in_file=1
"----let g:flake8_show_in_gutter=1
"----highlight link Flake8_Error      Error
"----highlight link Flake8_Warning    WarningMsg
"----highlight link Flake8_Complexity WarningMsg
"----highlight link Flake8_Naming     WarningMsg
"----highlight link Flake8_PyFlake    WarningMsg

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_python_flake8_args='--ignore=E501'
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_save = 0
let g:syntastic_check_on_wq = 0

map <leader>s :SyntasticCheck<space>flake8<space>pylint<cr>
map <leader>f :SyntasticToggleMode<cr>
let g:syntastic_check_on_open = 0

" Easier linewise reselection of what you just pasted. not useful right now
" nnoremap <leader>V V`]

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

"""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Move around
"""""""""""""""""""""""""""""""""""""""""""""""""
"Reselect visual block after in/outdenting
vnoremap < <gv
vnoremap > >gv

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
map <silent> <leader><cr> :noh<cr> 
map <space> /
" i manually map <Caps> to <Ctrl> in MAC Preference setting
map <caps> <ctrl>
map <c-space> ?

" disable below 4 lines due to conflict with vim-tmux-navigator
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

map <c-j> <c-w>j<c-w>_
map <c-k> <c-w>k<c-w>_
map # :MaximizerToggle!<cr>
"map <c-h> <c-w>h<c-w><Bar>
"map <c-l> <c-w>l<c-w><Bar>
imap <C-w> <C-o><C-w>
map - <C-W>-
map _ <C-W>-
map + <C-W>+
set winminheight=0


" map <left> <nop>
" map <right> <nop>
" map <up> <nop>
" map <down> <nop>


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

"""""""""""""""""""""" tab """"""""""""""""""""

map te :tabnew<cr>
"map tn :tabn<cr>
"map tp :tabp<cr>
"map to :tabonly<cr>
"map tq :tabclose<cr>

"map H :tabp<cr>
"map L :tabn<cr>

map q :tabp<cr>
map r :tabn<cr>
map E <C-W><C-W>

" map a :tabp<cr>
" map f :tabn<cr>

" map <leader>te :tabnew<cr>
" map <leader>tn :tabn<cr>
" map <leader>tp :tabp<cr>
" map <leader>to :tabonly<cr>
" map <leader>tq :tabclose<cr>

"imap ii <esc>
"imap kj <esc>`^

" Yank text to the OS X clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y
" " Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" map esc to tab for all modes
""""nnoremap <Tab> <Esc>
""""vnoremap <Tab> <Esc>gV
""""onoremap <Tab> <Esc>`^
""""inoremap <Tab> <Esc>`^
""""inoremap <Leader><Tab> <Tab>
" inoremap <Tab><Tab> <Tab>

"""""""""""""""""""""""""""""""""""""""""""""""""
" VIM User interface
"""""""""""""""""""""""""""""""""""""""""""""""""
syntax on               " turn syntax highlighting on by default
filetype on             " detect type of file
filetype indent on      " load indent file for specific file type
filetype plugin on 
set autoread 			" auto read when file is changed from outside
set history=100 		" keep 100 lines of command list history 
set nocompatible        " use vim defaults
set scrolloff=2         " keep 3 lines when scrolling
set ai                  " set auto-indenting on for programming
set si					" smart indent
set showcmd             " display incomplete commands
" set listchars=tab:>~,nbsp:_,trail:.
" set list
set showmode
set laststatus=2 		" always show the status line
" Format the status line
set smarttab			" be smart when using tabs
set shiftwidth=4
set tabstop=4		
set expandtab
set wildmenu
set number              " show line numbers
set backspace=eol,start,indent " config backspace so it acts as it should act
set whichwrap+=<,>,h,l
" set relativenumber		" show relative line number
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


"""""--------- nice color scheme
syntax enable
set background=light
"colorscheme solarized
"colorscheme torte
colorscheme gruvbox

"""""--------- google color scheme ---------
"""""""syntax enable
"""""""set t_Co=256
"""""""set background=dark
"""""""colorscheme primary



"Resize splits when the window is resized
" au VimResized * exe "normal! \<c-w>="


""""""""""""""""""""""""""""""""""""""""""""""""
" GUI related settings
""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

highlight StatusLine guifg=SlateBlue guibg=Red
highlight StatusLineNC guifg=Gray guibg=Blue
" When use NERDTree, remove the left-most vertical scrollbar
set guioptions-=L
if has("gui_running")
	set guifont=Courier:h14
	set t_Co=256		" 256 color mode
	set cursorline		" highlight current line
endif
" set cursorline			" highlight current line
"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

""""""""""""""""""""""""""""""""""""""""""""""""
" Lightweight Latex editing
""""""""""""""""""""""""""""""""""""""""""""""""
" my paper related mappings
nmap <leader>l :w<cr>:!pdflatex<space>%<cr>:!open<space>dt.pdf<cr><cr>
nmap <leader>o :!open<space>dt.pdf<cr><cr>
nmap <leader>ll :w<cr>:!pdflatex<space>%<cr>:!bibtex<space>dt.aux<cr>:!pdflatex<space>%<cr>:!pdflatex<space>%<cr>:!open<space>dt.pdf<cr><cr>
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
" nmap <leader>b :w<cr>:call Compile()<cr>:call Run()<cr>
" nmap <leader>c :w<cr>:call Compile()<cr>
" nmap <leader>r :call Run()<cr>
" nmap <leader>d :call Debug()<cr>

" jump to next compile error
" map <leader>cn :cn<cr>
" jump to previous compile error
" map <leader>cp :cp<cr>
" jump to 1st compile error
" map <leader>cf :cr<cr>
" jump to the last compile error
" map <leader>cl :cla<cr>


" Easier to type, and I never use the default behavior.
" noremap H ^
" oremap L $
" noremap L g_

" map 00 I  " i want to make 00 as I, but it does not work. why?
" disable highlight

