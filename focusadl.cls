%% focusadl.cls
%% Copyright (c) 2026 David Purton <david.purton@afes.org.au>
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is David Purton.

\ProvidesExplClass{focusadl}{2026-03-28}{1.0a}
  {FOCUS Adelaide Document Class (DCP)}


%%%
%%% Set up leader note compilation
%%%

\sys_if_shell_unrestricted:TF
  {
    \sys_shell_now:e
      {
        latexmk ~
          -lualatex ~
          -usepretex='\ExplSyntaxOn \bool_new:N \token_to_str:N \l__focusadl_use_leader_notes_bool \ExplSyntaxOff' ~
          \c_sys_jobname_str
      }
    \sys_shell_now:e
      {
        latexmk ~
          -lualatex ~
          -jobname="\c_sys_jobname_str-leadernotes" ~
          -usepretex='\ExplSyntaxOn \bool_new:N \token_to_str:N \l__focusadl_use_leader_notes_bool \bool_set_true:N \token_to_str:N \l__focusadl_use_leader_notes_bool \ExplSyntaxOff' ~
          \c_sys_jobname_str
      }
    \stop
  }
  {
    \bool_if_exist:NF \l__focusadl_use_leader_notes_bool
      {
        \bool_new:N \l__focusadl_use_leader_notes_bool
      }
  }


%%%
%%% Global class options
%%%

\clist_new:N \l__focusadl_options_to_base_class_clist
\skip_new:N  \l__focusadl_spacing_skip
\tl_new:N    \l__focusadl_base_class_tl

\cs_set_eq:NN \__focusadl_set_layout: \relax
\tl_new:N \l__focusadl_obv_tl
\tl_new:N \l__focusadl_rev_tl
\tl_set:Nn \l__focusadl_obv_tl { O }
\tl_set:Nn \l__focusadl_rev_tl { E }

