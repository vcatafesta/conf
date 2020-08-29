" Begin .vimrc
set laststatus=2
:filetype plugin on
:syntax enable
set relativenumber
"set inccommand=split

"set columns=80
set wrapmargin=8
set ruler
set nu
let g:powerline_pycmd="py3"
set nocp
set nowrap
set ruler
set ve=all
set vb
set ic
set ai
set tabstop=3
set shiftwidth=3
set softtabstop=3
set backspace=indent,eol,start
set title
set ttyfast
set background=dark

map <F11> <esc>:set nu!<cr>
" salva com F9
nmap <F9> :w<cr>
" F10 - sai do vim
nmap <F10> <esc>:q<cr>
" F11 - sai do vim sem salvar
nmap <F11> <esc>:q!<cr>

"set statusline=%F%m%r%h%w [FORMATO=%{&ff}] [TIPO=%Y] [ASCII=\%03.3b] [HEX=\%02.2B]   [POSIÇÃO=%04l,%04v][%p%%] [TAMANHO=%L]
set laststatus=2 " Sempre exibe a barra de status


" Fechamento automático de parênteses
imap { {}<left>
imap ( ()<left>
imap [ []<left>

"syn match ipaddr   /\(\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)\.\)\{3\}\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)/
"hi link ipaddr Identifier]]]]]])}]]]]]]))

" === Cria um registro de alterações de arquivo ========
" ChangeLog entry convenience
" Função para inserir um status do arquivo
" cirado: data de criação, alteração, autor etc (em modo normal)
fun! InsertChangeLog()
   normal(1G)
   call append(0, "Arquivo")
   call append(1, "Criado: " . strftime("%a %d/%b/%Y hs %H:%M"))
   call append(2, "ultima modificação: " . strftime("%a %d/%b/%Y hs %H:%M"))
   call append(3, "Autor: Sérgio Luiz Araújo Silva")
   normal($)
endfun
map ,cl :call InsertChangeLog()<cr>A
"
" Cria um cabeçalho para scripts bash
fun! InsertHeadBash()
   normal(1G)
   :set ft=bash
   :set ts=4
   call append(0, "#!bin/bash")
   call append(1, "# Criado em:" . strftime("%a %d/%b/%Y hs %H:%M"))
   call append(2, "# ultima modificação:" . strftime("%a %d/%b/%Y hs %H:%M"))
   call append(3, "# Nome da empresa")
   call append(3, "# Propósito do script")
   normal($)
endfun
map ,sh :call InsertHeadBash()<cr>A

" Ao entrar em modo insert ele muda a cor da barra de status
" altera a cor da linha de status dependendo do modo
if version >= 700
	au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
	au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif

" End .vimrc
"
"if empty(glob('~/.vim/autoload/plug.vim'))
"  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif


" important!!
set termguicolors

" for dark version
set background=dark

" for light version
"set background=light

" the configuration options should be placed before `colorscheme edge`
let g:edge_style = 'aura'
let g:edge_disable_italic_comment = 1

:colorscheme edge

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-github-dashboard'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '~/my-prototype-plugin'
"Plug ‘pangloss/vim-javascript’
"Plug ‘mxw/vim-jsx’
"Plug 'nvim-treesitter/nvim-treesitter'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'frazrepo/vim-rainbow'
Plug 'scrooloose/syntastic'
Plug 'vim-scripts/bash-support.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


"autocmd VimEnter *
"\ if !empty(filter(copy(g:plugs), ‘!isdirectory(v:val.dir)’))
"\ | PlugInstall | q
"\ | endif

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
set noshowmode
let g:lightline = {
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \     }
  \ }

map <C-o> :NERDTreeToggle<CR>
map <C-x> <esc>:q!<cr>
let g:rainbow_active = 1
let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
