(load-file "~/.config/emacs/customs.el")
;; Set default font
(set-frame-font nil nil t)

(set-face-attribute 'default nil
                    :family cust-monospace
		    :weight 'bold
                    :height 130
		    :foreground calm-fgcolor
		    :background bgcolor
                    :width 'ultra-condensed)

(set-face-attribute 'fringe nil :background bgcolor :foreground darker-bgcolor :height 130 :inherit 'nil)
(set-face-attribute 'line-number nil :background bgcolor :foreground grim-fgcolor :height 110 :inherit 'nil)
(set-face-attribute 'fixed-pitch nil :family cust-monospace :height 150 :width 'ultra-condensed)
(set-face-attribute 'variable-pitch nil :family cust-sans-serif :height 140 :width 'normal :weight 'regular)
(set-face-attribute 'region nil :background dim-bgcolor)
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)
(set-face-attribute 'line-number nil :family cust-monospace :height 120)
(set-face-attribute 'link nil :background 'nil :weight 'regular :height 160 :overline 'nil :underline dim-fgcolor :family cust-sans-serif :foreground mauve-color)
(set-face-attribute 'show-paren-match nil :foreground dim-fgcolor :background 'unspecified :underline 'nil)
(set-face-attribute 'show-paren-match-expression nil :background grim-bgcolor :foreground 'unspecified :inherit 'nil)
(set-face-attribute 'help-key-binding nil :family cust-sans-serif :weight 'semibold :background darker-bgcolor :foreground dim-fgcolor :box 'nil)
(set-face-attribute 'header-line nil :background bgcolor :foreground dim-fgcolor)
(set-face-attribute 'window-divider nil :background bgcolor :foreground bgcolor)

(set-face-attribute 'vertico-current nil :foreground blue-color :weight 'semibold :background dim-bgcolor :family cust-monospace)
(set-face-attribute 'vertico-multiline nil :weight 'semibold :height 170 :family cust-monospace)
(set-face-attribute 'minibuffer-prompt nil :foreground mauve-color :weight 'semibold :background bgcolor :family cust-monospace)
(set-face-attribute 'minibuffer-face nil :height 170 :background dim-bgcolor)

(set-face-attribute 'company-tooltip nil :background dim-bgcolor :foreground lavender-color :weight 'semibold)
(set-face-attribute 'company-tooltip-selection nil :background lavender-color :foreground bgcolor :weight 'semibold)
(set-face-attribute 'company-tooltip-common-selection nil :foreground red-color :background 'nil :weight 'semibold)
(set-face-attribute 'company-preview-common nil :background bgcolor :foreground grim-fgcolor :weight 'semibold)

(set-face-attribute 'lsp-face-highlight-textual nil :foreground 'unspecified :background dim-fgcolor :inherit 'nil)
(set-face-attribute 'lsp-face-highlight-read nil :underline 'nil :foreground 'unspecified :background highlight-bgcolor :inherit 'nil)
(set-face-attribute 'lsp-face-highlight-write nil :underline 'nil :foreground 'unspecified :background highlight-bgcolor :inherit 'nil)

(set-face-attribute 'flymake-error nil :background "#42232c" :foreground red-color :underline 'nil :weight 'bold)
(set-face-attribute 'flymake-note nil :background "#262d25" :foreground green-color :underline 'nil :weight 'bold)
(set-face-attribute 'flymake-warning nil :background "#453e29" :foreground yellow-color :underline 'nil :weight 'bold)
(set-face-attribute 'lsp-headerline-breadcrumb-path-error-face nil :inherit 'flymake-error :underline 'nil :weight 'extra-bold)

(set-face-attribute 'company-preview nil :underline 'nil :foreground dim-fgcolor :background bgcolor)
(set-face-attribute 'mono-complete-preview-face nil :underline 'nil :foreground dim-fgcolor :background bgcolor)


(set-face-attribute 'org-block nil :background darkest-bgcolor :family cust-monospace :weight 'bold)
(set-face-attribute 'org-verbatim nil :background 'unspecified :foreground calm-fgcolor :inherit 'fixed-pitch)
(set-face-attribute 'org-block-end-line nil :background darkest-bgcolor :foreground slightdark-bgcolor :family cust-monospace :height 100 :weight 'light)
(set-face-attribute 'org-block-begin-line nil :background darkest-bgcolor :foreground slightdark-bgcolor :family cust-monospace :height 100 :weight 'light)
(set-face-attribute 'org-meta-line nil :slant 'normal :height 130 :foreground dim-fgcolor :family cust-monospace :weight 'bold :width 'ultra-condensed)
(set-face-attribute 'org-document-info nil :foreground dim-fgcolor :height 120 :family cust-sans-serif :weight 'normal)
(set-face-attribute 'org-document-info-keyword nil :foreground dim-fgcolor :height 150)
(set-face-attribute 'org-special-keyword nil :slant 'normal :height 90 :foreground dim-fgcolor :family cust-sans-serif)
(set-face-attribute 'org-property-value nil :slant 'normal :height 90 :foreground dim-fgcolor :family cust-sans-serif)
(set-face-attribute 'org-drawer nil :foreground dim-fgcolor)
(set-face-attribute 'org-todo nil :background bgcolor :foreground blue-color :weight 'bold :family cust-sans-serif)
(set-face-attribute 'org-done nil :background bgcolor :foreground dim-fgcolor :weight 'regular :family cust-sans-serif)
(set-face-attribute 'org-agenda-diary nil :foreground blue-color :weight 'bold :family cust-sans-serif)
(set-face-attribute 'org-upcoming-distant-deadline nil :foreground calm-fgcolor)


(set-face-attribute 'org-level-1 nil :height 235 :family cust-sans-serif :weight 'normal :foreground lavender-color)
(set-face-attribute 'org-level-2 nil :height 220 :family cust-sans-serif :weight 'normal :foreground blue-color)
(set-face-attribute 'org-level-3 nil :height 205 :family cust-sans-serif :weight 'normal :foreground blue-color)
(set-face-attribute 'org-level-4 nil :height 190 :family cust-sans-serif :weight 'normal :foreground blue-color)
(set-face-attribute 'org-level-5 nil :height 190 :family cust-sans-serif :weight 'normal :foreground blue-color)
(set-face-attribute 'org-level-6 nil :height 190 :family cust-sans-serif :weight 'normal :foreground blue-color)
(set-face-attribute 'org-level-7 nil :height 190 :family cust-sans-serif :weight 'normal :foreground blue-color)
(set-face-attribute 'org-level-8 nil :height 190 :family cust-sans-serif :weight 'normal :foreground blue-color)
(set-face-attribute 'org-table nil :background darker-bgcolor :inherit 'fixed-pitch)

(set-face-attribute 'org-document-title nil :height 360 :weight 'extra-bold :foreground blue-color :family cust-sans-serif :width 'ultra-condensed)
(set-face-attribute 'org-ellipsis nil :slant 'normal :foreground dim-fgcolor)

(set-face-attribute 'org-agenda-date nil :family cust-sans-serif :weight 'regular :height 200 :foreground lavender-color)
(set-face-attribute 'org-agenda-date-today nil :family cust-sans-serif :weight 'extra-bold :height 200 :foreground blue-color)
(set-face-attribute 'org-agenda-done nil :weight 'regular :strike-through 't :foreground dim-fgcolor)
(set-face-attribute 'org-agenda-structure nil :family cust-serif :weight 'regular :height 230 :foreground lavender-color)

(set-face-attribute 'org-modern-done nil :foreground dim-fgcolor :background bgcolor :weight 'bold :slant 'normal :height 130 :inherit 'nil)
(set-face-attribute 'org-modern-todo nil :background darker-bgcolor :foreground blue-color :weight 'bold :height 130 :inherit 'fixed-pitch)
(set-face-attribute 'org-modern-priority nil :background 'nil :foreground red-color :weight 'bold :height 210 :inherit 'fixed-pitch)
(set-face-attribute 'org-modern-tag nil :background dim-bgcolor :foreground dim-fgcolor :weight 'bold)
(set-face-attribute 'org-modern-time-inactive nil :foreground dim-fgcolor :background darker-bgcolor :height 130 :inherit 'nil)
(set-face-attribute 'org-modern-date-inactive nil :foreground dim-fgcolor :background darker-bgcolor :height 130 :inherit 'nil)
(set-face-attribute 'org-modern-date-active nil :foreground dim-fgcolor :background grim-bgcolor :height 130 :inherit 'nil)
(set-face-attribute 'org-modern-time-active nil :background dim-fgcolor :foreground darker-bgcolor :height 130 :inherit 'nil)
(set-face-attribute 'dired-header nil :height 250 :weight 'bold :family cust-serif)

(set-face-attribute 'sp-show-pair-enclosing nil :background darkest-bgcolor :foreground 'unspecified :inherit 'nil)
(set-face-attribute 'sp-pair-overlay-face nil :background dim-bgcolor :foreground 'unspecified :inherit 'nil)
(setq buffer-face-mode-face '(:family cust-sans-serif :height 140 :foreground "#424266" ))
(set-face-attribute 'evil-ex-info nil :foreground red-color :slant 'oblique :family cust-sans-serif)
(set-face-attribute 'evil-ex-substitute-matches nil :background blue-color :foreground dim-bgcolor :strike-through 't :underline 'nil )
(set-face-attribute 'evil-ex-substitute-replacement nil :background teal-color :foreground dim-bgcolor :underline 'nil )

(set-face-attribute 'corfu-default nil :background dim-bgcolor :foreground dim-fgcolor :underline 'nil )
(set-face-attribute 'corfu-bar nil :background nil)
(set-face-attribute 'corfu-current nil :background dim-fgcolor :foreground dim-bgcolor :underline 'nil )

(set-face-attribute 'eldoc-box-body nil :background darkest-bgcolor :foreground dim-fgcolor :underline 'nil )
(set-face-attribute 'eldoc-box-border nil :background darkest-bgcolor :foreground dim-fgcolor :underline 'nil )
