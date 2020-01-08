;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives '(("Gnu" . "https://elpa.gnu.org/packages/")
                         ("Melpa"   . "https://melpa.org/packages/")))
(setq backup-directory-alist `(("." . "~/.saves/")))
(setq auto-save-file-name-transforms  `((".*" "~/.saves/" t)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages (quote (counsel swiper elpy)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  )
(global-set-key (kbd "C-d") 'duplicate-line)
(put 'downcase-region 'disabled nil)
(setq-default indent-tabs-mode nil)
(add-hook 'find-file-hook (lambda () (linum-mode 1))) ;; Enable line numbers globally
(add-hook 'find-file-hook (lambda () (column-number-mode 1))) ;; Show the column number of the cursor
(setq inhibit-startup-message t)    ;; Hide the startup message

;; ====================================
;; Development Setup
;; ====================================

(global-set-key (kbd "C-x 4") 'run-code-as-sh) ;; Run code in shell
;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24.5)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

(defun json-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "python -m json.tool" (buffer-name) t)
    )
  )

(defun shell-command-on-buffer (command)
  (interactive "sShell command on buffer: ")
  (shell-command-on-region (point-min) (point-max) command t)
  )

(defun run-code-as-sh()
  (interactive)
  (save-excursion
    (shell-command-on-region
     (point-min) (point-max)
     (read-shell-command "Shell command on buffer: " "bash"))
    )
  )
;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;; Enable Swiper/Ivy
(counsel-mode)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
