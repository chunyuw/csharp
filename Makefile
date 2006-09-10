## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn>
## $Rev$

PWD=cy.net
DATE=$(shell gdate "+%Y%m%d-%H:%M")
AUTOCI="Batch checkin by Makefile ($(DATE))"
CLNSUFFIX=" aux log snm toc vrb out out.bak dvi nav "
#OUTPUT="-output-directory=out"

all:
	@echo "Do nothing, except the following:"
	@echo "  make [0-8]"
	@echo "  make encrypt"
	@echo "  make cpdf|clean|cleanall"

%.pdf: %.tex preamble.tex $(wildcard pgf/*.tex)
	-@gbk2uni -s $(basename $@)
	pdflatex $(OUTPUT) $<

encrypt: $(foreach s,$(wildcard part-*.pdf),en-$(s))
en-%.pdf: %.pdf
	pdftk $< output $@ owner_pw $(PWD) allow printing
ci:
	svn commit . -m $(AUTOCI)

cleanall: cpdf clean
cpdf:
	-rm -f $(wildcard en-part-*.pdf part-*.pdf test.pdf z_region.pdf)
clean: 
	-rm -f $(foreach s,$(CLNSUFFIX),$(wildcard *.$(s))) $(wildcard test.exe z_region.*) 

.PHONY:	all ci clean cleanall cleanpdf encrypt $(shell seq 0 8)
.SUFFIXES: .tex .pdf

part-00.pdf: dn-intro.tex
part-01.pdf: dn-devel.tex dn-outline.tex
part-02.pdf: cs-basic.tex cs-class.tex
part-03.pdf: cs-advac.tex cs-other.tex
part-04.pdf: $(wildcard lib-*.tex)
part-05.pdf: 
part-06.pdf: 
part-07.pdf: 
part-08.pdf: 

0: part-00.pdf
1: part-01.pdf
2: part-02.pdf
3: part-03.pdf
4: part-04.pdf
5: part-05.pdf
6: part-06.pdf
7: part-07.pdf
8: part-08.pdf
t: test.pdf
