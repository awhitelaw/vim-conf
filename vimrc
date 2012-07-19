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
		"Session Helper"
		Bundle 'vim-scripts/sessionman.vim'
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
		" }
		
		"HTML {
			Bundle 'HTML-AutoCloseTag'
            Bundle 'ChrisYip/Better-CSS-Syntax-for-Vim'
		" }

		" Javascript {
			Bundle 'leshill/vim-json'
            Bundle 'groenewege/vim-less'
            Bundle 'taxilian/vim-web-indent'
		" }


		" PHP {
			"Designed to provide PHP support"
			Bundle 'spf13/PIV'
		" }
		
		" Python { 
			Bundle 'klen/python-mode'
			Bundle 'python.vim'
			Bundle 'python_match.vim'
			Bundle 'pythoncomplete'
		" }

		" Ruby { 
			Bundle 'tpope/vim-rails'
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


	" GUI Settings {
		" GVIM- (here instead of .gvimrc)
		if has('gui_running')
			set guioptions-=T           " remove the toolbar
			set lines=40                " 40 lines of text instead of 24,
			if has("gui_gtk2")
				set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 12,Consolas\ Regular\ 12,Courier\ New\ Regular\ 12
			else
				set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h12,Consolas\ Regular:h12,Courier\ New\ Regular:h12
			endif
			if has('gui_macvim')
				set transparency=5          " Make the window slightly transparent
			endif
		else
			if &term == 'xterm' || &term == 'screen'
				set t_Co=256                 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
			endif
			"set term=builtin_ansi       " Make arrow and other keys work
		endif
	" }

" }

" Sounds {
	set noerrorbells
	set novisualbell
	set t_vb=
" }






" PLUGINS{
	" AutoCloseTag {
		" Make it so AutoCloseTag works for xml and xhtml files as well
		au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
		nmap <Leader>ac <Plug>ToggleAutoCloseMappings
	" }
	
	" Buffer explorer {
		nmap <leader>b :BufExplorer<CR>
	" }

	" Ctags {
      	set tags=/.vim/tags
  	" }

	" ctrlp {
		let g:ctrlp_working_path_mode = 2
		nnoremap <silent> <D-t> :CtrlP<CR>
		nnoremap <silent> <D-r> :CtrlPMRU<CR>
		let g:ctrlp_custom_ignore = {
				\ 'dir':  '\.git$\|\.hg$\|\.svn$',
				\ 'file': '\.exe$\|\.so$\|\.dll$' }
	"}

	" Fugitive {	
		nnoremap <silent> <leader>gs :Gstatus<CR>
		nnoremap <silent> <leader>gd :Gdiff<CR>
		nnoremap <silent> <leader>gc :Gcommit<CR>
		nnoremap <silent> <leader>gb :Gblame<CR>
		nnoremap <silent> <leader>gl :Glog<CR>
		nnoremap <silent> <leader>gp :Git push<CR>
	" }

	" JSON {
      	nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
   	" }

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
	
	" Misc {
      	let g:NERDShutUp=1
      	let b:match_ignorecase = 1
  	" }
	
	" neocomplcache {
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_camel_case_completion = 1
        let g:neocomplcache_enable_smart_case = 1
        let g:neocomplcache_enable_underbar_completion = 1
        let g:neocomplcache_min_syntax_length = 3
        let g:neocomplcache_enable_auto_delimiter = 1

        " AutoComplPop like behavior.
        let g:neocomplcache_enable_auto_select = 0

        " SuperTab like snippets behavior.
        imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

        " Plugin key-mappings.
        imap <C-k>     <Plug>(neocomplcache_snippets_expand)
        smap <C-k>     <Plug>(neocomplcache_snippets_expand)
        inoremap <expr><C-g>     neocomplcache#undo_completion()
        inoremap <expr><C-l>     neocomplcache#complete_common_string()


        " <CR>: close popup
        " <s-CR>: close popup and save indent.
        inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
        inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup() "\<CR>" : "\<CR>"
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplcache#close_popup()
        inoremap <expr><C-e>  neocomplcache#cancel_popup()

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        " Enable heavy omni completion.
        if !exists('g:neocomplcache_omni_patterns')
            let g:neocomplcache_omni_patterns = {}
        endif
        let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
        "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
        let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
        let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif

     " }

	" OmniComplete {
		if has("autocmd") && exists("+omnifunc")
			autocmd Filetype *
						\if &omnifunc == "" |
						\setlocal omnifunc=syntaxcomplete#Complete |
						\endif
		endif

		hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
		hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
		hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

		" some convenient mappings
		inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
		inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
		inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
		inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
		inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
		inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

		" automatically open and close the popup menu / preview window
		au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
		set completeopt=menu,preview,longest
    " }


	" PIV {
      	let g:DisableAutoPHPFolding = 0
      	let g:PIVAutoClose = 0
   	" }
	
	" PyMode {
       	let g:pymode_lint_checker = "pyflakes"
   	" }
	
	" Python {
		" Disable if python is not available
		if !has('python')
           let g:pymode = 1
        endif
	" }

	" Session List {
       	set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
       	nmap <leader>sl :SessionList<CR>
       	nmap <leader>ss :SessionSave<CR>
   	" }

	" Tabularize {
        if exists(":Tabularize")
          nmap <Leader>a= :Tabularize /=<CR>
          vmap <Leader>a= :Tabularize /=<CR>
          nmap <Leader>a: :Tabularize /:<CR>
          vmap <Leader>a: :Tabularize /:<CR>
          nmap <Leader>a:: :Tabularize /:\zs<CR>
          vmap <Leader>a:: :Tabularize /:\zs<CR>
          nmap <Leader>a, :Tabularize /,<CR>
          vmap <Leader>a, :Tabularize /,<CR>
          nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
          vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

          " The following function automatically aligns when typing a
          " supported character
          inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

          function! s:align()
              let p = '^\s*|\s.*\s|\s*$'
              if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
                  let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
                  let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
                  Tabularize/|/l1
                  normal! 0
                  call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
              endif
          endfunction

        endif
 	" }


	" TagBar {
       	nnoremap <silent> <leader>tt :TagbarToggle<CR>
   	"}

" }

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" Use local gvimrc if available and gui is running {
    if has('gui_running')
        if filereadable(expand("~/.gvimrc.local"))
            source ~/.gvimrc.local
        endif
    endif
" }
