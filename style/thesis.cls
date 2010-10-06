%=======================================================================
% Fichier      : thesis.cls
% Title        : 
% Auteurs      : ``Guillaume Nee <guillaume.nee@greyc.ensicaen.fr>'', 
%                ``Romain Goffe <romain.goffe@gmail.com>''
% Creation     : mer. mai 19, 2010  17:49 
% Modification : 
%=======================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2010/05/19]

\LoadClass[a4paper,twoside,12pt]{book}

\RequirePackage{ifpdf}

\RequirePackage[utf8]{inputenc}
\RequirePackage[english,frenchb]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{type1cm}
\RequirePackage{lmodern}

\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{rotating}
\RequirePackage{multirow}
\RequirePackage{subfigure}

\RequirePackage{amssymb}
\RequirePackage{amsfonts}
\RequirePackage{amsmath}
\RequirePackage{amsthm}

\RequirePackage{psfrag}
\RequirePackage{fancyhdr}
\RequirePackage{appendix}
\RequirePackage{layout}
\RequirePackage{makeidx}

\RequirePackage{nota}
\RequirePackage[algo2e,ruled,vlined,french]{algorithm2e}

\RequirePackage[francais]{minitoc}

\definecolor{tango-green-1}{HTML}{8ae234}
\definecolor{tango-green-3}{HTML}{4e9a06}
\definecolor{tango-blue-3}{HTML}{204a87}
\definecolor{tango-red-3}{HTML}{a40000}

\newif{\ifnb}
\DeclareOption{nb}{\nbtrue}
\ProcessOptions

\ifnb % moteur pdflatex
\RequirePackage[hypertex,
hyperindex=false,
colorlinks=false]{hyperref}
\else% moteur tex
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
%figures
\newlength{\FigSpacing}
\newlength{\FigWidth}
\newlength{\FigLength}

\setlength{\FigSpacing}{0.5cm}
\setlength{\FigWidth}{3cm}
\setlength{\FigLength}{3cm}

\ifnb%
\newcommand{\image}[1]{\includegraphics[width=\FigWidth]{./grey/#1}}%
\else%
\newcommand{\image}[1]{\includegraphics[width=\FigWidth]{./pdf/#1}}
\fi

\ifnb%
\newcommand{\Image}[2]{\includegraphics[width=#1]{./grey/#2}}%
\else%
\newcommand{\Image}[2]{\includegraphics[width=#1]{./pdf/#2}}
\fi
%-----------------------------------------------------------------------

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
% configuration de l'environnement nota
\newcommand{\ficnota}{nota}
\setlength{\largeurnota}{.8cm}
\newenvironment{nota}{%
  \begin{pictonote}{\ficnota}}{\end{pictonote}}
%----------------------------------------------------------------------
% pour faire parler \include dans le terminal
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
% partage ici\refnote{note1}. C'est pas beau ça ?? (vient du package
% french)
\def\refnote#1{\hbox{$^{\ref{#1}}$}}

%-----------------------------------------------------------------------
%Espacement des paragraphes
\setlength{\parskip}{0.5ex plus .2ex minus .2ex}

%-----------------------------------------------------------------------
%Suppression des warnings
\setlength{\headheight}{15pt}
\pdfmapfile{+bsr.map}

%-----------------------------------------------------------------------
%Mini-sommaire par chapitre
\setcounter{minitocdepth}{1}



