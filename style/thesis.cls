%  thesis --- style these pour LaTeX2e
%             inspiré de plusieurs style de thèse differents
%             avec notamment :
%              - S. Horna
%              - P. Denis
%              - J. Dombre
%              - G. Damiand
%
%  PACKAGES REQUIRED:
%
%  - ifthen        (in latex2e/base/ifthen.sty)
%  - floatfig      (in latex209/contrib/floatfig/floatfig.sty)
%
%%%%%%%%%%%%%%%%%%%%%%%% Identification Part %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\NeedsTeXFormat{LaTeX2e}[1994/12/01]
%
\ProvidesClass{thesis}[2009/09/06]
%
% Pour les structures conditionnellles
\RequirePackage{ifthen}

% Packages de mise en forme pour la page de garde
\RequirePackage{soul}

% Pour utiliser la police times (surtout pour pdf)
\RequirePackage{times}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newboolean{@widepage}
\setboolean{@widepage}{true}
\newboolean{@headings}
\setboolean{@headings}{true}
\newboolean{@dblspace}
\setboolean{@dblspace}{false}
\newboolean{@minitoc}
\setboolean{@minitoc}{false}
%\newboolean{@twoside}
\setboolean{@twoside}{false}
\newboolean{@soutenue}
\setboolean{@soutenue}{true}
%
\def\centerfoot{}%
\def\datefoot{}%
%
%
%%%%%%%%%%%%%%%%%%%%%% Declaration of Options %%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\DeclareOption{a4paper}{%
  \setboolean{@widepage}{false}%
}
%
\DeclareOption{dblspace}{%
  \setboolean{@dblspace}{true}%
}
%
\DeclareOption{noheadings}{%
  \setboolean{@headings}{false}
}
%
\DeclareOption{twoside}{
  \setboolean{@twoside}{true}
}
%
\DeclareOption{minitoc}{%
  \setboolean{@minitoc}{true}
}
%
\DeclareOption{nonsoutenue}{%
  \setboolean{@soutenue}{false}
}
%

%
%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
%
%%%%%%%%%%%%%%%%%%%%%%% Execution of Options %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\ExecuteOptions{11pt}
%
\ProcessOptions
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%% Package Loading %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

\RequirePackage{fancyhdr}

