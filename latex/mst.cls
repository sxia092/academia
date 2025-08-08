%% mst-sage-portfolio.cls
%% Missouri S&T Sage Portfolio Class
%% Inspired by Camelot theme with official S&T branding

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mst_sage_portfolio}[2024/01/01 Missouri S&T Sage Portfolio Class]

% Base class
\LoadClass[11pt,letterpaper,oneside,openany]{book}

% Required packages
\RequirePackage[margin=1in,headheight=28pt]{geometry}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{fancyhdr}
\RequirePackage{hyperref}
\RequirePackage{pdfpages}
\RequirePackage{titlesec}
\RequirePackage{tocloft}
\RequirePackage{amsmath}
\RequirePackage{microtype}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{helvet}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{epigraph}
\RequirePackage{etoolbox}
\RequirePackage{everypage}
\RequirePackage{ifthen}

% TikZ libraries
\usetikzlibrary{shapes.geometric,patterns,decorations.pathmorphing,shadows}

% Define boolean for TOC watermark
\newif\ifinsidec
\insidecfalse

% Suppress any initial pages
\AtBeginDocument{%
    \pagestyle{empty}%
    \renewcommand{\headrulewidth}{0pt}%
    \fancyhf{} % Clear all headers and footers
    \markboth{}{} % Clear left and right marks
}

% Define Missouri S&T brand colors
\definecolor{MSTForest}{RGB}{21,71,52}      % Primary Green - #154734
\definecolor{MSTLime}{RGB}{191,215,48}       % Accent Green - #BFD730
\definecolor{MSTMiner}{RGB}{0,122,51}        % Secondary Green - #007A33
\definecolor{MSTLima}{RGB}{114,191,68}       % Light Green - #72BF44
\definecolor{MSTVegas}{RGB}{206,184,136}     % Gold - #CEB888
\definecolor{MSTShuttle}{RGB}{99,102,106}    % Cool Gray - #63666A
\definecolor{MSTPetra}{RGB}{172,161,153}     % Warm Gray - #ACA199
\definecolor{MSTWhite}{RGB}{255,255,255}
\definecolor{MSTCharcoal}{RGB}{64,64,64}     % Dark gray for text

% Camelot title page color
\definecolor{titlepagecolor}{RGB}{21,71,52}  % Using MSTForest for Camelot theme

% Font settings - Use standard LaTeX fonts
\renewcommand{\familydefault}{\rmdefault}
% Keep default Computer Modern for consistency

% Page styling - remove header logos, rely on watermarks instead
\fancypagestyle{fancy}{
    \fancyhf{}
    % No header logo - using watermark instead
    % No footer content - page numbers removed
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{plain}{
    \fancyhf{}
    % No header logo - using watermark instead
    \renewcommand{\headrulewidth}{0pt}
}
\fancypagestyle{empty}{
    \fancyhf{}
    \fancyhead{}
    \fancyfoot{}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\headrule}{}
    \let\@oddhead\@empty
    \let\@evenhead\@empty
    \let\@oddfoot\@empty
    \let\@evenfoot\@empty
}
\pagestyle{fancy}  % Use fancy page style with logo by default

% Hyperref setup
\hypersetup{
    colorlinks=true,
    linkcolor=MSTForest,
    urlcolor=MSTMiner,
    citecolor=MSTForest,
    pdftitle={Missouri S&T Academic Portfolio},
    pdfauthor={Missouri S&T Student}
}

% Chapter formatting inspired by Camelot with S&T colors
\titleformat{\chapter}[display]
{\normalfont\huge\bfseries\sffamily\color{MSTForest}}
{\tikz[remember picture,overlay]{
    \node[anchor=north east,inner sep=0pt] at ([xshift=-1in,yshift=-1in]current page.north east) {
        \fontsize{120}{120}\selectfont\color{MSTForest!20}\thechapter
    };
    % Small geometric accent
    \fill[MSTLime!20] ([xshift=-0.8in,yshift=-0.8in]current page.north east) -- ++(0,-0.3in) -- ++(-0.3in,0) -- cycle;
}}
{0pt}
{\vspace{-60pt}\raggedright}
[\vspace{10pt}]

% Part formatting
\titleformat{\part}[display]
{\normalfont\Huge\bfseries\sffamily\centering\color{MSTForest}}
{\tikz[remember picture,overlay]{
    \fill[MSTForest] (current page.north west) rectangle ([yshift=-3in]current page.north east);
    \node[anchor=center,text=white] at ([yshift=-1.5in]current page.north) {
        \fontsize{20}{20}\selectfont PART \thepart
    };
}}
{-2in}
{\color{white}}
[\vspace{2in}]

% Section formatting
\titleformat{\section}
{\normalfont\Large\bfseries\sffamily\color{MSTForest}}
{\thesection}{1em}{}[{\color{MSTMiner}\titlerule[1pt]}{\color{MSTLime!70}\titlerule[0.5pt]}]

\titleformat{\subsection}
{\normalfont\large\bfseries\sffamily\color{MSTMiner}}
{\thesubsection}{1em}{}

\titleformat{\subsubsection}
{\normalfont\normalsize\bfseries\sffamily\color{MSTShuttle}}
{\thesubsubsection}{1em}{}

