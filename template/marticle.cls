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
\ProvidesExplClass{marticle}{2023-11-20}{0.1}{Class for writing math marticles}

%%
%%   Usage:
%%
%%   \documentclass{marticle}
%%
%%   \mtitle[<plain title>]{<title>}
%%   \msubtitle[<plain subtitle>]{<subtitle>}
%%   \mauthor[<plain author>]{<author name>}
%%
%%   \keywords[<plain keywords>]{<keywords>}
%%   \date{<date>}% defaults to current date
%%
%%   note: the "plain" versions are optional and are used for PDF meta data
%%         in order to escape any latex commands (e.g. formatting)
%%

\prop_gput:Nnn \g_msg_module_type_prop { marticle } { Class }

\RequirePackage{l3keys2e}

\tl_set:Nn { \l_marticle_import_tikz } {}
\tl_set:Nn { \l_marticle_import_todo } {}

\keys_define:nn { marticle }
{
    tikz     .code:n = { \tl_set:Nn { \l_marticle_import_tikz } { tikz } },
    tikz     .value_forbidden:n = true,
    todo     .code:n = { \tl_set:Nn { \l_marticle_import_todo } { todo } },
    todo     .value_forbidden:n = true,
    lang     .tl_set:N = { \l_marticle_language_str },
    lang     .initial:n = { english },
    lang     .value_required:n = true,
    fontsize     .tl_set:N = { \l_marticle_fontsize_str },
    fontsize     .initial:n = { 4.2mm },
    fontsize     .value_required:n = true,
}

\LoadClass{scrartcl}

\ProcessKeysOptions { marticle } % process the keys that were passed to us

\KOMAoption{fontsize}{\tl_use:N \l_marticle_fontsize_str}
\KOMAoption{DIV}{calc}
\KOMAoption{headings}{standardclasses}

%%% custom packages
\RequirePackage[lang=\tl_use:N \l_marticle_language_str]{typesetting-misc}
\RequirePackage[\tl_use:N \l_marticle_import_todo]{project-misc}
\RequirePackage[\tl_use:N \l_marticle_import_tikz]{math-misc}
\RequirePackage{math-theorems}
\RequirePackage{math-names}
\RequirePackage{abbreviations}

%%% headers and footers
\RequirePackage{scrlayer-scrpage}
\ihead{}
\ohead{}
\chead{}
\ifoot{}
\cfoot{\pagemark}
\ofoot{}

\thispagestyle{scrheadings}

%%% title
\RequirePackage{titling}

\tl_set:Nn \l_marticle_title_tl {}
\tl_set:Nn \l_marticle_titleHyper_tl {}

\tl_set:Nn \l_marticle_subtitle_tl {}
\tl_set:Nn \l_marticle_subtitleHyper_tl {}

\tl_set:Nn \l_marticle_author_tl {}
\tl_set:Nn \l_marticle_authorHyper_tl {}

\tl_set:Nn \l_marticle_keywords_tl {}
\tl_set:Nn \l_marticle_keywordsHyper_tl {}

\DeclareDocumentCommand {\mtitle} {om} {%
    \tl_set:Nn \l_marticle_title_tl {#2}%
    \title{#2}%
    \IfValueTF {#1} {%
        \tl_set:Nn \l_marticle_titleHyper_tl {#1}%
    }{%
        \tl_set:Nn \l_marticle_titleHyper_tl {#2}%
    }
}

\DeclareDocumentCommand {\msubtitle} {om} {%
    \tl_set:Nn \l_marticle_subtitle_tl {#2}%
    \subtitle{#2}%
    \IfValueTF {#1} {%
        \tl_set:Nn \l_marticle_subtitleHyper_tl {#1}%
    }{%
        \tl_set:Nn \l_marticle_subtitleHyper_tl {#2}%
    }
}

\DeclareDocumentCommand {\mauthor} {om} {%
    \tl_set:Nn \l_marticle_author_tl {#2}%
    \author{#2}%
    \IfValueTF {#1} {%
        \tl_set:Nn \l_marticle_authorHyper_tl {#1}%
    }{%
        \tl_set:Nn \l_marticle_authorHyper_tl {#2}%
    }
}

\DeclareDocumentCommand {\keywords} {om} {%
    \tl_set:Nn \l_marticle_keywords_tl {#2}%
    \IfValueTF {#1} {%
        \tl_set:Nn \l_marticle_keywordsHyper_tl {#1}%
    }{%
        \tl_set:Nn \l_marticle_keywordsHyper_tl {#2}%
    }
}

\DeclareDocumentCommand {\themtitle} {} {\tl_use:N \l_marticle_title_tl}
\DeclareDocumentCommand {\themsubtitle} {} {\tl_use:N \l_marticle_subtitle_tl}
\DeclareDocumentCommand {\themauthor} {} {\tl_use:N \l_marticle_author_tl}
\DeclareDocumentCommand {\thekeywords} {} {\tl_use:N \l_marticle_keywords_tl}

\pretitle{\begin{center}\begin{bfseries}\begin{scshape}\LARGE}
\posttitle{\end{scshape}\\[2ex]\large~\themsubtitle\end{bfseries}\end{center}}
\preauthor{\begin{center}\large}
\postauthor{\end{center}}
\predate{\begin{center}\large}
\postdate{\end{center}}

\DeclareDocumentCommand {\theequation} {} {\thesection.\Alph{equation}}

\AtBeginDocument{%
    \hypersetup{%
        , pdftitle={\tl_use:N \l_marticle_titleHyper_tl {}~–~\tl_use:N \l_marticle_subtitleHyper_tl {}}%
        , pdfkeywords={\tl_use:N \l_marticle_keywordsHyper_tl {}}%
        , pdfauthor={\tl_use:N \l_marticle_authorHyper_tl {}}%
    }%
}
