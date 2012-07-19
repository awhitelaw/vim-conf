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
	" Vundle {
		set rtp+=~/.vim/bundle/vundle
		call vundle#rc()
		Bundle 'gmarik/vundle'
	" }
	
	" DEPENDENCIES {
		Bundle 'MarcWeber/vim-addon-mw-utils'
		Bundle 'tomtom/tlib_vim'
		if executable('ack')
			Bundle 'mileszs/ack.vim'
		endif
	" }
	
	" Theme {
		Bundle 'flazz/vim-colorschemes'
		Bundle 'nanotech/jellybeans.vim'
		Bundle 'chriskempson/vim-tomorrow-theme'
		Bundle 'altercation/vim-colors-solarized'
	" }
	
	" General {
		"File Explorer"
		Bundle 'scrooloose/nerdtree'
		"Make NERDTree act more like an IDE file explorer by having it always present across tabs"
		Bundle 'jistr/vim-nerdtree-tabs'
		"Text-mate like snippets"
		Bundle 'garbas/vim-snipmate'
		"Surroundings management. Add xml/html surroundings or brackets, speech marks etc"
		Bundle 'tpope/vim-surround'
		"Autoclose quotes, tags etc"
        Bundle 'AutoClose'
		"Full path fuzzy file, buffer, mru, tag, ... finder for Vim."
        Bundle 'kien/ctrlp.vim'
		"Improved Matching from %"
		Bundle 'matchit.zip'
		"Status line modifier"
		Bundle 'Lokaltog/vim-powerline'
		"EasyMotion provides a much simpler way to use some motions in vim"
		Bundle 'Lokaltog/vim-easymotion'
		"Colour scheme helper for terminal Vim from Gvim colourshemes"
		Bundle 'godlygeek/csapprox'
		"Easier buffer exploration"
		Bundle 'corntrace/bufexplorer'
	" }

	" Programming {
		
		" General {
			"Syntax validation"
			Bundle 'scrooloose/syntastic'
			"Code comments on steroids"
			Bundle 'scrooloose/nerdcommenter'
			"Some formatting niceties"
			Bundle 'godlygeek/tabular'
			"Provide an overview of current funcs class etc like an IDE"
			if executable('ctags')
				Bundle 'majutsushi/tagbar'
			endif
			"Some nice autocompletion"
			Bundle 'Shougo/neocomplcache'
			"Autocomplete simplifier using the tab key"
			Bundle 'ervandew / supertab'
		" }
		
		
		" PHP {
			"Designed to provide PHP support"
			Bundle 'spf13/PIV'
		" }
	" }
		
	" Version Control {
		"GIT wrapper"
		Bundle 'tpope/vim-fugitive'
	" }
" }


" THEME SET {
	if filereadable(expand("~/.vim/bundle/jellybeans.vim/colors/jellybeans.vim"))
		set background=dark
		colorscheme jellybeans 
	endif
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

	" Use ; instead of : so ;w or ;q works
	nnoremap ; :

	" cd to to the directory of the current file in the window 
	autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
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
	
	
	if has('cmdline_info')
		set ruler                   " show the ruler
		set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
	    set showcmd                 " show partial commands in status line and
	                                " selected characters/lines in visual mode
	endif


	if has('statusline')
		set laststatus=2									" Broken down into easily includeable segments
		set statusline=%<%f\								" Filename
		set statusline+=%w%h%m%r							" Options
		set statusline+=%{fugitive#statusline()}	        "  Git Hotness
		set statusline+=\ [%{&ff}/%Y]                       " filetype
		set statusline+=\ [%{getcwd()}]                     " current dir
		set statusline+=%=%-14.(%l,%c%V%)\ %p%%              "Right aligned file nav info
	endif
" }

" Sounds {
	set noerrorbells
	set novisualbell
	set t_vb=
" }






" PLUGINS{
	
	" NERDTree {
		if filereadable(expand('~/.vim/bundle/nerdtree/README.markdown'))
			map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
			map <leader>e :NERDTreeFind<CR>
			nmap <leader>nt :NERDTreeFind<CR>

			let NERDTreeShowBookmarks=1
			let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
			let NERDTreeChDirMode=0
			"let NERDTreeQuitOnOpen=1
			let NERDTreeShowHidden=1
			let NERDTreeKeepTreeInNewTab=1
	
			au VimEnter *  NERDTree                         " Auto open NERDTree when vim opens
		endif		
	" }

" }
