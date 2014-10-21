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
 '(org-agenda-files (quote ("c:/XLZHANG/HOME/org/books.org" "c:/XLZHANG/HOME/org/notes.org" "c:/XLZHANG/HOME/org/papers.org" "c:/XLZHANG/HOME/org/refile.org" "c:/XLZHANG/HOME/org/task.org")))
 '(org-agenda-skip-deadline-prewarning-if-scheduled t)
 '(org-emphasis-alist (quote (("*" bold) ("/" italic) ("_" underline) ("=" org-verbatim verbatim) ("~" org-code verbatim) ("+" (:strike-through t)))))
 '(org-modules (quote (org-bbdb org-bibtex org-crypt org-gnus org-habit org-id org-info org-jsinfo org-habit org-inlinetask org-irc org-mew org-mhe org-protocol org-rmail org-vm org-wl org-w3m)))
 '(reftex-default-bibliography (quote ("~/zoterolibrary.bib"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
