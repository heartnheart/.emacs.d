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
 '(company-backends (quote (company-elisp company-semantic company-clang company-cmake (company-gtags company-etags company-dabbrev-code company-keywords) company-oddmuse company-files company-dabbrev)))
 '(ecb-options-version "2.40")
 '(org-agenda-files (quote ("~/org/refile.org" "~/org/task.org" "~/org/notes.org" "~/research/notes/ResearchNotes.org" "~/classes/PR/notes/PR.org" "~/classes/grsc6001/notes/grsc6001.org" "~/classes/grsc6008/notes/grsc6008.org")))
 '(org-drill-optimal-factor-matrix (quote ((1 (2.36 . 3.86) (2.6 . 4.14) (1.7000000000000002 . 3.44)))))
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mhe org-rmail org-w3m org-drill))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
