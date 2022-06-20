" { init.vim }

set nocompatible
filetype plugin indent on
syntax on

set clipboard=unnamedplus " copy to system clipboard
set hidden " buffers remain open in the background
set ignorecase " search freely
set incsearch " incremental search
set nobackup " vim will not create a backup
set noerrorbells " peaceful writing
set nohlsearch " no highlighting on search
set noswapfile " will not create... swapfile
set nu " line numbers
set scrolloff=18 " cursor centered w/ 12 line margin top/bottom
set undofile
set wildmenu " tab autocomplete filenames

" { plugins }

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chrisbra/Colorizer' " color preview
Plug 'junegunn/fzf.vim' " fuzzy find
Plug 'junegunn/goyo.vim' " writing environment
Plug 'ptzz/lf.vim' " lf file manager
Plug 'farmergreg/vim-lastplace' " return to last place in file
Plug 'preservim/vim-pencil'
Plug 'tpope/vim-sensible'
Plug 'mhinz/vim-startify' " start screen for vim
Plug 'tpope/vim-surround'
"Plug 'vimwiki/vimwiki'
Plug 'lervag/vimtex' " LaTeX support
call plug#end()

" { plugin settings }

" Airline theme
let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline_powerline_fonts = 1

" vimtex 
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex' 

" vim-pencil 
let g:tex_conceal = ""
let g:pencil#conceallevel = 0

" vim-pencil autostart
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'

augroup pencil
	autocmd!
	autocmd FileType markdown,mkd call pencil#init()
	autocmd FileType text call pencil#init()
	autocmd FileType tex call pencil#init({'wrap' : 'soft'})
augroup END

" vim-wiki, markdown no conceal
"let g:vim_markdown_conceal = 0
"let g:vim_markdown_conceal_code_blocks = 0

"let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" { vim functions }

" Viewer options
let g:vimtex_view_method = 'zathura'

" Folds options
set viewoptions=folds,cursor
set sessionoptions=folds

" Folds, persistent
augroup AutoSaveGroup
  autocmd!
	" view files are about 500 bytes
	" bufleave but not bufwinleave captures closing 2nd tab
	" nested is needed by bufwrite* (if triggered via other autocmd)
	" BufHidden for compatibility with `set hidden`
  autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end

" LaTeX tweaks
autocmd FileType tex :NoMatchParen
au FileType tex setlocal nocursorline

" misc
autocmd InsertLeave * update		" autosaves/updates after insert move

" splits
highlight WinSeparator guibg=none	" thin separator
set laststatus=3					" global status line 

" tabs
set tabstop=4						" tab appears 4 spaces wide
set softtabstop=4 noexpandtab		" defensive setting
set shiftwidth=4					" indent matches tabs

" { key remaps - call them last so they don't get overwritten }

" shortcuts
let mapleader = " "
let g:matchup_matchparen_enabled = 0
let g:fzf_preview_window = ['right:50%', 'ctrl-/']"noremap <leader>f :FZF<cr>

noremap <leader>g :Goyo 60<cr>
noremap <leader>p :SoftPencil<cr>

" spelling toggle with F11 
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>

" esc
inoremap jj <Esc>
inoremap JJ <Esc>
