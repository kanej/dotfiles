(require 'package)

(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(package-initialize)

(defvar my-packages '(better-defaults
                      projectile
                      clojure-mode
                      yaml-mode
                      cider
                      zenburn-theme
                      magit
                      company
                      paredit
                      rainbow-delimiters
                      expand-region
                      markdown-mode
                      emmet-mode
                      go-mode
                      js2-mode
                      ))

(dolist (p my-packages)
    (unless (package-installed-p p)
        (package-install p)))

;; Setup Projectile
(projectile-global-mode)

;; Setup autocompletion
(global-company-mode)

;; Setup rainbow parens in clojure mode
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)

;; Setup HTML
;;(add-hook 'sgml-mode-hook 'zencoding-mode)

;; Setup Javascript settings
(setq js-indent-level 2)
(setq-default js2-basic-offset 2)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; Setup Emmet
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.

(transient-mark-mode 1)

;; Set theme
(load-theme 'zenburn t)

;; General Editor Settings
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Key bindings
(global-set-key [f12] (lambda () (interactive) (find-file user-init-file)))
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-l") 'kill-whole-line)

(global-set-key (kbd "M-=") 'er/expand-region)
(global-set-key (kbd "C-C r") 'recompile)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline)
  (yank))

(global-set-key (kbd "C-d") 'duplicate-line)

(global-auto-revert-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