\keys_define:nn { focusadl }
  {
    , layout  .choices:nn       = { 2 ~ on ~ 1 , repeated ~ 2-up }
                                  {
                                    \str_if_eq:nnT {#1} { 2 ~ on ~ 1 }
                                      {
                                        \tl_set:Nn \l__focusadl_obv_tl { E }
                                        \tl_set:Nn \l__focusadl_rev_tl { O }
                                      }
                                    \cs_set:Nn \__focusadl_set_layout:
                                      {
                                        \pgfpagesuselayout
                                          {#1}
                                          [ a4paper , landscape ]
                                      }
                                  }
    , layout  .value_required:n = true
    , spacing .code:n           = {
                                    \str_case:nnF {#1}
                                      {
                                        { normal }
                                        {
                                          \skip_set:Nn
                                            \l__focusadl_spacing_skip
                                            { 10mm plus 5mm minus 2mm }
                                        }
                                        { tighter }
                                        {
                                          \skip_set:Nn
                                            \l__focusadl_spacing_skip
                                            { 8mm plus 5mm minus 2mm }
                                        }
                                        { looser }
                                        {
                                          \skip_set:Nn
                                            \l__focusadl_spacing_skip
                                            { 12mm plus 5mm minus 2mm }
                                        }
                                      }
                                      {
                                        \skip_set:Nn
                                          \l__focusadl_spacing_skip
                                          {#1}
                                      }
                                  }
    , spacing .value_required:n = true
    , spacing .initial:n        = normal
    , type    .choices:nn       = { handout , booklet }
                                  {
                                    \str_if_eq:VnTF \l_keys_choice_str
                                      { handout }
                                      {
                                        \tl_set:Nn \l__focusadl_base_class_tl
                                          { article }
                                      }
                                      {
                                        \tl_set:Nn \l__focusadl_base_class_tl
                                          { book }
                                      }
                                  }
    , type    .initial:n        = handout
    , type    .value_required:n = true
    , unknown .code:n           = {
                                    \clist_put_right:NV
                                      \l__focusadl_options_to_base_class_clist
                                      \CurrentOption
                                  }
  }

\ProcessKeyOptions

\clist_if_in:NnF \l__focusadl_options_to_base_class_clist { oneside }
  {
    \clist_put_left:Nn \l__focusadl_options_to_base_class_clist
      { twoside }
  }

\exp_args:NVV \PassOptionsToClass
  \l__focusadl_options_to_base_class_clist
  \l__focusadl_base_class_tl

\exp_args:NV \LoadClass \l__focusadl_base_class_tl


%%%
%%% Load AFES unified branding
%%%

\RequirePackage
  [
    , table
    , cmyk
  ]
  { xcolor }

\RequirePackage { afesbrand }
\AFESBrandSetColours
  {
    , hero    = tangerineorange
    , neutral = lemonyellow
    , accent  = lightorange
  }


%%%
%%% Page layout
%%%

\dim_const:Nn \c__focusadl_min_paper_side_dim
  {
    \dim_min:nn { \paperwidth } { \paperheight }
  }

\RequirePackage
  [
    , margin      = 0.07 \c__focusadl_min_paper_side_dim
    , includehead = true
    , headsep     = 3ex
    , headheight  = 3ex
  ]
  { geometry }

\RequirePackage { pgfmorepages }
\pgfmorepagesloadextralayouts
\__focusadl_set_layout:

\RequirePackage { parskip }


%%%
%%% Language and font set up
%%%

\RequirePackage { microtype }
\RequirePackage { realscripts }

\RequirePackage { babel }
\babelprovide
  [
    , import
    , main
    , language    = Default
    , hyphenrules = ukenglish
  ]
  {australian}

\ExplSyntaxOff

\babelfont
  {sf}
  [
    , Numbers        = Proportional
    , BoldFont       = Source Sans 3 Semibold
    , BoldItalicFont = Source Sans 3 Semibold Italic
  ]
  { Source Sans 3 }

\babelprehyphenation {australian} { |– }
  {
    { insert, penalty = 10000 },
    {},
    {},
  }
\babelprehyphenation {australian} { [‘“][‘“] }
  {
    {},
    { insert, penalty = 10000 },
    { insert, space = .05 0 0 },
    {}
  }
\babelprehyphenation {australian} { [’”][’”] }
  {
    {},
    { insert, penalty = 10000 },
    { insert, space = .05 0 0 },
    {}
  }

\ExplSyntaxOn

\hook_gput_code:nnn { normalfont } { focusadl } { \AFESBrandFontBody }

\NewDocumentCommand \FOCUSAdlLoadLanguage { m }
  {
    \file_input:n { focusadl-lang-#1 }
  }


%%%
%%% Scripture quotation set up
%%%

\RequirePackage { scripture }
\scripturesetup
  {
    , chapter / font   =
    , chapter / format = \foreignlanguage { australian } {#1}
    , font             = \fontseries { m } \sffamily \footnotesize
    , parindent        = 1em
    , parskip          = 0pt plus 1pt
    , verse / format   = \foreignlanguage { australian }
                           { \textsuperscript {#1} }
    , version          = NIVUK

  }


%%%
%%% Title page set up
%%%

\tl_new:N \l__focusadl_passage_tl

\NewDocumentCommand \passage { m }
  {
    \tl_set:Nn \l__focusadl_passage_tl {#1}
  }

% Define a socket for different styles of titles

\socket_new:nn { focusadl / title } { 1 }

% article class style title socket plug

\socket_new_plug:nnn { focusadl / title } { top }
  {
    \AFESBrandGridSystem
      [
        , body          = false
        , head / colour = neutral
        , head / height = 0.1 \c__focusadl_min_paper_side_dim
        , logo          = focus
        , logo / colour = hero
        , url           = false
      ]
      { }
    \bool_if:nF {#1}
      {
        \tl_if_empty:NF \@title
          {
            \section
              {
                \@title
                \tl_if_empty:NF \l__focusadl_passage_tl
                  { \enspace ( \l__focusadl_passage_tl ) }
              }
          }
      }
  }

% book class style title socket plug

\socket_new_plug:nnn { focusadl / title } { page }
  {
    \AFESBrandGridSystem
      [
        , body / colour = white
        , body / height = 4ex + \textheight -
                          0.1 \c__focusadl_min_paper_side_dim
        , head / colour = hero
        , head / height = 0.1 \c__focusadl_min_paper_side_dim
        , logo          = focus
        , logo / colour = white
        , url           = false
      ]
      {
        \AFESBrandFontHeadOne
        \MakeUppercase { \@title }
      }
    \clearpage
  }

\legacy_if:nTF { @titlepage }
  {
    \socket_assign_plug:nn { focusadl / title } { page }
  }
  {
    \socket_assign_plug:nn { focusadl / title } { top }
  }

\RenewDocumentCommand \maketitle { s }
  {
    \mode_leave_vertical:
    \para_end:
    \skip_vertical:n { -8.2ex plus -2.0pt }
    \thispagestyle { empty }
    \socket_use:nn { focusadl / title } {#1}
  }

% title page environment allowing custom content inside the AFES Brand Grid
% System

\RenewDocumentEnvironment { titlepage } { +b }
  {
    \mode_leave_vertical:
    \para_end:
    \skip_vertical:n { -8.2ex plus -2.0pt }
    \thispagestyle { empty }
    \AFESBrandGridSystem
      [
        , body / colour = white
        , body / height = 4ex + \textheight -
                          0.1 \c__focusadl_min_paper_side_dim
        , head / colour = hero
        , head / height = 0.1 \c__focusadl_min_paper_side_dim
        , logo          = focus
        , logo / colour = white
        , url           = false
      ]
      {#1}
    \clearpage
  }
  { }

\cs_set_nopar:Npn \FOCUSAdlUseTitle
  { \@title }

\cs_set_nopar:Npn \FOCUSAdlUsePassage
  { \l__focusadl_passage_tl }


%%%
%%% Headers and footers
%%%

\RequirePackage { fancyhdr }
\pagestyle { fancy }
\fancyhf { }
\legacy_if:nTF { @twoside }
  {
    \fancyhead [ \exp_after:wN R \l__focusadl_obv_tl ] { \thepage }
    \fancyhead [ \exp_after:wN L \l__focusadl_rev_tl ] { \thepage }
    \fancyhead [ \exp_after:wN R \l__focusadl_rev_tl ] { \@title }
    \fancyhead [ \exp_after:wN L \l__focusadl_obv_tl ]
      {
        \tl_if_empty:NTF \l__focusadl_passage_tl
          { \@title }
          { \l__focusadl_passage_tl }
      }
  }
  {
    \fancyhead [ R ] { \thepage }
    \fancyhead [ L ]
      {
        \@title
        \tl_if_empty:NF \l__focusadl_passage_tl
          { \enspace ( \l__focusadl_passage_tl ) }
      }
  }


%%%
%%% Section heading set up
%%%

\int_zero:N \c@secnumdepth

\cs_if_exist:NT \chapter
  {
    \cs_set:Npn \chapter
      {
        \clearpage
        \@startsection { chapter } { 0 } { \z@ }
                       { -3.5ex \@plus -1ex \@minus -.2ex }
                       { 2.3ex \@plus .2ex }
                       {
                         \raggedright \AFESBrandFontHeadOne
                         \LARGE \MakeUppercase
                       }
      }
  }

\cs_set:Npn \section
  {
    \@startsection { section } { 1 } { \z@ }
                   { -3.5ex \@plus -1ex \@minus -.2ex }
                   { 2.3ex \@plus .2ex }
                   { \raggedright \AFESBrandFontHeadTwo }
  }

\cs_set:Npn \subsection
  {
    \@startsection { subsection } { 2 } { \z@ }
                   { -3.25ex \@plus -1ex \@minus -.2ex }
                   { 1.5ex \@plus .2ex }
                   {
                     \color { hero }
                     \raggedright
                     \AFESBrandFontHeadThree
                     \MakeUppercase
                   }
  }

\cs_set:Npn \subsubsection
  {
    \@startsection { subsubsection } { 3 } { \z@ }
                   { -3.25ex \@plus -1ex \@minus -.2ex }
                   { 1.5ex \@plus .2ex }
                   {
                     \raggedright
                     \normalfont
                     \normalsize
                     \bfseries
                   }
  }

%%%
%%% List set up
%%%

\RequirePackage { enumitem }


\setlist [ enumerate ]
  {
    , itemsep = \l__focusadl_spacing_skip
  }
\setlist [ enumerate , 1 ]
  {
    , resume = true
    , after  = \skip_vertical:N \l__focusadl_spacing_skip
  }
\setlist [ itemize ]
  {
    , itemsep = 0pt
  }
\setlist [ description ]
  {
    , font = \fontseries { sb } \selectfont
  }

%%%
%%% Box set up
%%%

\RequirePackage { multicol }
\RequirePackage { needspace }
\RequirePackage { paracol }
\RequirePackage
  [
    , breakable
    , skins
  ]
  { tcolorbox }

\tcbset
  {
    herobox / .style =
      {
        , enhanced ~ jigsaw
        , breakable
        , colback = white
        , colframe = hero
        , left = 2mm
        , right = 2mm
        , fonttitle = \bfseries
        , pad ~ at ~ break* = 0mm
        , fontupper = \small
        , fontlower = \small
        , segmentation ~ style =
            {
              , solid
              , tcbcolframe
              , line ~ width = 0.5mm
            }
        , sidebyside ~ align = top ~ seam
        , sidebyside ~ gap = 6.5mm
        , before ~ lower = \noindent
        , before ~ upper =
            \skip_zero:N \topskip
            \dim_set:Nn  \parindent { 1em }
            \everypar
              {
                { \setbox 0 \lastbox }
                \@minipagefalse
                \everypar { }
              }
      }
  }

\tcbset
  {
    accentbox / .style =
      {
        , enhanced ~ jigsaw
        , breakable
        , colback = white
        , colframe = accent
        , boxrule = 0.5mm
        , leftrule = 10pt
        , sharp ~ corners
        , segmentation ~ style =
            {
              , solid
              , tcbcolframe
              , line ~ width = 0.5mm
            }
        , left = 2mm
        , right = 2mm
        , pad ~ at ~ break* = 0mm
        , fontupper = \footnotesize
        , fontlower = \footnotesize
        , before ~ upper = \skip_zero:N \topskip
        , sidebyside ~ align = top ~ seam
        , sidebyside ~ gap = 6.5mm
        , hyphenationfix
      }
  }

\newtcolorbox { herobox } [ 1 ] [ ] { herobox , #1 }

% Different layouts of text in accentbox is set using sockets

\socket_new:nn { focusadl / accentbox / begin } { 0 }
\socket_new:nn { focusadl / accentbox / end } { 0 }

% Single column accent box socket plug definition using a standard tcolorbox

\socket_new_plug:nnn { focusadl / accentbox / begin } { onecolumn }
  {
    \cs_set_eq:NN \newsegment \tcbline
    \begin { tcolorbox } [ accentbox , colframe = colframe ]
  }
\socket_new_plug:nnn { focusadl / accentbox / end } { onecolumn }
  {
    \end { tcolorbox }
  }

% Two column accentbox socket plug adjusts \page@sofar to place vertical lines
% either side of the columns

% See https://tex.stackexchange.com/a/132461/87678
\cs_new:Npn \__focusadl_multicol_rules: #1\full@width#2#3!!
  {
    \cs_set:Npn \page@sofar
      {
        #1\full@width
          {
            {
              \color { colframe }
              \vrule width 10pt
            }
            \kern 3mm
            #2
            \kern 3mm
            {
              \color { colframe }
              \vrule width 0.5mm
            }
          }
        #3
      }
  }

\cs_new_protected:Nn \__focusadl_multicol_new_segment:
  {
    \end { multicols }
    \skip_vertical:n { -\parskip }
    \nobreak
    \tikz
      {
        \fill [ colframe ]
          ( 0 , 0 ) rectangle ( \linewidth , 0.5mm );
        \fill [ colframe ]
          ( 0 , -2mm ) rectangle ( 10pt , 3.5mm );
        \fill [ colframe ]
          ( \linewidth - 0.5mm , -2mm ) rectangle ( \linewidth , 3.5mm );
      }
    \skip_vertical:n { -1.2mm }
    \nobreak
    \begin { multicols } { 2 }
  }

\socket_new_plug:nnn { focusadl / accentbox / begin } { twocolumn }
  {
    \ensurevspace { 2ex }
    \dim_set:Nn \columnsep { 16mm }
    \dim_zero:N \multicolsep
    \cs_set_eq:NN \newsegment \__focusadl_multicol_new_segment:
    \exp_after:wN \__focusadl_multicol_rules: \page@sofar !!
    \tikz
      {
        \fill [ colframe ]
          ( 0 , 0 ) rectangle ( \linewidth , 0.5mm );
        \fill [ colframe ]
          ( 0 , 0 ) rectangle ( 10pt , -3mm );
        \fill [ colframe ]
          ( \linewidth - 0.5mm , 0 ) rectangle ( \linewidth , -3mm );
      }
    \skip_vertical:n { -2.2mm }
    \nobreak
    \begin { multicols } { 2 }
  }
\socket_new_plug:nnn { focusadl / accentbox / end } { twocolumn }
  {
    \end { multicols }
    \skip_vertical:n { -\parskip - 1mm }
    \nobreak
    \tikz
      {
        \fill [ colframe ]
          ( 0 , 0 ) rectangle ( 10pt , 4.1mm );
        \fill [ colframe ]
          ( \linewidth - 0.5mm , 0 ) rectangle ( \linewidth , 4.1mm );
        \fill [ colframe ]
          ( 0 , 0 ) rectangle ( \linewidth , -0.5mm );
      }
  }

\cs_new_protected:Nn \__focusadl_parallel_secondcolumn:
  {
      \end { tcolorbox }
      \switchcolumn
      \begin { tcolorbox } [ accentbox , boxrule = 0.5mm , empty ]
  }

\cs_new_protected:Nn \__focusadl_parallel_new_segment:
  {
      \end { tcolorbox }
    \end { paracol }
    \skip_vertical:n { -\baselineskip - 0.5mm }
    \begin { paracol } { 2 }
      \begin { tcolorbox }
        [
          , accentbox
          , grow ~ to ~ right ~ by = \textwidth - \linewidth - \@totalleftmargin
          , right = \textwidth - \linewidth - 2\@totalleftmargin + 2mm
        ]
  }

\socket_new_plug:nnn { focusadl / accentbox / begin } { parallel }
  {
    \skip_vertical:n { \parskip }
    \skip_zero:N \parskip
    \dim_set:Nn \l_tmpa_dim
      {
        \l__focusadl_col_ratio_tl \linewidth +
        \l__focusadl_col_ratio_tl 4mm
      }
    \setcolumnwidth { \l_tmpa_dim / -1mm , 0pt plus 1fil }
    \cs_set_eq:NN \secondcolumn \__focusadl_parallel_secondcolumn:
    \cs_set_eq:NN \newsegment   \__focusadl_parallel_new_segment:
    \begin { paracol } { 2 }
      \ensurevspace { 2ex }
      \begin { tcolorbox }
        [
          , accentbox
          , grow ~ to ~ right ~ by = \textwidth - \linewidth - \@totalleftmargin
          , right = \textwidth - \linewidth - 2\@totalleftmargin + 2mm
        ]
  }
\socket_new_plug:nnn { focusadl / accentbox / end } { parallel }
  {
      \end { tcolorbox }
    \end { paracol }
  }

\keys_define:nn { focusadl / accentbox }
  {
    , colframe .code:n           = {
                                     \colorlet { colframe } {#1}
                                   }
    , colframe .value_required:n = true
    , colframe .initial:n        = accent
    , ratio    .tl_set:N         = \l__focusadl_col_ratio_tl
    , ratio    .value_required:n = true
    , ratio    .initial:n        = 0.5
    , type     .choices:nn       = { onecolumn , twocolumn , parallel }
                                   {
                                     \socket_assign_plug:nn
                                       { focusadl / accentbox / begin }
                                       { #1 }
                                     \socket_assign_plug:nn
                                       { focusadl / accentbox / end }
                                       { #1 }
                                   }
    , type     .value_required:n = true
    , type     .initial:n        = onecolumn
  }

\keys_set:nn { focusadl / accentbox } { }

\NewDocumentEnvironment { accentbox } { o }
  {
    \tl_if_novalue:nF {#1}
      {
        \keys_set:nn { focusadl / accentbox } {#1}
      }
    \socket_use:n { focusadl / accentbox / begin }
  }
  {
    \socket_use:n { focusadl / accentbox / end }
  }


%%%
%%% Leader notes
%%%

\keys_define:nn { focusadl / leadernotes }
  {
    , color  .meta:n           = colour
    , colour .tl_set:N         = \l__focusadl_leadernotes_colour_tl
    , colour .initial:n        = black!40
    , colour .value_required:n = true
    , font   .tl_set:N         = \l__focusadl_leadernotes_font_tl
    , font   .initial:n        = \fontseries { m } \sffamily \footnotesize
    , font   .value_required:n = true
  }

\keys_set:nn { focusadl / leadernotes } { }

\NewDocumentEnvironment { leadernotes } { o }
  {
    \tl_if_novalue:nF {#1}
      {
        \keys_set:nn { focusadl / leadernotes } {#1}
      }
    \mode_leave_vertical:
    \color { \l__focusadl_leadernotes_colour_tl }
    \l__focusadl_leadernotes_font_tl
    \ignorespaces
  }
  { }


%%%
%%% Write in gaps
%%%

\keys_define:nn { focusadl / gap }
  {
    , text  .tl_set:N         = \l__focusadl_gap_text_tl
    , text  .value_required:n = true
    , width .skip_set:N       = \l__focusadl_gap_wd_skip
    , width .value_required:n = true
    , width .initial:n        = 4cm plus 3cm minus 2cm
  }

\keys_set:nn { focusadl / gap } { }

\NewDocumentCommand \gap { o }
  {
    \tl_if_novalue:nF {#1}
      {
        \keys_set:nn { focusadl / gap } {#1}
      }
    \vrule height 2.5ex width 0pt
    \nobreak
    \tl_if_empty:NF \l__focusadl_gap_text_tl
      {
        \hbox_overlap_right:n { \l__focusadl_gap_text_tl }
      }
    \leaders
    \hrule height -3.6pt depth 4pt
    \skip_horizontal:N \l__focusadl_gap_wd_skip
    \strut
  }

\endinput
