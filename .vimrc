set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

"Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'vim-scripts/Conque-GDB'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-python/python-syntax'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'w0rp/ale'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

let Tlist_Use_Right_Window   = 1
let g:python_highlight_all = 1
" let g:jedi#completions_command = "<C-N>"
let g:SuperTabDefaultCompletionType = "context"
let g:jedi#popup_on_dot = 0
let g:ale_linters = {'python': ['flake8', 'pylint']}
let g:ale_linters_ignore = {'python': ['pylint']}
let g:ale_fixers = {'python': ['autopep8']}
let g:ale_fix_on_save = 1

au VimEnter *  NERDTree
"au VimEnter *  TlistOpen

set exrc
set secure
filetype plugin indent on
syntax on

syntax enable
set tabstop=4
set shiftwidth=4
set expandtab
set number
filetype indent on
set autoindent
