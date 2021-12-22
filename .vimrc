
" https://web.archive.org/web/20180106045128/https://dougblack.io/words/a-good-vimrc.html

" TODO to read - power of g, highlight tabs
" TODO make it not wrap up lines

" apply the command in the last line only for this file
set modelines=1


if has("gui_running")
    " GUI is running or is about to start.
    " Maximize gvim window (for an alternative on Windows, see simalt below).
    set lines=50 columns=100
else
    " This is console Vim.
    " the below re-sizes the terminal window
    "if exists("+lines")
    "    set lines=50
    "endif
    "if exists("+columns")
    "    set columns=110
    "endif
endif


" plugins {{{
" apparently plugins block needs to come first

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'preservim/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :VundleInstall    - this actually worked for me, rather than PluginInstall
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" }}}


" misc {{{

" highlight last inserted text
nnoremap gV `[v`]

" Don't try to be vi compatible
set nocompatible

" Turn on syntax highlighting
syntax on

" edit vimrc/bashrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>eb :vsp ~/.bashrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>

" TODO
" nnoremap <leader>gs  :YcmCompleter GoToSymbol<CR>
nnoremap <leader>gt  :YcmCompleter GetType<CR>
" TODO
" nnoremap <leader>fix :YcmCompleter FixIt<CR>
" below seems to open files in same buffer so need to work that out
nnoremap <leader>gr  :YcmCompleter GoToReferences<CR>
" below seems ok, if multiple files changed then have to save them one by one which is laborious, a section to read about this command on git site, also diff nmap vs nnoremap
nmap <leader>rr :exe 'YcmCompleter RefactorRename '.input('refactor '.expand('<cword>').' to:')<cr>
" TODO Format
" TODO Symbol Search seems cool so can maybe add it
" TODO YcmDiags

"let g:ycm_clangd_args = [ '--compile-commands-dir=/home/lukaszmika/path/to/build/dir' ]
"let g:ycm_clangd_args = [ '--compile-commands-dir=/home/lukaszmika/Desktop/blabla' ] " dunno how to include two paths
let g:ycm_goto_buffer_command = 'new-tab' " so files open up in a new tab when going to definition etc
" https://stackoverflow.com/questions/38534285/vim-youcompleteme-plugin-opens-up-a-split-window-with-function-definition 
let g:ycm_autoclose_preview_window_after_insertion = 1

" TODO for nerdtree ctrl ww to switch tab <-> nerdtree, maybe add binding
autocmd BufWinEnter * NERDTreeMirror " when opening a new tab, it'll have nerd tree part

" }}}


" ui {{{

" Show line numbers
set number

" highlight current line
"set cursorline

" visual autocomplete for command menu
set wildmenu

" redraw only when we need to. speeds up macros
set lazyredraw

" seems to be set by default or something
"set showmatch

" }}}


" autogroups {{{

" language-specific settings for certain filetypes/file extensions
"augroup configgroup
"    autocmd!
"    autocmd VimEnter * highlight clear SignColumn
"    autocmd BufWritePre *.py,*.txt,*.java
"                \:call <SID>StripTrailingWhitespaces()
"    autocmd FileType java setlocal noexpandtab
"    autocmd FileType java setlocal list
"    autocmd FileType python setlocal commentstring=#\ %s
"    autocmd BufEnter Makefile setlocal noexpandtab
"augroup END

" }}}


" folding {{{

" useful read   http://dgp.toronto.edu/~mjmcguff/learn/vim/folding.txt


"enable folding
set foldenable


" open most folds by default
"set foldlevelstart=10

" 10 nested fold max
"set foldnestmax=10

" close the fold
"nnoremap <space> zc

" open the fold
" nnoremap <space> zo

" open the fold
"nnoremap <space> zf

" toggle the fold so open/close
"nnoremap <space> za

" fold based on indent level
"set foldmethod=indent

" }}}


" spaces, tabs & indent {{{

" TODO indention doesn't seem to work for python files, need to fix that

set autoindent      " tells vim to apply the indentation of the current line to the next
set smartindent     " reacts to the syntax/style of the code being edited

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces

set shiftwidth=4 " number of spaces per indention

" }}}


" searching {{{

set hlsearch
set incsearch

" turn off search highlight
nnoremap z<space> :nohlsearch<CR>

" }}}


" line shortcuts {{{

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" }}}


" custom functions {{{

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc


" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction


" v - virtual and select mode, no - non recursive
vnoremap ;/ :call ToggleComment()<cr>

" the way it works - select lines, then call the function
" it'll add or remove '//' at the beginning of each line
function! ToggleComment()
        if matchstr(getline(line(".")),'^\s*\/\/.*$') == ''
                :execute "s:^://:"
        else
                :execute "s:^\s*//::"
        endif
endfunction


" }}}


" colors {{{

set background=dark

" colorscheme VisualStudioDark
colorscheme murphy

"" Color scheme (terminal)
"set t_Co=256
"set background=dark
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
"" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
"" in ~/.vim/colors/ and uncomment:
"colorscheme solarized

" }}}

" to improve colours in ycm, otherwise they're veeeryyy bright 
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
highlight PmenuSel ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000

" vim:foldmethod=marker:foldlevel=0
