######################################################################
# Makefile
#
# Auteur : Romain Goffe
#          Guillaume Née <guillaume.nee@greyc.ensicaen.fr>
# Creation : 20 May 2010
#
# Fichier de configuration de la commande make
#
######################################################################

######################## Option de lancement #########################
#
# Par défaut un appel à la commande make génèrera le pdf
# ps : génére le manuscrit au format ps
# pdf : génère le manuscrit au format pdf
# clean : nettoyage des fichiers de backup
# cleanps : nettoyage des fichiers servants à générer le .ps.gz
# cleanpdf : nettoyage des fichiers servants à générer le pdf
# cleanall : nettoyage complet des fichiers compilés et images générée
#
######################################################################

######################## Dépendances #################################
#
# latex, pdflatex, inkscape, xfig, imagemagick(convert)
#
######################################################################

SOURCES	:= manuscrit.tex #$(shell egrep -l '^[^%]*\\begin\{document\}' *.tex)
CIBLE = $(SOURCES:%.tex=%)
AUX = $(SOURCES:%.tex=%.aux)
BIBLIO := $(`perl -ne '($$_)=/^[^%]*\\\bibliography\{(.*?)\}/;@_=split /,/; foreach $$b (@_) { print "$$b.bib "}'`) $(SOURCES)
BIB = $(SOURCES:%.tex=%.bbl)

# Figures directory
FIG_DIR = fig

# Sources for image files
FIGSRC_DIR = $(FIG_DIR)/src

# Destination directories for generated images
EPS_DIR = $(FIG_DIR)/eps
PDF_DIR = $(FIG_DIR)/pdf
TEX_DIR = $(FIG_DIR)/tex

# Various sources files
XFIGS  = $(wildcard $(FIGSRC_DIR)/*.fig)
IMAGES = $(wildcard $(FIGSRC_DIR)/*.gif) \
	$(wildcard $(FIGSRC_DIR)/*.jpg) \
	$(wildcard $(FIGSRC_DIR)/*.eps) \
	$(wildcard $(FIGSRC_DIR)/*.pdf) \
	$(wildcard $(FIGSRC_DIR)/*.svg)

IMG_PNG = $(wildcard $(FIGSRC_DIR)/*.png)

EPS  = $(foreach file, $(XFIGS), $(EPS_DIR)/$(basename $(notdir $(file))).eps)
EPS += $(foreach file, $(IMAGES), $(EPS_DIR)/$(basename $(notdir $(file))).eps)
EPS += $(foreach file, $(IMG_PNG), $(EPS_DIR)/$(basename $(notdir $(file))).eps)

PDF  = $(foreach file, $(XFIGS), $(PDF_DIR)/$(basename $(notdir $(file))).pdf)
PDF += $(foreach file, $(IMAGES), $(PDF_DIR)/$(basename $(notdir $(file))).pdf)
PDF += $(foreach file, $(IMG_PNG), $(PDF_DIR)/$(basename $(notdir $(file))).png)

TEX  = $(foreach file, $(XFIGS), $(TEX_DIR)/$(basename $(notdir $(file))).tex) 
TEX += $(wildcard /*.tex)


############################################################
### Cibles

default: pdf

ps: LATEX = latex
ps: $(CIBLE).ps.gz
#	gv $<

pdf: LATEX = pdflatex
pdf: $(CIBLE).pdf
#	evince $<

clean:
	@rm -f $(AUX) $(CIBLE).toc
	@rm -f $(CIBLE).dvi $(CIBLE).out $(CIBLE).log $(CIBLE).nav $(CIBLE).snm
	@rm -f $(BIB) $(BIB:%.bbl=%.blg)
	@rm -f *.aux *.log *.out

cleanps: clean
	@rm -f $(EPS) $(TEX) $(CIBLE).ps.gz

cleanpdf: clean
	@rm -f $(PDF) $(CIBLE).pdf

cleanall: cleanps cleanpdf

############################################################

$(AUX): $(SOURCES)
	$(LATEX) $(SOURCES)

$(CIBLE).bbl: $(AUX) $(BIBLIO)
	bibtex $(AUX:%.aux=%)
	$(LATEX) $(SOURCES)

$(CIBLE).ps.gz: $(CIBLE).ps
	gzip -f $(CIBLE).ps

$(CIBLE).ps: $(CIBLE).dvi
	dvips $(CIBLE).dvi -o

$(CIBLE).dvi: $(EPS) $(TEX) $(AUX) $(BIB)
	$(LATEX) $(CIBLE).tex

$(CIBLE).pdf: $(PDF) $(TEX) $(AUX) $(BIB)
	$(LATEX) $(CIBLE).tex

$(EPS_DIR)/%.eps: $(FIGSRC_DIR)/%.fig
	fig2dev -L pstex $< $@

$(EPS_DIR)/%.eps: $(FIGSRC_DIR)/%.jpg
	convert $< EPS:$@

$(EPS_DIR)/%.eps: $(FIGSRC_DIR)/%.png
	convert $< EPS:$@

$(EPS_DIR)/%.eps: $(FIGSRC_DIR)/%.gif
	convert $< EPS:$@

$(EPS_DIR)/%.eps: $(FIGSRC_DIR)/%.eps
	cp $< $@

$(EPS_DIR)/%.eps: $(FIGSRC_DIR)/%.svg
	inkscape $< --export-eps=$@

$(PDF_DIR)/%.pdf: $(FIGSRC_DIR)/%.fig
	fig2dev -L pdftex $< $@

$(PDF_DIR)/%.pdf: $(FIGSRC_DIR)/%.jpg
	convert $< EPDF:$@

$(PDF_DIR)/%.pdf: $(FIGSRC_DIR)/%.eps
	convert $< EPDF:$@

$(PDF_DIR)/%.pdf: $(FIGSRC_DIR)/%.pdf
	cp $< $@

$(PDF_DIR)/%.pdf: $(FIGSRC_DIR)/%.svg
	inkscape $< --export-pdf=$@

$(PDF_DIR)/%.png: $(FIGSRC_DIR)/%.png
	cp $< $@

$(TEX_DIR)/%.tex: $(FIGSRC_DIR)/%.fig
	fig2dev -L pdftex_t -p $(*F) $< $@
