# Terminal Apps

alacritty-themes
	terminal theme stitcher

ag
ag 'search-terms' w
	search program 

biber --tool --validate-datamodel ~/Dropbox/LaTeX/references.bib
	validate bibtex files

bottom
	system monitor like htop and btop
	activate with 'btm'

btop
	like htop, shows system info

cmatrix
	matrix text

cmus
	music player

corectrl
	many functions, I use it to look at the temp

du
	default app for disk usage 

duplicity 
	backup which uses rsync, good -h file

espanso 
	text expansion at http://espanso.org/docs/get-started/

fc-list
	list system fonts

fc-list | grep -i <name>
	search for specific font

figlet
figlet jeff + beth | pv -qL 20 | lolcat
	display text in terminal

fslint
	duplicate removal

fzf
	fuzzy search

git
	version control
	rm -rf .git*
		remove the Git tracking and metadata from your project

htop
	real time sys info

jrnl 
	simple journaling app

lfcd
	file navigation

lolcat
	Terminal rainbows
	Can be used with figlet. See example below.

lsusb
	usb drive

ncdu
	disk usage

neofetch
	sys info

nudoku
	terminal sudoku

neovim
	text editor, oh so sweet

pacman -Ql <package>
	locate <package> file structure and files

pacman -Qqe > pkglist.txt
	generates a list of all explicitly installed packages
	https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#List_of_installed_packages=

pacman -Rndd pkg-name

    -R to remove the package
    -n to purge the configuration files
    -dd so it would remove itself but not the things that depended on it (i.e. the rest of the gnome apps I had installed)

pacman -Si pkg-name
	detailed info about app

pfetch
	sys info

powertop
	checks power comsumption in the terminal

quickemu
	emulator, word on the street is it's much easier than VirtualBox

screenfetch

sensors
	temperature display

speedread
	helps you practice reading fast

taskwarrior
	tasks 
	https://taskwarrior.org/
	see: vit

tldr
	brief summary of application
	very nice

trash.cli
	trash management

vit
	taskwarrior frontend, vim functionality

xclip
	The only system-wide clipboard that worked in i3wm. 
	I tried ~5 of them. All failed but xclip. Long live xclip!

xprop
	dsiplay system information with a click

yt-dlp "url"
yt-dlp -x --audio-format mp3 "url"
	download youtube videos

ranger
	CLI file manager
	I use "lf" instead of ranger

yadm
	yet another dotfiles manager
	in the following order...
	yadm pull
	yadm add <file(s)>
	yadm commit
	yadm push

zathura file.xxx
	open files (i.e., PDF) in the terminal

zentile
	tiling window manager for xfce

# Shortcuts

Ctrl+l
	comment: equivalent to cd, Enter
