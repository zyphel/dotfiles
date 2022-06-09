# Cut
c		cut
caw		change all word (grabs whitespace)
ciw		change in word (just word, no whitespace)

# Delete
d		delete
dl		delete character (alias: "x")
diw		delete inner word
daw		delete a word
diW		delete inner WORD (see |WORD|)
daW		delete a WORD (see |WORD|)
dgn		delete the next search pattern match
dd		delete one line
dis		delete inner sentence
das		delete a sentence
dib		delete inner '(' ')' block
dab		delete a '(' ')' block
dip		delete inner paragraph
dap		delete a paragraph
diB		delete inner '{' '}' block
daB		delete a '{' '}' block

# Macros
Record a macro
	q{register}
	{do things}
	q(end recording)

Play macro
	@{register}

# Motions
a		all
i		in
t		'til
f		find forward
F		find backward

# Movement (^ = control)

gg		jump to beginning of file
G		jump to end of file

^e		scroll down
^y		scroll up
^f		scroll down full page (fwd)
^b		scroll up full page (back)

H		move to top of screen
M		move to middle of screen
L		move to bottom of screen

# Tags
t		tags (xml/html files)

# Text Objects
w		words
s		sentences
p		paragraphs

# Visual
v		visually select

# Yank (copy)
y		yank
