## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn> ## $Rev$

CLOGO  = cs-logo
BLOGO  = $(basename $(basename $(wildcard *.pbm.gz)))

all: cs-logo.pdf hit-logo.pdf
#all: $(addsuffix .pdf,$(CLOGO) $(BLOGO))

$(addsuffix .pdf,$(CLOGO)): %.pdf: %.mp ; mpost $< ; epstopdf $(basename $<).1

$(addsuffix .pbm,$(BLOGO)): %.pbm: %.pbm.gz ; gunzip -c $< > $@
$(addsuffix .eps,$(BLOGO)): %.eps: %.pbm    ; potrace -c -C "#707070" $<
$(addsuffix .pdf,$(BLOGO)): %.pdf: %.eps    ; epstopdf $<

cpdf: ;-@rm -fv $(wildcard *.pdf)
clean: ;-@rm -fv $(wildcard cs-logo.1 *.log *.mpo *.tmp *.pbm *.eps)
cleanall: clean cpdf

## 7z x -y $<

## pbm to eps (bitmap image to vector graph)
## $ potrace -c -C "#606060" -W 8.4cm -o logo.eps logo.pbm 
##
## eps color setting:
##   /b{0.500 setgray z fill}D
##   /b{0.625 0.625 0 setrgbcolor z fill}D


# jpg: eps
# 	convert cs-logo.2 cs-logo.jpg
# 	convert cs-logo.3 -blur 0x01 cs-mask.jpg
#	convert cs-logo.1 -background transparent -fuzz 5% -transparent white cs-logo.png
#	composite -dissolve 60% -gravity center hit-logo.jpg -size 685x581 null: hit-logo-light.jpg
# eps: cs-logo.mp
# 	mpost $<
