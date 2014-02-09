set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'Blackrush/vim-gocode'
Bundle 'kchmck/vim-coffee-script'
Bundle 'L9'
Bundle 'tpope/vim-fugitive'
Bundle 'majutsushi/tagbar'
Bundle 'bling/vim-airline'

filetype plugin indent on
set guioptions=aegi

"GUI hacks
if has("gui_running")
"Paste from clipboard in normal mode
   nmap <S-INS> "+gP
"Paste from clipboard in insert mode
   imap <S-INS> <c-r>+
"Copy to system clipboard
   vmap <C-S-C> "+y
" Hide the mouse pointer while typing
   set mousehide
endif


let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_cpp_compiler = 'g++'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set et
set ts=4
set st=4
set sw=4
set noai
set nocin
set nosi
set cinoptions=1s

" Show line numbers and length
set number " show linenumbers
set tw=79  " width of the document
set nowrap " don't automatically wrap on load
set fo-=t  " don't automatically wrap when typing
set colorcolumn=80 "
highlight ColorColumn term=reverse ctermbg=203

" Show whitespaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

if $TERM =~ "-256color"
    set t_Co=256
    color wombat256mod
endif

" Remap leader key
let mapleader = ","

" New Tab
map <Leader>t <esc>:tabnew<CR>
" Next Tab
map <Leader>m <esc>:tabnext<CR>
" Previous Tab
map <Leader>n <esc>:tabprevious<CR>
" Tab Close
map <Leader>c <esc>:tabclose<CR>

" Resize split screen equally
map <Leader>o <c-w>=

map <Leader>p "*p
map <Leader>P "+p

:au! BufWritePost $MYVIMRC source $MYVIMRC

" Improved code indention
vnoremap < <gv
vnoremap > >gv

" Bind Ctrl+<movement> key to move around the windows
" instead of using Ctrl+w+direction
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Sort selection
vnoremap <Leader>s :sort<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

filetype off
call pathogen#infect()
call pathogen#helptags()
" let g:Powerline_symbols = 'fancy'

filetype plugin indent on
syntax on
" call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = "powerlineish"

set laststatus=2

"cscope
if filereadable("cscope.out")
    set nocscopeverbose
    cs add cscope.out
    set cscopeverbose
endif

:autocmd FileType c,cpp,h nmap <C-]> :cs find g <C-R>=expand("<cword>")<CR><CR>
:autocmd FileType c,cpp,h nmap <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>

"Code jumping
:autocmd FileType python nmap <C-\> :Ggrep "^\s*[^\#].*\<<cword>\>" -- *.py<CR>
:autocmd FileType * nmap <A-\> :Ggrep "\<<cword>\>" -- *.[ch]<CR>
:autocmd FileType python nmap <C-]> :Ggrep "\(class\\|def\)\s\+<cword>\s*[(:]" -- *.py<CR>
:autocmd FileType go nmap <C-]> :call GodefUnderCursor()<CR>
:let g:godef_split = 0

let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set nofoldenable

map <Leader>g :call RopeGotoDefinition()<CR>
let ropevim_enable_shortcuts = 1
let g:pymode_rope_goto_def_newwin = "vnew"
let g:pymode_rope_extended_complete = 1
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
"map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
  if pumvisible()
    if a:action == 'j'
      return "\<C-N>"
    elseif a:action == 'k'
      return "\<C-P>"
    endif
 endif
 return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" Vala specific
autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi setfiletype vala
