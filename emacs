(add-to-list 'load-path "~/.emacs.d/lisp/")

;; It is very funny that I should load the tool-bar, just to immediately disable it
(load-library "tool-bar")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-start nil)
 '(ac-trigger-key "TAB")
 '(ansi-color-for-comint-mode t)
 '(auto-compression-mode t nil (jka-compr))
 '(auto-save-default nil)
 '(bs-alternative-configuration "files")
 '(bs-default-configuration "all-intern-last")
 '(c-basic-offset 4)
 '(c-offsets-alist (quote ((substatement-open . 0) (case-label . +))))
 '(column-number-mode t)
 '(custom-safe-themes (quote ("20f9c36dea110eb7c9ef197891fccaf54f9c6fa4c594df45c5d41f4f002f36fb" default)))
 '(delete-selection-mode t nil (delsel))
 '(desktop-enable t nil (desktop))
 '(desktop-path (quote ("." "~/.emacs.d/" "~")))
 '(ediff-split-window-function (quote split-window-horizontally))
 '(electric-indent-mode t)
 '(electric-pair-mode t)
 '(emacs-lisp-mode-hook (quote (turn-on-eldoc-mode)))
 '(fill-column 120)
 '(global-auto-complete-mode t)
 '(global-auto-revert-mode t)
 '(global-font-lock-mode t nil (font-lock))
 '(global-hl-line-mode t)
 '(global-semantic-idle-summary-mode t)
 '(global-subword-mode t)
 '(hi-lock-mode t t (hi-lock))
 '(ido-create-new-buffer (quote always))
 '(ido-decorations (quote (" { " " }" " | " " | ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
 '(ido-everywhere t)
 '(ido-save-directory-list-file "~/.emacs.d/ido.last")
 '(ielm-mode-hook (quote (turn-on-eldoc-mode)))
 '(indent-tabs-mode nil)
 '(initial-buffer-choice nil)
 '(initial-scratch-message nil)
 '(ispell-query-replace-choices t)
 '(ispell-silently-savep t)
 '(jit-lock-stealth-time 1)
 '(kill-ring-max 300)
 '(lisp-interaction-mode-hook (quote (turn-on-eldoc-mode)))
 '(locate-make-command-line (quote my-locate-command-line))
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(normal-erase-is-backspace nil)
 '(org-adapt-indentation nil)
 '(org-startup-truncated nil)
 '(scroll-bar-mode nil)
 '(semantic-idle-truncate-long-summaries nil)
 '(semantic-mode t)
 '(show-paren-mode t nil (paren))
 '(size-indication-mode t)
 '(sql-input-ring-file-name "~/.emacs.d/sql-history")
 '(sql-password "SYSADM")
 '(sql-user "SYSADM")
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(tooltip-mode t)
 '(tooltip-use-echo-area t)
 '(truncate-lines nil)
 '(truncate-partial-width-windows nil)
 '(uniquify-after-kill-buffer-p t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(vc-follow-symlinks t)
 '(which-function-mode t nil (which-func))
 '(woman-fill-frame t)
 '(xterm-mouse-mode t))

;; Font
(set-default-font "Source Code Pro-9")

;; Start the emacs server needed by the emacsclient
(server-start)

;; xterm mouse support
(require 'mouse)
(defun track-mouse (e))
(global-set-key [mouse-4]'(lambda ()
                             (interactive)
                             (scroll-down 1)))
(global-set-key [mouse-5] '(lambda ()
                             (interactive)
                             (scroll-up 1)))

;; Spell
(if (file-readable-p "/usr/bin/enchant")
    (setq ispell-program-name "/usr/bin/enchant")
  (if (file-readable-p "/usr/bin/hunspell")
      (setq ispell-program-name "/usr/bin/hunspell")
    (if (file-readable-p "/usr/bin/aspell")
        (setq ispell-program-name "/usr/bin/aspell"))))

