
paper.pdf: paper.tex main.tex
	pdflatex $< && pdflatex $<

main.tex: README.markdown
	pandoc $^ -o $@

clean:
	-rm -f main.tex paper.aux paper.log paper.pdf
