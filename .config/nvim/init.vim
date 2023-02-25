" ~~~~~ init.vim ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if has("eval")							"vim-tiny lacks 'eval'
	let skip_defaults_vim = 1
endif

set nocompatible " no vi compatibility
filetype plugin on " filetype detection
syntax on " sytax detection and display

set background=dark
set clipboard=unnamed,unnamedplus
set display=lastline
set hidden					" buffers open in the background
set history=1000
set ignorecase				" case-insensitive search 
set incsearch
set linebreak				" visual word-wrap
set mouse=nv
set nobackup
set noerrorbells
set nohlsearch
set noswapfile
set nu 
set path+=**				" subdir search ':find <search-term>'
set scrolloff=18			" cursor centered, margin as defined
set shell=/usr/bin/zsh
set smartcase				" search recognizes uppercase
set termguicolors			" enables 24-bit color in the TUI
set undofile
set wildmenu				" tab autocomplete filenames

autocmd Filetype yaml set cursorcolumn
autocmd Filetype yml set cursorcolumn
"autocmd Filetype python set cursorcolumn

" ----- plugins -----------------------------------------------------

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'dkarter/bullets.vim'
Plug 'chrisbra/Colorizer'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/goyo.vim'
"Plug 'jakewvincent/mkdnflow.nvim'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'voldikss/vim-floaterm'
Plug 'baskerville/vim-sxhkdrc'
Plug 'farmergreg/vim-lastplace'
Plug 'preservim/vim-pencil'
Plug 'tpope/vim-sensible'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'lervag/vimtex'

" colorschemes
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'savq/melange'

call plug#end()

" ----- plugin settings ---------------------------------------------

" syntax contingency
if has("syntax")
	syntax enable
endif

" bullets.vim
let g:bullets_enabled_file_types = ['markdown', 'text', 'gitcommit']

" vimtex 
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex' 
let g:vimtex_view_method = 'zathura'
autocmd FileType tex :NoMatchParen
au FileType tex setlocal nocursorline

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

" retain colorscheme after goyo exit
autocmd! User GoyoLeave source $HOME/.config/nvim/init.vim

let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_transparent_background = 1
let g:gruvbox_material_background = 'soft'

" colorscheme (settings precede colorscheme)
colorscheme gruvbox-material

" ----- lightline ---------------------------------------------------

let g:lightline = {'colorscheme' : 'gruvbox_material'}

" ~~~~~ VIM FUNCTIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ----- stop automatic comment insertion ----------------------------

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" ---- folds --------------------------------------------------------

" options
set viewoptions=folds,cursor
set sessionoptions=folds

" persistent folds
augroup AutoSaveGroup
  autocmd!
	" view files are about 500 bytes
	" bufleave but not bufwinleave captures closing 2nd tab
	" nested is needed by bufwrite* (if triggered via other autocmd)
	" BufHidden for compatibility with `set hidden`
  autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end

" ----- splits ------------------------------------------------------

" thin separator
highlight WinSeparator guibg=none

" global status line
set laststatus=3

" ----- tabs --------------------------------------------------------

set tabstop=4 " tab appears 4 spaces wide
set softtabstop=4 noexpandtab " defensive setting
set shiftwidth=4 " indent matches tabs

" ----- autosave/update upon insert leave ---------------------------

autocmd InsertLeave * update 

" ----- key remaps (last to prevent overwrite) ----------------------

" shortcuts
let mapleader = " "
let g:matchup_matchparen_enabled = 0
let g:fzf_preview_window = ['right:50%', 'ctrl-/']"noremap <leader>f :FZF<cr>

noremap <leader>g :Goyo 60<cr>
noremap <leader>p :SoftPencil<cr>
nnoremap <leader>n :NERDTreeToggle<cr>
noremap <leader>f :FZF<cr>
noremap	<leader>s :w<cr>
noremap <leader>q :wq<cr>

" spelling toggle with F11
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>
