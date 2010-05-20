SRC := $(wildcard *.tex)

SOURCES := $(shell egrep -l '^[^%]*\\begin\{document\}' *.tex)

CIBLE = $(SOURCES:%.tex=%)

PDF = $(CIBLE:%=%.pdf)
PSF = $(CIBLE:%=%.ps.gz)

# Sources for image files
FIG_DIR = fig

# Destination directories for generated images
EPS_DIR = $(FIG_DIR)/eps
PDF_DIR = $(FIG_DIR)/pdf
TEX_DIR = $(FIG_DIR)/tex

# Various sources files
XFIGS  = $(wildcard $(FIG_DIR)/*.fig)
IMAGES = $(wildcard $(FIG_DIR)/*.gif) $(wildcard $(FIG_DIR)/*.jpg) $(wildcard $(FIG_DIR)/*.eps) $(wildcard $(FIG_DIR)/*.pdf) $(wildcard $(FIG_DIR)/*.svg)

IMG_PNG = $(wildcard $(FIG_DIR)/*.png)

IMG_EPS  = $(foreach file, $(XFIGS), $(EPS_DIR)/$(basename $(notdir $(file))).eps)
IMG_EPS += $(foreach file, $(IMAGES), $(EPS_DIR)/$(basename $(notdir $(file))).eps)
IMG_EPS += $(foreach file, $(IMG_PNG), $(EPS_DIR)/$(basename $(notdir $(file))).eps)

IMG_PDF  = $(foreach file, $(XFIGS), $(PDF_DIR)/$(basename $(notdir $(file))).pdf)
IMG_PDF += $(foreach file, $(IMAGES), $(PDF_DIR)/$(basename $(notdir $(file))).pdf)
IMG_PDF += $(foreach file, $(IMG_PNG), $(PDF_DIR)/$(basename $(notdir $(file))).png)

IMG_TEX  = $(foreach file, $(XFIGS), $(TEX_DIR)/$(basename $(notdir $(file))).tex)

# Pogramms
BIBTEX=bibtex
ECHO=echo

# Get dependencies (that can also have dependencies)
define get_dependencies
	deps=`perl -ne '($$_)=/^[^%]*\\\(?:include|input)\{(.*?)\}/;@_=split /,/; foreach $$t (@_) { print "$$t "}' $<`
endef

# Get related bibliographies
define get_bibliographies
	@$(get_dependencies) ; bibs=`perl -ne '($$_)=/^[^%]*\\\bibliography\{(.*?)\}/;@_=split /,/; foreach $$b (@_) { print "$$b.bib "}' $< $$deps`
endef

# Get graphics files
define get_pdf_graphics
	@$(get_dependencies) ; graphics=`perl -ne '@foo=/^[^%]*\\\includegraphics(<.*>)?(\[.*?\])?\{(.*?)\}/;if (defined($$foo[2])) { if ( -e "$(FIG_DIR)/$$foo[2].png" ) { print "$(PDF_DIR)/$$foo[2].png "; } else { print "$(PDF_DIR)/$$foo[2].pdf "; }}' $< $$deps`
endef
define get_eps_graphics
	@$(get_dependencies) ; graphics=`perl -ne '@foo=/^[^%]*\\\includegraphics(<.*>)?(\[.*?\])?\{(.*?)\}/;if (defined($$foo[2])) { print "$(EPS_DIR)/$$foo[2].eps "; }' $< $$deps`
endef

############################################################
### Cibles

default: pdf

ps: $(PSF)
	gv $<

pdf: $(PDF)
	evince $<

clean:
	@rm -f $(SRC:%.tex=%.d)
	@rm -f $(CIBLE:%=%.aux) 
	@rm -f $(CIBLE:%=%.toc)
	@rm -f $(CIBLE:%=%.out) 
	@rm -f $(CIBLE:%=%.log) 
	@rm -f $(CIBLE:%=%.nav) 
	@rm -f $(CIBLE:%=%.snm)
	@rm -f $(CIBLE:%=%.dvi)
	@rm -f $(CIBLE:%=%.blg)
	@rm -f $(CIBLE:%=%.bbl)
	@rm -f thesis.bib

cleanall: clean
	@rm -f $(IMG_EPS) $(IMG_PDF) $(IMG_TEX)
	@rm -f $(PDF) $(PSF)

depend:

############################################################

# ps generation related rules
$(PSF): LATEX=latex

$(PSF): %.ps.gz: %.ps
	gzip -f $<

%.ps: %.dvi
	dvips -o $@ $<

# pdf generation related rules
$(PDF): LATEX=pdflatex
$(PDF): %.pdf: %.tex %.aux

%.aux: %.tex
	$(LATEX) $< 

%.d: %.tex
	@$(get_eps_graphics) ; $(ECHO) $(patsubst %.tex,%,$<)_EPS_GRAPHICS="$$graphics" > $@ 
	@$(get_pdf_graphics) ; $(ECHO) $(patsubst %.tex,%,$<)_PDF_GRAPHICS="$$graphics" >> $@ 
	@$(get_dependencies) ; $(ECHO) $< $@: $$deps >> $@
	@$(get_dependencies) ; $(ECHO) $(patsubst %.tex,%.aux,$<): $$deps >> $@
	@$(get_bibliographies) ; if [ "$$bibs" ]; then $(ECHO) $(patsubst %.tex,%.dvi,$<): $$\($(patsubst %.tex,%,$<)_EPS_GRAPHICS\) $(patsubst %.tex,%.aux,$<) $(patsubst %.tex,%.bbl,$<) >> $@ ; $(ECHO) "\t"$$\(LATEX\) $< >> $@ ; $(ECHO) $(patsubst %.tex,%.pdf,$<): $$\($(patsubst %.tex,%,$<)_PDF_GRAPHICS\) $(patsubst %.tex,%.aux,$<) $(patsubst %.tex,%.bbl,$<) >> $@ ; $(ECHO) "\t"$$\(LATEX\) $< >> $@ ; $(ECHO) $(patsubst %.tex,%.bbl,$<) :  $(patsubst %.tex,%.aux,$<) $$bibs >> $@ ; $(ECHO) "\t"$$\(BIBTEX\) $(patsubst %.tex,%,$<) >> $@ ; $(ECHO) "\t"$$\(LATEX\) $< >> $@ ; else $(ECHO) $(patsubst %.tex,%.dvi,$<): $$\($(patsubst %.tex,%,$<)_EPS_GRAPHICS\) $(patsubst %.tex,%.aux,$<) >> $@ ; $(ECHO) "\t"$$\(LATEX\) $< >> $@ ; $(ECHO) $(patsubst %.tex,%.pdf,$<): $$\($(patsubst %.tex,%,$<)_PDF_GRAPHICS\) $(patsubst %.tex,%.aux,$<) >> $@ ; $(ECHO) "\t"$$\(LATEX\) $< >> $@ ;fi;

include $(SOURCES:%.tex=%.d)

# figures related rules
$(EPS_DIR)/%.eps: $(FIG_DIR)/%.fig
	fig2dev -L pstex $< $@

$(EPS_DIR)/%.eps: $(FIG_DIR)/%.jpg
	convert $< EPS:$@

$(EPS_DIR)/%.eps: $(FIG_DIR)/%.png
	convert $< EPS:$@

$(EPS_DIR)/%.eps: $(FIG_DIR)/%.gif
	convert $< EPS:$@

$(EPS_DIR)/%.eps: $(FIG_DIR)/%.eps
	cp $< $@

$(EPS_DIR)/%.eps: $(FIG_DIR)/%.svg
	inkscape $< --export-eps=$@

$(PDF_DIR)/%.pdf: $(FIG_DIR)/%.fig
	fig2dev -L pdftex $< $@

$(PDF_DIR)/%.pdf: $(FIG_DIR)/%.jpg
	convert $< EPDF:$@

$(PDF_DIR)/%.pdf: $(FIG_DIR)/%.eps
	convert $< EPDF:$@

$(PDF_DIR)/%.pdf: $(FIG_DIR)/%.pdf
	cp $< $@

$(PDF_DIR)/%.pdf: $(FIG_DIR)/%.svg
	inkscape $< --export-pdf=$@

$(PDF_DIR)/%.png: $(FIG_DIR)/%.png
	cp $< $@

$(TEX_DIR)/%.tex: $(FIG_DIR)/%.fig
	fig2dev -L pdftex_t -p $(*F) $< $@

thesis.bib: 
	cat `find bibtex -type f` > $@
