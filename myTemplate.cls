\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myTemplate}[2023/07/10]
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


%数学支持
\RequirePackage{myMath}
\RequirePackage{siunitx}	%单位


%颜色支持
\RequirePackage[usenames,svgnames,dvipsnames]{xcolor}


%代码块格式
\RequirePackage{myCode}


%本地化
%\RequirePackage[utf8]{inputenc}	%似在XeLaTeX下不必使用
\ifchn
	\RequirePackage{ctex}             	%中文
\fi
%章节标题
\RequirePackage{titlesec}
\def\probmark{\ifchn 题 \else Problem \fi}
\ifhstyle
	\titleformat{\section}{\raggedright\large\bfseries}{\probmark\,\,}{0em}{}
	\titleformat{\subsection}[runin]{\raggedright\bfseries}{}{1em}{(\,}[\,)]
	\renewcommand{\sectionmark}[1]{\markboth{\probmark\, #1}{}} 
\fi

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
	\crefname{listing}{代码}{代码}
	\ifhstyle
		\crefname{section}{题}{题}
	\else
		\crefname{section}{节}{节}
	\fi
	\renewcommand{\figurename}{图}                  
	\renewcommand{\tablename}{表}
	\renewcommand{\lstlistingname}{代码}
	\renewcommand{\abstractname}{\large{摘要}\\} 
	\renewcommand{\today}{\number\year 年 \number\month 月 \number\day 日}
\fi


%排版支持
\RequirePackage{wrapfig}            %图文混排（环绕）      
\RequirePackage{indentfirst}        %使每节第一段适用段首缩进
\setlength{\parindent}{2em}     	%段首缩进
\linespread{1.4}                	%行距倍数
\RequirePackage{geometry}			%页面设置
\geometry{
	width=150mm,
	top=25mm,
	bottom=25mm,
}
%\RequirePackage{multicol}
\RequirePackage{caption}
\RequirePackage{subcaption}


%表格
\RequirePackage{multirow}       %表格分行
\RequirePackage{booktabs}       %三线表
\RequirePackage{longtable}		%跨页表格
%\RequirePackage{tabu}          %更灵活的表格


%定理环境
\RequirePackage{myTheorem}


%绘图支持
%建议使用其他绘图方式
\RequirePackage{graphicx}				%图片
\RequirePackage{pgfplots}				%pgf绘图
\pgfplotsset{width=11cm,compat=1.17}


%页眉页脚设置
%以下取消|\maketitle|对|\@title|和|\@author|的重置
%原始定义参见article.cls
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
    \setcounter{footnote}{0}
    \global\let\thanks\relax
    \global\let\maketitle\relax
    \global\let\@maketitle\relax
    \global\let\@thanks\@empty
	\ifx\@title\@empty
		\relax
	\else
		\let\Title\@title
	\fi
	\ifx\@author\@empty
		\relax
	\else
		\let\Author\@author
	\fi
    \global\let\@author\@empty
    \global\let\@date\@empty
    \global\let\@title\@empty
    \global\let\title\relax
    \global\let\author\relax
    \global\let\date\relax
    \global\let\and\relax
}
\makeatother
\ifx\Title\undefined
	\let\Title\empty
\fi
\ifx\Author\undefined
	\let\Author\empty
\fi

\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\fancypagestyle{fancy}
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
\pagestyle{fancy}

