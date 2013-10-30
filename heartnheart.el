
(add-to-list 'load-path "~/.emacs.d/other-els")

(setq heartnheart/is-win32 (eq system-type 'windows-nt))
(setq heartnheart/is-cygwin (eq system-type 'cygwin))
(setq heartnheart/is-linux (or (eq system-type 'gnu/linux) (eq system-type 'linux)))

(setq package-archives
      '(("gnu"         . "http://elpa.gnu.org/packages/")
        ("original"    . "http://tromey.com/elpa/")
        ("org"         . "http://orgmode.org/elpa/")
        ("marmalade"   . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;;------------------------------------------------------------------------------
;; On-demand installation of packages -- from binchen
;;------------------------------------------------------------------------------

(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(setq inhibit-splash-screen  t)

(add-to-list 'default-frame-alist '(font . "YtYaHei:pixelsize=20"))

(setq browse-url-generic-program (executable-find "firefox")
      browse-url-browser-function 'browse-url-generic)

(if heartnheart/is-win32
    (progn 
            (global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
            (global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease))
  (progn
    (global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
    (global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)))

;; change S-SPC to set mark
(global-set-key [?\S- ] 'set-mark-command)

;; set new method of kill a whole line 
(defadvice kill-ring-save (before slickcopy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(defadvice kill-region (before slickcut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(add-to-list 'default-frame-alist '(width . 80))
(add-to-list 'default-frame-alist '(height . 25))

(delete-selection-mode 1)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(setq-default buffer-file-coding-system 'utf-8)

;; use apsell as ispell backend
(setq-default ispell-program-name "aspell")
;; use American English as ispell default dictionary
(ispell-change-dictionary "american" t)
(eval-after-load "flyspell"
  '(define-key flyspell-mode-map (kbd "C-M-i") nil))

(require 'flymake-cursor)

(setq ispell-program-name
      (cond (heartnheart/is-win32 "D:/Software/cygwin/bin/aspell")
            (t "aspell")
            ))
(setq ispell-personal-dictionary "~/.ispell")
(require 'ispell)
(global-set-key (kbd "<f8>") 'ispell-word)

(require 'erc)

(defun my-gnus-group-list-subscribed-groups ()
  "List all subscribed groups with or without un-read messages"
  (interactive)
  (gnus-group-list-all-groups 5)
  )
 (add-hook 'gnus-group-mode-hook
           ;; list all the subscribed groups even they contain zero un-read messages
           (lambda () (local-set-key "o" 'my-gnus-group-list-subscribed-groups ))
           )

(require-package 'zenburn-theme)
(load-theme 'zenburn t)

(require-package 'autopair)
(require 'autopair)
(autopair-global-mode)

(require-package 'smex)
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'semx-major-mode-commands)
;; To use the old M-x
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(require-package 'switch-window)
(require 'switch-window)

(require-package 'ace-jump-mode)
(require 'ace-jump-mode)
(global-set-key (kbd "C-c j") 'ace-jump-mode)



(require-package 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(setq ac-auto-start nil)
(setq ac-delay 0.5)
(require 'ac-math)

(add-to-list 'ac-modes 'org-mode)   ; make auto-complete aware of `org-mode`


(defun ac-org-mode-setup ()         ; add ac-sources to default ac-sources
  (setq ac-sources
     (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands )
               ac-sources)))



(add-hook 'org-mode-hook 'ac-org-mode-setup)

;; (require 'auto-complete-clang-async)

;; (defun ac-cc-mode-setup ()
;;   (setq ac-clang-complete-executable "/usr/local/bin/clang-complete")
;;   (setq ac-sources '(ac-source-clang-async))
;;   (ac-clang-launch-completion-process)
;; )

;; (defun my-ac-config ()
;;   (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
;;   (add-hook 'auto-complete-mode-hook 'ac-common-setup)
;;   (global-auto-complete-mode t))

;; (my-ac-config)

(require-package 'yasnippet)
(yas-global-mode 1)

(require-package 'cmake-mode)
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

(require-package 'cpputils-cmake)
(add-hook 'c-mode-hook (lambda () (cppcm-reload-all)))
(add-hook 'c++-mode-hook (lambda () (cppcm-reload-all)))
(message "CHANGED C++ MODE hook here!")
;; OPTIONAL, somebody reported that they can use this package with Fortran
(add-hook 'c90-mode-hook (lambda () (cppcm-reload-all)))

;; ;; OPTIONAL, avoid typing full path when starting gdb
;; (global-set-key (kbd "C-c C-g")
;;  '(lambda ()(interactive) (gud-gdb (concat "gdb --annotate=3 --fullname " (cppcm-get-exe-path-current-buffer))))
;; )

(require-package 'wxwidgets-help)
(global-set-key (kbd "C-c w")
                '(lambda ()
                   (interactive)
                   (wxhelp-browse-class-or-api (thing-at-point 'symbol))))

(setq TeX-engine 'xetex)

(defun yodao-dict-search-wordap (&optional word)
  "Use python script dict to look up word under point"
  (interactive)
  (or word (setq word (current-word)))
  ;; for python 27
  (if heartnheart/is-win32
      (shell-command (format (concat "python " (expand-file-name "~/.emacs.d/extra-bin/dict.py") " %s") word))
    ))
(global-set-key [f5] 'yodao-dict-search-wordap)



(defun delete-this-file-to-trash ()
   "Delete (move to trash) the file that is associated with the
  current buffer."
    (interactive)
    (let ((filename (buffer-file-name)))
      (move-file-to-trash filename t)
      (kill-buffer)))

(require 'cc-mode)
(add-to-list 'c++-font-lock-extra-types
             "\\bwx[A-Z][a-z][a-zA-Z]*?\\b")
(defun c-wx-line-up-topmost-intro-cont (langelem)
  (save-excursion
    (beginning-of-line)
    (if (re-search-forward "EVT_" (line-end-position) t)
        'c-basic-offset
      (c-lineup-topmost-intro-cont langelem))))

(add-hook  'c++-mode-hook
           (lambda()
             (c-set-offset 'topmost-intro-cont 'c-wx-line-up-topmost-intro-cont)))

;; (defun ac-complete-semantic-self-insert (arg)
;;   (interactive "p")
;;   (self-insert-command arg)
;;   (ac-complete-semantic))
;; (defun ac-complete-clang-self-insert(arg)
;;   (interactive "p")
;;   (self-insert-command arg)
;;   (ac-complete-clang))
;; (add-hook 'c++-mode-hook
;;           '(lambda ()
;;              (c-set-style "K&R")
;;              (setq tab-width 4)
;;              (setq indent-tabs-mode t)
;;              (setq c-basic-offset 4)
;;              (c-toggle-hungry-state 1)
;;         ;             (flyspell-prog-mode)       ;may conflict with auto-complete-mode
;;              (local-set-key (kbd "RET") 'newline-and-indent)
;;         ;                  (semantic-mode 1)
;;              (local-set-key "." 'ac-complete-clang-self-insert)
;;              (local-set-key ">" 'ac-complete-clang-self-insert)
;;              (local-set-key (kbd "C-c o") 'ff-find-other-file)
;;              ))
;; (require 'auto-complete-clang)
;; (setq ac-quick-help-delay 0.5)
;; (define-key ac-mode-map (kbd "M-/") 'auto-complete)

(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;; ;;(setq ac-clang-executable "~/.emacs.d/extra-bin/clang/clang.exe")
(require-package 'auto-complete-clang)
(require 'auto-complete-clang)
;; ;; 添加c-mode和c++-mode的hook，开启auto-complete的clang扩展  
 (defun wttr/ac-cc-mode-setup ()  
   (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))  
(add-hook 'c-mode-hook 'wttr/ac-cc-mode-setup)  
(add-hook 'c++-mode-hook 'wttr/ac-cc-mode-setup)  


;(setq company-clang-arguments  (list
;; (setq ac-clang-flags   (list   
;;                        "-I/usr/lib/gcc/i686-pc-linux-gnu/4.8.1/../../../../include/c++/4.8.1"
;;                        "-I/usr/lib/gcc/i686-pc-linux-gnu/4.8.1/../../../../include/c++/4.8.1/i686-pc-linux-gnu"
;;                        "-I/usr/lib/gcc/i686-pc-linux-gnu/4.8.1/../../../../include/c++/4.8.1/backward"
;;                        "-I/usr/lib/gcc/i686-pc-linux-gnu/4.8.1/include"
;;                        "-I/usr/local/include"
;;                        "-I/usr/lib/gcc/i686-pc-linux-gnu/4.8.1/include-fixed"
;;                        "-I/usr/include"
;;                        "-I/usr/lib/wx/include/gtk2-unicode-2.9"
;;                        "-I/usr/include/wx-2.9"
;;                        "-D_FILE_OFFSET_BITS=64"
;;                        "-DWXUSINGDLL"
;;                        "-D__WXGTK__"
;;                       ))


(defadvice cppcm-reload-all (after append-stl-flags activate compile)
  (progn
    (setq command "echo | g++ -v -x c++ -E - 2>&1 |
                 grep -A 20 starts | grep include | grep -v search")
    (setq ac-clang-flags
          (append 
           (mapcar (lambda (item)
                     (concat "-I" item))
                   (split-string
                    (shell-command-to-string command)))
           ac-clang-flags)
          )
    ))

;; set org-mode as the default mode for .org, .org_archive, and .txt
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)\\'" . org-mode))
(require 'org)

;; common key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)


;; Set todo keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "SCHEDULED(s)" "Someday" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)"  "|" "CANCELLED(c@/!)"))))


;; cycle through the TODO states while skipping all the normal process
(setq org-treat-S-cursor-todo-selection-as-state-change nil)

;; ORG-CAPTURE
;; set the default file for org capture for templates that do not
;; specify a target
(setq org-default-notes-file "~/org/refile.org")

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "Todo" entry (file "~/org/refile.org")
               "* TODO %?\n%U\n%a\n")
              ("n" "note" entry (file "~/org/refile.org")
               "* %? :NOTE:\n%U\n%a\n")
              ("j" "Journal" entry (file+datetree "~/org/journal.org")
               "* %?\n%U\n" )
              ("p" "English plural words" table-line (file+headline "~/org/notes.org" "special plural words")
               "|%?| |%U|")
                             ("w" "English Words" table-line (file+headline "~/org/refile.org" "new words")
               "|%?| | | |%U|"               )

              ("e" "Exercise" table-line (file+headline "~/org/exercise.org" "Exercise")
               "|%?| |  |%U|")
              )))





(setq org-startup-indented t)           ;use org-indent-mode by default
(setq org-export-with-smart-quotes t)
;; use sumatraPDF to open PDF
(add-hook 'org-mode-hook
      '(lambda ()
         (local-unset-key "\C-c[")
         (local-unset-key "\C-c]")
         (delete '("\\.pdf\\'" . default) org-file-apps)
         (add-to-list 'org-file-apps
                      `("\\.pdf\\'" .
                        ,(cond (heartnheart/is-win32 "sumatraPDF -reuse-instance %s")
                              (t "FoxitReader %s")
                              )
                        )
                      )))



;; agenda
(setq org-agenda-files '("~/org/refile.org" 
                         "~/org/task.org"
                         "~/org/notes.org"
                         "~/research/notes/ResearchNotes.org"
                         ;; for current classes
                         "~/classes/PR/notes/PR.org"
                         "~/classes/grsc6001/notes/grsc6001.org"
                         "~/classes/grsc6008/notes/grsc6008.org"
                         ))

;; refile
(setq org-refile-use-outline-path 'file)
(setq org-refile-targets '((org-agenda-files . (:maxlevel .  4)))) ;ATTEDTION! must set after
                                        ;org-ageda-files has been set

(setq org-mobile-directory "~/org/MobileOrg")
(setq org-mobile-checksum-binary "D:/home/.emacs.d/extra-bin/sha1sum.exe")

(setq org-mobile-inbox-for-pull "~/org/refile.org")

(setq reftex-default-bibliography '("~/research/references/references.bib"))
(setq reftex-cite-format "\\citeA{%l}" )

(setq org-latex-pdf-process '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                              "bibtex %b"
                              "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                              "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

                                        ;(setq org-latex-pdf-process (list "latexmk -pdf -bibtex %f"))
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)
