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
\RequirePackage{graphicx,amsfonts,amsmath,amssymb,amsthm,psfrag,fancyhdr,appendix,subfigure}
\RequirePackage{layout}
%\RequirePackage[sectionbib]{natbib}
%\RequirePackage{chapterbib}
\RequirePackage{makeidx} % pour l'index
\RequirePackage[english,frenchb]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{xcolor}
\RequirePackage[algo2e,ruled,vlined,french]{algorithm2e}
\RequirePackage{nota}
%\RequirePackage{MnSymbol}
%\RequirePackage{thesischapter}

\definecolor{tango-green-1}{HTML}{8ae234}
\definecolor{tango-green-3}{HTML}{4e9a06}
\definecolor{tango-blue-3}{HTML}{204a87}
\definecolor{tango-red-3}{HTML}{a40000}

\ifpdf % moteur pdflatex
\RequirePackage[pdftex,
hyperindex=true,
pdfpagelabels,
bookmarks,
bookmarksopen,
colorlinks=true,
linkcolor=tango-red-3,
citecolor=tango-green-3,
urlcolor=tango-blue-3]{hyperref}
\else% moteur tex
\RequirePackage[hypertex,
hyperindex=false,
colorlinks=false]{hyperref}
\fi

%-----------------------------------------------------------------------
% figures en noir & blanc
\newif{\ifnb}
\DeclareOption{nb}{\nbtrue}
\ProcessOptions
%-----------------------------------------------------------------------
\ifnb%
%\newcommand{\image}[2]{\IfFileExists{./grey/#2.pdf}{\includegraphics[width=#1]{./grey/#2}}{\includegraphics[width=#1]{./pdf/#2}}}%
\newcommand{\image}[2]{\includegraphics[width=#1]{./grey/#2}}%
\else%
\newcommand{\image}[2]{\includegraphics[width=#1]{./pdf/#2}}
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
\fancyhf{}
\renewcommand{\chaptermark}[1]{\markboth{ \emph{#1}}{}}
\fancyhead[LO]{}
\fancyhead[RE]{\leftmark}
\fancyfoot[LE,RO]{\thepage}

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
