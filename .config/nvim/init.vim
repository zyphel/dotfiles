" ----- init.vim ----------------------------------------------------

set nocompatible					" no vi compatibility
filetype plugin indent on			" filetype detection
syntax on							" sytax detection and display

set shell=/usr/bin/zsh
set clipboard+=unnamedplus			" copy to system clipboard
set hidden							" buffers remain open in the background
set history=1000					" remembers command-lines entered in table
set ignorecase						" case-insensitive search 
set incsearch						" incremental search
set linebreak						" visual word-wrap
set nobackup						" vim will not create a backup
set noerrorbells					" peaceful writing
set nohlsearch						" no highlighting on search
set noswapfile						" will not create... swapfile
set nu								" line numbers
set number
set scrolloff=18					" cursor centered with margin as defined
set smartcase						" search recognizes uppercase
set termguicolors					" enables 24-bit color in the TUI
set undofile						" creates file to persistently track 'undo'
set wildmenu						" tab autocomplete filenames

autocmd Filetype yaml set cursorcolumn
autocmd Filetype yml set cursorcolumn
autocmd Filetype python set cursorcolumn

" ----- plugins -----------------------------------------------------

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'dkarter/bullets.vim'
Plug 'chrisbra/Colorizer'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'ptzz/lf.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'baskerville/vim-sxhkdrc'
Plug 'farmergreg/vim-lastplace'
Plug 'preservim/vim-pencil'
Plug 'tpope/vim-sensible'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'lervag/vimtex'

" colorschemes
Plug 'ayu-theme/ayu-vim'
Plug 'sainnhe/everforest'
Plug 'arcticicestudio/nord-vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'nanotech/jellybeans.vim'
Plug 'savq/melange'
Plug 'EdenEast/nightfox.nvim'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'ajh17/spacegray.vim'
Plug 'sainnhe/sonokai'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" ----- plugin settings ---------------------------------------------

" Airline theme
let g:airline_theme='base16_gruvbox_dark_pale'
let g:airline_powerline_fonts = 1

" bullets.vim
let g:bullets_enabled_file_types = ['markdown', 'text', 'gitcommit']

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

" ----- colorscheme settings ----------------------------------------

" colorscheme
colorscheme gruvbox-material

" colorscheme, background transparency
hi Normal guibg=NONE ctermbg=NONE

" colorscheme, retain after goyo exit
autocmd! User GoyoLeave source $HOME/.config/nvim/init.vim

" ----- vim functions -----------------------------------------------

" stop automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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

" Viewer options
let g:vimtex_view_method = 'zathura'

" ----- key remaps, last to prevent overwrite -----------------------

" shortcuts
let mapleader = " "
let g:matchup_matchparen_enabled = 0
"let g:fzf_preview_window = ['right:50%', 'ctrl-/']"noremap <leader>f :FZF<cr>

noremap <leader>g :Goyo 60<cr>
noremap <leader>p :SoftPencil<cr>

" spelling toggle with F11
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>
