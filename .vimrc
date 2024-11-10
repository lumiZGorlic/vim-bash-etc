" https://web.archive.org/web/20180106045128/https://dougblack.io/words/a-good-vimrc.html
" https://stackoverflow.blog/2020/11/09/modern-ide-vs-vim-emacs/
" https://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim
" https://www.reddit.com/r/vim/comments/k183tt/is_there_any_proper_guidetutorial_for_ycm/

" apply the command in the last line only for this file
set modelines=1


if has("gui_running")
    " GUI is running or is about to start.
    " Maximize gvim window (for an alternative on Windows, see simalt below).
    set lines=50 columns=150
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


" TODO hmmm those plugins how do i update them ? is it automatic ?

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
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'easymotion/vim-easymotion'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :VundleInstall    - this actually worked for me, rather than PluginInstall.
"  on another occasion worked but only when i stopped specifying a plugin i
"  wanted to install
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" }}}


" misc {{{

" without this 'jump to next word' is slow
" but with this on one cannot do '<leader>ev' etc. at least it seems so. need
" to investigate. what about other key combinations that use <leader> ?
set timeout timeoutlen=100 ttimeoutlen=100

set nowrap

" so that hq files treated as normal c++ headers
au BufNewFile,BufRead,BufReadPost *.hq set filetype=cpp

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


"------------------------------------------------------------------------------------------------------------------------------------------------------
map  s <Plug>(easymotion-sn)
omap t <Plug>(easymotion-tn)


"------------------------------------------------------------------------------------------------------------------------------------------------------
" in https://gitter.im/Valloric/YouCompleteMe go to 'chat via matrix' 
" and then can search in old messages

nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>

"nmap <leader>yfw <Plug>(YCMFindSymbolInWorkspace)
"nmap <leader>yfd <Plug>(YCMFindSymbolInDocument)
"nnoremap <leader>gs  :YcmCompleter GoToSymbol<CR>
"nmap <leader>gs :exe 'YcmCompleter GoToSymbol '.input('refactor '.expand('<cword>').' to:')<cr>

nnoremap <leader>gt  :YcmCompleter GetType<CR>

" nnoremap <leader>fix :YcmCompleter FixIt<CR>
" TODO below seems to open files in same buffer so need to work that out, also
" when run the command, then i try to re-run it and does not work
" https://stackoverflow.com/questions/6852763/how-to-make-vim-quickfix-list-launch-files-in-a-new-tab
set switchbuf+=usetab,newtab
nnoremap <leader>gr  :YcmCompleter GoToReferences<CR>

" TODO below seems ok, if multiple files changed then have to save them one by one which is laborious, a section
" to read about this command on git site, maybe just google 'ycm refactor rename save files' also diff nmap vs nnoremap
nmap <leader>rr :exe 'YcmCompleter RefactorRename '.input('refactor '.expand('<cword>').' to:')<cr>

" TODO Format, Symbol Search seems cool so can maybe add it, YcmDiags

" show documentation in a popoup about function or class or whatever.
nmap <leader>d <plug>(YCMHover)

let g:ycm_auto_hover = "" " don't want popup showing up by defult when i hover

"let g:ycm_clangd_args = [ '--compile-commands-dir=/home/lukaszmika/Projects/zs_build' ] " zonesense !!!!!
"let g:ycm_clangd_args = [ '--compile-commands-dir=/home/lukaszmika/Desktop/writeDebugger/trap/_out' ] " dunno how to include two paths
let g:ycm_goto_buffer_command = 'new-tab' " so files open up in a new tab when going to definition etc
" https://stackoverflow.com/questions/38534285/vim-youcompleteme-plugin-opens-up-a-split-window-with-function-definition 
let g:ycm_autoclose_preview_window_after_insertion = 1


"------------------------------------------------------------------------------------------------------------------------------------------------------
nmap nt :NERDTreeToggle<CR>

" TODO for nerdtree ctrl ww to switch tab <-> nerdtree, maybe add binding
" hmmm below does not seem to work
" hmmm how do i map 'ctrl ww' ???
nmap abc <C-ww>
" below is fine, and A is Alt
map <A-Right> <C-W>l
map <A-Left> <C-W>h

autocmd BufWinEnter * NERDTreeMirror " when opening a new tab, it'll have nerd tree part


"------------------------------------------------------------------------------------------------------------------------------------------------------
" to switch to a scroll mode in Termdebug use a combination 'Ctrl w' followed
" by 'N', then to go back press 'i' or 'a'
" https://stackoverflow.com/questions/50535334/how-do-i-scroll-through-a-terminal-using-vim-8-1s-new-terminal-termpack-support


"------------------------------------------------------------------------------------------------------------------------------------------------------
" https://yufanlu.net/2016/10/30/ultisnips/

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" Source the termdebug plugin
packadd termdebug

" Add mapping to load termdebug
noremap <silent> <leader>td :Termdebug<cr>

" comments sections in the link below useful
" https://www.dannyadam.com/blog/2019/05/debugging-in-vim/#comment-251004
let g:termdebug_wide=1

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



" spaces, tabs & indent {{{

" TODO indention doesn't seem to work for python files, need to fix that

set autoindent      " tells vim to apply the indentation of the current line to the next
set smartindent     " reacts to the syntax/style of the code being edited

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces

set shiftwidth=4 " number of spaces per indention

" https://superuser.com/questions/271023/can-i-disable-continuation-of-comments-to-the-next-line-in-vim
set formatoptions-=cro

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
        if matchstr(getline(line(".")),'^\/\/.*$') == ''
                :execute "s:^:\/\/:"
        else
                :execute "s:^\/\/::"
        endif
endfunction


" }}}


" colors {{{

set background=dark

" colorscheme VisualStudioDark
colorscheme murphy


" }}}

" to improve colours in ycm, otherwise they're veeeryyy bright 
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
highlight PmenuSel ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000

" if the below is in the list line, the sections are folded
" vim:foldmethod=marker:foldlevel=0
