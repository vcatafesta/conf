" Begin .vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set laststatus=2
:filetype plugin on
:syntax enable
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
Plug 'nvim-treesitter/nvim-treesitter'
