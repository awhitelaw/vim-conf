" INITIAL {
	set nocompatible									" Disable Vi compatibility (required)
	
	" Windows Compat {
		" Force windows to use .vim instead of vimfiles.
		if has('win32') || has('win64')                           
			set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
		endif
	" }	
" }




" BUNDLES {
	source ~/.vim/vimrc/bundles/Vundle.vim
	source ~/.vim/vimrc/bundles/Dependencies.vim
	" Theme {
		source ~/.vim/vimrc/bundles/themes.vim	
	" }

	" Programming {
		
		" General {
			source ~/.vim/vimrc/bundles/NERDTree.vim
			source ~/.vim/vimrc/bundles/snipmate.vim
			Bundle 'scrooloose/syntastic'
		" }
	" }
	
	" Version Control {
		
	" }
" }




" GENERAL {

	filetype plugin indent on							" Detect by filetype
	set mouse=a											" Enable mouse
	scriptencoding utf-8								" A must
	set encoding=utf8									" Necessary?

	set hidden											" Allow buffer switching without saving
	set shortmess+=filmnrxoOtT							" Message abbreviation
	set spell											" Enable spellchecking
	
	noremap , \
	let mapleader=","									" Change the default leader key

" }

" Backups {
	set backup
	set backupdir=~/.vim/backup
	set directory=~/.vim/tmp
" }


" Formatting {
	syntax on											" Lovely syntax highlighting
	set autoindent								        " indent at the same level of the previous line
	set cindent
	set shiftwidth=4									" use indents of 4 spaces
	"set expandtab										" tabs are spaces, not tabs
	set tabstop=4										" an indentation every four columns
	set softtabstop=4									" let backspace delete indent
	set pastetoggle=<F12>						        " pastetoggle (sane indentation on pastes)
	"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
	" Remove trailing whitespaces and ^M chars
	autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" }


" Search {
	set ignorecase										" case-insensitive search
	set smartcase										" non-case search
	set incsearch
	set hlsearch
	set wildmenu
	set wildmode=list:longest,full
    set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,.sass-cache,*.class,*.scssc	
" }


" UI {	
	

	set tabpagemax=15									" only show 15 tabs
	set showmode										" display the current mode
	set cursorline										" highlight current line
	set nu												" show line numbers
	set nowrap											" turn off line wrapping
	set backspace=indent,eol,start						" Common backspace rule
	set linespace=0										" No extra line space
	set showmatch										" opening/closing highlighting
	set matchtime=2										" Match blink in seconds
	set whichwrap=b,s,h,l,<,>,[,]				   		" backspace and cursor keys wrap to
	set scrolljump=5			            			" lines to scroll when cursor leaves screen
	set scrolloff=3								 		" minimum lines to keep above and below cursor
	set foldenable										" auto fold code
	"set list
	"set listchars=tab:,.,trail:.,extends:#,nbsp:.		" Highlight problematic whitespace
" }

" Sounds {
	set noerrorbells
	set novisualbell
	set t_vb=
" }

