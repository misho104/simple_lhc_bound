.PHONY: clean manual.pdf

manual.pdf:
	latexmk -lualatex -shell-escape manual

clean:
	@rm -f *.dvi *.aux *.fls *.ps *.log *.fdb_latexmk *~ *.out *.blg *.bbl *.synctex.gz *.bak *.xmpi *.xmpdata
	@rm -rf _minted-*
	@ls *.pdf | grep -v '^manual' | xargs rm

pip:
	pip install pygments-mathematica
