" ----- .vimrc ------------------------------------------------------

if has("eval")							"vim-tiny lacks 'eval'
	let skip_defaults_vim = 1
endif

set nocompatible						" no vi compatibility
filetype plugin on						" filetype detection
syntax on

set autowrite							" write when switching between files
set background=dark
set clipboard=unnamed,unnamedplus
set display=lastline
set hidden								" buffers open in background
set history=500							" remember table command-lines
set ignorecase							" case-insensitive search
set incsearch							" incremental search
set linebreak							" visual word-wrap
set nobackup							" vim will not create a backup
set noerrorbells						" peaceful writing
set nohlsearch							" no highlighting on search
set noswapfile							" will not create... swapfile
set nu									" line numbers
set paste
set scrolloff=18						" centered cursor 12 line margin 
set shell=/usr/bin/zsh
set smartcase							" search recognizes uppercase
set undofile							" create file to track 'undo'
set wildmenu							" tab autocomplete filenames
set viminfo='20,<1000,s1000				" stop truncated yanks, deletes, etc.

" tabs
set tabstop=4							" tab appears 4 spaces wide
set softtabstop=4 noexpandtab			" defensive setting
set shiftwidth=4						" indent matches tabs

autocmd Filetype yaml set cursorcolumn 
autocmd Filetype yml set cursorcolumn
autocmd Filetype python set cursorcolumn

" ----- plugins -----------------------------------------------------

call plug#begin()

Plug 'ConradIrwin/vim-bracketed-paste'	" fixes multi-line paste
Plug 'dkarter/bullets.vim'				" bullet point functionality
Plug 'chrisbra/Colorizer'				" color preview
Plug 'junegunn/goyo.vim'				" writing environment
Plug 'ptzz/lf.vim'						" lf file manager
Plug 'farmergreg/vim-lastplace'			" return to last place
Plug 'preservim/nerdtree'
Plug 'preservim/vim-pencil'				" writing tweaks
Plug 'tpope/vim-sensible'				" usibility defaults
Plug 'mhinz/vim-startify'				" start screen
Plug 'baskerville/vim-sxhkdrc'			" sxhkdrc highlighting
Plug 'lervag/vimtex'					" LaTeX support w/ preview
Plug 'tribela/vim-transparent'			" vim/terminal fix

" colorschemes
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

" colorscheme, retain after goyo exit
autocmd! User GoyoLeave source $HOME/.vimrc

let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_transparent_background = 1
let g:gruvbox_material_background = 'soft'

" colorscheme (settings precede colorscheme)
colorscheme gruvbox-material

" ----- vim functions -----------------------------------------------

""""" please fix (set guicursor=i:ver25-Cursor)

" stop automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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

" misc (autosaves/updates after instert move)
autocmd InsertLeave * update

" splits
highlight WinSeparator guibg=#282828	" thin separator
set laststatus=3						" global status line 

" ----- key remaps, last to prevent overwrite -------------

" shortcuts
let mapleader = " "
let g:matchup_matchparen_enabled = 0
let g:fzf_preview_window = ['right:50%', 'ctrl-/']"noremap <leader>f :FZF<cr>

" editing
noremap <leader>g :Goyo 60<cr>
noremap <leader>p :SoftPencil<cr>
nnoremap <leader>n :NERDTreeToggle<CR>
noremap <leader>f :FZF<cr>
noremap	<leader>s :w<cr>
noremap <leader>q :wq<cr>

" spelling toggle with F11
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>
