" ----- init.vim -------------------------

set nocompatible " no vi compatibility
filetype plugin indent on " filetype detection
syntax on " sytax detection and display

set shell=/usr/bin/zsh
set clipboard+=unnamedplus			
set display=lastline
set hidden " buffers open in the background
set history=1000 " remember command-lines
set ignorecase " case-insensitive search 
set incsearch " incremental search
set linebreak " visual word-wrap
set mouse=nv " mouse use in vim
set nobackup " vim will not create a backup
set noerrorbells " peaceful writing
set nohlsearch " no highlighting on search
set noswapfile " will not create... swapfile
set nu " line numbers
set number
set scrolloff=18 " cursor centered, margin as defined
set smartcase " search recognizes uppercase
set termguicolors " enables 24-bit color in the TUI
set undofile " track 'undo' in file
set wildmenu " tab autocomplete filenames

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
Plug 'preservim/nerdtree'
Plug 'davidgranstrom/nvim-markdown-preview'
Plug 'voldikss/vim-floaterm'
Plug 'baskerville/vim-sxhkdrc'
Plug 'farmergreg/vim-lastplace'
Plug 'preservim/vim-pencil'
Plug 'tpope/vim-sensible'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'lervag/vimtex'

" colorschemes
Plug 'ayu-theme/ayu-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'savq/melange'
Plug 'EdenEast/nightfox.nvim'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

call plug#end()

" ----- plugin settings ---------------------------------------------

" bullets.vim
let g:bullets_enabled_file_types = ['markdown', 'text', 'gitcommit']

" vimtex 
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex' 

" vim-pencil 
let g:tex_conceal = ""
let g:pencil#conceallevel = 0

" vim-pencil autostart
let g:pencil#wrapModeDefault = 'soft'

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

autocmd InsertLeave * update " autosaves/updates after insert move

"" splits
" thin separator
highlight WinSeparator guibg=none
" global status line
set laststatus=3

" tabs
set tabstop=4 " tab appears 4 spaces wide
set softtabstop=4 noexpandtab " defensive setting
set shiftwidth=4 " indent matches tabs

" Viewer options
let g:vimtex_view_method = 'zathura'

" ----- key remaps, last to prevent overwrite -----------------------

" shortcuts
let mapleader = " "
let g:matchup_matchparen_enabled = 0
"let g:fzf_preview_window = ['right:50%', 'ctrl-/']"noremap <leader>f :FZF<cr>

noremap <leader>g :Goyo 60<cr>
noremap <leader>p :SoftPencil<cr>
nnoremap <leader>n :NERDTreeToggle<CR>
noremap <leader>f :FZF<CR>

" spelling toggle with F11
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>
