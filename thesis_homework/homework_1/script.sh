#!/bin/bash
pandoc homework.md --standalone --pdf-engine=xelatex --include-before-body=title_page.tex --lua-filter=split_pages.lua -V geometry:margin=1in -V mainfront="Times New Roman" -o output.pdf
