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
Plugin 'Valloric/YouCompleteMe'
"Plugin 'vim-scripts/Conque-GDB'
Plugin 'tmhedberg/SimpylFold'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tell-k/vim-autopep8'
Plugin 'sirver/ultisnips'
"find . -name '*.py' -exec autopep8 --in-place '{}' \;
"Plugin 'KangOl/vim-pudb'
"Plugin 'szymonmaszke/vimpyter' "Vundle
"Plugin 'vim-python/python-syntax'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'ervandew/supertab'
"Plugin 'w0rp/ale'

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

let g:ycm_autoclose_preview_window_after_completion=1
let Tlist_Use_Right_Window   = 1
let g:python_highlight_all = 1
"let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_quiet_messages = {
        \ "!level":  "errors",
        \ "type":    "style"}
let g:syntastic_python_checkers = ['flake8']
let g:NERDTreeWinSize = 20
let g:Tlist_WinWidth = 20

" let g:jedi#completions_command = "<C-N>"
"let g:SuperTabDefaultCompletionType = "context"
"let g:jedi#popup_on_dot = 0
"let g:ale_linters = {'python': ['flake8', 'pylint']}
"let g:ale_linters_ignore = {'python': ['pylint']}
"let g:ale_fixers = {'python': ['autopep8']}
"let g:ale_fix_on_save = 1

au VimEnter *  NERDTree
au VimEnter *  TlistOpen
autocmd VimEnter * wincmd h

" allow toggling between local and default mode
function TabToggle()
  if &expandtab
    set shiftwidth=8
    set softtabstop=0
    set noexpandtab
  else
    set shiftwidth=4
    set softtabstop=4
    set expandtab
  endif
endfunction

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(compile(open(activate_this, "rb").read(), activate_this, 'exec'), dict(__file__=activate_this))
EOF

" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <silent> gb :YcmCompleter GoToDefinitionElseDeclaration<CR>
" nnoremap <silent> gb :YcmCompleter GoToDefinition<CR>
nnoremap <F5> :set invnumber<CR>:NERDTreeToggle<CR>:TlistToggle<CR>
nnoremap <F6> :NERDTreeToggle<CR>
nnoremap <F7> :TlistToggle<CR>
" nnoremap <F9> mz:execute TabToggle()<CR>'z
nnoremap <F3> :Autopep8<CR>
inoremap <C-D> <C-O>x
nnoremap <C-M> <C-W>50>
nnoremap <C-N> <C-W>50<
nnoremap cj ct_
nnoremap cl ct'
nnoremap cL ct"
nnoremap co ct(
nnoremap cp ct)
nnoremap cn ct,
nnoremap cm ct.
nnoremap ck ct:
nnoremap <F8> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
nnoremap <F9> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>
vnoremap <F8> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
vnoremap <F9> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>
"nnoremap <F8> :TogglePudbBreakPoint<CR>
"nnoremap <C-J> <C-W>j
"nnoremap <C-K> <C-W>k
"nnoremap <C-L> <C-W>l
"nnoremap <C-H> <C-W>h
" Enable folding with the spacebar
nnoremap <space> za

set exrc
set secure
" Enable folding
set foldmethod=indent
set foldlevel=99

filetype plugin indent on
syntax on

syntax enable
set tabstop=4
set shiftwidth=4
set expandtab
set number
filetype indent on
set autoindent

set encoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set termencoding=utf-8

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
