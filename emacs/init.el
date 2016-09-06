(setq gc-cons-threshold 400000000)

;;; Begin initialization
;; Turn off mouse interface early in startup to avoid momentary display
(when window-system
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

(setq inhibit-startup-message t)
(setq initial-scratch-message "")


;;; Set up package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)


;;; Bootstrap use-package
;; Install use-package if it's not already installed.
;; use-package is used to configure the rest of the packages.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; From use-package README
(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)
(setq use-package-verbose t)
;;(server-start)

(setq user-full-name "John Kane"
      user-mail-address "john@kanej.me")

;; Theme

;; Set theme

(use-package zenburn-theme
  :ensure t
  :init
  (load-theme 'zenburn t))

;;; Sane Defaults

(use-package better-defaults
  :ensure t
  :defer f)

(transient-mark-mode 1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-auto-revert-mode)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

;; Keep all backup and auto-save files in one directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-inhibited t)

;; Symbolic link nonsense
(setq create-lockfiles nil)

;; UTF-8 please
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top
(setq-default indent-tabs-mode nil)

;;; Tramp
;;(use-package tramp)

;;; ELPA

(use-package company
  :ensure t
  :diminish company-mode
  :config (global-company-mode))

(use-package helm
  :ensure t
  :diminish helm-mode
  :init (progn
          (require 'helm-config)
          (use-package helm-ls-git :ensure t)
          (use-package helm-projectile
            :ensure t
            :commands helm-projectile
            :bind ("C-c p h" . helm-projectile))
          ;;(use-package helm-ag :defer 10  :ensure t)
          (setq ;;helm-locate-command "mdfind -interpret -name %s %s"
                helm-ff-newfile-prompt-p nil
                helm-M-x-fuzzy-match t)
          (helm-mode)
          (use-package helm-swoop
            :ensure t
            :bind ("H-w" . helm-swoop)))
  :bind (("C-c h" . helm-command-prefix)
         ("C-x b" . helm-mini)
         ("C-`" . helm-resume)
         ("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  ;;:commands (projectile-mode projectile-switch-project)
  :bind ("C-c p p" . projectile-switch-project)
  :init
  (projectile-global-mode t)
  :config
  (setq projectile-enable-caching t)
  (setq projectile-switch-project-action 'projectile-dired))

(use-package magit
  :ensure t
  :defer t
  :bind ("C-c g" . magit-status)
  :config
  (define-key magit-status-mode-map (kbd "q") 'magit-quit-session))

(use-package flycheck
  :ensure t
  :defer 10
  :diminish flycheck-mode
  :init
  (global-flycheck-mode)
  :config
  (setq flycheck-html-tidy-executable "tidy")
  (flycheck-add-mode 'html-tidy 'web-mode))

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :config
  (yas-global-mode))

(use-package expand-region
  :disabled t
  :ensure t
  :bind ("C-@" . er/expand-region))

;;; Languages

;; Web
(use-package web-mode
  :defer t
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode)))

(use-package emmet-mode
  :defer t
  :ensure t
  :init
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode)
  (add-hook 'web-mode-hook  'emmet-mode))

(use-package js2-mode
  :defer t
  :ensure t
  :init
  (setq auto-mode-alist (rassq-delete-all 'js-mode auto-mode-alist))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  :config
  (setq js-indent-level 2)
  (setq-default js2-basic-offset 2))

(use-package mocha
  :defer t
  :ensure t
  :config
  (custom-set-variables '(mocha-command "node_modules/.bin/mocha"))
  (custom-set-variables '(mocha-options "--reporter dot"))
  :bind
  ("C-C t t" . mocha-test-project)
  ("C-C t r" . mocha-test-at-point)
  ("C-C t f" . mocha-test-file))

;; Clojure
(use-package clojure-mode
  :defer t
  :ensure t)

(use-package cider
  :defer t
  :ensure t)

(use-package paredit
  :defer t
  :ensure t
  :init
  (add-hook 'clojure-mode-hook #'enable-paredit-mode))

(use-package rainbow-delimiters
  :defer t
  :ensure t
  :init
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode))

;; Go
(use-package go-mode
  :defer t
  :ensure t)

;; Elm
(use-package elm-mode
  :defer t
  :ensure t)

;; Markdown
(use-package markdown-mode
  :defer t
  :ensure t)

;; YAML
(use-package yaml-mode
  :defer t
  :ensure t)

;; Terraform
(use-package terraform-mode
  :defer t
  :ensure t
  :config
  (custom-set-variables '(terraform-indent-level 4)))

;;; Key bindings
(global-set-key [f12] (lambda () (interactive) (find-file user-init-file)))
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

(global-set-key (kbd "C-X d") 'duplicate-line)
