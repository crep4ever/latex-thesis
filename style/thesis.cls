%=======================================================================
% Fichier      : thesis.cls
%=======================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2010/05/19]
\LoadClass[a4paper,twoside,12pt]{book}

%font
\RequirePackage{calligra}
\RequirePackage{inconsolata}
\RequirePackage{lmodern}
\RequirePackage[utf8]{inputenc}
\RequirePackage[english,frenchb]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{type1cm}

%index
\RequirePackage[algo2e,ruled,vlined,french]{algorithm2e}
\RequirePackage[francais]{minitoc}
\RequirePackage{makeidx}

%graphics
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{rotating}
\RequirePackage{multirow}
\RequirePackage{subfigure}

%math
\RequirePackage{amssymb}
\RequirePackage{amsfonts}
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage[squaren, Gray, cdot]{SIunits}

%layout
\RequirePackage{psfrag}
\RequirePackage{fancyhdr}
\RequirePackage{appendix}
\RequirePackage{layout}
\RequirePackage{makeidx}
\RequirePackage{xspace}
\RequirePackage{multicol}

%tools
\RequirePackage{ifmtarg}
\RequirePackage{nota}

%hyperref
\RequirePackage{ifpdf}
\definecolor{tango-green-1}{HTML}{8ae234}
\definecolor{tango-green-3}{HTML}{4e9a06}
\definecolor{tango-blue-3}{HTML}{204a87}
\definecolor{tango-red-3}{HTML}{a40000}

\newboolean{@soutenue}
\setboolean{@soutenue}{false}

\newif{\ifnb}
\DeclareOption{nb}{\nbtrue}
\ProcessOptions

\ifnb
\RequirePackage[hypertex,
hyperindex=false,
colorlinks=false]{hyperref}
\else
\RequirePackage[pdftex,
hyperindex=true,
pdfpagelabels,
bookmarks,
bookmarksopen,
colorlinks=true,
linkcolor=tango-red-3,
citecolor=tango-green-3,
urlcolor=tango-blue-3]{hyperref}
\fi

%-----------------------------------------------------------------------
%metadata
\ifpdf
\hypersetup{
pdfauthor = {Romain Goffe},%
pdftitle = {Pyramides irrégulières descendantes pour la segmentation de
  grandes images histologiques},%
pdfkeywords = {},%
pdfcreator = {PDFLaTeX},%
pdfproducer = {PDFLaTeX}}
\fi

%-----------------------------------------------------------------------
%figures
\graphicspath{ {fig/} }
\newlength{\FigSpacing}
\newlength{\FigWidth}
\newlength{\FigLength}

\setlength{\FigSpacing}{0.5cm}
\setlength{\FigWidth}{3cm}
\setlength{\FigLength}{3cm}

\newcommand{\image}[2][width=\FigWidth]{%
  \ifnb%
  \includegraphics[#1]{./grey/#2}%
  \else%
  \includegraphics[#1]{./pdf/#2}
  \fi%
}%

\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}
\subfigcapskip=.2cm

%-----------------------------------------------------------------------
% Set equal margins on book style
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
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{#1}{}}
 
\fancyhf{}
\fancyfoot[LE,RO]{\thepage}
\fancyhead[RE]{\textit{\nouppercase{\leftmark}}}
\fancyhead[LO]{\textit{\nouppercase{\rightmark}}}
 
\fancypagestyle{plain}{ %
\fancyhf{} % remove everything
\renewcommand{\headrulewidth}{0pt} % remove lines as well
\renewcommand{\footrulewidth}{0pt}}

%-----------------------------------------------------------------------
%renvois
\newcommand{\voir}[2]{%
  #2{\tiny$\blacktriangleleft$}%
  \marginpar{%
    \parbox[t]{.9\marginparwidth}{%
      {\small$\blacktriangleright$}{\footnotesize\sffamily\S\,\ref{#1}\,\\p.\,\pageref{#1}}
  }}
}

%-----------------------------------------------------------------------
%nota environment configuration
\newcommand{\ficnota}{nota}
\setlength{\largeurnota}{.8cm}
\newenvironment{nota}{%
  \begin{pictonote}{\ficnota}}{\end{pictonote}}

%----------------------------------------------------------------------
% more output text in terminal for \include macro
\let\includeORIG\include
\renewcommand{\include}[1]{%
  \typeout{============================================================}%
  \typeout{+ #1}%
  \typeout{============================================================}%  
  \includeORIG{#1}}

%-----------------------------------------------------------------------
% référence à une même note de fin de page
% exemple :
% une note\footnote{un note partagée\label{note1}} blablabla et je la
% partage ici\refnote{note1}. 
\def\refnote#1{\hbox{$^{\ref{#1}}$}}

%-----------------------------------------------------------------------
%Paragraphs
\setlength{\parskip}{0.5ex plus .2ex minus .2ex}
\renewcommand{\paragraph}[1]{\subsubsection*{#1}}

%Disable single lines at the start of a paragraph 
\clubpenalty = 10000
\widowpenalty = 10000
\displaywidowpenalty = 10000

%-----------------------------------------------------------------------
%Remove warnings
\setlength{\headheight}{15pt}
\pdfmapfile{+bsr.map}

%-----------------------------------------------------------------------
%Tables spacing
\renewcommand{\arraystretch}{1.2}

%-----------------------------------------------------------------------
%Additional toc entries
\newcommand{\addentry}[3]{
  \cleardoublepage%
  \phantomsection%
  \addcontentsline{#1}{#2}{#3}%
}

%-----------------------------------------------------------------------
%Index (fix pdfbookmark switching to entry list instead of Index title)
\makeatletter
\renewenvironment{theindex}
  {\if@twocolumn
      \@restonecolfalse
   \else
      \@restonecoltrue
   \fi
   \setlength{\columnseprule}{0pt}
   \setlength{\columnsep}{35pt}
   \begin{multicols}{2}[\chapter*{\indexname}]
   \markboth{\MakeUppercase\indexname}%
            {\MakeUppercase\indexname}%
   \thispagestyle{plain}
   \setlength{\parindent}{0pt}
   \setlength{\parskip}{0pt plus 0.3pt}
   \relax
   \let\item\@idxitem}%
  {\end{multicols}\if@restonecol\onecolumn\else\clearpage\fi}
\makeatother

%-----------------------------------------------------------------------
%Typo
\frenchspacing
\hyphenpenalty=4000
\tolerance=1000

%-----------------------------------------------------------------------
%Backcover
\newenvironment{abstract}{%
  \begin{center}%
    {\small \bfseries \abstractname\vspace{-.5em}}%
  \end{center}%
}%

\newenvironment{backcover}{%
  \footnotesize%
  \thispagestyle{empty}%
}%

\let\oldbackcover\backcover
\let\endoldbackcover\endbackcover
\renewenvironment{backcover}%
{\begin{samepage}\begin{oldbackcover}}%
{\end{oldbackcover}\end{samepage}}

%-----------------------------------------------------------------------
