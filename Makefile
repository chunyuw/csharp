## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn>
## $Rev$

DATE=$(shell gdate "+%Y%m%d-%H:%M")
AUTOCI="Batch checkin by Makefile ($(DATE))"
CLNSUFFIX=" aux log snm toc vrb out out.bak dvi "
OTHSUFFIX=" nav rel "

all:
	@echo "Do nothing default"
	@echo "Please use 'make N', N=[0-8]"

%.pdf: %.tex preamble.tex $(wildcard pgf/*.tex)
	@if [ -e $(basename $@).tex ] ; then \
	  if [ -e $(basename $@).out ] ; then gbk2uni $(basename $@) ; fi ; \
	  pdflatex $(basename $@) ; \
	else \
	  echo "$@ doesn't exist" ; \
	fi

ci:
	svn ci . -m $(AUTOCI)

clean: 
	-rm -f $(foreach s,$(CLNSUFFIX),$(wildcard *.$(s)))
	-rm -f $(wildcard prv_*)
cleanpdf:
	-rm -f $(wildcard part-*.pdf test.pdf z_region.pdf) 
cleanoth:
	-rm -f $(foreach s,$(OTHSUFFIX),$(wildcard *.$(s)))
	-rm -f $(wildcard z_region.* test.exe) 

cleanall: clean cleanpdf cleanoth

.PHONY:	all clean

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
