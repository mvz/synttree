# PHONY TARGETS

.PHONY: style test package clean doc all

style:	synttree.sty

test: 	test.dvi

package: synttree.tar.gz

clean:
	rm -f *.aux *.log *.dvi *.toc *.sty *.glo *.idx *.ilg *.ind *.gls
	rm -f *.pdf
	rm -f synttree.tar.gz

doc: 	synttree.pdf

demos:	simple.dvi balance.dvi tree.dvi

all:	style doc test demos package

# REAL TARGETS

synttree.sty: synttree.ins synttree.dtx
	rm -f $@
	tex $<

test.pdf: test.tex synttree.sty
	latex $<

synttree.glo: synttree.dtx synttree.sty
	latex $<

synttree.idx: synttree.dtx synttree.sty
	latex $<

synttree.gls: synttree.glo
	makeindex -s gglo.ist -o synttree.gls synttree.glo

synttree.ind: synttree.idx
	makeindex -s gind.ist -o synttree.ind synttree.idx

synttree.dvi: synttree.dtx synttree.sty synttree.ind synttree.gls
	latex $<
	latex $<

synttree.pdf: synttree.dvi
	dvipdfm $^

synttree.tar.gz: synttree.dtx synttree.ins README synttree.pdf
	tar cvzf $@ $^

simple.dvi balance.dvi tree.dvi : %.dvi : %.tex
	latex $<