;; auto modes
(add-to-list 'auto-mode-alist '("\\.pc\\'"   . c-mode))
(add-to-list 'auto-mode-alist '("\\.pcpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("make.*"     . makefile-mode))
(add-to-list 'auto-mode-alist '("Makefile.*" . makefile-mode))
(add-to-list 'auto-mode-alist '("make.out"   . compilation-mode))
(add-to-list 'auto-mode-alist '("emacs" . emacs-lisp-mode))

;; Hooks
(add-hook 'text-mode-hook 'ispell-minor-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; List variables
(eval-after-load "grep"
  '(progn
     ;; delete the default c/c++ aliases
     (assq-delete-all (car(assoc "ch" grep-files-aliases)) grep-files-aliases)
     (assq-delete-all (car(assoc "c" grep-files-aliases)) grep-files-aliases)
     (assq-delete-all (car(assoc "cc" grep-files-aliases)) grep-files-aliases)
     (assq-delete-all (car(assoc "cchh" grep-files-aliases)) grep-files-aliases)
     (assq-delete-all (car(assoc "hh" grep-files-aliases)) grep-files-aliases)
     (assq-delete-all (car(assoc "h" grep-files-aliases)) grep-files-aliases)
     ;; add my aliases
     (add-to-list 'grep-files-aliases '("h" . "*.h *.hpp"))
     (add-to-list 'grep-files-aliases '("c" . "*.c *.cpp *.pc *.pcpp"))
     (add-to-list 'grep-files-aliases '("ch" . "*.h *.hpp *.c *.cpp *.pc *.pcpp"))))

(eval-after-load "find-file"
  '(progn 
     (add-to-list 'cc-other-file-alist '("\\.pc\\'" (".h")))
     (add-to-list 'cc-other-file-alist '("\\.pcpp\\'" (".hpp" ".h")))))

;; packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; ladebug
(if (file-readable-p "~/.emacs.d/listp/ladebug.el")
    (load-library "ladebug"))

;; Modes
(define-generic-mode
  'note-history-mode  ;; name of the mode to create
  nil                 ;; comments
  nil                 ;; keywords
  '(("^=====.*" . 'font-lock-comment-face)
   )
  '("notehistory")    ;; files for which to activate this mode
  nil                ;; other functions to call
  "Note History mode" ;; doc string for this mode
  )

;; Functions

(defun bscs-update ()
  "Update BSCS related configurations."
  (interactive)
  (setq tags-table-list (list (concat (getenv "MAIN") "/src/TAGS.gz")))
  ;; The first part used to change between the header and implementation files
  ;; The second part (where the MAIN is used) is used to search for include files
  (setq cc-search-directories (list "." "include" "*" ".." "../*/*" "../../*/*" "/usr/include" "/usr/local/include/*" (concat (getenv "MAIN") "/src/*/include") (concat (getenv "MAIN") "/src/mp/*/include") (concat (getenv "MAIN") "/src/rp/*/srv/src/*/interface") (concat (getenv "MAIN") "/src/rp/crc/int/Public_Interfaces/includes")))
  (setq sql-database (getenv "BSCSDB")))

(bscs-update)

(defun my-locate-command-line (search-string)
  (list locate-command "-d" (concat(getenv "MAIN") "/locate.db") search-string))

(defun pn ()
  "print the PN number from the environment variable PNNUMBER"
  (interactive)
  (insert (getenv "PNNUMBER")))

(defun smart-newline-and-indent ()
    "Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode."
    (interactive)
    (move-end-of-line nil)
    (newline-and-indent))

(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-defun ()
  "Indent the current defun."
  (interactive)
  (save-excursion
    (mark-defun)
    (indent-region (region-beginning) (region-end))))

(defun smart-indent ()
  "Indent a region if selected, otherwise the sexp."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (indent-pp-sexp ())
        (message "Indented sexp.")))))

(defun duplicate-line (&optional n)
  "Duplicate the current line
With optinal arg n, duplicate n times"
  (interactive "*^P")
  (or n (setq n 1))
  (save-excursion
    (kill-ring-save (line-beginning-position) (line-beginning-position 2))
    (forward-line)
    (while (> n 0)
      (yank)
      (setq n (1- n)))))

