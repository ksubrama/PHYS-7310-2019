% Adapted from hmcpset
%%% IDENTIFICATION --------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[1995/01/01]
\ProvidesClass{cubouldpset}
    [2005/03/10 v0.04 HMC Math Dept problem set class]

%%% INITIAL CODE ----------------------------------------------------------

% test whether the document is being compiled with PDFTeX
\RequirePackage{ifpdf}


%%% DECLARATION OF OPTIONS ------------------------------------------------
%% Header Options: header*, no header
\newif\ifcubouldpset@header

% no header block in upper right hand corner
\DeclareOption{noheader}{%
    \cubouldpset@headerfalse%
}

% do print header block
\DeclareOption{header}{%
    \cubouldpset@headertrue%
}

%% Font Options: palatino*, cm
\newif\ifcubouldpset@palatino

% use palatino fonts
\DeclareOption{palatino}{%
    \cubouldpset@palatinotrue%
}

% use compuer modern fonts
\DeclareOption{cm}{%
    \cubouldpset@palatinofalse%
}

%% Problem Boxing: boxed*, unboxed
\newif\ifcubouldpset@boxed

% box problem statements
\DeclareOption{boxed}{%
    \cubouldpset@boxedtrue%
}
   
% don't box problem statements
\DeclareOption{unboxed}{%
    \cubouldpset@boxedfalse%
}
   
% pass remaining options to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

%%% EXECUTION OF OPTIONS --------------------------------------------------
%% default to:
% including header, 
% loading mathpazo package for palatino fonts,
% boxing problem statements
\ExecuteOptions{header,palatino,boxed}

\ProcessOptions

%%% PACKAGE LOADING -------------------------------------------------------
%% based on std article class
\LoadClass{article}


%% Font loading: Palatino text/math fonts
\ifcubouldpset@palatino
    \RequirePackage{mathpazo}
\fi

%% AMSLaTeX math environments and symbols
\RequirePackage{amsmath}
\RequirePackage{amssymb}

%% boxed minipage for boxed problem environment
\RequirePackage{boxedminipage}

%%% MAIN CODE -------------------------------------------------------------
%% Tell dvips/pdflatex correct page size
\ifpdf
  \AtBeginDocument{%
    \setlength{\pdfpageheight}{\paperheight}%
    \setlength{\pdfpagewidth}{\paperwidth}%
  }
\else
  \AtBeginDvi{\special{papersize=\the\paperwidth,\the\paperheight}}%
\fi


%% Problem set environments
% boxed problem environment
\newenvironment{problem}[1][]{%
  \ifcubouldpset@boxed\def\cubouldpset@probenv{boxed}\else\def\cubouldpset@probenv{}\fi%
  \bigskip% put space before problem statement box %
  \noindent\begin{\cubouldpset@probenv minipage}{\columnwidth}%
  \def\@tempa{#1}%
  \ifx\@tempa\empty\else%
    \cubouldpset@probformat{#1}\hspace{0.5em}%
  \fi%
}{%
  \end{\cubouldpset@probenv minipage}%
}
% display optional argument to problem in bold
\let\cubouldpset@probformat\textbf

% solution environment with endmark and optional argument
\newenvironment{solution}[1][]{%
  \begin{trivlist}%
  \def\@tempa{#1}%
  \ifx\@tempa\empty%
    \item[]%
  \else%
    \item[\hskip\labelsep\relax #1]%
  \fi%
}{%
  \mbox{}\penalty10000\hfill\cubouldpset@endmark%
  \end{trivlist}%
}

% default endmark is small black square
\def\cubouldpset@endmark{\ensuremath{\scriptscriptstyle\blacksquare}}

%% Problem set list, for top of document
\newcommand{\problemlist}[1]{\begin{center}\large\sffamily{#1}\end{center}}

%% commands for upper-right id header block
\newcommand{\headerblock}{%
\begin{flushright}
\mbox{\cubouldpset@name}\protect\\
\mbox{\cubouldpset@class}\protect\\
\mbox{\cubouldpset@assignment}\protect\\
\cubouldpset@duedate%
\ifx\cubouldpset@extraline\empty\else\protect\\\cubouldpset@extraline\fi%
\end{flushright}%
}

% put id header block at start of document
\ifcubouldpset@header\AtBeginDocument{\headerblock}\fi

% internal state for headerblock
\def\cubouldpset@name{}
\def\cubouldpset@class{}
\def\cubouldpset@assignment{}
\def\cubouldpset@duedate{}
\def\cubouldpset@extraline{}

% commands to set header block info
\newcommand{\name}[1]{\def\cubouldpset@name{#1}}
\newcommand{\class}[1]{\def\cubouldpset@class{#1}}
\newcommand{\assignment}[1]{\def\cubouldpset@assignment{#1}}
\newcommand{\duedate}[1]{\def\cubouldpset@duedate{#1}}
\newcommand{\extraline}[1]{\def\cubouldpset@extraline{#1}}
