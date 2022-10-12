\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myTemplate}[2022/10/10]
\LoadClass[a4paper]{article}


%可选项：homework,eng,nofooter
\newif\ifhstyle\hstylefalse					%适合作业的格式
\DeclareOption{homework}{\hstyletrue}
\newif\ifchn\chntrue						%中文
\DeclareOption{eng}{\chnfalse}
\newif\iffooter\footertrue					%页脚图片
\DeclareOption{nofooter}{\footerfalse}
\DeclareOption*{
	\PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax


%语言支持
%\RequirePackage[utf8]{inputenc}	%似在XeLaTeX下不必使用
\RequirePackage{xeCJK}             	%中文


%数学支持与运算符快捷方式
\RequirePackage{amsmath,amssymb,amsthm}     %数学支持
\RequirePackage{bm}                         %粗斜体
\providecommand{\dif}{\,\mathrm{d}}
\providecommand{\euler}{\mathrm{e}}
\providecommand{\driv}[2]{\frac{\dif #1}{\dif #2}}
\providecommand{\ddriv}[2]{\dfrac{\dif #1}{\dif #2}}


%颜色支持
\RequirePackage[usenames,svgnames,dvipsnames]{xcolor}	%颜色


%排版支持
\RequirePackage{wrapfig}            %图文混排（环绕）      
\RequirePackage{indentfirst}        %使每节第一段适用段首缩进
\setlength{\parindent}{2em}     	%段首缩进量
\linespread{1.4}                	%行距倍数
\RequirePackage{geometry}			%边距等页面设置
\geometry{
	width=150mm,
	top=25mm,
	bottom=25mm,
}
%\RequirePackage{multicol}
\RequirePackage{caption}
\RequirePackage{subcaption}


%杂项
%章节标题
\def\probmark{\ifchn 题 \else Problem \fi}
\RequirePackage{titlesec}           %章节标题设置
\ifhstyle
	\titleformat{\section}{\raggedright\large\bfseries}{\probmark\,\,}{0em}{}
	\titleformat{\subsection}[runin]{\raggedright\bfseries}{}{1em}{(\,}[\,)]
\fi

\RequirePackage{siunitx}	%单位

\RequirePackage{authblk}                       	%改良的作者和联系方式显示
\setlength{\affilsep}{0em}						%修改作者与联系方式间的垂直间隔

\RequirePackage{hyperref}   %为交叉引用添加超链接
\hypersetup{
	colorlinks=true,
	linkcolor=blue,
	filecolor=red,      
	urlcolor=blue,
	citecolor=green,
}
\RequirePackage{cleveref}
\ifchn
	\crefname{figure}{图}{图}
	\crefname{table}{表}{表}
	\crefname{equation}{式}{式}
	\ifhstyle
		\crefname{section}{题}{题}
	\else
		\crefname{section}{节}{节}
	\fi
	\renewcommand{\figurename}{图}                  
	\renewcommand{\tablename}{表}                   
	\renewcommand{\abstractname}{\large{摘要}\\} 
	\renewcommand{\today}{\number\year 年 \number\month 月 \number\day 日}
\fi

\RequirePackage{multirow}       %表格分行
\RequirePackage{booktabs}       %三线表
\RequirePackage{longtable}		%跨页表格
%\RequirePackage{tabu}          %更灵活的表格


%定理环境
\RequirePackage{thmtools}                   	%定理等环境支持
\RequirePackage[framemethod=TikZ]{mdframed}     %带背景色的box
%以下是几种box配置
%来自 Evan CHAN 的著作 A Infinite Napkin ，有改动
%见于https://github.com/vEnhance/napkin
\mdfdefinestyle{mdredbox}{
	linewidth=0.5pt,
	skipabove=12pt,
	frametitleaboveskip=5pt,
	frametitlebelowskip=0pt,
	skipbelow=2pt,
	frametitlefont=\bfseries,
	innertopmargin=4pt,
	innerbottommargin=8pt,
	linecolor=RawSienna,
	backgroundcolor=Salmon!5,
}
\declaretheoremstyle[
	headfont=\bfseries\color{RawSienna},
	mdframed={style=mdredbox},
	headpunct={\\[3pt]},
	postheadspace={0pt},
]{thmredbox}

\mdfdefinestyle{mdblackbox}{
	skipabove=8pt,
	linewidth=3pt,
	rightline=false,
	leftline=true,
	topline=false,
	bottomline=false,
	linecolor=black,
	backgroundcolor=RedViolet!5!gray!5,
}
\declaretheoremstyle[
	headfont=\bfseries,
	bodyfont=\normalfont\small,
	spaceabove=0pt,
	spacebelow=0pt,
	mdframed={style=mdblackbox},
	headpunct={},
]{thmblackbox}

\newcommand{\newredbox}[2]{
	\declaretheorem[style=thmredbox,name=#1]{#2}
	\catcode`*11
	\declaretheorem[style=thmredbox,numbered=no,name=#1]{#2*}
	\catcode`*12
}
\newcommand{\newblackbox}[2]{
	\declaretheorem[style=thmblackbox,name=#1]{#2}
	\catcode`*11
	\declaretheorem[style=thmblackbox,numbered=no,name=#1]{#2*}
	\catcode`*12
}


%绘图支持
%建议使用其他绘图方式
\RequirePackage{graphicx}				%图片
\RequirePackage{pgfplots}				%pgf绘图
\pgfplotsset{width=11cm,compat=1.17}


%页眉页脚设置
%以下取消|\maketitle|对|\@title|和|@author|的重置
%原定义参见article.cls
%对其进行修改可以自定义\maketitle宏
\makeatletter
\renewcommand{\maketitle}
{	
	\par
    \begingroup
		\renewcommand\thefootnote{\@fnsymbol\c@footnote}%
		\def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
		\long\def\@makefntext##1{\parindent 1em\noindent
					\hb@xt@1.8em{%
					\hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
		\if@twocolumn
        	\ifnum \col@number=\@ne
          		\@maketitle
        	\else
          		\twocolumn[\@maketitle]%
        	\fi
    	\else
			\newpage
			\global\@topnum\z@   % Prevents figures from going at top of page.
			\@maketitle
    	\fi
    	%\thispagestyle{plain}
		\@thanks
    \endgroup
    \setcounter{footnote}{0}%
    \global\let\thanks\relax
    \global\let\maketitle\relax
    \global\let\@maketitle\relax
    \global\let\@thanks\@empty
    %\global\let\@author\@empty
    \global\let\@date\@empty
    %\global\let\@title\@empty
    \global\let\title\relax
    \global\let\author\relax
    \global\let\date\relax
    \global\let\and\relax
}

\def\Title{\@title}
\def\Author{\@author}
%此处|\Title|的出现是为了解决|\fancyhead|无法访问|\@title|的问题
%倘若有更好的解决办法，烦请告知
\makeatother

\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\pagestyle{fancy}
\fancypagestyle{preContent}
{
    \fancyhf{}
    \fancyhead[L]{\Title}
	\fancyhead[R]{\leftmark}
    \renewcommand\headrulewidth{.5pt}	%修改为0pt即可取消页眉线
	\renewcommand\footrulewidth{.5pt}	%页脚同上
    \fancyfoot[R]{\setlength{\affilsep}{0em}\renewcommand*{\Affilfont}{\normalfont}\Author}
	\fancyfoot[C]{
		\raisebox{-1.5ex}{
			\ifchn 
				第 \thepage 页，共 \pageref{LastPage} 页 
			\else
				Page \thepage{} of\ \pageref{LastPage}
			\fi	
		}
	}
	\iffooter
	\fancyfoot[L]{\raisebox{-3ex}{\includegraphics[width=0.3\textwidth]{sampleLogo.pdf}}}
	\fi
}
\pagestyle{preContent}

\ifhstyle
	\renewcommand{\sectionmark}[1]{\markboth{\probmark\, #1}{}} 
\fi
