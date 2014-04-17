(prefer-coding-system 'utf-8)
(setq hnh-emacs-start-time (current-time))

(package-initialize)			;initialize org mode here


(require 'ob-tangle)
;; load up the starter kit
(org-babel-load-file (expand-file-name "~/.emacs.d/heartnheart.org" ))



(message "Emacs startup time: %.2f seconds" (float-time (time-since hnh-emacs-start-time)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-math-abbrev-prefix "'")
 '(company-backends (quote (company-elisp company-semantic company-clang company-cmake (company-gtags company-etags company-dabbrev-code company-keywords) company-oddmuse company-files company-dabbrev)))
 '(ecb-options-version "2.40")
 '(org-drill-optimal-factor-matrix (quote ((1 (2.36 . 3.86) (2.6 . 4.14) (1.7000000000000002 . 3.44)))))
 '(org-emphasis-alist (quote (("*" bold) ("/" italic) ("_" underline) ("=" org-code verbatim) ("~" org-verbatim verbatim) ("+" (:strike-through t)))))
 '(org-enforce-todo-checkbox-dependencies t)
 '(org-export-backends (quote (ascii beamer html icalendar latex md freemind)))
 '(org-html-mathjax-options (quote ((path "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML") (scale "100") (align "center") (indent "2em") (mathml nil))))
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m org-checklist org-drill)))
 '(org-structure-template-alist (quote (("S" "#+BEGIN_SRC latex :results raw :export results
?
#+END_SRC" "") ("s" "#+BEGIN_SRC ?

#+END_SRC" "<src lang=\"?\">

</src>") ("e" "#+BEGIN_EXAMPLE
?
#+END_EXAMPLE" "<example>
?
</example>") ("q" "#+BEGIN_QUOTE
?
#+END_QUOTE" "<quote>
?
</quote>") ("v" "#+BEGIN_VERSE
?
#+END_VERSE" "<verse>
?
</verse>") ("V" "#+BEGIN_VERBATIM
?
#+END_VERBATIM" "<verbatim>
?
</verbatim>") ("c" "#+BEGIN_CENTER
?
#+END_CENTER" "<center>
?
</center>") ("l" "#+BEGIN_LaTeX
?
#+END_LaTeX" "<literal style=\"latex\">
?
</literal>") ("L" "#+LaTeX: " "<literal style=\"latex\">?</literal>") ("h" "#+BEGIN_HTML
?
#+END_HTML" "<literal style=\"html\">
?
</literal>") ("H" "#+HTML: " "<literal style=\"html\">?</literal>") ("a" "#+BEGIN_ASCII
?
#+END_ASCII" "") ("A" "#+ASCII: " "") ("i" "#+INDEX: ?" "#+INDEX: ?") ("I" "#+INCLUDE: %file ?" "<include file=%file markup=\"?\">")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button)))) t)
 '(preview-reference-face ((t nil))))
(put 'narrow-to-region 'disabled nil)
