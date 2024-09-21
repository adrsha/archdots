
;; EMACS UIs
(setq-default
 mode-line-format nil
 frame-title-format nil
 widget-image-enable nil
 resize-mini-windows t
 cursor-in-non-selected-windows nil
 line-spacing 0.1
 font-lock-maximum-size nil
 truncate-lines t
 recentf-save-file "~/.config/emacs/recentf"
 evil-escape-excluded-major-modes '(eat-mode)
 echo-keystrokes 0.025
 evil-echo-state nil
 enable-recursive-minibuffers t
 read-extended-command-predicate #'command-completion-default-include-p
 org-hide-emphasis-markers t
 warning-minimum-level :emergency)

;; General settings
(setq
 org-emphasis-alist
 (quote
  (("*" bold)
   ("/" italic)
   ("_" underline)
   ("=" org-verbatim verbatim)
   ("~" org-code verbatim)
   ("+"
    (:strike-through t))
   ))
 eldoc-mode 'nil
 org-modern-star 'replace
 org-modern-replace-stars "    ✳"
 org-modern-list '((42 . "◦") (43 . "•") (45 . "–"))
 org-modern-block-name t
 org-modern-keyword nil
 org-modern-todo nil
 org-modern-tag nil
 org-modern-table nil
 org-agenda-start-with-log-mode nil
 org-log-done 'nil
 org-agenda-span 10
 org-agenda-start-on-weekday nil
 org-log-into-drawer t
 org-startup-folded 'nofold
 which-key-idle-delay 0.3
 which-key-max-description-length 27
 which-key-add-column-padding 3
 which-key-max-display-columns nil
 which-key-separator "  " 
 which-key-prefix-prefix " " 
 which-key-special-keys nil
 which-key-show-prefix 'nil
 which-key-show-remaining-keys nil
 which-key-frame-max-height 10
 which-key-frame-max-width 150
 which-key-popup-type 'frame
 dired-use-ls-dired nil
 dired-kill-when-opening-new-dired-buffer 't
 ;; dired-listing-switches "--format=single-column"
 org-src-fontify-natively t
 org-confirm-babel-evaluate nil
 inhibit-startup-screen t
 org-confirm-babel-evaluate nil
 make-backup-files nil
 create-lockfiles nil
 read-process-output-max (* 1024 1024)
 org-edit-src-content-indentation 4 ;; Set src block automatic indent to 0 instead of 2.
 server-client-instructions nil
 initial-scratch-message nil
 inhibit-startup-echo-area-message t
 global-auto-revert-non-file-buffers t
 evil-want-keybinding nil
 inhibit-message nil
 auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
 auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t))
 user-emacs-directory (expand-file-name "~/.cache/emacs")
 byte-compile-warnings 'nil
 ad-redefinition-action 'accept
 delete-by-moving-to-trash t
 help-window-select t
 mouse-yank-at-point t
 scroll-conservatively most-positive-fixnum
 select-enable-clipboard t
 show-trailing-whitespace nil
 tab-width 2
 uniquify-buffer-name-style 'forward
 ring-bell-function 'ignore
 confirm-kill-processes nil
 sentence-end-double-space nil
 scroll-step 1
 scroll-conservatively 101
 indent-tabs-mode nil
 tab-always-indent 't
 org-ellipsis " ⋅"
 css-fontify-colors nil
 project-vc-extra-root-markers '("Cargo.toml")
 )

;; Conditional native compilation settings
(if (boundp 'comp-deferred-compilation)
    (setq-default comp-deferred-compilation nil)
  (setq-default native-comp-deferred-compilation nil))
(setq-default native-comp-async-report-warnings-errors nil)

;; Suppressed events
(defun my-command-error-function (data context caller)
  "Ignore buffer-read-only, beginning-of-buffer, and end-of-buffer signals."
  (unless (memq (car data) '(buffer-read-only beginning-of-buffer end-of-buffer))
    (command-error-default-function data context caller)))
(setq command-error-function #'my-command-error-function)
