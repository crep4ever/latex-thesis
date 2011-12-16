#Description

This package contains the LaTeX sources and tools that I've used for my thesis :

     Top-down irregular pyramids for large histological images segmentation

A pdf version (in french) is available on my personnal [website](http://www.rgoffe.org/static1/publications)

#Dependencies

+ latex
+ pdflatex
+ inkscape
+ makeindex
+ imagemagick (convert)

#Usage

make [OPTION] : build the pdf version

#Options

+ pdf (default): pdf
+ ps : ps version
+ clean : remove LaTeX temporary files
+ cleanps : remove files that are required to build .ps.gz
+ cleanpdf : remove files that are required to build  .pdf
+ cleanall : remove all generated files
+ cleansvg : cleans svg images headers

#Notes

You can specify a black & white output version by setting the 'nb' option in the file 'main.tex'. This mode is better for a printing result :

    \documentclass[nb]{thesis}
 
Note that svg figures can be automatically converted to grey levels if they are drawn excusively with [tango colors](http://en.wikipedia.org/wiki/Tango_Desktop_Project#Palette). Use the provided python script in utils/. Run :

     ./utils/grey.sh
     ./utils/tango2grey.py
     make

Some spelling/LaTeX mistakes in your files tex/my_chapter.tex can be automatically corrected with the application of the 'spelling.py' script. Run :

     ./utils/spelling.py
