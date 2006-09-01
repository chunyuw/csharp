## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn>

DATE=$(shell gdate "+%Y%m%d-%H:%M")
AUTOCI="Batch checkin by Makefile ($(DATE))"
CLNSUFFIX=" aux log snm toc vrb out out.bak dvi "
OTHSUFFIX=" nav rel "

all: 0 1 2

%.pdf: %.tex preamble.tex
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
	-rm -f prv_*
cleanpdf:
	-rm -f part-*.pdf test.pdf z_region.pdf
cleanoth:
	-rm -f $(foreach s,$(OTHSUFFIX),$(wildcard *.$(s)))
	-rm -f z_region.* test.exe

cleanall: clean cleanpdf cleanoth

.PHONY:	all clean

part-00.pdf: dn-intro.tex
part-01.pdf: $(wildcard dn-*.tex) $(wildcard pgf/*.tex)
part-02.pdf: $(wildcard cs-*.tex)

0: part-00.pdf
1: part-01.pdf
2: part-02.pdf
3: part-03.pdf
4: part-04.pdf
5: part-05.pdf
6: part-06.pdf
t: test.pdf
