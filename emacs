
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
 '(custom-safe-themes (quote ("2f80d6ea18d147a6b4e5b54801317b7789531c691edecfa2ab0d2972bee6b36d" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "20f9c36dea110eb7c9ef197891fccaf54f9c6fa4c594df45c5d41f4f002f36fb" default)))
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
 '(global-undo-tree-mode t)
 '(grep-find-template "find -L . <X> -type f <F> -exec grep <C> -nH -e <R> {} +")
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
 '(show-paren-style (quote expression))
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
(set-default-font "Source Code Pro-11")

;; Start the emacs server needed by the emacsclient
(server-start)

;; xterm mouse support
(require 'mouse)
(defun track-mouse (e))
(global-set-key [mouse-4] '(lambda ()
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
(add-hook 'prog-mode-hook 'yas-minor-mode)
(add-hook 'text-mode-hook 'yas-minor-mode)

;; defadvice
(defadvice find-tag (after find-tag-and-reposition-window)
  "Reposition window after find a tag"
  (reposition-window))

(defadvice find-tag-other-window (after find-tag-and-reposition-window)
  "Reposition window after find a tag"
  (reposition-window))

(ad-activate 'find-tag)
(ad-activate 'find-tag-other-window)

;; yasnippet
(eval-after-load "yasnippet"
  '(yas-reload-all))

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
  ;; other functions to call
  ;;(read-only-mode 1)
  "Note History mode" ;; doc string for this mode
  )

;; Functions
(defun my-locate-command-line (search-string)
  (list locate-command "-d" (concat(getenv "MAIN") "/locate.db") search-string))

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

(defun duplicate-line-or-region (&optional n)
  "Duplicate the active region or current line
With optinal arg n, duplicate n times"
  (interactive "*p")
  (or n (setq n 1))
  (setq count n)
  (if (use-region-p)
      (setq buffer (buffer-substring (region-beginning) (region-end)))
    (setq buffer (buffer-substring (point-at-bol) (point-at-eol))))
  (end-of-line)
  (while (> count 0)
    (newline)
    (insert buffer)
    (setq count (1- count))))

;; Key binds
(global-set-key (kbd "M-g M-g") 'goto-line) ;; default in emacs 22
(global-set-key (kbd "M-g g") 'goto-line) ;; default in emacs 22
(global-set-key (kbd "ESC <prior>") 'scroll-other-window-down) ;; default in emacs 22
(global-set-key (kbd "ESC <next>") 'scroll-other-window) ;; default in emacs 22

(global-set-key (kbd "M-o") 'ff-find-other-file)
(global-set-key (kbd "M-/") 'hippie-expand) ;; default is dabbrev-expand
(global-set-key (kbd "M-?") 'tags-search)
(global-set-key (kbd "C-x C-b") 'bs-show) ;; default is list-buffers
(global-set-key (kbd "RET") 'newline-and-indent) ;; default is newline
(global-set-key (kbd "M-RET") 'smart-newline-and-indent) ;; ALT ENTER
(global-set-key (kbd "C-c C-k") 'kill-whole-line)
(global-set-key (kbd "C-c k") 'kill-whole-line)
(global-set-key (kbd "C-c C-d") 'duplicate-line-or-region)
(global-set-key (kbd "C-c d") 'duplicate-line-or-region)
(global-set-key (kbd "C-c C-r") 'revert-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

(global-set-key (kbd "ESC <up>") 'scroll-down-line)
(global-set-key (kbd "ESC <down>") 'scroll-up-line)
(global-set-key (kbd "<select>") 'move-end-of-line)
(global-set-key (kbd "ESC <select>") 'end-of-buffer-other-window)

(package-initialize)
(load-theme 'zenburn t)
;; Auto Complete
(require 'auto-complete-config)
(ac-config-default)
(global-semantic-idle-local-symbol-highlight-mode)
(require 'undo-tree)
(ido-mode t)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bold-italic ((t (:inherit (bold italic)))))
 '(italic ((t (:underline t :slant italic))))
 '(woman-italic ((t (:inherit italic))) t))