\AtBeginDocument{%
  \ifthenelse{\boolean{@headings}}{
    
    \setlength{\headheight}{15pt}
    \pagestyle{fancy}
    
    % se souvenir du numero et du titre des chapitres spéciaux
    % (\chapter*, annexes, etc.)
    \renewcommand{\schaptermark}[1]{
      \markboth{\MakeUppercase{#1}}{\MakeUppercase{#1}}
    }

    % se souvenir du numero et du titre des chapitres normaux
    \renewcommand{\chaptermark}[1]{
      % \markboth{#1}{#1}
      \markboth{
        \MakeUppercase{\if@mainmatter \@chapapp\ \thechapter~-~\fi #1}
      }{
        \MakeUppercase{\if@mainmatter \@chapapp\ \thechapter. \fi #1}
      }
      \thispagestyle{empty}%
    }

    % se souvenir du numero et du titre de la section
    \renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
  }
}

\ifthenelse{\boolean{@headings}}{
  \if@twoside%
  % on met a droite pour les pages paires le nom du chapitre
  \fancyhead[RE]{\bf \leftmark}     %Right Even = droite paire
  % on met le numero de la page a droite pour les pages impaires et a gauche pour les pages paires
  \fancyhead[RO,LE]{\bf \thepage}   %Right Odd, Left Even
  % on met a gauche pour les pages impaires le nom de la section
  \fancyhead[LO]{\bf \rightmark}    % Left Odd
  \fancyfoot{}  %on ne veut rien mettre en pied de page  
  \else
  \fancyhead[R]{\bf \thepage}
  \fancyhead[L]{\bf \rightmark}
  \fi
}{
  \fancyhead{}
  \fancyfoot{}
}

\if@widepage\else\PassOptionsToClass{a4paper}{book}\fi
\if@twoside\PassOptionsToClass{twoside}{book}\fi

\LoadClass{book}

%
%
%%%%%%%%%%%%%%%%%%%%%%%%%% Special commands %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
\AtBeginDocument{

}
\AtEndOfPackage{}

%\renewcommand{\mainmatter}{%
%  \if@openright
%    \cleardoublepage
%  \else
%    \clearpage
%  \fi
%  \@mainmattertrue
%  \pagenumbering{arabic}
%  \pagestyle{fancy}
%}

%%
%% Traitement de quelques options
%%
%
%
%
% format de la page : a4 "large" (a4wide) ou a4 par d\'efaut (a4paper)
%
\ifthenelse{\boolean{@widepage}}{% a4wide
  \RequirePackage[
  a4paper % paper size
  ,includeheadfoot % include header and footer into text size
% ,hmarginratio=2:3 % ratio between inner and outer margin (default)
  ,outer=2.1cm % outer margin (right)
  ,vmarginratio=6:5 % ratio between top and bottom margin
  ,bmargin=2cm % bottom margin
  ,bindingoffset=1.7cm % space reserved to bound pages together
  ]{geometry}
}{}

%%
%%
%% Mise en page generale
%%
%
% Probleme du placement des figures
%
%\renewcommand{\topfraction}{0.85}       % une figure peut occuper 85%
%                                         % du haut de la page.
%\renewcommand{\bottomfraction}{0.85}
% \renewcommand{\floatpagefraction}{0.8} % une figure peut occuper 85%
                                        % d'une page
%\setcounter{totalnumber}{4} % jusqu'a` 4 figures par page.
%\setlength{\floatsep}{0cm}
%\renewcommand{\topfraction}{1}         % déf. 0.7 % lmo97 1   % remplissage haut
%\renewcommand{\bottomfraction}{1}      % déf. 0.3 % lmo97 1   % remplissage bas
%\renewcommand{\textfraction}{0}        % déf. 0.2 % lmo97 0   % remplissage texte / page
%\renewcommand{\floatpagefraction}{0.8} % déf. 0.5 % lmo97 0.8 % remplissage floatpage

%
% Paragraphe en fin et debut de page.
%
% Disable single lines at the start of a paragraph 
\clubpenalty = 10000
\widowpenalty = 10000
\displaywidowpenalty = 10000


%%%%%%%%%%%%%%%%%%%%%%%%% PAGE DE TITRE %%%%%%%%%%%%%%%%%%%%%%%%%

% le numero d'identification
\def\@nid{}
\newcommand{\nid}[1]{
\gdef\@nid{#1}}

%%%% debut : \author
\def\@author{}
\def\@authorfirstname{}
\def\@authorlastname{}
\renewcommand{\author}[2]{
  \gdef\@author{{#1} {#2}}
  \gdef\@authorfirstname{#1}
  \gdef\@authorlastname{#2}
}%% fin : \author

%%%% debut : \director
\def\@director{}
\def\@directorfirstname{}
\def\@directorlastname{}
\newcommand{\director}[2]{
  \gdef\@director{{#1} {#2}}
  \gdef\@directorfirstname{#1}
  \gdef\@directorlastname{#2}
}%% fin : \director

%%%% debut : \directorAd
\def\@directorAd{}
\def\@directorfirstnameAd{}
\def\@directorlastnameAd{}
\newcommand{\directorAd}[2]{
  \gdef\@directorAd{{#1} {#2}}
  \gdef\@directorfirstnameAd{#1}
  \gdef\@directorlastnameAd{#2}
}%% fin : \directorAd

%\def\@directorAdA{}
%\def\@directorfirstnameAdA{}
%\def\@directorlastnameAda{}
%\newcommand{\directorAdA}[2]{
%        \gdef\@directorAdA{{#1} {#2}}
%        \gdef\@directorfirstnameAdA{#1}
%        \gdef\@directorlastnameAdA{#2}
%}


%%%% debut : \academy
\def\@academy{}
\newcommand{\academy}[1] {
  \gdef\@academy{#1}
}%% fin : \academy

%%%% debut : \university
\def\@university{}
\def\@universityother{}
\def\@universityotherlong{}
\newcommand{\university} [3] {
  \def\@university{#1}
  \def\@universityother{#2}
  \def\@universityotherlong{#3}
}%% fin : \university

%%%% debut : \doctoralschool
\def\@specialty{}
\def\@doctoralschool{}
\newcommand{\doctoralschool} [2] {
  \gdef\@specialty{#1}
  \gdef\@doctoralschool{#2}
}%% fin : \doctoralschool

%%%% debut : \@longtitle
\def\@title{}
\newcommand{\@longtitle}{
  \ifthenelse{\equal{\@subtitle}{}}
  { \begin{center}
      \huge{\bf\@title}       
    \end{center}}
  { \begin{center}
      \huge{\bf\@title}\par \vspace{\stretch{1}} \Large{\bf\@subtitle}
    \end{center}}
}%% fin : \@longtitle

%%%% debut : \subtitle
\def\@subtitle{}
\newcommand{\subtitle}[1]{
        \gdef\@subtitle{#1}
}%% fin : \subtitle

%%%% debut : \addjurydirth
\def\@jurydirth{}
\newcommand{\addjurydirth}[3]{
    \xdef\@jurydirth {\@jurydirth \centerline{#1, #2, #3 \dotfill Directeur de Th\`ese}}%
}%% fin : \addjurydirth

%%%% debut : \addjurycodirth
\def\@jurycodirth{}
\newcommand{\addjurycodirth}[3]{
    \xdef\@jurycodirth {\@jurycodirth \centerline{#1, #2, #3 \dotfill Co-encadrant de Th\`ese}}%
}%% fin : \addjurycodirth

%%%% debut : \addjuryrapport
\def\@juryrapport{}
\newcommand{\addjuryrapport}[3]{
    \xdef\@juryrapport {\@juryrapport \centerline{#1, #2, #3 \dotfill Rapporteur}}%
  %  \vspace{.13cm}
}%% fin : \addjuryrapport

%%%% debut : \addjurypres
\def\@jurypres{}
\newcommand{\addjurypres}[3]{
    \xdef\@jurypres {\@jurypres \centerline{#1, #2, #3 \dotfill Pr\'esident du Jury}}%
}%% fin : \addjurypres

%%%% debut : \addjuryexam
\def\@juryexam{}
\newcommand{\addjuryexam}[3]{
    \xdef\@juryexam {\@juryexam \centerline{#1, #2, #3 \dotfill Examinateur}}%
}%% fin : \addjuryexam

%%%% debut : \addjuryinvit
\def\@juryinvit{}
\newcommand{\addjuryinvit}[3]{
    \xdef\@juryinvit {\@juryinvit \centerline{#1, #2, #3 \dotfill Invit\'e}}%
}%% fin : \addjuryinvit

%%%% debut : \@makethesisinfobanner
\newcommand{\@makethesisinfobanner}{
    \centerline{\huge \bf Th\`ese}%
    \vspace{\stretch{4}}%
    \centerline{ \large pour l'obtention du grade de}
    \vspace{\stretch{1}}%
    \centerline{ \LARGE \sc Docteur de l'\@universityotherlong}
    \vspace{\stretch{1}}%
    \centerline{ \large \textbf{\@universityother}}
    \centerline{ \large (Dipl\^ome National - Arr\^et\'e du 7 Ao\^ut 2006)}
    \vspace{\stretch{2}}
    {
      \large
      \begin{center}
        \begin{tabular}{l@{~~:~~}l}
          \emph{\'Ecole Doctorale}    & {\bf \@doctoralschool} \cr
          \emph{Secteur de Recherche} & {\bf \@specialty}      \cr
        \end{tabular} 
      \end{center}
    }
}%% fin : \@makethesisinfobanner

%%%% debut : \@makethesistitlebanner
\newcommand{\@makethesistitlebanner}{
   \centerline{\large pr\'esent\'ee par :}
   \vspace{\stretch{2}}%
   \centerline{\LARGE {\@authorfirstname} {\sc \@authorlastname}}
   \vspace{\stretch{4}}%
   \@longtitle
   \vspace{\stretch{6}}%
   \centerline{\large Directeurs de th\`ese :}
   \vspace{\stretch{1}}%
   \centerline{\Large {\@directorfirstname} {\sc \@directorlastname}}
   \vspace{\stretch{1}}%
   \centerline{\Large {\@directorfirstnameAd} {\sc
       \@directorlastnameAd}}
%   \vspace{\stretch{1}}%
%   \centerline{\Large {\@directorfirstnameAdA} {\sc \@directorlastnameAdA}}

}%% fin : \@makethesistitlebanner

%%%% debut : \@makejurybanner
\newcommand{\@makejurybanner}{
  \begin{footnotesize}
    \ifthenelse{\boolean{@soutenue}}%
    {
      \centerline{Soutenue le {\@date} devant le jury compos\'e de :}
    }
    {
      \centerline{Soutenance pr\'evue le {\@date} devant le jury compos\'e de :}
    }
    \medskip
    \ifthenelse{\equal{\@jurypres}{}}{}
    {
      \@for \@name := \@jurypres \do {\@name}%
      \vspace{.13cm}
    }%
    \@for \@name := \@juryrapport \do {\@name}%
    \vspace{.13cm}%
    \@for \@name := \@juryexam \do {\@name}%
    \vspace{.13cm}%
    \@for \@name := \@jurydirth \do {\@name}%
    \vspace{.13cm}%
    \@for \@name := \@jurycodirth \do {\@name}%
    \vspace{.13cm}%
    \@for \@name := \@juryinvit \do {\@name}%
  \end{footnotesize}
}%% fin : \@makejurybanner

%%%% debut : \@makethesistitle
\newcommand{\@makethesistitle}{
  \begin{titlepage}
    \ifthenelse{\equal{\@nid}{}}{}
    {
      {\footnotesize Num\'ero d'identification :}~\@nid\hfill\hfill\par
      \vspace{.8cm}
    }
    
    \@makethesisinfobanner
    \vspace{\stretch{8}}
    
    \@makethesistitlebanner
    
    \vspace{\stretch{10}}
    \@makejurybanner
  \end{titlepage}
}%% fin : \@makethesistitle

%%%% debut : \maketitle
\renewcommand{\maketitle}{
  \@makethesistitle
  \thispagestyle{empty}
  \newpage
}%% fin :\maketitle

%%%%%%%%%%%%%%%%%%%%%%%FIN PAGE DE TITRE %%%%%%%%%%%%%%%%%%%%%%%%

%%
%%
%%  Definitions relatives aux differentes tables
%%
%%  
\def\setstyletable#1{\gdef\styles@tables{#1}}
\setstyletable{plain}
% 
\renewcommand{\tableofcontents}{%
  \if@twocolumn
  \@restonecoltrue\onecolumn
  \else
  \@restonecolfalse
  \fi
  \chapter*{\contentsname}%
  \thispagestyle{\styles@tables}
  % \addtolength{\headheight}{\@ptsize pt}\addtolength{\headheight}{\@ptsize pt}
  \@starttoc{toc}%
  \if@restonecol\twocolumn\fi
}
%% 
%%
\renewcommand{\listoffigures}{%
  \if@twocolumn
  \@restonecoltrue\onecolumn
  \else
  \@restonecolfalse
  \fi
  \chapter*{\listfigurename}%
  \thispagestyle{\styles@tables}
  \addtolength{\headheight}{\@ptsize pt}\addtolength{\headheight}{\@ptsize pt}
  \@starttoc{lof}%
  \if@restonecol\twocolumn\fi
}
%%
%%
\renewcommand{\listoftables}{%
  \if@twocolumn
  \@restonecoltrue\onecolumn
  \else
  \@restonecolfalse
  \fi
  \chapter*{\listtablename}%
  \thispagestyle{\styles@tables}
  \addtolength{\headheight}{\@ptsize pt}\addtolength{\headheight}{\@ptsize pt}
  \@starttoc{lot}%
  \if@restonecol\twocolumn\fi
}
%%
%%
\renewenvironment{thebibliography}[1]{
  \chapter*{\bibname}
  \addcontentsline{toc}{chapter}{\bibname}
  \thispagestyle{plain}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
  {\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy\clubpenalty4000\widowpenalty4000%
  \sfcode`\.\@m
}
{
  \def\@noitemerr
  {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
}

\newcommand*{\schaptermark}[1]{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ce qu'il faut dessiner en tete de chaque chapitre
\def\thickhrulefill{\leavevmode \leaders \hrule height 1ex \hfill \kern \z@}
% copié et modifié depuis book.ltx
\def\@makechapterhead#1{%
  \thispagestyle{empty}%
  \vspace*{50\p@}%
  \vspace*{10\p@}%
  {\parindent \z@ \centering \reset@font
    \thickhrulefill\quad
    \scshape \@chapapp{} \thechapter
    \quad \thickhrulefill
    \par\nobreak
    \vspace*{10\p@}%
    \interlinepenalty\@M
    \hrule
    \vspace*{10\p@}%
    \Huge \bfseries #1\par\nobreak
    \par
    \vspace*{10\p@}%
    \hrule
    % \vskip 40\p@
    \vskip 40\p@
  }}
% copié et modifié depuis book.ltx
\def\@makeschapterhead#1{%
  \thispagestyle{empty}%
  \vspace*{50\p@}%
  \vspace*{10\p@}%
  {\parindent \z@ \centering \reset@font
    \thickhrulefill
    \par\nobreak
    \vspace*{10\p@}%
    \interlinepenalty\@M
    \hrule
    \vspace*{10\p@}%
    \Huge \bfseries \scshape #1\par\nobreak
    \par
    \vspace*{10\p@}%
    \hrule
    % \vskip 40\p@
    \vskip 40\p@
  }
}

\def\@afterheadingchapter{%
  \vskip 30\p@
}
% copié et modifié depuis book.ltx
\def\@schapter#1{%
  \schaptermark{#1}%
  \if@twocolumn
    \@topnewpage[\@makeschapterhead{#1}]%
  \else
    \@makeschapterhead{#1}%
    \@afterheadingchapter%
  \fi
}
% copié et modifié depuis book.ltx
\def\@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
      \refstepcounter{chapter}%
      \typeout{\@chapapp\space\thechapter.}%
      \addcontentsline{toc}{chapter}%
      {\protect\numberline{\thechapter}#1}%
    \else
      \addcontentsline{toc}{chapter}{#1}%
    \fi
  \else
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%

  \if@twocolumn
    \setlength{\mtcindent}{0pt}%
    \@topnewpage[\@makechapterhead{#2}]%
  \else
    \@makechapterhead{#2}%
    \@afterheadingchapter%
  \fi
}


% copié et modifié depuis book.ltx
\def\@part[#1]#2{%
  \thispagestyle{empty}%
  \ifnum \c@secnumdepth >-2\relax
    \refstepcounter{part}%
    \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
  \else
    \addcontentsline{toc}{part}{#1}%
  \fi
  \markboth{}{}%
  {\centering
    \interlinepenalty \@M
    \normalfont
    \ifnum \c@secnumdepth >-2\relax
    \huge\bfseries \partname~\thepart
    \par
    \vskip 20\p@
    \fi
    \Huge \bfseries #2\par}%
  \@endpart
}

%\newcommand\keywordname{Keywords}

\newenvironment{abstract}{%
%  \null\vfil
  \@beginparpenalty\@lowpenalty
  \begin{center}%
    {\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}%
    % {\bfseries \abstractname}%
    \@endparpenalty\@M
  \end{center}%
}%
{\par\vfil\null}

\newenvironment{backcover}{%
  \cleardoublepage
  \if@twoside 
    \ifodd\c@page
      \thispagestyle{empty}% pas de numérotation
        \hbox{}\newpage%
        \if@twocolumn
          \hbox{}\newpage%
        \fi
    \fi
  \fi
  \thispagestyle{empty}%
}%


% Je veux que les pages vides soient vraiment vides...
% Copié depuis latex.ltx, indenté  et modifié
\def\cleardoublepage{%
  \clearpage%
  \if@twoside 
    \ifodd\c@page
    \else
      \thispagestyle{empty}% pas de numérotation
      \hbox{}\newpage%
      \if@twocolumn
        \hbox{}\newpage%
      \fi
    \fi
  \fi
}

