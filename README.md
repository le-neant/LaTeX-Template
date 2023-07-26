# 这是什么
一个主要适用于小型报告和作业的LaTeX模板，具有基础的排版功能

# 它有什么功能
- 简单的自定义带框定理环境
- 代码块支持（目前仅对C++有效，但简单修改后可适用于其他语言）
- 可能略显花哨的页眉页脚
- 其他琐碎功能

# 如何使用
将所有的.cls和.sty文件复制到你的工作目录中，并以`\documentclass{myTemplate}`开始你的.tex文件

如果你愿意安装它，以在Windows系统下的TeX Live发行版为例，你需要将这些文件复制到你的TeX Live安装目录下的 \texmf-local\tex\latex\local 文件夹，然后在命令行中运行`texhash`命令

# 致谢
本模板是对包括但不限于如下作品的拙劣模仿：

https://github.com/vEnhance/napkin

http://tex.stackexchange.com/questions/81834/whats-the-best-way-to-typeset-c-codes-in-latex

https://github.com/liblaf/ilatex

https://github.com/singlet-Carbene/WYC-Template

