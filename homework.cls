\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{homework}{2023-11-04}{0.1}{Class for writing math homeworks}
\prop_gput:Nnn \g_msg_module_type_prop { homework } { Class }

\RequirePackage{l3keys2e}

\keys_define:nn { homework }
{
    tikz     .code:n = { \homework_import_tikz },
    tikz     .value_forbidden: = true,
    todo     .code:n = { \homework_import_todo },
    todo     .value_forbidden: = true,
    lang     .tl_set:N = { \l_homework_language_str },
    lang     .initial:n = { english },
    lang     .value_required:n = true,
}

\msg_new:nnnn { homework } { option } { option~#1~is~given } { loading~package~#2 }

\cs_set_protected:Npn \homework_import_tikz {%
    \msg_note:nnnn { homework } { option } { tikz } { tikz }
}

\cs_set_protected:Npn \homework_import_todo {%
    \msg_note:nnnn { homework } { option } { todo } { zebra-goodies }
}

\LoadClass{scrartcl}

\ProcessKeysOptions { homework } % process the keys that were passed to us

\KOMAoption{fontsize}{4.2mm}
\KOMAoption{DIV}{calc}
\KOMAoption{headings}{standardclasses}

%%% headers and footers
\RequirePackage{scrlayer-scrpage}
\ihead{\small\itshape\theauthor}
\ohead{\small\itshape\tl_use:N \l_homework_course_tl{}~--~\thetitle}
\chead{}
\ifoot{}
\cfoot{\pagemark}
\ofoot{}

\thispagestyle{scrheadings}

%%% title
\RequirePackage{titling}

\tl_set:Nn \l_homework_assignment_tl {0}
\tl_set:Nn \l_homework_assignmentname_tl {Assignment}
\tl_set:Nn \l_homework_course_tl {}

\DeclareDocumentCommand {\assignment} {m} {\tl_set:Nn \l_homework_assignment_tl {#1}}
\DeclareDocumentCommand {\theassignment} {} {\tl_use:N \l_homework_assignment_tl}

\DeclareDocumentCommand {\assignmentname} {m} {\tl_set:Nn \l_homework_assignmentname_tl {#1}}
\DeclareDocumentCommand {\theassignmentname} {} {\tl_use:N \l_homework_assignmentname_tl}

\DeclareDocumentCommand {\course} {m} {\tl_set:Nn \l_homework_course_tl {#1}}
\DeclareDocumentCommand {\thecourse} {} {\tl_use:N \l_homework_course_tl}

\pretitle{\begin{center}\begin{bfseries}\begin{scshape}\LARGE}
\posttitle{\end{scshape}\\[2ex]\large~\thecourse\end{bfseries}\end{center}}
\preauthor{\begin{center}\large}
\postauthor{\end{center}}
\predate{\begin{center}\large}
\postdate{\end{center}}

\DeclareDocumentCommand {\theequation} {} {\thesection.\Alph{equation}}
\DeclareDocumentCommand {\thesection} {} {Exercise~\arabic{section}.}

% --------------------------------------------------

%% custom environments

% theorems
% - syntax: \newtheorem{name}[counter]{Printed output}[numberby]
% - counter: specify counter, if omitted, a counter named after the first argument is used; numberby: specify when to reset the counter, e. g. every chapter, section.

\RequirePackage{amsthm}

\newtheoremstyle{theoremex} % name of the style to be used
   {\topsep}               % measure of space to leave above the theorem. E.g.: 3pt
   {\topsep}               % measure of space to leave below the theorem. E.g.: 3pt
   {}                      % name of font to use in the body of the theorem
   {0pt}                   % measure of space to indent
   {}                      % name of head font
   {.}                     % punctuation between head and body
   {~}                     % space after theorem head; " " = normal interword space
   {{\bfseries\thmname{#1}~(\thmnumber{#2})}\thmnote{ (#3)}}

\theoremstyle{theoremex}
\newtheorem{exercise}{Part}[section]
\DeclareDocumentCommand {\theexercise} {} {\alph{exercise}}
