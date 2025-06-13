" General Settings
lua require('config')

set nocompatible	" not compatible with the old-fashion vi mode
set bs=2		" allow backspacing over everything in insert mode
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set autoread		" auto read when file is changed from outside
set number
set showcmd
set noshowmode
set laststatus=2
set listchars=tab:>-,trail:·  " Show trailing whitespace
" set autochdir         " auto set working directory to the current file -breaks git 
set nomodeline          " Annoying error ex: 

" set leader to ,
let mapleader=","
let g:mapleader=","

" Enable plugins not in nvim (vscode)
if exists('g:vscode')
  nnoremap z= <Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>
  nnoremap H <Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>
  nnoremap L <Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>
  nnoremap <leader>rn <Cmd>call VSCodeNotify('editor.action.rename')<CR>
  nnoremap g[ <Cmd>call VSCodeNotify('editor.action.marker.next')<CR>
  nnoremap g] <Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>
  nnoremap gr <Cmd>call VSCodeNotify('references-view.findReferences')<CR>
  nnoremap <leader>t <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
  nnoremap <leader>gh <Cmd>call VSCodeNotify('openInGithub.openInGitHubFile')<CR>
  nnoremap <leader>ag <Cmd>call VSCodeNotify('runInSearchPanel', {'filesToInclude': '${workspaceFolder}', 'triggerSearch': true })<CR>
  let g:copilot_enabled = 0

  " Git lens
  map <leader>gc <Cmd>call VSCodeNotify('gitlens.compareHeadWith')<CR>
  map <leader>gs <Cmd>call VSCodeNotify('gitlens.showCommitInView')<CR>
  map <C-y> <TAB>
  map <leader>gd <Cmd>call VSCodeNotify('gitlens.diffLineWithWorking')<CR>

  " Folding
  nnoremap <silent> za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
  nnoremap <silent> zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>
  nnoremap <silent> zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>
  nnoremap <silent> zo <Cmd>call VSCodeNotify('editor.unfold')<CR>
  nnoremap <silent> zO <Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>
  nnoremap <silent> zc <Cmd>call VSCodeNotify('editor.fold')<CR>
  nnoremap <silent> zC <Cmd>call VSCodeNotify('editor.foldRecursively')<CR>
elseif has('nvim')
  let g:copilot_enabled = 1
  packadd plenary.nvim
  packadd diffview.nvim
  packadd vim-fugitive
  packadd coc.nvim  
"  packadd copilot.vim
  packadd vim-visual-multi


endif

"--------------------------------------------------------------------------- 
" PLUGIN SETTINGS
"--------------------------------------------------------------------------- 
" -- git 
" Map git blame 
map <leader>b :Git blame<CR>
map <leader>gs :Git show <cword><CR>
map <leader>gd :DiffviewOpen main<CR>
map <leader>gdh :Gvdiff head~<CR>

"-- Copilot 
" Toggle Copilot on or off 
function! ToggleCopilot() 
  if exists('g:copilot_enabled') && g:copilot_enabled == 1
    let g:copilot_enabled = 0
    echo "Copilot disabled"
  else 
    let g:copilot_enabled = 1
    echo "Copilot enabled"
  endif
endfunction
map <leader>fp :call ToggleCopilot()<CR>
map <leader>fc :call ToggleCopilot()<CR>


"-- local vim
let homedir = expand('~')
let whitelist_paths = glob(homedir . '/dev-tools/config/*', 0, 1)
call add(whitelist_paths, homedir . '/.journal')
let g:localvimrc_whitelist = whitelist_paths
let g:localvimrc_sandbox=0

"-- fzf 
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
map <C-p> :GFiles --cached --others --exclude-standard <CR>

"-- folding 
"set foldmethod=syntax " Try using tree-sitter
"set foldlevelstart=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable                     " Disable folding at startup.

"-- lightline 
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], 
      \             [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ] ],
      \   'right': [
      \              [ 'projectroot' ],
      \            ]
      \  },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'projectroot': 'ProjectRootForLightLine'
      \  },
      \ 'colorscheme': 'PaperColor',
      \ }

" -- get project root directory name 
function! ProjectRootForLightLine() 
  let dir = finddir('.git/..', expand('%:p:h').';')
  return fnamemodify(dir, ':t')
endfunction

"-- Language settings 
" If python, enable black formatter
if &filetype == 'python'
  packadd black
  nnoremap <buffer><silent> <c-q> <cmd>call Black()<cr>
  let g:python_recommended_style = 0
  let g:python_black_path = '/usr/local/bin/black'
  let g:python_black_args = '--line-length=88'
  let g:python_black_local_args = '--line-length=88'
  let g:python_black_local = 1
  let g:python_black_on_save = 1
  let g:python_black_on_write = 1
  let g:python_black_on_insert_leave = 1
  let g:python_black_on_insert_leave = 1
  let g:python_black_on_insert_leave = 1
