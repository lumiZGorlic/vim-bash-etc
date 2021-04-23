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


" set cindent
" set autoindent
" set smartindent
"
" https://vim.fandom.com/wiki/Search_and_replace_in_multiple_buffers
"
"
" align continuations within open parens with the start of the parens
" set cinoptions+=(0
"
" but when the last char of prev line is the open parens, just indent 1 sw
" set cinoptions+=Ws
"
" line up close brackets on their own line like blocks
" set cinoptions+=m1
"
" enable sane java and javascript indenting
" set cinoptions+=j1,J1
"



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

" }}}


" ui {{{

" Show line numbers
set number

" highlight current line
set cursorline

" visual autocomplete for command menu
set wildmenu

" redraw only when we need to. speeds up macros
set lazyredraw

" seems to be set by default or something
"set showmatch

" }}}


" plugins {{{

set runtimepath^=~/.vim/bundle/ctrlp.vim

" plugins to look at: tmux, ag, nerdtree

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


" spaces & tabs {{{

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces


" number of spaces per indention
"set shiftwidth=2

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
