let g:syntastic_cpp_compiler_options = ' -std=c++0x'
let g:syntastic_cpp_compiler = 'g++-4.7.1'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set et
set ts=4
set st=4
set noai
set nocin
set nosi

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

set t_Co=256
color wombat256mod

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


filetype off
call pathogen#infect()
call pathogen#helptags()
"let g:Powerline_symbols = 'fancy'

filetype plugin indent on
syntax on
call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')

set laststatus=2

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



