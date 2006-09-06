## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn>
## $Rev$ $LastChangedDate$

all: jpg

jpg: eps
	convert cs-logo.2 cs-logo.jpg
	convert cs-logo.3 -blur 0x01 cs-mask.jpg
#	convert cs-logo.1 -background transparent -fuzz 5% -transparent white cs-logo.png
#	composite -dissolve 60% -gravity center hit-logo.jpg -size 685x581 null: hit-logo-light.jpg

eps: cs-logo.mp
	mpost $<

clean:
	rm -f cs-logo.1 cs-logo.2 cs-logo.3 *.log