;; Key binds
(global-set-key (kbd "ESC g g") 'goto-line) ;; default in emacs 22
(global-set-key (kbd "ESC g ESC g") 'goto-line) ;; default in emacs 22
(global-set-key (kbd "ESC o") 'ff-find-other-file)
(global-set-key (kbd "ESC /") 'hippie-expand) ;; default is dabbrev-expand
(global-set-key (kbd "C-c ESC /") 'complete-tag) ;; ALT ENTER
(global-set-key (kbd "ESC ?") 'tags-search)
(global-set-key (kbd "C-x C-b") 'bs-show) ;; default is list-buffers
(global-set-key (kbd "C-c C-r") 'revert-buffer)
(global-set-key (kbd "RET") 'newline-and-indent) ;; default is newline
(global-set-key (kbd "ESC RET") 'smart-newline-and-indent) ;; ALT ENTER
(global-set-key (kbd "C-M-\\") 'smart-indent) ;; default is indent-region
(global-set-key (kbd "C-M-q") 'smart-indent) ;; default is indent-pp-sexp
(global-set-key (kbd "C-c C-k") 'kill-whole-line)
(global-set-key (kbd "C-c k") 'kill-whole-line)
(global-set-key (kbd "C-c C-d") 'duplicate-line)
(global-set-key (kbd "C-c d") 'duplicate-line)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

(global-set-key (kbd "ESC [ d") 'backward-word) ;; ctrl left
(global-set-key (kbd "ESC [ c") 'forward-word) ;; ctrl right
(global-set-key (kbd "ESC <left>") 'backward-word) ;; alt left
(global-set-key (kbd "ESC <right>") 'forward-word) ;; alt right
(global-set-key (kbd "ESC ESC [ d") 'backward-sexp) ;; ctrl alt left
(global-set-key (kbd "ESC ESC [ c") 'forward-sexp) ;; ctrl alt right

(global-set-key (kbd "ESC [ A") 'backward-to-indentation) ;; ctrl up
(global-set-key (kbd "ESC [ B") 'forward-to-indentation) ;; ctrl down
(global-set-key (kbd "ESC <up>") 'backward-paragraph) ;; alt up
(global-set-key (kbd "ESC <down>") 'forward-paragraph) ;; alt down
(global-set-key (kbd "ESC ESC [ a") 'backward-sentence) ;; ctrl alt up
(global-set-key (kbd "ESC ESC [ b") 'forward-sentence) ;; ctrl alt down

(global-set-key (kbd "<insertchar>") 'overwrite-mode)
;;(global-set-key (kbd "ESC <insertchar>") ')
(global-set-key (kbd "ESC <deletechar>") 'kill-word)
(global-set-key (kbd "ESC <home>") 'beginning-of-buffer)
(global-set-key (kbd "ESC <end>") 'end-of-buffer)
(global-set-key (kbd "ESC <prior>") 'scroll-other-window-down)
(global-set-key (kbd "ESC <next>") 'scroll-other-window)

;; Num pad
(global-set-key (kbd "ESC O p") "0")
(global-set-key (kbd "ESC O q") "1")
(global-set-key (kbd "ESC O r") "2")
(global-set-key (kbd "ESC O s") "3")
(global-set-key (kbd "ESC O t") "4")
(global-set-key (kbd "ESC O u") "5")
(global-set-key (kbd "ESC O v") "6")
(global-set-key (kbd "ESC O w") "7")
(global-set-key (kbd "ESC O x") "8")
(global-set-key (kbd "ESC O y") "9")
(global-set-key (kbd "ESC O o") "/")
(global-set-key (kbd "ESC O j") "*")
(global-set-key (kbd "ESC O m") "-")
(global-set-key (kbd "ESC O k") "+")
(global-set-key (kbd "ESC O M") 'newline-and-indent)
(global-set-key (kbd "ESC O n") ",")

(if (>= emacs-major-version 24)
    (progn
      (package-initialize)
      (load-theme 'zenburn t)
      ;; Auto Complete
      (require 'auto-complete-config)
      (ac-config-default)
      (global-semantic-idle-local-symbol-highlight-mode)
      (ido-mode t)
      (yas-global-mode t)))

(if (<= emacs-major-version 23)
    (progn
      ;; 256 Colors hack to Emacs
      (load-library "emacs21-256color-hack")
      (require 'color-theme)
      (color-theme-initialize)
      ;;(color-theme-hober)
      (require 'zenburn)
      (color-theme-zenburn)
      (xterm-mouse-mode 1)
      (mouse-wheel-mode 1)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bold-italic ((t (:inherit (bold italic)))))
 '(italic ((t (:underline t :slant italic))))
 '(woman-italic ((t (:inherit italic)))))