% Fix chapter and section marks
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{#1}}

% Table of contents styling
\renewcommand{\cfttoctitlefont}{\Huge\bfseries\sffamily\color{MSTForest}}
\renewcommand{\cftchapfont}{\large\bfseries\sffamily\color{MSTForest}}
\renewcommand{\cftsecfont}{\normalsize\sffamily\color{MSTMiner}}
\renewcommand{\cftsubsecfont}{\small\sffamily\color{MSTShuttle}}
\renewcommand{\cftchappagefont}{\large\bfseries\color{MSTForest}}
\renewcommand{\cftsecpagefont}{\normalsize\color{MSTMiner}}
\renewcommand{\cftsubsecpagefont}{\small\color{MSTShuttle}}

% Ensure tocloft doesn't override page styles
\tocloftpagestyle{fancy}

% Ensure TOC pages use fancy page style with logo
\let\oldtableofcontents\tableofcontents
\renewcommand{\tableofcontents}{%
    \pagestyle{fancy}%
    \oldtableofcontents%
}

% Define a toggle for TOC pages
\newif\ifinsidetoc
\global\insidetocfalse

% Add watermark to TOC pages only - check on EVERY page output
\AddEverypageHook{%
    \ifinsidetoc%
        % Watermark for ALL TOC pages
        \begin{tikzpicture}[remember picture,overlay]
            % S&T watermark in center of page
            \node[anchor=center,opacity=0.04] at ([yshift=0pt]current page.center) {
                \includegraphics[width=4in]{assets/s_t.png}
            };
        \end{tikzpicture}%
    \fi%
}

% Camelot title fonts
\DeclareFixedFont{\titlefont}{T1}{ppl}{b}{it}{0.5in}
\renewcommand\epigraphflush{flushright}
\renewcommand\epigraphsize{\normalsize}
\setlength\epigraphwidth{0.7\textwidth}

% Camelot titlepage decoration macro
\newcommand\titlepagedecoration{%
\begin{tikzpicture}[remember picture,overlay]

\coordinate (aux1) at ([xshift=0.1in,yshift=-15pt]current page.north east);
\coordinate (aux2) at ([xshift=0.05in,yshift=-410pt]current page.north east);
\coordinate (aux3) at ([xshift=-4.5cm]current page.north east);
\coordinate (aux4) at ([xshift=0.02in,yshift=-150pt]current page.north east);

\begin{scope}[titlepagecolor!40,line width=10pt,rounded corners=16pt]
% Animated shadow cascade with soft blur
\fill[black!12,opacity=0.12] ([xshift=4pt,yshift=-4pt]aux1) -- ++(225:5.38) -- ++(-45:5.48) -- cycle;
\fill[black!9,opacity=0.22] ([xshift=3pt,yshift=-3pt]aux1) -- ++(225:5.35) -- ++(-45:5.45) -- cycle;
\fill[black!6,opacity=0.32] ([xshift=2pt,yshift=-2pt]aux1) -- ++(225:5.31) -- ++(-45:5.41) -- cycle;
\fill[black!3,opacity=0.42] ([xshift=1pt,yshift=-1pt]aux1) -- ++(225:5.27) -- ++(-45:5.37) -- cycle;
% Silk gradient with 7 ultra-smooth layers
\fill[MSTLima!32,opacity=0.75] (aux1) -- ++(225:5.27) -- ++(-45:5.37) -- cycle;
\fill[MSTLima!27,opacity=0.68] (aux1) -- ++(225:5.18) -- ++(-45:5.28) -- cycle;
\fill[MSTLima!22,opacity=0.61] (aux1) -- ++(225:5.09) -- ++(-45:5.19) -- cycle;
\fill[MSTLima!17,opacity=0.54] (aux1) -- ++(225:5.0) -- ++(-45:5.1) -- cycle;
\fill[MSTLima!12,opacity=0.47] (aux1) -- ++(225:4.91) -- ++(-45:5.01) -- cycle;
\fill[MSTLima!8,opacity=0.4] (aux1) -- ++(225:4.82) -- ++(-45:4.92) -- cycle;
\fill[MSTLima!4,opacity=0.33] (aux1) -- ++(225:4.73) -- ++(-45:4.83) -- cycle;
% Liquid metal flow dynamics
\fill[black!95,opacity=0.03] (aux1) -- ++(225:4.52) -- ++(-45:4.62) -- cycle;
\fill[MSTMiner!80,opacity=0.05] (aux1) -- ++(225:4.49) -- ++(-45:4.59) -- cycle;
\fill[MSTVegas!60,opacity=0.07] (aux1) -- ++(225:4.46) -- ++(-45:4.56) -- cycle;
% Ethereal glow layers with mercury sheen
\fill[white!8,opacity=0.25] (aux1) -- ++(225:4.5) -- ++(-45:4.6) -- cycle;
\fill[MSTLime!3,opacity=0.18] (aux1) -- ++(225:4.3) -- ++(-45:4.4) -- cycle;
% Liquid metal surface tension
\fill[white!92,opacity=0.04] (aux1) -- ++(225:4.25) -- ++(-45:4.35) -- cycle;
\fill[MSTMiner!88,opacity=0.06] (aux1) -- ++(225:4.2) -- ++(-45:4.3) -- cycle;
% Holographic metallic sheen with shimmer
\fill[white!22,opacity=0.12] (aux1) -- ++(225:3.6) -- ++(-45:2.4) -- ++(45:1.2) -- ++(135:0.8) -- cycle;
\fill[MSTVegas!15,opacity=0.08] (aux1) -- ++(225:3.2) -- ++(-45:2.8) -- ++(45:0.6) -- ++(135:1.4) -- cycle;
\fill[MSTLime!10,opacity=0.06] (aux1) -- ++(225:2.8) -- ++(-45:3.2) -- ++(45:0.4) -- ++(135:1.8) -- cycle;
\draw[line width=10pt]
  (aux1) -- coordinate (a)
  ++(225:5.27) --
  ++(-45:5.37) coordinate (b);
% Quad-layer extended lines with gradient
\draw[line width=10pt,opacity=1] (aux1) -- ++(45:1.45in);
\draw[line width=9.6pt,opacity=0.75] (aux1) -- ++(45:1.58in);
\draw[line width=9.2pt,opacity=0.5] (aux1) -- ++(45:1.71in);
\draw[line width=8.8pt,opacity=0.25] (aux1) -- ++(45:1.84in);
\draw[line width=10pt,opacity=1] (aux1) -- ++(135:1.45in);
\draw[line width=9.6pt,opacity=0.75] (aux1) -- ++(135:1.58in);
\draw[line width=9.2pt,opacity=0.5] (aux1) -- ++(135:1.71in);
\draw[line width=8.8pt,opacity=0.25] (aux1) -- ++(135:1.84in);
% Quantum edge glow with chromatic aberration
\draw[red!15,opacity=0.08,line width=1.2pt] ([xshift=-0.5pt]aux1) -- ++(45:2in);
\draw[white!40,opacity=0.12,line width=1pt] (aux1) -- ++(45:2in);
\draw[blue!15,opacity=0.08,line width=1.2pt] ([xshift=0.5pt]aux1) -- ++(45:2in);
\draw[red!15,opacity=0.08,line width=1.2pt] ([yshift=-0.5pt]aux1) -- ++(135:2in);
\draw[white!40,opacity=0.12,line width=1pt] (aux1) -- ++(135:2in);
\draw[blue!15,opacity=0.08,line width=1.2pt] ([yshift=0.5pt]aux1) -- ++(135:2in);
% Sublime nano accent constellation
\fill[MSTVegas!48,opacity=0.32] ([xshift=-0.162in,yshift=0.162in]aux1) circle (0.024in);
\fill[MSTLime!62,opacity=0.24] ([xshift=-0.123in,yshift=0.123in]aux1) circle (0.016in);
\fill[MSTMiner!52,opacity=0.19] ([xshift=-0.084in,yshift=0.084in]aux1) circle (0.011in);
\fill[white!40,opacity=0.15] ([xshift=-0.14in,yshift=0.14in]aux1) circle (0.008in);
\fill[MSTForest!35,opacity=0.12] ([xshift=-0.10in,yshift=0.10in]aux1) circle (0.006in);
% Premium nested shape with crystal depth
\fill[black!7,opacity=0.1] ([xshift=2pt,yshift=-2pt]b) -- ++(225:2.47) -- ++(-45:2.47) -- cycle;
\fill[MSTMiner!28,opacity=0.35] (b) -- ++(225:2.44) -- ++(-45:2.44) -- cycle;
\fill[MSTMiner!21,opacity=0.5] (b) -- ++(225:2.35) -- ++(-45:2.35) -- cycle;
\fill[MSTMiner!15,opacity=0.65] (b) -- ++(225:2.26) -- ++(-45:2.26) -- cycle;
\fill[MSTMiner!10,opacity=0.8] (b) -- ++(225:2.17) -- ++(-45:2.17) -- cycle;
\fill[MSTMiner!6,opacity=0.9] (b) -- ++(225:2.08) -- ++(-45:2.08) -- cycle;
% Dimensional portal vortex layers
\fill[black!98,opacity=0.02] (b) -- ++(225:2.0) -- ++(-45:2.0) -- cycle;
\fill[MSTMiner!95,opacity=0.04] (b) -- ++(225:1.98) -- ++(-45:1.98) -- cycle;
\fill[MSTVegas!90,opacity=0.06] (b) -- ++(225:1.96) -- ++(-45:1.96) -- cycle;
% Aurora borealis shimmer with dimensional shift
\fill[MSTLime!5,opacity=0.15] (b) -- ++(225:1.95) -- ++(-45:1.95) -- cycle;
\fill[white!12,opacity=0.2] (b) -- ++(225:1.85) -- ++(-45:1.85) -- cycle;
% Portal event horizon
\fill[black!85,opacity=0.08] (b) -- ++(225:1.75) -- ++(-45:1.75) -- cycle;
\fill[MSTForest!70,opacity=0.1] (b) -- ++(225:1.65) -- ++(-45:1.65) -- cycle;
\draw[opacity=0.45,titlepagecolor,line width=9.5pt]
  (b) --
  ++(225:2.44) --
  ++(-45:2.44);
\end{scope}
% Crystal accent with prismatic effect
\fill[black!10,opacity=0.1] ([xshift=1pt,yshift=-1pt]aux4) -- ++(225:0.89) -- ++(-45:0.89) -- cycle;
\fill[black!7,opacity=0.2] ([xshift=0.6pt,yshift=-0.6pt]aux4) -- ++(225:0.875) -- ++(-45:0.875) -- cycle;
\fill[black!4,opacity=0.3] ([xshift=0.3pt,yshift=-0.3pt]aux4) -- ++(225:0.86) -- ++(-45:0.86) -- cycle;
% Prismatic gradient layers
\fill[MSTLime!42,opacity=0.7] (aux4) -- ++(225:0.87) -- ++(-45:0.87) -- cycle;
\fill[MSTLime!35,opacity=0.78] (aux4) -- ++(225:0.82) -- ++(-45:0.82) -- cycle;
\fill[MSTLime!28,opacity=0.86] (aux4) -- ++(225:0.77) -- ++(-45:0.77) -- cycle;
\fill[MSTLime!22,opacity=0.94] (aux4) -- ++(225:0.72) -- ++(-45:0.72) -- cycle;
\fill[MSTLime!17] (aux4) -- ++(225:0.67) -- ++(-45:0.67) -- cycle;
% Crystal prismatic refraction with spectrum
\fill[white!38,opacity=0.33] (aux4) -- ++(225:0.43) -- ++(-45:0.17) -- ++(45:0.26) -- cycle;
\fill[MSTVegas!32,opacity=0.18] (aux4) -- ++(225:0.36) -- ++(-45:0.34) -- ++(45:0.12) -- ++(135:0.08) -- cycle;
\fill[MSTLime!25,opacity=0.12] (aux4) -- ++(225:0.38) -- ++(-45:0.28) -- ++(45:0.10) -- ++(135:0.14) -- cycle;
\fill[MSTMiner!20,opacity=0.09] (aux4) -- ++(225:0.32) -- ++(-45:0.32) -- ++(45:0.08) -- ++(135:0.08) -- cycle;
% Fractal edge patterns with recursive detail
\draw[white!50,opacity=0.4,line width=0.5pt] (aux4) -- ++(225:0.6) coordinate (f1) -- ++(-45:0.6) coordinate (f2) -- (aux4);
\draw[MSTLime!30,opacity=0.3,line width=0.3pt] (f1) -- ++(225:0.1) -- ++(-45:0.1);
\draw[MSTVegas!25,opacity=0.25,line width=0.3pt] (f1) -- ++(215:0.08) -- ++(-35:0.08);
\draw[MSTMiner!20,opacity=0.2,line width=0.3pt] (f2) -- ++(235:0.06) -- ++(-55:0.06);
\draw[white!35,opacity=0.15,line width=0.2pt] (f2) -- ++(245:0.04) -- ++(-65:0.04);
% Divine light core
\fill[white!60,opacity=0.08] (aux4) circle (0.3);
\fill[MSTLime!8,opacity=0.12] (aux4) circle (0.25);
\fill[white!15,opacity=0.3] (aux4) circle (0.05);
\draw[titlepagecolor,line width=6pt,rounded corners=12pt,opacity=0.8]
  (aux4) --
  ++(225:0.87) --
  ++(-45:0.87);
\begin{scope}[titlepagecolor!70,line width=4pt,rounded corners=13pt]
% Volumetric shadow with depth
\fill[black!11,opacity=0.13] ([xshift=2.5pt,yshift=-2.5pt]aux2) -- ++(225:3.29) -- ++(-45:3.39) -- cycle;
\fill[black!8,opacity=0.23] ([xshift=1.8pt,yshift=-1.8pt]aux2) -- ++(225:3.26) -- ++(-45:3.36) -- cycle;
\fill[black!5,opacity=0.33] ([xshift=1pt,yshift=-1pt]aux2) -- ++(225:3.23) -- ++(-45:3.33) -- cycle;
% Luxury triangular gradient with 6 layers
\fill[MSTForest!24,opacity=0.65] (aux2) -- ++(225:3.24) -- ++(-45:3.34) -- cycle;
\fill[MSTForest!20,opacity=0.72] (aux2) -- ++(225:3.15) -- ++(-45:3.25) -- cycle;
\fill[MSTForest!16,opacity=0.79] (aux2) -- ++(225:3.06) -- ++(-45:3.16) -- cycle;
\fill[MSTForest!12,opacity=0.86] (aux2) -- ++(225:2.97) -- ++(-45:3.07) -- cycle;
\fill[MSTForest!8,opacity=0.93] (aux2) -- ++(225:2.88) -- ++(-45:2.98) -- cycle;
\fill[MSTForest!4,opacity=0.97] (aux2) -- ++(225:2.79) -- ++(-45:2.89) -- cycle;
\draw[line width=4pt]
  (aux2) --
  ++(225:3.24) coordinate[pos=0.45] (c) --
  ++(-45:3.34);
% Quad-fade extended lines
\draw[line width=4pt,opacity=1] (aux2) -- ++(315:1.2in);
\draw[line width=3.7pt,opacity=0.7] (aux2) -- ++(315:1.32in);
\draw[line width=3.4pt,opacity=0.4] (aux2) -- ++(315:1.44in);
\draw[line width=3.1pt,opacity=0.2] (aux2) -- ++(315:1.56in);
% Nano pattern accents
\fill[MSTLime!55,opacity=0.22] ([xshift=0.11in,yshift=-0.11in]aux2) -- ++(225:0.16) -- ++(-45:0.16) -- cycle;
\fill[MSTVegas!60,opacity=0.18] ([xshift=0.09in,yshift=-0.09in]aux2) -- ++(225:0.12) -- ++(-45:0.12) -- cycle;
\fill[MSTMiner!65,opacity=0.15] ([xshift=0.07in,yshift=-0.07in]aux2) -- ++(225:0.08) -- ++(-45:0.08) -- cycle;
% Luxury complex shape with pearl gradient
\begin{scope}
\path (aux2) -- (c) -- ++(135:2.67) -- ++(45:2.67) -- ++(-45:2.67) coordinate[pos=0.3] (d);
\fill[black!6,opacity=0.12] ([xshift=1.5pt,yshift=-1.5pt]aux2) -- ([xshift=1.5pt,yshift=-1.5pt]c) -- ++(135:2.67) -- ++(45:2.67) -- ++(-45:2.67) -- cycle;
\fill[MSTVegas!32,opacity=0.45] (aux2) -- (c) -- ++(135:2.64) -- ++(45:2.64) -- ++(-45:2.64) -- cycle;
\fill[MSTVegas!26,opacity=0.57] (aux2) -- (c) -- ++(135:2.55) -- ++(45:2.55) -- ++(-45:2.55) -- cycle;
\fill[MSTVegas!20,opacity=0.69] (aux2) -- (c) -- ++(135:2.46) -- ++(45:2.46) -- ++(-45:2.46) -- cycle;
\fill[MSTVegas!14,opacity=0.81] (aux2) -- (c) -- ++(135:2.37) -- ++(45:2.37) -- ++(-45:2.37) -- cycle;
\fill[MSTVegas!8,opacity=0.93] (aux2) -- (c) -- ++(135:2.28) -- ++(45:2.28) -- ++(-45:2.28) -- cycle;
\fill[MSTVegas!4,opacity=0.98] (aux2) -- (c) -- ++(135:2.19) -- ++(45:2.19) -- ++(-45:2.19) -- cycle;
% Iridescent pearl sheen with aurora effect
\fill[white!27,opacity=0.16] (aux2) -- (c) -- ++(135:1.85) -- ++(45:1.15) -- ++(-45:1.25) -- cycle;
\fill[MSTLime!12,opacity=0.08] (aux2) -- (c) -- ++(135:1.6) -- ++(45:1.4) -- ++(-45:1.0) -- cycle;
\fill[MSTVegas!10,opacity=0.06] (aux2) -- (c) -- ++(135:1.4) -- ++(45:1.6) -- ++(-45:0.8) -- cycle;
\end{scope}
\draw[line width=4pt]
  (aux2) --
  (c) --
  ++(135:2.67) --
  ++(45:2.67) --
  ++(-45:2.67) coordinate[pos=0.3] (d);
\draw[opacity=0.75,line width=3.8pt]
  (d) -- +(45:1.2);
% Celestial micro details with chromatic split
\draw[red!20,opacity=0.2,line width=0.9pt] ([xshift=-0.3pt]d) -- +(45:0.6);
\draw[MSTLime!40,opacity=0.3,line width=0.8pt] (d) -- +(45:0.6);
\draw[blue!20,opacity=0.2,line width=0.9pt] ([xshift=0.3pt]d) -- +(45:0.6);
\draw[white!30,opacity=0.2,line width=0.4pt] (d) -- +(45:0.8);
\draw[MSTVegas!25,opacity=0.15,line width=0.3pt] (d) -- +(45:0.4);
% Liquid metal droplet accents
\fill[MSTMiner!85,opacity=0.12] (d) circle (0.02in);
\fill[white!70,opacity=0.08] ([xshift=0.01in]d) circle (0.015in);
% Stardust particles
\fill[white!70,opacity=0.25] ([xshift=0.05in,yshift=-0.05in]d) circle (0.004in);
\fill[white!70,opacity=0.2] ([xshift=0.03in,yshift=-0.07in]d) circle (0.003in);
\end{scope}
\end{tikzpicture}%
}

% Clean geometric title page design with mirrored Camelot decorations
\newcommand{\makemstcover}[3]{
    % #1 = Title, #2 = Subtitle, #3 = Portfolio Type
    \leavevmode  % Ensure we're in horizontal mode
    \thispagestyle{empty}
    \renewcommand{\headrulewidth}{0pt}  % Ensure no header rule on this page
    \renewcommand{\headrule}{}  % Clear the header rule command
    \fancyhf{}  % Clear all headers and footers
    \markboth{}{}  % Clear marks
    \setlength{\marginparsep}{0pt}
    \setlength{\marginparwidth}{0pt}
    % Explicitly clear any headers
    \def\@oddhead{}
    \def\@evenhead{}
    
    % Top right Camelot decoration (original)
    \titlepagedecoration
    
    % Background watermark elements - Joe Miner only
    \begin{tikzpicture}[remember picture,overlay]
        % Subtle Joe Miner watermark in background
        \node[anchor=center,opacity=0.03] at (current page.center) {
            \includegraphics[width=12in]{assets/joe_miner.png}
        };
    \end{tikzpicture}
    
    % Bottom left Camelot decoration (mirroring top right)
    \begin{tikzpicture}[remember picture,overlay]
        
        % Define coordinates for bottom left corner
        \coordinate (bl1) at ([xshift=-0.1in,yshift=15pt]current page.south west);
        \coordinate (bl2) at ([xshift=-0.05in,yshift=410pt]current page.south west);
        \coordinate (bl3) at ([xshift=4.5cm]current page.south west);
        \coordinate (bl4) at ([xshift=-0.02in,yshift=150pt]current page.south west);
        
        \begin{scope}[titlepagecolor!40,line width=10.5pt,rounded corners=15pt]
        % Multi-layer shadow with blur effect
        \fill[black!10,opacity=0.2] ([xshift=-3pt,yshift=3pt]bl1) -- ++(45:5.35) -- ++(135:5.45) -- cycle;
        \fill[black!7,opacity=0.3] ([xshift=-2pt,yshift=2pt]bl1) -- ++(45:5.32) -- ++(135:5.42) -- cycle;
        \fill[black!4,opacity=0.4] ([xshift=-1pt,yshift=1pt]bl1) -- ++(45:5.28) -- ++(135:5.38) -- cycle;
        % Ultra-smooth gradient with 5 layers
        \fill[MSTLima!30,opacity=0.8] (bl1) -- ++(45:5.26) -- ++(135:5.36) -- cycle;
        \fill[MSTLima!24,opacity=0.7] (bl1) -- ++(45:5.12) -- ++(135:5.22) -- cycle;
        \fill[MSTLima!18,opacity=0.6] (bl1) -- ++(45:4.98) -- ++(135:5.08) -- cycle;
        \fill[MSTLima!12,opacity=0.5] (bl1) -- ++(45:4.84) -- ++(135:4.94) -- cycle;
        \fill[MSTLima!8,opacity=0.4] (bl1) -- ++(45:4.7) -- ++(135:4.8) -- cycle;
        \draw[line width=10.5pt]
          (bl1) -- coordinate (bla)
          ++(45:5.26) --
          ++(135:5.36) coordinate (blb);
        \draw[line width=10.5pt]
          (bl3) --
          (bla) --
          (bl1);
        % Premium extended lines with triple fade
        \draw[line width=10.5pt,opacity=1] (bl1) -- ++(225:1.5in);
        \draw[line width=10pt,opacity=0.8] (bl1) -- ++(225:1.65in);
        \draw[line width=9.5pt,opacity=0.6] (bl1) -- ++(225:1.8in);
        \draw[line width=10.5pt,opacity=1] (bl1) -- ++(315:1.5in);
        \draw[line width=10pt,opacity=0.8] (bl1) -- ++(315:1.65in);
        \draw[line width=9.5pt,opacity=0.6] (bl1) -- ++(315:1.8in);
        % Micro accent detail
        \fill[MSTVegas!40,opacity=0.3] ([xshift=0.15in,yshift=-0.15in]bl1) circle (0.03in);
        % Refined smaller shape with premium depth
        \fill[black!6,opacity=0.15] ([xshift=-1.5pt,yshift=1.5pt]blb) -- ++(45:2.46) -- ++(135:2.46) -- cycle;
        \fill[MSTMiner!25,opacity=0.4] (blb) -- ++(45:2.43) -- ++(135:2.43) -- cycle;
        \fill[MSTMiner!18,opacity=0.6] (blb) -- ++(45:2.32) -- ++(135:2.32) -- cycle;
        \fill[MSTMiner!12,opacity=0.8] (blb) -- ++(45:2.21) -- ++(135:2.21) -- cycle;
        \draw[opacity=0.5,titlepagecolor,line width=10pt]
          (blb) --
          ++(45:2.43) --
          ++(135:2.43);
        \end{scope}
        % Premium small accent with glass effect
        \fill[black!8,opacity=0.15] ([xshift=-0.8pt,yshift=0.8pt]bl4) -- ++(45:0.88) -- ++(135:0.88) -- cycle;
        \fill[black!5,opacity=0.25] ([xshift=-0.4pt,yshift=0.4pt]bl4) -- ++(45:0.87) -- ++(135:0.87) -- cycle;
        \fill[MSTLime!40,opacity=0.75] (bl4) -- ++(45:0.865) -- ++(135:0.865) -- cycle;
        \fill[MSTLime!32,opacity=0.85] (bl4) -- ++(45:0.805) -- ++(135:0.805) -- cycle;
        \fill[MSTLime!26,opacity=0.95] (bl4) -- ++(45:0.745) -- ++(135:0.745) -- cycle;
        \fill[MSTLime!20] (bl4) -- ++(45:0.685) -- ++(135:0.685) -- cycle;
        % Glass highlight effect
        \fill[white!30,opacity=0.4] (bl4) -- ++(45:0.4) -- ++(135:0.2) -- ++(225:0.2) -- cycle;
        \draw[titlepagecolor,line width=6.5pt,rounded corners=11pt,opacity=0.85]
          (bl4) --
          ++(45:0.865) --
          ++(135:0.865);
        \begin{scope}[titlepagecolor!70,line width=4.5pt,rounded corners=12pt]
        % Premium shadow cascade
        \fill[black!9,opacity=0.18] ([xshift=-2pt,yshift=2pt]bl2) -- ++(45:3.27) -- ++(135:3.37) -- cycle;
        \fill[black!6,opacity=0.28] ([xshift=-1.2pt,yshift=1.2pt]bl2) -- ++(45:3.24) -- ++(135:3.34) -- cycle;
        % Ultra-refined triangular gradient
        \fill[MSTForest!22,opacity=0.7] (bl2) -- ++(45:3.23) -- ++(135:3.33) -- cycle;
        \fill[MSTForest!17,opacity=0.78] (bl2) -- ++(45:3.11) -- ++(135:3.21) -- cycle;
        \fill[MSTForest!12,opacity=0.86] (bl2) -- ++(45:2.99) -- ++(135:3.09) -- cycle;
        \fill[MSTForest!8,opacity=0.94] (bl2) -- ++(45:2.87) -- ++(135:2.97) -- cycle;
        \draw[line width=4.5pt]
          (bl2) --
          ++(45:3.23) coordinate[pos=0.45] (blc) --
          ++(135:3.33);
        % Triple-layer extended lines
        \draw[line width=4.5pt,opacity=0.95] (bl2) -- ++(135:1.25in);
        \draw[line width=4.2pt,opacity=0.75] (bl2) -- ++(135:1.38in);
        \draw[line width=3.9pt,opacity=0.55] (bl2) -- ++(135:1.5in);
        % Micro detail accent
        \fill[MSTLime!50,opacity=0.25] ([xshift=-0.1in,yshift=0.1in]bl2) -- ++(45:0.15) -- ++(135:0.15) -- cycle;
        % Premium complex shape with silk gradient
        \begin{scope}
        \path (bl2) -- (blc) -- ++(-45:2.66) -- ++(225:2.66) -- ++(135:2.66) coordinate[pos=0.3] (bld);
        \fill[black!5,opacity=0.15] ([xshift=-1.2pt,yshift=1.2pt]bl2) -- ([xshift=-1.2pt,yshift=1.2pt]blc) -- ++(-45:2.66) -- ++(225:2.66) -- ++(135:2.66) -- cycle;
        \fill[MSTVegas!30,opacity=0.5] (bl2) -- (blc) -- ++(-45:2.63) -- ++(225:2.63) -- ++(135:2.63) -- cycle;
        \fill[MSTVegas!22,opacity=0.65] (bl2) -- (blc) -- ++(-45:2.51) -- ++(225:2.51) -- ++(135:2.51) -- cycle;
        \fill[MSTVegas!15,opacity=0.8] (bl2) -- (blc) -- ++(-45:2.39) -- ++(225:2.39) -- ++(135:2.39) -- cycle;
        \fill[MSTVegas!9,opacity=0.92] (bl2) -- (blc) -- ++(-45:2.27) -- ++(225:2.27) -- ++(135:2.27) -- cycle;
        \end{scope}
        \draw[line width=4.5pt]
          (bl2) --
          (blc) --
          ++(-45:2.66) --
          ++(225:2.66) --
          ++(135:2.66) coordinate[pos=0.3] (bld);
        \draw[opacity=0.8,line width=4.3pt]
          (bld) -- +(225:1.18);
        \end{scope}
    \end{tikzpicture}
    
    \vspace*{0.3in}
    
    % Enhanced centered layout
    \begin{center}
        % Missouri S&T horizontal logo at top
        \includegraphics[height=0.8in]{assets/missouri_s_t_horizontal.png}
        
        \vspace{0.5in}
        
        % Main title with enhanced typography
        {\fontsize{48}{56}\selectfont\bfseries\color{MSTCharcoal}
        #1}
        
        \vspace{0.3in}
        
        % Enhanced decorative element
        \begin{tikzpicture}
            % Main lime line with subtle variations
            \fill[MSTLime] (-2.75in,0) rectangle (2.75in,0.08in);
            % Thin forest green accent lines
            \fill[MSTForest] (-2in,-0.15in) rectangle (-0.5in,-0.13in);
            \fill[MSTForest] (0.5in,-0.15in) rectangle (2in,-0.13in);
        \end{tikzpicture}
        
        \vspace{0.4in}
        
        % Author name - more prominent with decorative elements
        \vspace{0.3in}
        
        {\fontsize{32}{38}\selectfont\scshape\color{MSTForest}
        \myname}
        
        \vspace{0.2in}
        
        % Subtitle - enhanced typography with better spacing
        {\fontsize{20}{26}\selectfont\color{MSTCharcoal}
        #2}
        
        \vspace{0.7in}
        
        % Bottom information with enhanced styling
        \begin{tikzpicture}
            % Decorative line above degree info
            \fill[MSTForest!30] (-2in,0) rectangle (2in,0.5pt);
            \fill[MSTLime] (-0.3in,-0.02in) rectangle (0.3in,0.02in);
        \end{tikzpicture}
        
        \vspace{0.25in}
        
        {\fontsize{16}{20}\selectfont\color{MSTCharcoal}
        \mydegree}
        
        \vspace{0.15in}
        
        {\fontsize{16}{20}\selectfont\scshape\color{MSTForest}
        Class of \mygraduation}
    \end{center}
    
    \vspace{0.3in}
    
    \clearpage
}

% Preface page command with four variants
\newcommand{\makepreface}[1]{
    \clearpage
    \thispagestyle{empty}
    
    \vspace*{1in}
    
    \begin{center}
        {\fontsize{36}{42}\selectfont\bfseries\color{MSTForest}Preface}
    \end{center}
    
    \vspace{0.5in}
    
    % Content based on portfolio type
    \ifthenelse{\equal{#1}{complete}}{
        This comprehensive portfolio represents the entirety of my academic journey at Missouri University of Science and Technology, documenting four years of rigorous coursework across computer science, mathematics, and engineering disciplines. Each page within this collection reflects the depth and breadth of a technical education that challenged me to think critically, solve complex problems, and develop expertise across multiple domains of computing.
        
        From foundational courses in data structures and discrete mathematics to advanced topics in artificial intelligence and numerical methods, this portfolio captures not only the knowledge acquired but also the evolution of my analytical and technical capabilities. The materials presented here—including lecture notes, homework assignments, laboratory reports, and projects—demonstrate the comprehensive nature of the Missouri S\&T computer science curriculum and my dedication to academic excellence throughout my undergraduate studies.
    }{}
    
    \ifthenelse{\equal{#1}{assignments}}{
        This collection of academic assignments showcases the practical application of theoretical knowledge gained during my studies at Missouri University of Science and Technology. Through homework assignments, programming projects, and laboratory reports, these materials demonstrate my ability to translate complex concepts into working solutions across diverse areas of computer science and engineering.
        
        Each assignment represents a stepping stone in my technical development, from early programming exercises in introductory courses to sophisticated implementations in advanced algorithms and software engineering. The progression visible in these works illustrates not only mastery of individual topics but also the integration of knowledge across disciplines—a hallmark of the comprehensive education provided at Missouri S\&T.
    }{}
    
    \ifthenelse{\equal{#1}{curated}}{
        This carefully selected portfolio contains teaching materials and educational resources developed during my time as a teaching assistant at Missouri University of Science and Technology. These materials represent my commitment to knowledge transfer and my ability to distill complex technical concepts into accessible learning experiences for fellow students.
        
        The resources presented here demonstrate both pedagogical understanding and technical expertise, showcasing how I've contributed to the academic community through structured labs, comprehensive demonstrations, and evaluation rubrics. This collection reflects my belief that true mastery of a subject comes not just from learning, but from the ability to effectively teach and mentor others in their educational journey.
    }{}
    
    \ifthenelse{\equal{#1}{notes}}{
        This compilation of academic notes and reference materials represents the intellectual foundation built during my studies at Missouri University of Science and Technology. These carefully organized notes capture key concepts, methodologies, and insights from across the computer science curriculum, serving as both a record of learning and a valuable reference resource.
        
        From detailed lecture transcriptions to synthesized study guides, these materials demonstrate my systematic approach to learning and knowledge retention. The notes encompass theoretical foundations, practical applications, and problem-solving strategies that have proven invaluable throughout my academic career and continue to serve as a professional reference.
    }{}
    
    \vspace{1in}
    
    % Common footer section
    \begin{center}
        \rule{2in}{0.5pt}\\[0.3in]
        {\fontsize{14}{18}\selectfont\bfseries\color{MSTCharcoal}
        Illya Starikov}\\[0.1in]
        {\fontsize{12}{16}\selectfont\color{MSTCharcoal}
        Bachelor of Science, Computer Science\\
        Missouri University of Science and Technology\\[0.15in]
        Academic Advisors: Dr. Jennifer Leopold, Dr. A. Ricardo Morales,\\
        Dr. Simone Silvestri, Professor Clayton Price\\[0.15in]
        Class of 2018\\
        starikov@mst.edu}\\[0.3in]
        {\fontsize{14}{18}\selectfont\itshape\color{MSTForest}
        ``Miners Dig Deeper'' ⛏️}
    \end{center}
    
    \clearpage
}

% Section divider page - Camelot style with S&T branding
\newcommand{\sectiondivider}[1]{
    \clearpage
    \thispagestyle{empty}
    \vspace*{\fill}
    \begin{center}
        \includegraphics[height=0.4in]{assets/s_t.png}\\[0.4in]
        {\fontsize{36}{42}\selectfont\bfseries\color{titlepagecolor}
        #1}\\[0.2in]
        {\color{MSTLime!70}\rule{1.5in}{0.5pt}}
    \end{center}
    \vspace*{\fill}
    \clearpage
}

% Custom table of contents page - Camelot style enhanced
\newcommand{\makecustomtoc}{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{Table of Contents}
    \markboth{}{} % Clear the headers for TOC
    \pagestyle{fancy}  % Ensure fancy page style with logo for TOC pages
    \thispagestyle{fancy}  % Ensure first page of TOC also has logo
    \global\insidectrue  % Turn on TOC watermark GLOBALLY

% Add decoration to TOC page
    \begin{tikzpicture}[remember picture,overlay]
        % Smaller Camelot decoration in corner
        \coordinate (corner) at ([xshift=-0.5in,yshift=-0.5in]current page.north east);
        % Add subtle fill
        \fill[MSTForest!10] (corner) -- ++(225:1.2) -- ++(-45:1.2) -- cycle;
        \draw[titlepagecolor!60,line width=6pt,rounded corners=6pt]
          (corner) --
          ++(225:1.2) --
          ++(-45:1.2);
        \draw[MSTLime!60,line width=3pt,rounded corners=3pt]
          ([xshift=-0.1in,yshift=-0.1in]corner) --
          ++(225:0.8) --
          ++(-45:0.8);
        % Larger watermark for TOC first page
        \node[anchor=center,opacity=0.04] at (current page.center) {
            \includegraphics[width=4in]{assets/s_t.png}
        };
    \end{tikzpicture}
    
    \vspace*{0.8in}
    \begin{center}
    {\fontsize{28}{32}\selectfont\bfseries\color{MSTForest}Table of Contents}
    \end{center}
    \vspace{0.3in}
    
    \begin{center}
    {\color{MSTLime}\rule{0.5\textwidth}{1pt}}
    \end{center}
    \vspace{0.5in}
    
    % Ensure flag stays on for entire TOC
    \tableofcontents
    % Leave flag on - it will be turned off by first coursesection
}

% Section header for course PDFs - Camelot style chapters
\newcommand{\coursesection}[2]{
    % #1 = Course code, #2 = Course name
    \global\insidetocfalse  % Turn off TOC watermark GLOBALLY when we start course sections
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{[#1] #2}
    \markboth{#1: #2}{\currentassignmentname} % Set both marks
    \vspace*{0.5in}
    
    % Large centered watermark like the cover
    \begin{tikzpicture}[remember picture,overlay]
        % Large transparent S&T watermark in center
        \node[anchor=center,opacity=0.05] at (current page.center) {
            \includegraphics[width=4.5in]{assets/s_t.png}
        };
        \draw[MSTForest,line width=3pt]
          ([xshift=1in,yshift=-0.3in]current page.north west) --
          ++(1.5in,0);
        \draw[MSTLime,line width=1.5pt]
          ([xshift=1in,yshift=-0.35in]current page.north west) --
          ++(1in,0);
    \end{tikzpicture}
    
    \noindent
    \begin{tikzpicture}[baseline=(box.base)]
        \node[fill=MSTLime,inner sep=3pt] (box) {\color{MSTForest}\fontsize{14}{16}\selectfont\bfseries\,#1\,};
        \fill[MSTForest!30] ([xshift=1pt,yshift=-1pt]box.south west) rectangle ([xshift=2pt,yshift=-2pt]box.south east);
    \end{tikzpicture}\\[0.15in]
    {\fontsize{24}{28}\selectfont\bfseries\color{MSTForest}#2}
    
    \vspace{0.3in}
    \noindent{\color{MSTForest!30}\rule{\textwidth}{0.5pt}}\\[-3pt]
    {\color{MSTLime!70}\rule{1.5in}{1pt}}
    \vspace{0.3in}
}

% Global variable to store assignment name
\gdef\currentassignmentname{}

% Define a custom page style for PDFs - completely empty
\fancypagestyle{pdfwithheader}{%
    \fancyhf{}
    % No header content
    % No footer content - no page numbers
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\headrule}{}
}

% Command to include PDF and set right header for each page
\newcommand{\includepdfwithheader}[3][]{%
    % #1 = options (optional), #2 = filename, #3 = header text
    % Keep PDFs at original size
    \gdef\currentassignmentname{#3}%
    \markright{#3}%
    \includepdf[pages=-,pagecommand={\thispagestyle{pdfwithheader}},noautoscale=true,#1]{#2}%
}

% Simpler version that just takes filename and header
\newcommand{\includeassignment}[2]{%
    % #1 = filename, #2 = assignment name/header
    % Keep PDFs at original size - no fitpaper or resizing
    \clearpage
    \phantomsection
    \addcontentsline{toc}{section}{#2}% Add to table of contents
    \gdef\currentassignmentname{#2}%
    \markright{#2}%
    \includepdf[pages=-]{#1}%
}

% Footer style - completely empty
\fancypagestyle{mstfooter}{
    \fancyhf{}
    % No footer content - no page numbers
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}

\endinput
