" Stefan's .vimrc file, loosely based on ~stefanl/.exrc
"
" $Id: .vimrc 305 2014-05-17 15:23:35Z stefanl $ 

""" Use Vundle -- Vim bundles
" See https://github.com/gmarik/Vundle.vim/blob/master/README.md
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Other Vundles
 
"" rodjek/vim-puppet 
Plugin 'rodjek/vim-puppet'

"" Indenting for vim-puppet, etc.
Plugin 'godlygeek/tabular'

"" Vundle https://github.com/plasticboy/vim-markdown
"" I like Markdown for personal documentation
Plugin 'plasticboy/vim-markdown'

let g:vim_markdown_folding_disabled=1
let g:vim_markdown_initial_foldlevel=1

"" Solarized plugin
Plugin 'altercation/vim-colors-solarized'

"" plugins from http://vim-scripts.org/vim/scripts.html
"" DirDiff -- For effective diffing of directories within Vim
Plugin 'DirDiff.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :so ~/.vimrc           - Reload .vimrc
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""" End Vundle

""" Themes
" I want a black background. This removes conflicting colors, such as 'Blue'
"colorscheme ir_black
colorscheme chocolate
"set background=dark

""" tab and formatting options
" I prefer to indent with spaces, not tabs. And I want shorter looking tabs.
set expandtab
set shiftwidth=4
set tabstop=4
set noautoindent

""" Print whitespace characters
"set list

""" Set options based on the Vim version.
"
"" 'listchars'. In 'list' mode, print these strings instead of the default.
" http://vimdoc.sourceforge.net/htmldoc/options.html#%27listchars%27
" The command :dig displays other digraphs you can use.

" Make sure your terminal supports these characters
" Display tabs with "»·····" trailing spaces with elipses
"
"" If vim6, update the runtimepath to be .vim6 if we're using older version of Vim.
if v:version < 700
    " Use the ~/.vim6 directory on hosts which run Vim 6
    let &runtimepath=substitute(&runtimepath, '\.vim', '&6', 'g')
    "set listchars=tab:.\ ,trail:.
    set listchars=tab:>-,trail:-
else
    " Otherwise, assume .vim7 or newer
    " Some of these options only supported on vim7+
    " http://vim.wikia.com/wiki/Highlight_unwanted_spaces#Using_the_list_and_listchars_options
    " Some of these options only supported on vim7+
    " Enter the middle-dot by pressing Ctrl-k then .M
    " Enter the right-angle-quote by pressing Ctrl-k then >>
    " Enter the Pilcrow mark by pressing Ctrl-k then PI
    set listchars=tab:»·,trail:·,eol:¶,precedes:<,extends:>

	" And a test of tab and trailing whitespace   

    " Older tries
    "set listchars=tab:».,trail:.
    "set listchars=tab:>-,trail:.,extends:>
    "set listchars=tab:\|.,trail:.
    "set listchars=tab:\|·,trail:·
    "set listchars=tab:»·,trail:·,extends:…,nbsp:‗,eol:¶
    "set listchars=tab:»·,trail:·,precedes:^,extends:…,nbsp:‗,eol:¶
    "set listchars=eol:¶ " Display end-of-line character with a Pilcrow character
    " http://vim.wikia.com/wiki/Highlight_unwanted_spaces#Showing_long_lines
    "set listchars=precedes:<,extends:>
endif

" Misc mappings. I forget what these do.
"map g 1G
"map - 
"map _ 
"map + 
"map = 

""""""""""""""""""""""""""""""""
" Windows keyboard emulation
" Page up
map [5~ 
" Page down
map [6~ 
" Insert key starts insert mode
map [2~ i
" Delete key same as 'x' , deletes current char
map  x
" Home/End keys do not print to terminal 
" Home
map [1~ ^
" End
map [4~ $
""""""""""""""""""""""""""""""""

set directory=~/tmp

" Show the mode, like Insert, Replace or Visual mode 
set showmode

" set guioptions=-t  " Disable gui on buggy systems
" set mouse=a        " Less mouse interaction

""" Status line
" Always enable the status line
set laststatus=2
" Print an informative status line, like
" .vimrc 88% [POS=55,1] [LEN=75] [[73%] TYPE=VIM] 
set statusline=%t\ %P\ [POS=%l,%v]\ [LEN=%L]\ [[%p%%]\ TYPE=%Y]

"Show the line and column number of the cursor position in the lower right corner
set ruler

" Syntax highlighting
if !exists("syntax_on")
	syntax on
endif

" Use search highlighting
set hlsearch
