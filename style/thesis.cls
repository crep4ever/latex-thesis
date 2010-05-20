%=======================================================================
% Fichier      : greycthesis.cls
% Title        : 
% Auteur       : <guillaume.nee@greyc.ensicaen.fr>
% Creation     : mer. mai 19, 2010  17:49 
% Modification : 
%=======================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{greycthesis}[2010/05/19]

\LoadClass[a4paper,twoside,12pt]{book}

\RequirePackage{ifpdf}
\RequirePackage{graphicx,amsfonts,amsmath,amssymb,psfrag,fancyhdr,appendix,subfigure}
\RequirePackage{layout}
\RequirePackage[sectionbib]{natbib}
\RequirePackage{chapterbib}
\RequirePackage{makeidx} % pour l'index
\RequirePackage[francais]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage{xcolor}

\ifpdf % moteur pdflatex
\RequirePackage[pdftex,
hyperindex=true,
pdfpagelabels,
colorlinks=true]{hyperref}
\else% moteur tex
\RequirePackage[hypertex,
hyperindex=false,
colorlinks=false]{hyperref}
\fi

% % Set equal margins on book style
\setlength{\oddsidemargin}{30pt}
\setlength{\evensidemargin}{30pt}
\setlength{\marginparwidth}{45pt}
\setlength{\footskip}{30pt}
\setlength{\textwidth}{400pt}

% Redefine plain page style
\fancypagestyle{plain}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[LE,RO]{\thepage}
}

% Code for creating empty pages
% No headers on empty pages before new chapter
\makeatletter
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
  \hbox{}
  \thispagestyle{plain}
  \newpage
  \if@twocolumn\hbox{}\newpage\fi\fi\fi}
\makeatother \clearpage{\pagestyle{plain}\cleardoublepage}

% Define pagestyle
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\chaptermark}[1]{\markboth{ \emph{#1}}{}}
\fancyhead[LO]{}
\fancyhead[RE]{\leftmark}
\fancyfoot[LE,RO]{\thepage}

