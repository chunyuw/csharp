## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn>

DATE=$(shell gdate "+%Y%m%d-%H:%M")
AUTOCI="Batch checkin by Makefile ($(DATE))"
CLNSUFFIX="nav log snm toc out aux vrb out.bak pdf dvi"

all: 1 2

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

.PHONY:	all clean

lesson-01.pdf: $(wildcard dn-*.tex) $(wildcard pgf/*.tex)
lesson-02.pdf: $(wildcard cs-*.tex)

1: lesson-01.pdf
2: lesson-02.pdf
3: lesson-03.pdf
4: lesson-04.pdf
5: lesson-05.pdf
6: lesson-06.pdf
t: test.pdf