endif

"-- ctags 
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" Explaination for the following 
" a: Access (or export) of class members
" i: Inheritance information
" l: Language of input file containing tag
" m: Implementation information
" n: Line number of tag definition
" S: Signature of routine (e.g. prototype or parameter list)
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]

let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ '*.md',
      \ '*.js', '*.d.ts',
      \ '*-lock.json', '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '*.json',
      \ '*.zip',
      \ '*.class',
      \ '*.sln',
      \ '*.tmp',
      \ '*.cache',
      \ 'tags*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

" coc (recommended settings)
set updatetime=300
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window.
if !exists('g:vscode')
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
  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gp :CocList diagnostics<CR>
  nmap <silent> g[ :call CocAction('diagnosticNext')<CR>
  nmap <silent> g] :call CocAction('diagnosticPrevious')<CR>
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)
endif

" In insert mode, use 'j' and 'k' for navigating Coc's suggestion window
inoremap <expr> j pumvisible() ? "\<C-n>" : "j"
inoremap <expr> k pumvisible() ? "\<C-p>" : "k"

" COC - fixes....

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"--------------------------------------------------------------------------- 

"--------------------------------------------------------------------------- 
" Custom Colors 
"--------------------------------------------------------------------------- 
set t_Co=256   " This is may or may not needed.
set background=light " light" or dark
colorscheme Black " Black or Light

highlight DiffAdd    cterm=bold ctermbg=17 gui=none guifg=none guibg=#4b5632
highlight DiffDelete cterm=bold ctermbg=17 gui=none guifg=none guibg=#9b5632
highlight DiffChange cterm=bold ctermbg=17 gui=none guifg=none guibg=#6b5632
highlight DiffText   cterm=bold ctermbg=88 gui=none guifg=none guibg=88
"--------------------------------------------------------------------------- 

"--------------------------------------------------------------------------- 
" More general settings 
"--------------------------------------------------------------------------- 
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vim/.vimrc

" To exit ternimal insert mode with just Ctrl-N
tnoremap <C-n> <C-\><C-n>

" syntax on " syntax highlight --- try using tree-sitter
set re=0
set hlsearch		" search highlighting

set clipboard=unnamed	" yank to the system register (*) by default
set showmatch		" Cursor shows matching ) and }
set showmode		" Show current mode
set wildchar=<TAB>	" start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set autoindent		" auto indentation
set incsearch		" incremental search
set nobackup		" no *~ backup files
set copyindent		" copy the previous indentation on autoindenting
set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab		" insert tabs on the start of a line according to context
set undofile            " Save undo's after file closes
if has('nvim')
  set undodir=~/.nvim/undodir
  set shadafile=~/.nvim/.viminfo
else 
  set undodir=~/.vim/undodir
  set viminfofile=~/.vim/.viminfo
endif
set undolevels=500      " How many undos
set undoreload=10000    " Number of lines to save for undos
set backupdir=.backup/,~/tmp//,/tmp//
set directory=.swp/,~/tmp//,/tmp//


" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" TAB setting
set expandtab        "replace <TAB> with spaces
set softtabstop=2
set tabstop=2
set shiftwidth=2 

au FileType Makefile set noexpandtab

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


"--------------------------------------------------------------------------- 
" USEFUL SHORTCUTS
"--------------------------------------------------------------------------- 

if !exists('g:vscode')
  packadd nerdtree
  map <leader>t :NERDTreeFind<cr>
  map <leader>c :NERDTreeToggle<cr>
  map <leader>ya :%y<cr>
  let NERDTreeIgnore = ['\.d.ts$', '\.d.ts.map$']
  let g:NERDTreeWinSize=40
endif

function! Ijs() 
  let g:NERDTreeIgnore = ['\.d.ts$', '\.d.ts.map$', '\.js$']
endfunction

function! BranchName ()
  let g:branchName = system("git branch --show-current")
  echo g:branchName
endfunction

" Function to execute nodedev command
function! RunNodeDev()
  " Copy file name to clipboard
  let @+ = expand('%')
  " Execute nodedev command in shell
  :!nodedev
endfunction
" Map <leader>d to the RunNodeDev function
nnoremap <leader>d :call RunNodeDev()<CR>

"Open notes
map <leader>n :vsp<CR>:e ~/.journal/notes.md<CR>
map <leader>do :vsp<CR>:e ~/.journal/todo.md<CR>

