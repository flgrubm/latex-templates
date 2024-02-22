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
\ProvidesExplClass{thesis}{2023-11-20}{0.1}{Class for writing math theses}

%%
%%   Usage:
%%
%%   \documentclass{thesis}
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

\prop_gput:Nnn \g_msg_module_type_prop { thesis } { Class }

\RequirePackage{l3keys2e}

\tl_set:Nn { \l_thesis_import_tikz } {}
\tl_set:Nn { \l_thesis_import_todo } {}

\keys_define:nn { thesis }
{
    tikz     .code:n = { \tl_set:Nn { \l_thesis_import_tikz } { tikz } },
    tikz     .value_forbidden:n = true,
    todo     .code:n = { \tl_set:Nn { \l_thesis_import_todo } { todo } },
    todo     .value_forbidden:n = true,
    lang     .tl_set:N = { \l_thesis_language_str },
    lang     .initial:n = { english },
    lang     .value_required:n = true,
    fontsize     .tl_set:N = { \l_thesis_fontsize_str },
    fontsize     .initial:n = { 4.2mm },
    fontsize     .value_required:n = true,
}

\LoadClass{scrreprt}

\ProcessKeysOptions { thesis } % process the keys that were passed to us

\KOMAoption{fontsize}{\tl_use:N \l_thesis_fontsize_str}
\KOMAoption{DIV}{calc}
\KOMAoption{headings}{standardclasses}
\KOMAoption{chapterprefix}{false}

%%% custom packages
\RequirePackage[lang=\tl_use:N \l_thesis_language_str]{typesetting-misc}
\RequirePackage[\tl_use:N \l_thesis_import_todo]{project-misc}
\RequirePackage[\tl_use:N \l_thesis_import_tikz]{math-misc}
\RequirePackage{math-theorems}
\RequirePackage{math-names}
\RequirePackage{abbreviations}

%%% headers and footers
%\RequirePackage{scrlayer-scrpage}
%\ihead{}
%\ohead{}
%\chead{}
%\ifoot{}
%\cfoot{\pagemark}
%\ofoot{}
%
%\thispagestyle{scrheadings}

%%% title
\RequirePackage{titling}

\tl_set:Nn \l_thesis_title_tl {}
\tl_set:Nn \l_thesis_titleHyper_tl {}

\tl_set:Nn \l_thesis_subtitle_tl {}
\tl_set:Nn \l_thesis_subtitleHyper_tl {}

\tl_set:Nn \l_thesis_author_tl {}
\tl_set:Nn \l_thesis_authorHyper_tl {}

\tl_set:Nn \l_thesis_keywords_tl {}
\tl_set:Nn \l_thesis_keywordsHyper_tl {}

\tl_set:Nn \l_thesis_institute_tl {}
\tl_set:Nn \l_thesis_instituteHyper_tl {}

\tl_set:Nn \l_thesis_thesistype_tl {}
\tl_set:Nn \l_thesis_thesistypeHyper_tl {}

\tl_set:Nn \l_thesis_supervisor_tl {}
\tl_set:Nn \l_thesis_supervisorHyper_tl {}

%\tl_set:Nn \l_thesis_logo_tl {}

