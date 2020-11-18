;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Qian Xiao"
      user-mail-address "dahuaciliu@gmail.com")

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
;;(setq doom-font (font-spec :family "Rec Mono Casual" :size 14))
;; (setq doom-font (font-spec :family "Recursive Mono Casual Static" :size 14))
(setq doom-font (font-spec :family "monaco" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-dracula)
;; (setq doom-theme 'nord)

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

;; ----------------------
;; python
;; ----------------------

;; to auto enable conda-env when open a project, need add below in .dir-locals.el
;;;; ((python-mode . ((lsp-python-ms-extra-paths . [ "/Users/paozi/Documents/taidi/taidiiv2/taidii" ])
;;                  (eval . (conda-env-activate "new2.7")))))
;; (setq lsp-pyright-extra-paths ["taidii"])

(use-package! conda
    :config
    (setq conda-anaconda-home "/Users/paozi/anaconda")
    (setq conda-env-home-directory "/Users/paozi/anaconda")
    (conda-env-initialize-interactive-shells)
    (conda-env-initialize-eshell)
    (conda-env-autoactivate-mode t))

(after! lsp
  (add-hook! 'lsp-ui-mode-hook
    (run-hooks (intern (format "%s-lsp-ui-hook" major-mode)))))

(defun gagbo-python-flycheck-setup ()
  "Setup Flycheck checkers for Python"
  (flycheck-add-next-checker 'lsp))

(add-hook 'python-mode-lsp-ui-hook
          #'gagbo-python-flycheck-setup)

;; For python
(add-hook 'python-mode-hook #'(lambda ()
                                (setq flycheck-checker-error-threshold 999)
                                (modify-syntax-entry ?_ "w")))

;; (use-package! lsp-python-ms
;;   :ensure t
;;   :config
;;   (setq! lsp-python-ms-python-executable-cmd "python")
;;   )

;; (setq lsp-enable-file-watchers nil)
(use-package! lsp-pyright
  :after lsp-mode
  :init
  (setq lsp-pyright-diagnostic-mode "openFilesOnly")
  :custom
  (lsp-pyright-typechecking-mode "off")
  :config
  )

;; (use-package! lsp-python-ms
;;   :demand t
;;   ;; :init
;;   ;; (setq! lsp-python-ms-extra-paths (list "./taidii"))
;;   :config
;;   (setq! lsp-python-ms-python-executable-cmd "python")
;;   )
;; (setq lsp-pyls-plugins-pycodestyle-enabled nil)

;; (use-package! lsp-pyls
;;   :config
;;   (setq lsp-pyls-plugins-jedi-environment "/Users/paozi/anaconda/envs/new2.7")   ;; set execute path (install python-language-server env)
;;   (setq lsp-pyls-plugins-pylint-enabled nil)
;;   (setq lsp-pyls-plugins-flake8-enabled t)
;;   (setq lsp-pyls-configuration-sources ["flake8"])
;;   (setq lsp-pyls-plugins-yapf-enabled t)
;;   (setq lsp-pyls-plugins-autopep8-enabled nil)
;;   (setq lsp-pyls-plugins-pycodestyle-max-line-length 130)
;;   (setq lsp-pyls-plugins-flake8-max-line-length 120)
;;   ;;  "F841" assigned but not use variable
;;   ;;  "F401" assigned but not use import
;;   (setq lsp-pyls-plugins-flake8-ignore '("E402" "E302" "E305" "W293" "E501" "E128" "W292" "E303" "W29"))
;;   (setq! flycheck-check-syntax-automatically nil)
;;   )

;; ----------------------
;; end python
;; ----------------------

;; (use-package! flycheck
;;   :config
;;   (setq flycheck-python-pylint-executable "flake8")
;;   )
(after! flycheck
  (setq flycheck-check-syntax-automatically '(save idle-change new-line mode-enabled)))

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
  ;; (setq lsp-gopls-server-path "~/go/bin/gopls")
  )

;; (use-package! git-gutter
;;   :config
;;   (custom-set-variables
;;     '(git-gutter:modified-sign "  ") 
;;     '(git-gutter:added-sign "++")
;;     '(git-gutter:deleted-sign "⇲"))
;;   (set-face-background 'git-gutter:deleted "#ff5555")
;;   )

;; -----------------
;; keymap        
;; -----------------
(map!
 :leader
 :desc "popup-hunc" "g p" #'git-gutter:popup-hunk
 ;; g c 也可以，比这个好用，但是要在 v 模式
 :desc "comment-line" "c /" #'comment-line
 )
(map! :n "g ]" #'dumb-jump-go)
(map! :n "g [" #'dumb-jump-back)
;; -----------------
;; end keymap
;; -----------------


;; For Javascript
;; (add-hook 'js2-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; More generally, this will do it for all major modes:
;; (add-hook 'after-change-major-mode-hook
          ;; (lambda ()
            ;; (modify-syntax-entry ?_ "w")))

(use-package! doom-modeline
  :config
  (setq! doom-modeline-major-mode-icon t)
  )

(setq! org-bullets-bullet-list '("✿" "✸" "◉" "○"))

;; org-mode table  中英文对齐
(with-eval-after-load 'org
  (set-face-attribute 'org-link              nil  :font "Sarasa Term SC 14")
  (set-face-attribute 'org-table             nil  :font "Sarasa Term SC 14" :fontset (create-fontset-from-fontset-spec (concat "-*-*-*-*-*--*-*-*-*-*-*-fontset-orgtable" ",han:Sarasa Term SC:size=14")))
  )

(setq! doom-dracula-colorful-headers t)
;; (setq! doom-dracula-brighter-comments t)

(use-package! web-mode
  )
(setq web-mode-engines-alist '(("django"    . "\\.html\\'")))

;; 开了这个巨卡无比
;; (add-hook! 'prog-mode-hook 'highlight-indent-guides-mode)
;; (use-package! highlight-indent-guides
;;   :config
;;   (setq! highlight-indent-guides-method 'bitmap)
;;   (setq! highlight-indent-guides-character ?\▏)
;;   (setq! highlight-indent-guides-responsive 'stack)
;;   (setq! highlight-indent-guides-delay 0)
;;   )

;; doom 可以自动懒加载 根据#+BEGIN_SRC 指定的语言
;; (org-babel-do-load-languages
;;   'org-babel-load-languages
;;   '((emacs-lisp . nil)
;;     (python . t)
;;     (javascript . t)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   (quote
    ((encoding . utf-8)
     (eval conda-env-activate "new2.7")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq! treemacs-follow-mode t)
