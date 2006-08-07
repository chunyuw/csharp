## Slides for ".NET Programming" by Chunyu Wang <chunyu@hit.edu.cn>

LESSONS = $(wildcard lesson-*)

all: 
	echo $(LESSONS)

%.pdf: %.tex
	@if [ -e $(basename $@).tex ] ; then \
	  if [ -e $(basename $@).out ] ; then gbk2uni $(basename $@) ; fi ; \
	  pdflatex $(basename $@) ; \
	else \
	  echo "$@ doesn't exist" ; \
	fi

clean: 
	rm -f *.nav *.log *.snm *.toc *.out *.aux *.vrb *.out.bak
	rm -f *.pdf

.PHONY:	all clean

# lesson-01.pdf: dn-outline.tex
# lesson-02.pdf: $(wildcard cs-*.tex)

1: lesson-01.pdf
2: lesson-02.pdf
3: lesson-03.pdf
4: lesson-04.pdf
5: lesson-05.pdf
6: lesson-06.pdf

