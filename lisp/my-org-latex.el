
;;; my-org-latex.el --- ...

;; Copyright (C) 2013-2021  Klaus Kähler Holst

;; Authors: Klaus Kähler Holst <klaus@holst.it>
;;
;; Keywords: tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:


(require 'org)


(defun headless-latex ()
  "exports to a .tex file without any preamble"
  (interactive)
  (if (derived-mode-p 'org-mode)
    (let ((nn (replace-regexp-in-string "\.org$" "" (buffer-name))))
      (org-latex-export-as-latex nil nil nil t nil)
      (write-file (concat nn ".tex") nil)
      (kill-buffer-and-window)))
  (save-buffer) ;; If not org-mode just save the buffer
 )

;; define mode for some special key-binding
(define-minor-mode my-org-buffer-local-mode
  "Minor mode to simulate buffer local keybindings."
  :init-value nil
  :ligher "my-loc"
  :keymap '(([M-j] . headless-latex) ([C-c C-p] . headless-latex))
  )
;;(define-key my-org-buffer-local-mode-map (kbd "M-j") 'headless-latex)
(eval-after-load "my-org-buffer-local-mode"
  '(bind-keys* ("M-j" . headless-latex)))

;; Can then add this to org file to create custom key-bindings
;; # Local Variables:
;; # my-org-buffer-local-mode: t
;; # eval:(define-key my-org-buffer-local-mode-map (kbd "<f10>") 'some-other-custom-defun-specific-to-this-buffer)
;; # End:

;; Also add tikz to the auto-fragile regexp list
(setq org-beamer-fragile-re "\\\\\\(verb\\|lstinline\\)\\|^[    ]*\\\\begin{\\(verbatim\\|lstlisting\\|tikzpicture\\|minted\\)}")

(defun my-beamer-bold (contents backend info)
  (when (eq backend 'beamer)
    (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\textbf" contents)))
;; (add-to-list 'org-export-filter-bold-functions 'my-beamer-bold)

(setq org-latex-prefer-user-labels t)
(setq org-highlight-latex-and-related '(script entities))
;; (native latex script entities))

;;(unless (boundp 'org-latex-classes)
(setq org-latex-classes nil)
;;)


;; (defcustom org-export-latex-tables-centered nil
;;   "When non-nil, tables are exported in a center environment."
;;   :group 'org-export-latex
;;   :type 'boolean)

(setq org-latex-images-centered nil)
(setq org-latex-tables-centered nil)

(setq org-preview-latex-image-directory "tmp/ltximg")
(setq org-preview-latex-default-process 'dvipng) ;;'imagemagick)
(setq org-preview-latex-default-process 'dvisvgm)

(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.75))
(setq org-format-latex-options (plist-put org-format-latex-options :foreground 'default))
(setq org-format-latex-options (plist-put org-format-latex-options :background 'default))
;; (setq org-format-latex-options
;;       '(:foreground default :background default :scale 1.25 :html-foreground "default" :html-background "Transparent" :html-scale 1.0 :matchers
;; 		    ("begin" "$1" "$" "$$" "\\(" "\\["))
;; (setq org-format-latex-options (quote (:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 2.0 :matchers ("begin" "$1" "$" "$$" "\\(" "\\["))))


;;{{{ latex content definitions

(defvar my/org-latex-minted "\\usepackage[outputdir=tmp/build,cachedir=minted]{minted}
\\usemintedstyle{tango}
\\setminted{linenos,fontsize=\\footnotesize,texcomments,breaklines=true,frame=lines,framerule=0.3pt,framesep=2.5pt}
"
"latex minted settings")

(defvar my/org-latex-tufte "\\usepackage{environ}
\\NewEnviron{mnote}{\\marginnote{\\BODY}}
\\NewEnviron{snote}{\\sidenote{\\BODY}}
"
"latex-tufte settings"
  )

(defvar my/org-latex-tikz "\\usepackage{tikz}
\\usetikzlibrary{shapes,arrows,shadows,shadows.blur}
\\tikzstyle{plain}=[rectangle,thick,fill=white,align=left, minimum size=1cm,draw=gray!80,blur shadow={shadow blur steps=5}]
\\tikzstyle{exo}=[rectangle,thick,minimum size=1cm,draw=gray!80,fill=blue!20,blur shadow={shadow blur steps=5}]
\\tikzstyle{endo}=[rectangle,thick,minimum size=1cm,draw=gray!80,fill=orange!80,blur shadow={shadow blur steps=5}]
\\tikzstyle{latent}=[circle,thick,minimum size=1cm,draw=gray!80,fill=olive!80,blur shadow={shadow blur steps=5}]
"
  "org header tikz template")

(defvar my/org-latex-default
 "
"
"org latex template used in several org-latex-classes elements")
;; %%\\rowcolors[]{1}{beamer@blendedblue!2%%0}{beamer@blendedblue!10}\naboberies"

;;}}}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; LaTeX classes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;{{{ jss

(add-to-list 'org-latex-classes
	     '("jss"
	       "\\documentclass[useAMS,article,shortnames]{jss}
                   [NO-DEFAULT-PACKAGES]
                   [PACKAGES]
                   [EXTRA]"
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;;}}}

;;{{{ beamer
(add-to-list 'org-latex-classes
	     '("beamer"
	       "\\documentclass{beamer}
             [NO-DEFAULT-PACKAGES]
             [PACKAGES]
             [EXTRA]"
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
	     )
;;}}}

;;{{{ plain
(add-to-list 'org-latex-classes
	     '("plain"
	       "\\documentclass[12pt]{article}
             [NO-DEFAULT-PACKAGES]"
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;;}}}

;;{{{ none
(add-to-list 'org-latex-classes
	     '("none"
	       "[NO-DEFAULT-PACKAGES]"
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;;}}}

;;{{{ practical
(add-to-list 'org-latex-classes
	     `("practical"
	       ,(concat
	       "\\documentclass{article}
             [NO-DEFAULT-PACKAGES]"
             "[PACKAGES]
             [EXTRA]")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;;}}}

;;{{{ default

(add-to-list 'org-latex-classes
	     '("default"
	       "\\documentclass{article}
[DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]
"	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;;}}}

;;{{{ article, article+tikz, article+listings

(add-to-list 'org-latex-classes
	     `("article"
	       ,(concat "\\PassOptionsToPackage{usenames}{xcolor}
\\PassOptionsToPackage{hidelinks,colorlinks,linkcolor={blue!50!black},urlcolor={blue!50!black},citecolor={blue!50!black}}{hyperref}
%%\\PassOptionsToPackage{outputdir=tmp/build,cachedir=minted}{minted}
\\documentclass{article}
[DEFAULT-PACKAGES]
"
my/org-latex-default
my/org-latex-minted
"[PACKAGES]
[EXTRA]
")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
	     `("article+minted"
	       ,(concat "\\PassOptionsToPackage{usenames}{xcolor}
\\PassOptionsToPackage{hidelinks,colorlinks,linkcolor={blue!50!black},urlcolor={blue!50!black},citecolor={blue!50!black}}{hyperref}
%%\\PassOptionsToPackage{outputdir=tmp/build,cachedir=minted}{minted}
\\documentclass{article}
[EXTRA]
[DEFAULT-PACKAGES]
"
my/org-latex-default
my/org-latex-minted
"[PACKAGES]
")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
	     `("article+tikz"
	       ,(concat "\\PassOptionsToPackage{usenames}{xcolor}
\\PassOptionsToPackage{hidelinks,colorlinks,linkcolor={blue!50!black},urlcolor={blue!50!black},citecolor={blue!50!black}}{hyperref}
\\documentclass{article}
[DEFAULT-PACKAGES]
\\usepackage[left=2.5cm,top=4cm,right=2.5cm,bottom=4cm]{geometry}
"
my/org-latex-default
my/org-latex-tikz
my/org-latex-minted
"[PACKAGES]
[EXTRA]
")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(add-to-list 'org-latex-classes
	     `("article+listings"
	       ,(concat "\\PassOptionsToPackage{usenames}{xcolor}
\\PassOptionsToPackage{hidelinks,colorlinks,linkcolor={blue!50!black},urlcolor={blue!50!black},citecolor={blue!50!black}}{hyperref}
\\documentclass{article}
[EXTRA]
[DEFAULT-PACKAGES]
\\usepackage[left=2.5cm,top=4cm,right=2.5cm,bottom=4cm]{geometry}
"
my/org-latex-default
"[PACKAGES]
")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;;}}}

;;{{{ tufte-handout, tufte-handout+tikz

(add-to-list 'org-latex-classes
	     `("tufte-handout"
	       ,(concat "\\PassOptionsToPackage{usenames}{xcolor}
\\PassOptionsToPackage{hidelinks,colorlinks,linkcolor={blue!50!black},urlcolor={blue!50!black},citecolor={blue!50!black}}{hyperref}
\\documentclass{tufte-handout}
[DEFAULT-PACKAGES]
"
my/org-latex-default
my/org-latex-minted
my/org-latex-tufte
"[PACKAGES]
[EXTRA]
")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
	     `("tufte-handout+tikz"
	       ,(concat "\\PassOptionsToPackage{usenames}{xcolor}
\\PassOptionsToPackage{hidelinks,colorlinks,linkcolor={blue!50!black},urlcolor={blue!50!black},citecolor={blue!50!black}}{hyperref}
\\documentclass{tufte-handout}
[DEFAULT-PACKAGES]
"
my/org-latex-tufte
my/org-latex-default
my/org-latex-minted
my/org-latex-tikz
"[PACKAGES]
[EXTRA]
")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
	     `("tufte-handout+listings"
	       ,(concat "\\PassOptionsToPackage{usenames}{xcolor}
\\PassOptionsToPackage{hidelinks,colorlinks,linkcolor={blue!50!black},urlcolor={blue!50!black},citecolor={blue!50!black}}{hyperref}
\\documentclass{tufte-handout}
[EXTRA]
[DEFAULT-PACKAGES]
"
my/org-latex-tufte
my/org-latex-default
"[PACKAGES]
")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;;}}}

;;{{{ tufte-book, tufte-book+tikz
(add-to-list 'org-latex-classes
	     `("tufte-book"
	       ,(concat "\\PassOptionsToPackage{usenames}{xcolor}
\\PassOptionsToPackage{hidelinks,colorlinks,linkcolor={blue!50!black},urlcolor={blue!50!black},citecolor={blue!50!black}}{hyperref}
\\documentclass{tufte-book}
[EXTRA]
[DEFAULT-PACKAGES]
"
my/org-latex-default
my/org-latex-minted

"[PACKAGES]
")
	       ("\\chapter{%s}" . "\\chapter*{%s}")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
	     `("tufte-book+tikz"
	       ,(concat "\\PassOptionsToPackage{usenames}{xcolor}
\\PassOptionsToPackage{hidelinks,colorlinks,linkcolor={blue!50!black},urlcolor={blue!50!black},citecolor={blue!50!black}}{hyperref}
\\documentclass{tufte-book}
[DEFAULT-PACKAGES]
"
my/org-latex-default
my/org-latex-minted
my/org-latex-tikz
"[PACKAGES]
[EXTRA]
")
	       ("\\chapter{%s}" . "\\chapter*{%s}")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;;}}}

;;{{{ presentation, presentation+tikz

(add-to-list 'org-latex-classes
	     `("presentation"
	       ,(concat "\\documentclass{beamer}
[DEFAULT-PACKAGES]
"
my/org-latex-default
my/org-latex-minted
"[PACKAGES]
[EXTRA]
")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(add-to-list 'org-latex-classes
	     `("presentation+listings"
	       ,(concat "\\documentclass{beamer}
[EXTRA]
[DEFAULT-PACKAGES]
"
my/org-latex-default
"[PACKAGES]
")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
	     `("presentation+tikz"
	       ,(concat "\\documentclass{beamer}
[DEFAULT-PACKAGES]
"
my/org-latex-default
my/org-latex-minted
my/org-latex-tikz
"[PACKAGES]
[EXTRA]
")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;;}}}


;;{{{ business letter

(add-to-list 'org-latex-classes
	     '("letter2"
	       "
\\PassOptionsToPackage{pdfpagelabels=false,hidelinks,colorlinks,linkcolor={blue!50!black},urlcolor={blue!50!black},citecolor={blue!50!black}}{hyperref}
\\documentclass[a4paper,12pt]{letter}
\\usepackage{etex}
\\usepackage{etoolbox}
\\usepackage[T1]{fontenc}
\\usepackage{mathtools}
\\usepackage[strict=true]{csquotes}
\\usepackage[utf8]{inputenc}
\\usepackage{graphicx}
\\usepackage{verbatim}
\\usepackage{url}
\\usepackage{booktabs}
\\usepackage[usenames]{xcolor}
\\usepackage[hidelinks,colorlinks,linkcolor={blue!50!black},urlcolor={blue!50!black},citecolor={blue!50!black}]{hyperref}
[NO-DEFAULT-PACKAGES]
"
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;;}}}


(add-to-list 'org-latex-classes
	     `("letter"
	       ,(concat "
\\PassOptionsToPackage{pdfpagelabels=false,hidelinks,colorlinks,linkcolor={blue!50!black},urlcolor={blue!50!black},citecolor={blue!50!black}}{hyperref}
\\documentclass{mletter}
[EXTRA]
[NO-DEFAULT-PACKAGES]
\\usepackage{amssymb,amsmath}
\\newenvironment{sverb}{\\small\\verbatim}{\\endverbatim}

"
"[PACKAGES]
")
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


;;}}}


;; Default packages included in every tex file, pdflatex or xelatex
(setq org-latex-default-packages-alist
      '(
        ("ext" "orgstd" nil)
	;; ("" "etex" nil)
	;; ("" "etoolbox" nil)
	;; ("l2tabu,orthodox" "nag" nil) ;; Old habits die hard.
	;;("" "units" nil) ;; non-stacked fractions and better unit spacing
	;; ("utf8" "inputenc" t)
	;; ("T1" "fontenc" t)
;;	("" "fixltx2e" nil) ;; All fixes should now be in new releases
	;; ("" "mathtools,amssymb" nil)  ;; extended mathematics
	;; ("strict=true" "csquotes" nil)
	;; ("" "xcolor" nil)
	;; ("" "natbib" nil)
	;; ("" "bm" t)
	;; ("" "graphicx" t)
	;; ("" "wrapfig" nil)
	;;("" "ulem" t)
	;;("textcomp","", nil)
	;; ("" "rotating" nil)
	;;("" "capt-of" nil)
	;;("" "listings" nil)
	;; ("" "booktabs" nil) ;; book-quality tables
	;; ("" "multicol" nil)
	;; ("" "longtable" nil)
	;; ("" "zlmtt" nil) ;; Modern typewriter (i.e., bf,it)
	;; ("" "float" nil)
	;; ("" "fancyvrb" nil)
	;; ("" "verbatim" nil)
	;; ("english" "babel" nil)
	;; ("" "hyperref" nil)
	))
;;(add-to-list 'org-latex-packages-alist '("" "listings"))


;; Newer
(setq org-latex-listings-options ;;nil)
       '(
;; 	;;("basicstyle" "\\scriptsize")
;; 	("basicstyle" "\\ttfamily\\small")
;; 	;;("keywordstyle" "\\color{blue}")
;; 	("keywordstyle" "\\color{black}")
;; 	("commentstyle" "\\color{gray}\\ttfamily\\itshape")
;; 	("stringstyle" "\\color[rgb]{0,0,0.5}")
;; 	("columns" "fullflexible")
;; 	("alsoletter" ".")
;; 	;;("mathescape" "true")
;; 	("texcl" "true")
;; 	;;("escapechar" "`"),
;; 	("escapeinside" "{*@}{@*)}")
;; 	("escapebegin" "\\lst@commentstyle\\,")
;; 	;;("escapebegin" "\\lst@commentstyle \\,")
;; 	;;("escapebegin" "\\color{gray}\\(")
;; 	;;("escapeend" "\\)")
;; 	("breaklines" "true")         ;; sets automatic line breaking
;; 	("breakatwhitespace" "false") ;; sets if automatic breaks should only happen at whitespace
 	("numbers" "left")
 	("numberstyle" "\\ttfamily\\tiny\\color{gray}")
;; 	("stepnumber" "1")
;; 	("numbersep" "10pt")
;; 	("backgroundcolor" "\\color{white}")
;; 	("tabsize" "4")
;; 	("showspaces" "false")
;; 	("showstringspaces" "false")
;; 	("xleftmargin" ".23in")
;; 	;; frame=single,
;; 	;;("frame" "shadowbox")
;; 	;;      ("rulesepcolor" "\\color[rgb]{0.9,0.9,0.9}")
;; 	("rulesepcolor" "\\color[rgb]{0.85,0.85,0.85}")
;; 	("basewidth" "{0.5em,0.42em}")))
	;; ;;      ("morekeywords" "{regression,intercept,covariance,lava,latent,lvm,estimate,gof,compare}"))
	))
;; (setq org-latex-listings nil)

;; Overwrite this with minted (above kept for historic reasons)
(setq org-latex-listings 'minted)
;;(setq org-latex-listings t)
;; (setq org-latex-custom-lang-environments
;;       '(
;; 	(emacs-lisp "common-lispcode")
;; 	))
(setq org-latex-minted-options
      '(
     ;;("frame" "lines,framerule=1pt,framesep=4pt")
     ;; ("frame" "single,framerule=0.5pt,framesep=2pt")
     ;;("frame" "shadowbox")
     ;; ("breaklines" "true")
     ;; ("mathescape" "true")
     ;; ("fontsize" "\\scriptsize")
	;; ("linenos" "")
	))

;; (add-to-list 'org-latex-minted-langs '(sas "javascript"))
;; (add-to-list 'org-latex-minted-langs '(stata "javascript"))
;; (add-to-list 'org-latex-minted-langs '(emacs-lisp "lisp"))

(setq org-latex-minted-langs '((sas "javascript")
			       (stata "javascript")
			       (emacs-lisp "common-lisp")
			       (cc "c++")
			       (cperl "perl")
			       (shell-script "bash")
			       (caml "ocaml")))

;;(add-to-list 'org-latex-packages-alist '("usenames,table" "xcolor"))

(defun my/org-export-to-latex ()
  (interactive)
  (save-buffer)
  (if (string= major-mode 'org-mode)
      (if (bound-and-true-p org-beamer-mode)
	  (org-beamer-export-to-latex)
        (ignore-errors
	  (org-latex-export-to-latex))
	)))



;; Taken and adapted from org-colored-text
(let ((inhibit-message t))
(org-add-link-type
 "color"
 (lambda (path)
   "No follow action.")
 (lambda (color description backend)
   (cond
    ((eq backend 'latex)                  ; added by TL
     (format "{\\color{%s}%s}" color description)) ; added by TL
    ((eq backend 'html)
     (let ((rgb (assoc color color-name-rgb-alist))
	     r g b)
       (if rgb
	   (progn
	     (setq r (* 255 (/ (nth 1 rgb) 65535.0))
		   g (* 255 (/ (nth 2 rgb) 65535.0))
		   b (* 255 (/ (nth 3 rgb) 65535.0)))
	     (format "<span style=\"color: rgb(%s,%s,%s)\">%s</span>"
                     (truncate r) (truncate g) (truncate b)
                     (or description color)))
	 (format "No Color RGB for %s" color))))))))

(provide 'my-org-latex)

;; Local Variables:
;;   mode: emacs-lisp
;;   outline-regexp: "^;;;_\([,. ]+\)"
;; End:

;;; my-org-latex.el ends here