" open the error console
map <leader>cc :botright cope<CR> 
" move to next error
map <leader>] :cn<CR>
" move to the prev error
map <leader>[ :cp<CR>

" GoTo file in split
map <C-g> :let mycurf=expand("<cfile>")<cr><c-w> w :execute("e ".mycurf)<cr><c-w>p

" --- move around splits {
map <C-J> <C-W>j
map <C-K> <C-W>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l
set wmw=0                     " set the min width of a window to 0 so we can maximize others 
set wmh=0                     " set the min height of a window to 0 so we can maximize others
" }

" move around tabs. conflict with the original screen top/bottom
" comment them out if you want the original H/L
if !exists('g:vscode')
  " go to prev tab 
  map <S-H> gT
  " go to next tab
  map <S-L> gt
endif

" new tab
nnoremap <C-t><C-t> :tabnew<CR>
" close tab
map <C-t><C-w> :tabclose<CR> 

" ,/ turn off search highlighting
nmap <leader>/ :nohl<CR>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" Replace the word with yank (sends current word to null register
nnoremap <leader>r "_diwP

"--------------------------------------------------------------------------- 
" PROGRAMMING SHORTCUTS
"--------------------------------------------------------------------------- 

" Enable omni completion. (Ctrl-X Ctrl-O)
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
              \	if &omnifunc == "" |
              \		setlocal omnifunc=syntaxcomplete#Complete |
              \	endif
endif

set cot-=preview "disable doc preview in omnicomplete

" make CSS omnicompletion work for SASS and SCSS
autocmd BufNewFile,BufRead *.scss             set ft=scss.css
autocmd BufNewFile,BufRead *.sass             set ft=sass.css

"--------------------------------------------------------------------------- 
" ENCODING SETTINGS
"--------------------------------------------------------------------------- 
set encoding=utf-8                                  
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

fun! ViewUTF8()
	set encoding=utf-8                                  
	set termencoding=big5
endfun

fun! UTF8()
	set encoding=utf-8                                  
	set termencoding=big5
	set fileencoding=utf-8
	set fileencodings=ucs-bom,big5,utf-8,latin1
endfun

fun! Big5()
	set encoding=big5
	set fileencoding=big5
endfun


function! Hey() 
  let ok = system('echo hey '.shellescape(expand('%')).' 2>/dev/null')
  echo ok
endfunction

"--------------------------------------------------------------------------- 
" Plugin Idea - Open selected text on SourceGraph
"--------------------------------------------------------------------------- 
fu! OpenInEnglogs() 
  echom "someday i'll figure out how to open this automatically..." 
  echom "https://logging.eng.convoy.com/_plugin/kibana/app/kibana#/discover?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-1hr,to:now))&_a=(columns:!(message),filters:!(),index:'13660d70-91b7-11eb-a6ac-11c8977654bf',interval:auto,query:(language:lucene,query:'".s:get_visual_selection()."'),sort:!())"
endfunction

xnoremap <leader>el :call OpenInEnglogs()<CR>

"--------------------------------------------------------------------------- 
" Helper Functions
"--------------------------------------------------------------------------- 
" Working

" Not working 
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

"--------------------------------------------------------------------------- 
" Define a custom command to copy the relative file path to clipboard
nnoremap <leader>y :let @+ = expand('%')<CR>
" Function to copy all buffer paths in current tab to clipboard
function! CopyAllBufferPaths()
    let paths = []
    " Loop through all windows in current tab
    for winnr in range(1, winnr('$'))
        " Get buffer number for each window
        let bufnr = winbufnr(winnr)
        " Get buffer name/path
        let bufname = bufname(bufnr)
        " Check if buffer is valid and not NERDTree
        if bufname != '' && bufname !~ 'NERD_tree'
            " Get relative path
            let relpath = fnamemodify(bufname, ':.')
            call add(paths, relpath)
        endif
    endfor
    " Join paths with newlines and copy to clipboard
    let @+ = join(paths, "\n")
    echo "Copied " . len(paths) . " file paths to clipboard"
endfunction

" Map it to a key combination (e.g., <leader>Y)
nnoremap <leader>Y :call CopyAllBufferPaths()<CR>

"--------------------------------------------------------------------------- 
" Sessions
"--------------------------------------------------------------------------- 
fu! SaveSesh() 
  tabdo NERDTreeClose
  let name = system("seshname")
  echo name
  exec "mks! ".name
endfunction

map <C-s> :call SaveSesh()<CR>

fu! Loadit() 
  let s:vimrc = getcwd()."/.vim/.vimrc"
  if filereadable(s:vimrc)
    echo "Found a local vimrc file, sourcing it.."
    echo s:vimrc
  else 
    echo "No local vimrc found ".s:vimrc
  endif
endfunction

" Load other vimrc configs
source ~/.config/nvim/config/snippets.vim

