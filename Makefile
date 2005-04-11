# PHONY TARGETS

.PHONY: style test package clean doc all

style:	synttree.sty

test: 	test.dvi

package: synttree.tar.gz

clean:
	rm -f *.aux *.log *.dvi *.toc *.sty *.glo *.idx *.ilg *.ind
	rm -f *.pdf
	rm -f synttree.tar.gz

doc: 	synttree.dvi

demos:	simple.dvi balance.dvi tree.dvi

all:	style doc test demos package

# REAL TARGETS

synttree.sty: synttree.ins synttree.dtx
	rm -f $@
	tex $<

test.dvi: test.tex synttree.sty
	latex $<

synttree.dvi: synttree.dtx synttree.sty
	latex $<
	latex $<

synttree.pdf: synttree.dvi
	dvipdfm $^

synttree.tar.gz: synttree.dtx synttree.ins README synttree.pdf
	tar cvzf $@ $^

simple.dvi balance.dvi tree.dvi : %.dvi : %.tex
	latex $<

