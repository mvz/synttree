test.dvi: test.tex synttree.sty
	latex test.tex

synttree.sty: synttree.dtx synttree.ins
	rm -f synttree.sty
	tex synttree.ins

synttree.dvi: synttree.dtx synttree.sty
	latex synttree.dtx
	latex synttree.dtx

clean:
	rm -f *.aux *.log *.dvi *.toc *.sty *.glo *.idx *.ilg *.ind

doc: 	synttree.dvi

all:	doc test.dvi