\DeclareDocumentCommand {\mtitle} {om} {%
    \tl_set:Nn \l_thesis_title_tl {#2}%
    \title{#2}%
    \IfValueTF {#1} {%
        \tl_set:Nn \l_thesis_titleHyper_tl {#1}%
    }{%
        \tl_set:Nn \l_thesis_titleHyper_tl {#2}%
    }
}

\DeclareDocumentCommand {\msubtitle} {om} {%
    \tl_set:Nn \l_thesis_subtitle_tl {#2}%
    \subtitle{#2}%
    \IfValueTF {#1} {%
        \tl_set:Nn \l_thesis_subtitleHyper_tl {#1}%
    }{%
        \tl_set:Nn \l_thesis_subtitleHyper_tl {#2}%
    }
}

\DeclareDocumentCommand {\mauthor} {om} {%
    \tl_set:Nn \l_thesis_author_tl {#2}%
    \author{#2}%
    \IfValueTF {#1} {%
        \tl_set:Nn \l_thesis_authorHyper_tl {#1}%
    }{%
        \tl_set:Nn \l_thesis_authorHyper_tl {#2}%
    }
}

\DeclareDocumentCommand {\keywords} {om} {%
    \tl_set:Nn \l_thesis_keywords_tl {#2}%
    \IfValueTF {#1} {%
        \tl_set:Nn \l_thesis_keywordsHyper_tl {#1}%
    }{%
        \tl_set:Nn \l_thesis_keywordsHyper_tl {#2}%
    }
}

\DeclareDocumentCommand {\institute} {om} {%
    \tl_set:Nn \l_thesis_institute_tl {#2}%
    \IfValueTF {#1} {%
        \tl_set:Nn \l_thesis_instituteHyper_tl {#1}%
    }{%
        \tl_set:Nn \l_thesis_instituteHyper_tl {#2}%
    }
}

\DeclareDocumentCommand {\thesistype} {om} {%
    \tl_set:Nn \l_thesis_thesistype_tl {#2}%
    \IfValueTF {#1} {%
        \tl_set:Nn \l_thesis_thesistypeHyper_tl {#1}%
    }{%
        \tl_set:Nn \l_thesis_thesistypeHyper_tl {#2}%
    }
}

\DeclareDocumentCommand {\supervisor} {om} {%
    \tl_set:Nn \l_thesis_supervisor_tl {#2}%
    \IfValueTF {#1} {%
        \tl_set:Nn \l_thesis_supervisorHyper_tl {#1}%
    }{%
        \tl_set:Nn \l_thesis_supervisorHyper_tl {#2}%
    }
}

%\DeclareDocumentCommand {\logo} {m} {%
%    \tl_set:Nn \l_thesis_logo_tl {#1}%
%}

\DeclareDocumentCommand {\themtitle} {} {\tl_use:N \l_thesis_title_tl}
\DeclareDocumentCommand {\themsubtitle} {} {\tl_use:N \l_thesis_subtitle_tl}
\DeclareDocumentCommand {\themauthor} {} {\tl_use:N \l_thesis_author_tl}
\DeclareDocumentCommand {\thekeywords} {} {\tl_use:N \l_thesis_keywords_tl}
\DeclareDocumentCommand {\theinstitute} {} {\tl_use:N \l_thesis_institute_tl}
\DeclareDocumentCommand {\thethesistype} {} {\tl_use:N \l_thesis_thesistype_tl}
\DeclareDocumentCommand {\thesupervisor} {} {\tl_use:N \l_thesis_supervisor_tl}


\pretitle{\begin{spacing}{2}\centering\begin{huge}\scshape\bfseries}
\posttitle{\end{huge} \tl_if_empty:NF \l_thesis_subtitleHyper_tl {\\[2ex]\large~\themsubtitle} \end{spacing}}
\preauthor{\begin{center}\large}
\postauthor{\end{center}}
\predate{\begin{center}\large}
\postdate{\end{center}}

\DeclareDocumentCommand {\theequation} {} {\thesection.\Alph{equation}}

\AtBeginDocument{%
    \hypersetup{%
        , pdftitle={\tl_use:N \l_thesis_titleHyper_tl {}\tl_if_empty:NF \l_thesis_subtitleHyper_tl {~–~\tl_use:N \l_thesis_subtitleHyper_tl {}}}%
        , pdfkeywords={\tl_use:N \l_thesis_keywordsHyper_tl {}}%
        , pdfauthor={\tl_use:N \l_thesis_authorHyper_tl {}}%
    }%

    \setlength{\droptitle}{-5cm}
    \renewcommand {\maketitlehooka} {%
        \tl_if_empty:NF \l_thesis_institute_tl {\centering\begin{spacing}{1.2}\large\tl_use:N \l_thesis_institute_tl {}\end{spacing}\vspace{1cm}}%
        \tl_if_empty:NF \l_thesis_thesistype_tl {\centering\begin{spacing}{1.2}\large\itshape\tl_use:N \l_thesis_thesistype_tl {}\end{spacing}\vspace{.5cm}}%
    }
    \renewcommand {\maketitlehookd} {%
        \tl_if_empty:NF \l_thesis_supervisor_tl {\vspace{1cm}\centering\begin{spacing}{1.2}\large\tl_use:N \l_thesis_supervisor_tl {}\end{spacing}}%
        %\tl_if_empty:NF \l_thesis_logo_tl {\vspace{1cm}\tl_use:N \l_thesis_logo_tl {} \vspace{1cm}}%
    }
}
