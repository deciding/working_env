" VIM Configuration File
" Description: created for C/C++ development, but is useful for other things as well
" Author: Zining Zhang
" Last updated: July 06 2020

" I like the desert theme the best
color desert
" turn syntax highlighting on
set t_Co=256

let Tlist_Use_Right_Window   = 1
let g:NERDTreeWinSize = 20
let g:Tlist_WinWidth = 20
au VimEnter *  NERDTree
au VimEnter *  TlistOpen
autocmd VimEnter * wincmd h
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :TlistToggle<CR>
nnoremap <F4> :set nu!<CR>

let g:ycm_global_ycm_extra_conf = '~/.vim/pack/plugins/start/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
nnoremap gd :YcmCompleter GoToDefinition<CR>

" execute pathogen#infect()

syntax on
" set the hightlight for search, with background black and red font
set hlsearch
hi Search ctermbg=black
hi Search ctermfg=Red

" Set no backup, avoids creating extra files by vim
set nobackup

"folding settings  
" zc folds at the current place
" zM folds everything
" zR unfolds everything
" za toggle folding
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=2         "this is just what i use

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" disable vi compatibility (emulation of old bugs)
set nocompatible
"enable filetype
filetype plugin on
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is no longer the norm
set textwidth=120
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
" c++ indent
set cindent
set cinoptions=g0
retab
"enable python syntax
let python_highlight_all = 1

" Auto complete using clang_complete
" 1. Install libclang-dev
" 2. Ensure python 2 support is enabled in vim (otherwise build vim with it)
" 3. Install clang_complete from here https://www.vim.org/scripts/script.php?script_id=3302 
" 4. Install libclang1 in ubuntu or libclang in other distro; ensure libclang.so is available
let g:clang_user_options="-std=c++0x"

" Install DoxygenToolkit from http://www.vim.org/scripts/script.php?script_id=987
let g:DoxygenToolkit_authorName="Zining Zhang <zhangzn710@gmail.com>"

" Enhanced keyboard mappings
" switch between header/source with F4
" map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Build gcc, g++ or python code from here <Shift F8>
autocmd FileType c nnoremap <buffer> <S-F8> :update<bar>!gcc -Werror % && ./a.out<CR>
autocmd FileType c nnoremap <buffer> <S-F9> :update<bar>!gcc -g -Werror % && gdb ./a.out<CR>
autocmd FileType cpp nnoremap <buffer> <S-F8> :update<bar>!g++ -Werror -std=c++17 % && ./a.out<CR>
autocmd FileType cpp nnoremap <buffer> <S-F9> :update<bar>!g++ -g -Werror % && gdb ./a.out<CR>
autocmd FileType python nnoremap <buffer> <S-F8> :update<bar>!sudo python3 %<CR>
autocmd FileType go  nnoremap <buffer> <S-F8> :update<bar>!go build %<CR>

" Auto build using make with <F5>
map <F5> :make<CR>
" Auto build using make with <S-F7>
map <S-F9> :make clean all<CR>
" recreate tags file with <F7>, needs ctags installed
map <F7> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR>
" create doxygen comment with <F6>
map <F6> :Dox<CR>
" goto definition with F12
map <S-F12> <C-]>

" auto cmd to add c header
autocmd bufnewfile *.c so ~/.vim/c_header
autocmd bufnewfile *.c exe "1," . 10 . "g/File Name :.*/s//File Name : " .expand("%")
autocmd bufnewfile *.c exe "1," . 10 . "g/Creation Date :.*/s//Creation Date : " .strftime("%d-%m-%Y")
autocmd Bufwritepre,filewritepre *.c execute "normal ma"
autocmd Bufwritepre,filewritepre *.c exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
autocmd bufwritepost,filewritepost *.c execute "normal `a"
" auto cmd to add cpp header
autocmd bufnewfile *.cpp so ~/.vim/cpp_header
autocmd bufnewfile *.cpp exe "1," . 10 . "g/File Name :.*/s//File Name : " .expand("%")
autocmd bufnewfile *.cpp exe "1," . 10 . "g/Creation Date :.*/s//Creation Date : " .strftime("%d-%m-%Y")
autocmd Bufwritepre,filewritepre *.cpp execute "normal ma"
autocmd Bufwritepre,filewritepre *.cpp exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
autocmd bufwritepost,filewritepost *.cpp execute "normal `a"
" auto cmd to add go header
autocmd bufnewfile *.go so ~/.vim/go_template
autocmd bufnewfile *.go exe "1," . 10 . "g/File Name :.*/s//File Name : " .expand("%")
autocmd bufnewfile *.go exe "1," . 10 . "g/Creation Date :.*/s//Creation Date : " .strftime("%d-%m-%Y")
autocmd Bufwritepre,filewritepre *.go execute "normal ma"
autocmd Bufwritepre,filewritepre *.go exe "1," . 10 . "g/Last Modified :.*/s/Last Modified :.*/Last Modified : " .strftime("%c")
autocmd bufwritepost,filewritepost *.go execute "normal `a"
"execute retab  on write
autocmd BufWritePost,filewritepost *.c :retab
autocmd BufWritePost,filewritepost *.py :retab
autocmd BufWritePost,filewritepost *.go :retab
autocmd BufWritePost,filewritepost *.cpp :retab
autocmd BufWritePost,filewritepost *.js :retab

if has("autocmd")
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

endif

function! CompileAndViewAssembly()
    " Path to where you want to save the compiled output and assembly
    let output_file = '/tmp/output'
    let assembly_file = '/tmp/output.asm'

    " let include_paths = ['/usr/include/eigen3']
    " Get the CPLUS_INCLUDE_PATH environment variable
    let cplus_include_path = getenv('CPLUS_INCLUDE_PATH')

    " Check if the CPLUS_INCLUDE_PATH is not empty
    if !empty(cplus_include_path)
        " Split the paths into a list of strings
        let include_paths = split(cplus_include_path, ':')
        " Now, you have a list of paths in cplus_include_path_list
    else
        echo "CPLUS_INCLUDE_PATH is not set"
    endif
    " Compile the C++ code, replacing % with your current file name
    let include_args = join(map(copy(include_paths), '"-I" . v:val'), ' ')
    execute '!g++ -g -O0 -mavx -o ' . output_file . ' ' . include_args . ' ' . expand('%')

    " Generate the assembly code
    execute '!objdump -d ' . output_file . ' > ' . assembly_file

    " Check if the new split is already open, don't open it again
    let windows = filter(range(1, winnr('$')), 'getwinvar(v:val, "&filetype") ==# "asm"')
    if empty(windows)
        " Open the assembly file in a vertical split on the right
        execute 'vsplit ' . assembly_file
        setlocal filetype=asm  " To ensure syntax highlighting, if you have it for asm files
    else
        " Bring the cursor to the assembly window if it's already open
        execute windows[0] . 'wincmd w'
    endif

    " Optional: Jump back to the original C++ source file window
    "wincmd p
endfunction

" Map 'ga' to the custom function in normal mode
nnoremap ga :call CompileAndViewAssembly()<CR>
