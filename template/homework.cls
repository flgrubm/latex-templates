%%   Copyright (C) 2023 Fabian Lukas Grubmüller
%%
%%   This program is free software: you can redistribute it and/or modify
%%   it under the terms of the GNU General Public License as published by
%%   the Free Software Foundation, either version 3 of the License, or
%%   (at your option) any later version.
%%
%%   This program is distributed in the hope that it will be useful,
%%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%   GNU General Public License for more details.
%%
%%   A copy of the GNU General Public License can be found in `COPYING`.

\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{homework}{2023-11-07}{0.2}{Class for writing math homeworks}

%%
%%   Usage:
%%
%%   \documentclass{homework}
%%
%%   \course{<course name>}
%%   \assignment{<assignment number>}
%%   \assignmentname{<name of assignment>}% this defaults to `Assignment`
%%
%%   \author{<author name>}
%%

\prop_gput:Nnn \g_msg_module_type_prop { homework } { Class }

\RequirePackage{l3keys2e}

\tl_set:Nn { \l_homework_import_tikz } {}
\tl_set:Nn { \l_homework_import_todo } {}

\keys_define:nn { homework }
{
    tikz     .code:n = { \tl_set:Nn { \l_homework_import_tikz } { tikz } },
    tikz     .value_forbidden:n = true,
    todo     .code:n = { \tl_set:Nn { \l_homework_import_todo } { todo } },
    todo     .value_forbidden:n = true,
    lang     .tl_set:N = { \l_homework_language_str },
    lang     .initial:n = { english },
    lang     .value_required:n = true,
}

\LoadClass{scrartcl}

\ProcessKeysOptions { homework } % process the keys that were passed to us

\KOMAoption{fontsize}{4.2mm}
\KOMAoption{DIV}{calc}
\KOMAoption{headings}{standardclasses}

%%% custom packages
\RequirePackage[lang=\tl_use:N \l_homework_language_str]{typesetting-misc}
\RequirePackage[\tl_use:N \l_homework_import_todo]{project-misc}
\RequirePackage[\tl_use:N \l_homework_import_tikz]{math-misc}
\RequirePackage{math-theorems}
\RequirePackage{math-names}
\RequirePackage{abbreviations}

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

%%% theorem environments
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

\AtBeginDocument{
    \title{\tl_use:N \l_homework_assignmentname_tl{}~\tl_use:N \l_homework_assignment_tl{}}
    \hypersetup{%
        , pdftitle={\thetitle{}~–~\tl_use:N \l_homework_course_tl{}}
    }
}
