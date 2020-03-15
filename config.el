;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;;(setq doom-font (font-spec :family "monospace" :size 14))
(setq doom-font (font-spec :family "monaco" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(use-package! conda
    :config
    (setq conda-anaconda-home "/Users/paozi/anaconda")
    (setq conda-env-home-directory "/Users/paozi/anaconda")
    (conda-env-initialize-interactive-shells)
    (conda-env-initialize-eshell)
    (conda-env-autoactivate-mode t))

(use-package! flycheck
  :config
  (setq flycheck-python-pylint-executable "flake8")
  )

(use-package! lsp-pyls
  :config
  (setq lsp-pyls-plugins-jedi-environment "/Users/paozi/anaconda/envs/new2.7")   ;; set execute path (install python-language-server env)
  (setq lsp-pyls-plugins-pylint-enabled nil)
  (setq lsp-pyls-plugins-flake8-enabled t)
  (setq lsp-pyls-configuration-sources ["flake8"])
  (setq lsp-pyls-plugins-yapf-enabled t)
  (setq lsp-pyls-plugins-autopep8-enabled nil)
  (setq lsp-pyls-plugins-pycodestyle-max-line-length 130)
  (setq lsp-pyls-plugins-flake8-max-line-length 120)
  ;;  "F841" assigned but not use variable
  ;;  "F401" assigned but not use import
  (setq lsp-pyls-plugins-flake8-ignore '("E402" "E302" "E305" "W293" "E501" "E128" "W292" "E303" "W29"))
  )

(define-coding-system-alias 'UTF-8 'utf-8)

(use-package! go-mode
  :config
  ;;配置format & import on save
  ;;The goimports approach
  ;;(setq gofmt-command "goimports")
  ;;(add-hook 'before-save-hook 'gofmt-before-save)
  ;; or
  ;; The lsp approach:   use lsp import; use `gofmt -s` format 
  (setq gofmt-args (list "-s"))
  (add-hook 'before-save-hook
            (lambda ()
              ;;(lsp-format-buffer)
              (gofmt-before-save)
              (lsp-organize-imports)))
  )

;;(use-package! git-gutter
  ;;:config
  ;;(custom-set-variables
    ;;;;'(git-gutter:modified-sign "  ") 
    ;;;;'(git-gutter:added-sign "++")
    ;;'(git-gutter:deleted-sign "⇲"))
  ;;(set-face-background 'git-gutter:deleted "#ff5555")
  ;;)

(map!
 :leader
 :desc "popup-hunc" "g p" #'git-gutter:popup-hunk
 )
