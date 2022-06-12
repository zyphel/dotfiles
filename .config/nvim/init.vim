" ===== init.vim

set nocompatible
filetype plugin indent on
syntax enable

set clipboard=unnamedplus " copy to system clipboard
set hidden " buffers remain open in the background
set ignorecase " search freely
set incsearch
set nobackup
set noerrorbells
set nohlsearch
set noswapfile
set nu " line numbers
set scrolloff=18 " cursor centered w/ 12 line margin top/bottom
set undofile
set wildmenu " tab autocomplete filenames

" =======
" Plugins 
" =======

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'vim-airline/vim-airline' " vim status bar
Plug 'vim-airline/vim-airline-themes' " install airline themes
Plug 'jiangmiao/auto-pairs' " closes pairs
Plug 'chrisbra/Colorizer' " color preview
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf.vim' " fuzzy find
Plug 'junegunn/goyo.vim' " writing environment
Plug 'ptzz/lf.vim'
Plug 'farmergreg/vim-lastplace' " return to last place in file
Plug 'preservim/vim-pencil'
Plug 'tpope/vim-sensible'
Plug 'mhinz/vim-startify' " start screen for vim
Plug 'lervag/vimtex' " LaTeX support
call plug#end()

" ===============
" Plugin settings
" ===============

" ===== Airline theme
"let g:airline_theme='base16_monokai'
let g:airline_theme='base16_gruvbox_dark_hard'

" ===== vimtex 
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" ===== vim-pencil 
let g:tex_conceal=""
let g:pencil#conceallevel = 0

" ===== vim-pencil autostart
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'

augroup pencil
	autocmd!
	autocmd FileType markdown,mkd call pencil#init()
	autocmd FileType text call pencil#init()
	autocmd FileType tex call pencil#init({'wrap' : 'soft'})
augroup END

" =============
" Vim functions
" =============

" ===== Viewer options
let g:vimtex_view_method = 'zathura'

" ===== Folds options
set viewoptions=folds,cursor
set sessionoptions=folds

" ===== Folds, persistent
augroup AutoSaveGroup
  autocmd!
  " view files are about 500 bytes
  " bufleave but not bufwinleave captures closing 2nd tab
  " nested is needed by bufwrite* (if triggered via other autocmd)
  " BufHidden for compatibility with `set hidden`
  autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end

" ===== LaTeX tweaks
autocmd FileType tex :NoMatchParen
autocmd InsertLeave * update " autosaves/updates after insert move
au FileType tex setlocal nocursorline

" ===== Tabs
set tabstop=4 " tab appears 4 spaces wide
set softtabstop=4 noexpandtab " defensive setting
set shiftwidth=4 " indent matches tabs

" ============================================
" Key Remaps 
" Call them last so they don't get overwritten
" ============================================

" ===== Shortcuts
let mapleader = " "
let g:matchup_matchparen_enabled = 0
let g:fzf_preview_window = ['right:50%', 'ctrl-/']"noremap <leader>f :FZF<cr>

noremap <leader>g :Goyo 60<cr>
noremap <leader>p :SoftPencil<cr>

" ===== Spelling toggle with F11 
" https://jdhao.github.io/2019/04/29/nvim_spell_check/
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>

" ===== Esc
inoremap jj <Esc>
inoremap JJ <Esc>
