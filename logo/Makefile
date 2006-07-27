
all: jpg

jpg: eps
	convert cs-logo.1 cs-logo.jpg
	convert cs-logo.2 -blur 0x01 cs-mask.jpg
#	convert cs-logo.1 -background transparent -transparent white cs-logo.png

eps: cs-logo.mp
	mpost $<

clean:
	rm -f cs-logo.1 cs-logo.2 *.log
