(fset 'yes-or-no-p 'y-or-n-p)
(fset #'jsonrpc--log-event #'ignore)
;; (setenv "LSP_USE_PLISTS" "true")

;; Run at full power please
(dolist (cmd '(downcase-region upcase-region narrow-to-region dired-find-alternate-file))
  (put cmd 'disabled nil))

;; Load side files
(dolist (file '("default-modes.el" "variables.el" "customs.el" "customizations.el" "elpaca.el" "treesitter.el" "org.el" "hooks.el"))
  (load-file (expand-file-name file "~/.config/emacs/")))

;; (set-frame-parameter nil 'alpha-background 70)
;; (add-to-list 'default-frame-alist '(alpha-background . 70))
;; Borders and fringes
(add-to-list 'default-frame-alist '(internal-border-width . 40 ))
(set-fringe-mode '(0 . 0))
(save-place-mode 1)
(savehist-mode 1)
(global-eldoc-mode 0)

;; Replace the truncation symbols for file buffers with truncation enabled. (Doesn’t work for org-mode)
(set-display-table-slot standard-display-table 0 ?\ )
;; Disable the line break symbols in fringes.
(setf (cdr (assq 'continuation fringe-indicator-alist)) '(nil nil))

;; Default Autosave dir
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)

;; Disable default Emacs keybindings
(defvar my-emacs-keymap (make-sparse-keymap)
  "My custom keymap to disable all default Emacs keybindings.")
;; Set my-emacs-keymap as the parent of global-map
(set-keymap-parent global-map my-emacs-keymap)


(use-package gcmh
  :ensure t
  :demand t
  :config
  (setq gcmh-high-cons-threshold 33554432)
  (gcmh-mode 1)
  )
(use-package evil
  :ensure t
  :demand t
  :init
  (setq evil-undo-system 'undo-fu
        evil-want-C-i-jump nil
        evil-want-C-u-scroll t
        evil-want-C-d-scroll t
        evil-want-fine-undo t
        evil-want-Y-yank-to-eol t
        evil-emacs-state-cursor    '("#cba6f7" box)
        evil-normal-state-cursor   '("#BAC2DE" box)
        evil-operator-state-cursor '("#90b6f3" (bar . 6))
        evil-visual-state-cursor   '("#6C7096" box)
        evil-insert-state-cursor   '("#b4befe" (bar . 2))
        evil-replace-state-cursor  '("#eb998b" hbar)
        evil-motion-state-cursor   '("#f38ba8" box))

  :config
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  (evil-define-key 'motion help-mode-map "q" 'kill-this-buffer)
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :demand t
  :after evil
  :config
  (evil-collection-init))

(use-package evil-commentary
  :ensure t
  :demand t
  :after evil)

(use-package evil-surround
  :ensure t
  :demand t
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-escape
  :ensure t
  :demand t
  :after evil
  :config
  (evil-escape-mode)
  :custom
  (evil-escape-key-sequence "jk")
  (evil-escape-delay 0.2))

(use-package evil-textobj-anyblock
  :ensure t
  :demand t
  :after evil
  :config
  (defun my-evil-textobj-anyblock-define (inner outer blocks)
    "Helper function to define text objects for inner and outer blocks."
    (evil-define-text-object inner
      (count &optional beg end type)
      "Select the closest inner block."
      (let ((evil-textobj-anyblock-blocks blocks))
        (evil-textobj-anyblock--make-textobj beg end type count nil)))
    (evil-define-text-object outer
      (count &optional beg end type)
      "Select the closest outer block."
      (let ((evil-textobj-anyblock-blocks blocks))
        (evil-textobj-anyblock--make-textobj beg end type count t))))

  ;; Define text objects for quotes
  (my-evil-textobj-anyblock-define
   'my-evil-textobj-anyblock-inner-quote
   'my-evil-textobj-anyblock-a-quote
   '(("'" . "'")
     ("\"" . "\"")
     ("`" . "`")
     ("“" . "”")))

  ;; Set key bindings for text objects
  (define-key evil-inner-text-objects-map "q" 'my-evil-textobj-anyblock-inner-quote)
  (define-key evil-outer-text-objects-map "q" 'my-evil-textobj-anyblock-a-quote)

  ;; Add hook for Lisp mode
  (add-hook 'lisp-mode-hook
            (lambda ()
              (setq-local evil-textobj-anyblock-blocks
                          '(("(" . ")")
                            ("{" . "}")
                            ("\\[" . "\\]")
                            ("\"" . "\"")))))

  ;; Define default block text objects for 'u'
  (define-key evil-inner-text-objects-map "u" 'evil-textobj-anyblock-inner-block)
  (define-key evil-outer-text-objects-map "u" 'evil-textobj-anyblock-a-block))


(use-package undo-fu
  :ensure t
  :demand t
  )
(use-package undo-fu-session
  :ensure t
  :demand t
  :config
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
  (undo-fu-session-global-mode))

(use-package helpful
  :ensure t
  :demand t
  :config
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable))

(use-package catppuccin-theme
  :ensure t
  :demand t
  :config
  ;; Customization
  (setq catppuccin-flavor 'mocha) ;; or 'latte, 'macchiato, or 'mocha
  (catppuccin-set-color 'rosewater "#dca3a3")
  (catppuccin-set-color 'flamingo "#cc9393")
  (catppuccin-set-color 'pink "#dca3a3")
  (catppuccin-set-color 'mauve "#dca3a3")
  (catppuccin-set-color 'red "#cc9393")
  (catppuccin-set-color 'maroon "#dca3a3")
  (catppuccin-set-color 'peach "#dfaf8f")
  (catppuccin-set-color 'yellow "#f0dfaf")
  (catppuccin-set-color 'green "#7f9f7f")
  (catppuccin-set-color 'teal "#6ca0a3")
  (catppuccin-set-color 'sky "#8cd0d3")
  (catppuccin-set-color 'sapphire "#8cd0d3")
  (catppuccin-set-color 'blue "#8cd0d3")
  (catppuccin-set-color 'lavender "#8cd0d3")
  (catppuccin-set-color 'text "#dcdccc")
  (catppuccin-set-color 'subtext1 "#9f9f9f")
  (catppuccin-set-color 'subtext0 "#8c8c8c")
  (catppuccin-set-color 'overlay2 "#5f5f5f")
  (catppuccin-set-color 'overlay1 "#4e4e4e")
  (catppuccin-set-color 'overlay0 "#3a3a3a")
  (catppuccin-set-color 'surface2 "#3f3f3f")
  (catppuccin-set-color 'surface1 "#3f3f3f")
  (catppuccin-set-color 'surface0 "#3f3f3f")
  (catppuccin-set-color 'mantle "#3f3f3f")
  (catppuccin-set-color 'crust "#2f2f2f")
  (catppuccin-set-color 'base "#0a0a0a")

  (load-theme 'catppuccin :no-confirm))


(use-package vertico
  :ensure t
  :demand t
  :config
  (vertico-mode 1)
  (vertico-reverse-mode)
  (setq vertico-cycle t
        vertico-resize t
        vertico-quick-exit t
        vertico-quick-exit-delay 0.0
        vertico-cycle t
        vertico-sort t
        vertico-scroll-margin 2
        vertico-count 10
        vertico-resize t
        vertico-scroll-fraction 0.2
        vertico-unsplittable-prefix t))

(use-package general
  :ensure (:wait t)
  :demand t
  :config
  (general-evil-setup)
  (general-create-definer minibuffer-local-map
    :states '(normal visual insert emacs)
    :keymaps 'override
    :prefix "SPC"
    :non-normal-prefix "M-SPC"
    :global-prefix "C-SPC"
    :prefix-map minibuffer-local-map
    :prefix-default nil
    :prefix-arg nil
    :non-normal-prefix-map minibuffer-local-map
    :non-normal-prefix-default nil
    :non-normal-prefix-arg nil
    :global-prefix-map minibuffer-local-map
    :global-prefix-default nil
    :global-prefix-arg nil))

(load-file "/home/chilly/.config/emacs/bindings.el")

(use-package rainbow-mode
  :ensure t
  :demand t
  :config
  (dolist (mode '(prog-mode org-mode markdown-mode text-mode))
    (add-hook (intern (concat (symbol-name mode) "-hook")) #'rainbow-mode))
  )
(use-package rainbow-delimiters
  :ensure t
  :demand t
  :hook (org-mode prog-mode text-mode))

(use-package orderless
  :ensure t
  :demand t
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-cycle-threshold 0
        completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :ensure t
  :demand t
  :init
  (setq register-preview-delay 0.5
	register-preview-function 'nil
	consult-narrow-key "<"
	xref-show-xrefs-function #'consult-xref
	xref-show-definitions-function #'consult-xref)
  :config
  (add-to-list 'consult-buffer-filter "\*.*\*")
  (consult-customize
   consult-theme consult-buffer :preview-key 'nil
   consult-recent-file :preview-key "C-h"
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file))

(use-package embark-consult
  :ensure t
  :demand t)

(use-package embark
  :ensure t
  :demand t)

(use-package markdown-mode ;;  Dependency of lsp
  :ensure t
  :demand t)

(use-package yasnippet ;; Dependency of lsp
  :ensure t
  :demand t
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t
  :demand t)

(use-package corfu
  :ensure t
  :demand t
  :config
  (global-corfu-mode 1))

(use-package smartparens
  :ensure t
  :demand t
  :config
  (sp-pair "$$" "$$")   ;; latex math mode. 
  (require 'smartparens-config)
  (add-hook 'text-mode-hook 'smartparens-mode)
  (add-hook 'prog-mode-hook 'smartparens-mode)
  (add-hook 'org-mode-hook 'smartparens-mode))


(use-package which-key
  :ensure t
  :demand t
  :config
  (which-key-mode))

(use-package org-appear
  :ensure t
  :demand t
  :config
  :hook (org-mode-hook . org-appear-mode))

(use-package all-the-icons
  :ensure t
  :demand t
  :config
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :ensure t
  :demand t
  :hook
  (dired-mode . all-the-icons-dired-mode))

(use-package org-modern
  :ensure t
  :demand t
  :config
  :hook (org-mode . org-modern-mode))

(use-package visual-fill-column
  :ensure t
  :demand t
  :config
  (defun org-mode-visual-fill ()
    (setq visual-fill-column-width 150
          visual-fill-column-center-text t)
    (visual-fill-column-mode 1))

  :hook (org-mode . org-mode-visual-fill))

(use-package org-roam
  :ensure t
  :demand t
  :custom
  (org-roam-db-autosync-mode)
  :config
  (org-roam-setup))

(use-package jsonrpc
  :ensure t
  :demand t)

;; required for roam ui
(use-package websocket
  :ensure t
  :demand t
  :after org-roam)

(use-package org-roam-ui
  :ensure t
  :demand t
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(use-package openwith
  :ensure t
  :demand t
  :config
  (require 'openwith)
  (openwith-mode t)
  (setq openwith-associations '(
				("\\.pdf\\'" "/home/chilly/Scripts/launch" (file))
				("\\.docx\\'" "/home/chilly/Scripts/launch" (file))
				("\\.pptx\\'" "/home/chilly/Scripts/launch" (file))
				)))
(use-package devdocs
  :ensure t
  :demand t)

(use-package posframe
  :ensure t
  :demand t)

(use-package beacon
  :ensure t
  :demand t
  :config
  (setq beacon-blink-delay 0.3) 
  (setq beacon-color "#F8CDBA")
  )

(use-package eldoc
  :ensure t
  :demand t
  :config
  (setq eldoc-idle-delay 0.1)
  (setq eldoc-echo-area-prefer-doc-buffer t)
  (setq eldoc-echo-area-use-multiline-p nil)
  :hook
  (prog-mode . eldoc-mode))

(use-package eldoc-box
  :ensure t
  :demand t
  :config)

(use-package eglot
  :ensure t
  :demand t
  :hook (prog-mode . eglot-ensure)
  :custom
  (eglot-autoshutdown t)
  (eglot-events-buffer-size 0)
  (eglot-extend-to-xref nil)
  (eglot-ignored-server-capabilities
   '(:documentRangeFormattingProvider
     :documentOnTypeFormattingProvider
     :colorProvider
     :foldingRangeProvider))
  (eglot-stay-out-of '(yasnippet))
  (eglot-server-programs '(
			   ((rust-ts-mode rust-mode) "rust-analyzer")
			   ((python-ts-mode python-mode) "pyright-langserver")
			   ((js-mode :language-id "javascript")
			    (js-ts-mode :language-id "javascript")
			    (tsx-ts-mode :language-id "typescriptreact")
			    (typescript-ts-mode :language-id "typescript")
			    (typescript-mode :language-id "typescript"))
			   "typescript-language-server" "--stdio")
			 ))

(use-package eglot-booster :ensure (:host github :repo "jdtsmith/eglot-booster")
  :after eglot
  :after jsonrpc
  :config (eglot-booster-mode))

(use-package js2-refactor
  :ensure t
  :demand t)

(use-package iedit
  :ensure t
  :demand t)

(use-package eat
  :ensure t
  :demand t)

(use-package org-download
  :ensure t
  :demand t)

(use-package toggle-term
  :ensure t
  :demand t)

(use-package apheleia
  :ensure t
  :demand t
  :config
  (apheleia-global-mode +1))

;; External plugins
;; Overriding Functions!!
(setq eldoc-box-frame-parameters '((left . -1)
				   (top . -1)
				   (width . 0)
				   (height . 0)
				   (no-accept-focus . t)
				   (no-focus-on-map . t)
				   (min-width . 0)
				   (min-height . 0)
				   (child-frame-border-width . 20)
				   (vertical-scroll-bars)
				   (alpha-background . 100)
				   (horizontal-scroll-bars)
				   (right-fringe . 3)
				   (left-fringe . 3)
				   (menu-bar-lines . 0)
				   (tool-bar-lines . 0)
				   (line-spacing . 0)
				   (unsplittable . t)
				   (undecorated . t)
				   (visibility)
				   (mouse-wheel-frame)
				   (no-other-frame . t)
				   (cursor-type)
				   (inhibit-double-buffering . t)
				   (drag-internal-border . t)
				   (no-special-glyphs . t)
				   (desktop-dont-save . t)
				   (tab-bar-lines . 0)
				   (tab-bar-lines-keep-state . 1)))

(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ;; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
            (setcar orig-result command-from-exec-path))
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)
