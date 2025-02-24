;; Variables
(defvar bgcolor "#0a0a0a"
  "The normal background of Emacs.")
(defvar slightdark-bgcolor "#1F1F1F"
  "The normal background of Emacs.")
(defvar grim-bgcolor "#1F1F1F"
  "The darker background of Emacs.")
(defvar highlight-bgcolor "#1e1e1e"
  "The darker background of Emacs.")
(defvar grim-fgcolor "#8A8A8A"
  "The calm foreground of Emacs.")
(defvar dim-bgcolor "#111111"
  "The darker background of Emacs.")
(defvar darker-bgcolor "#020202"
  "The darker background of Emacs.")
(defvar darkest-bgcolor "#000000"
  "The darker background of Emacs.")
(defvar dim-fgcolor "#4A4541"
  "The calm foreground of Emacs.")
(defvar calm-fgcolor "#e8e8e8"
  "The calm foreground of Emacs.")
(defvar mauve-color "#dca3c3"
  "The magenta color for Emacs.")
(defvar lavender-color "#d3d3ff"
  "The lavender color for Emacs.")
(defvar blue-color "#8cd0d3"
  "The blue color for Emacs.")
(defvar blue-alt-color "#8ca0c3"
  "The blue alt color for Emacs.")
(defvar teal-color "#6cc0a3"
  "The pink color for Emacs.")
(defvar pink-color "#dca3c3"
  "The pink color for Emacs.")
(defvar red-color "#dc9393"
  "The red color for Emacs.")
(defvar orange-color "#dca393"
  "The red color for Emacs.")
(defvar yellow-color "#D9BB80"
  "The red color for Emacs.")
(defvar green-color "#A7CF80"
  "The pink color for Emacs.")
(defvar cust-monospace "JetBrainsMono Nerd Font"
  "The monospace font for Emacs.")
(defvar cust-sans-serif "EB Garamond"
  "The sans-serif font for Emacs.")
(defvar cust-serif "EB Garamond"
  "The serif font for Emacs.")

;; Functions

(defun insert-current-date () (interactive)
       (insert (shell-command-to-string "echo -n $(date '+%B %e, %Y')")))

(defun sync-org-roam-notes ()
  "Sync files from ~/Documents/OrgRoamNotes to ~/Dropbox/OrgRoamNotes."
  (interactive)
  (let ((source-dir "~/Documents/OrgRoamNotes")
        (dest-dir "~/Dropbox/OrgRoamNotes"))
    (unless (file-directory-p source-dir)
      (error "Source directory does not exist: %s" source-dir))
    (unless (file-directory-p dest-dir)
      (make-directory dest-dir t))
    (copy-directory source-dir dest-dir t t t)
    (message "Files copied from %s to %s" source-dir dest-dir)))

;; Define a function to toggle the "eat" terminal
(defun my-toggle-eat-terminal ()
  "Toggle the 'eat' terminal buffer."
  (interactive)
  (if (get-buffer "*eat*")
      ;; If the buffer exists, toggle it with popper
      (popper-toggle-latest)
    ;; Otherwise, create a new eat terminal
    (eat)
    ))


(defun config-dired ()
  "Dired hook."
  (evil-collection-define-key 'normal 'dired-mode-map
    "l" 'dired-find-alternate-file
    "h" 'dired-up-directory
    "c" 'dired-create-empty-file
    "Q" 'kill-buffer-and-window
    )
  (face-remap-add-relative 'default '(:family "Segoe UI Variable")))

(add-hook 'dired-mode-hook 'config-dired)
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(defun delete-window-or-frame (&optional window frame force)
  "Delete WINDOW or FRAME if it's the only window in FRAME."
  (interactive)
  (if (= 1 (length (window-list frame)))
      (delete-frame frame force)
    (delete-window window)))

(defun clear ()
  "Redraw display, force normal state, and quit iedit if active."
  (interactive)
  (iedit--quit)
  (redraw-display)
  (evil-force-normal-state))

(defun configure-evil-ins ()
  "Enable evil-escape-mode in insert state."
  (evil-escape-mode 1))
(add-hook 'evil-insert-state-entry-hook #'configure-evil-ins)
(add-hook 'minibuffer-setup-hook #'configure-evil-ins)

(defun configure-evil-exit-ins ()
  "Disable evil-escape-mode in visual state and org-agenda-mode."
  (evil-escape-mode -1))
(add-hook 'evil-visual-state-entry-hook #'configure-evil-exit-ins)
(add-hook 'org-agenda-mode-hook #'configure-evil-exit-ins)

(defcustom my-skippable-buffer-regexp
  (rx bos "*" (one-or-more not-newline) "*" eos)
  "Regex for buffers ignored by `my-next-buffer' and `my-previous-buffer'."
  :type 'regexp)

(defun my-change-buffer (change-buffer)
  "Change buffer with CHANGE-BUFFER until `my-skippable-buffer-regexp` doesn't match."
  (let ((initial (current-buffer)))
    (funcall change-buffer)
    (let ((first-change (current-buffer)))
      (catch 'loop
        (while (string-match-p my-skippable-buffer-regexp (buffer-name))
          (funcall change-buffer)
          (when (eq (current-buffer) first-change)
            (switch-to-buffer initial)
            (throw 'loop t)))))))

(defun my-next-buffer ()
  "Variant of `next-buffer` that skips `my-skippable-buffer-regexp`."
  (interactive)
  (my-change-buffer 'next-buffer))

(defun my-previous-buffer ()
  "Variant of `previous-buffer` that skips `my-skippable-buffer-regexp`."
  (interactive)
  (my-change-buffer 'previous-buffer))

(defun read-from-file (file)
  "Return content of FILE as Lisp object."
  (with-temp-buffer
    (insert-file-contents file)
    (read (current-buffer))))

(defun open-in-terminal ()
  "Open current buffer in a terminal emulator."
  (interactive)
  (call-process-shell-command "kitty --class=emacsterminal" nil 0))

(defun open-current-file-in-vim ()
  "Open current file in NeoVim using a terminal emulator."
  (interactive)
  (async-shell-command
   (format "kitty nvim +%d %s"
           (+ (if (bolp) 1 0) (count-lines 1 (point)))
           (shell-quote-argument buffer-file-name))))

(defun rename-current-buffer-file ()
  "Rename current buffer and its visiting file."
  (interactive)
  (let* ((name (buffer-name))
         (filename (buffer-file-name)))
    (unless (and filename (file-exists-p filename))
      (error "Buffer '%s' is not visiting a file!" name))
    (let* ((dir (file-name-directory filename))
           (new-name (read-file-name "New name: " dir)))
      (when (get-buffer new-name)
        (error "A buffer named '%s' already exists!" new-name))
      (let ((dir (file-name-directory new-name)))
        (when (and (not (file-exists-p dir))
                   (yes-or-no-p (format "Create directory '%s'?" dir)))
          (make-directory dir t)))
      (rename-file filename new-name 1)
      (rename-buffer new-name)
      (set-visited-file-name new-name)
      (set-buffer-modified-p nil)
      (when (fboundp 'recentf-add-file)
        (recentf-add-file new-name)
        (recentf-remove-if-non-kept filename))
      (message "File '%s' successfully renamed to '%s'"
               name (file-name-nondirectory new-name)))))

(defun hm/convert-org-to-docx-with-pandoc ()
  "Convert current org-mode buffer to docx using Pandoc."
  (interactive)
  (message "Exporting .org to .docx")
  (shell-command
   (concat "pandoc -N --from org " (buffer-file-name)
           " -o "
           (file-name-sans-extension (buffer-file-name))
           (format-time-string "-%Y-%m-%d-%H%M%S") ".docx")))

(defun er-open-asm (arg)
  "Open current buffer file in default external program.
With prefix ARG always prompt for command to use."
  (interactive "P")
  (when buffer-file-name
    (shell-command (concat
                    (cond
                     ((and (not arg) (eq system-type 'darwin)) "open")
                     ((and (not arg) (member system-type '(gnu gnu/linux gnu/kfreebsd))) "xdg-open")
                     (t (read-shell-command "Open current file with: ")))
                    " "
                    (shell-quote-argument buffer-file-name)))))

(defun compile-latex-doc ()
  "Compile LaTeX document using pdflatex."
  (interactive)
  (call-process-shell-command
   (format "pdflatex -shell-escape %s"
           (shell-quote-argument buffer-file-name))))

(defun view-latex-doc ()
  "Compile LaTeX document using pdflatex and open the resulting PDF."
  (interactive)
  (let* ((file-name (file-name-sans-extension buffer-file-name))
         (pdf-file (concat file-name ".pdf")))
    (async-shell-command
     (format "evince %s"
             (shell-quote-argument pdf-file)))))

(defun google-this ()
  "Google the selected region or prompt for a query."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
                           (buffer-substring (region-beginning) (region-end))
                         (read-string "Google: "))))))

(defun org-schedule-tomorrow ()
  "Schedule task for tomorrow (+1d) in org-mode."
  (interactive)
  (org-schedule t "+1d"))

(defun org-copy-blocks ()
  "Copy source code blocks from org-mode buffer."
  (interactive)
  (let ((code ""))
    (save-restriction
      (org-narrow-to-subtree)
      (org-babel-map-src-blocks nil
	(setq code (concat code (org-no-properties body)))))
    (kill-new code)))

(defun org-icons ()
  (interactive)
  (setq prettify-symbols-alist
	(mapcan (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
		'(("#+title:" . " ")
		  ("#+author:" . "")
		  ("#+filetags:" . "")
		  ("#+date:" . "")
		  ("#+header:" . " ")
		  ("#+end_src:" . " ")
		  ("#+name:" . ?﮸)
		  ("#+results:" . ?)
		  ("#+call:" . ?)
		  (":properties:" . "")
		  (":logbook:" . ?)
		  ("TODO" . "☐")
		  ("MODO" . "")
		  ("ASSIGNMENT" . "")
		  ("DONE" . "☑")
		  ("#A" . "✽")
		  ("#B" . "✻")
		  ("#C" . "✣")
		  ("|" . "│")
		  ("[ ]" . "☐")
		  ("[X]" . "☑")
		  ("[-]" . "❍")
		  )))
  (prettify-symbols-mode 1))
(add-hook 'org-mode-hook #'org-icons)

(defun prettify-set ()
  (interactive)
  (setq prettify-symbols-alist
        '(("lambda" .  "λ")
          ("|>"	 . "▷")
          ("<|"	 . "◁")
          ("->>" . "↠")
          ("->"	 . "→")
          ("<-"	 . "←")
          ("=>"	 . "⇒")
          ("<="	 . "≤")
          (">="	 . "≥")
          ))
  (prettify-symbols-mode 1))
(add-hook 'prog-mode-hook 'prettify-set)

;; CUSTOM FACES

(defface minibuffer-face
  '((t :height 170))
  "Face for minibuffer."
  :group 'minibuffer )

(defface minibuffer-prompt
  '((t :height 170))
  "Face for minibuffer."
  :group 'minibuffer )

(defface vertico-current
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface vertico-multiline
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface company-tooltip
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface company-tooltip-selection
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface company-tooltip-common
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface company-tooltip-common-selection
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface company-preview-common
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface lsp-face-highlight-textual
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface lsp-face-highlight-read
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface lsp-face-highlight-write
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface lsp-headerline-breadcrumb-path-error-face
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface flymake-warning
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface flymake-error
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface flymake-note
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface company-preview
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-block
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-verbatim
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-block-end-line
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-block-begin-line
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-meta-line
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-drawer
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-todo
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-agenda-diary
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-level-1
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-level-2
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-level-3
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-level-4
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-level-5
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-level-6
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-level-7
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-level-8
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-level-9
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-ellipsis
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-document-title
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-table
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-done
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-agenda-date
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-agenda-date-today
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-scheduled
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-agenda-structure
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-agenda-done
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-document-info-keyword
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-document-info
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-special-keyword
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-property-value
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-modern-done
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-modern-tag
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-modern-todo
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-modern-time-active
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-modern-time-inactive
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface org-modern-priority
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface dired-header
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface sp-show-pair-enclosing
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface sp-pair-overlay-face
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface buffer-face-mode-face
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface evil-ex-info
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface evil-ex-substitute-matches
  '((t :inherit default))
  "Face used for the current candidate in Vertico.")

(defface evil-ex-substitute-replacement
  '((t :inherit default))
  "Evil-ex-substitute-replacement face.")

(defface org-modern-date-active
  '((t :inherit default))
  "Org-modern-date-active face.")

(defface org-modern-date-inactive
  '((t :inherit default))
  "Org-modern-date-inactive face.")

(defface org-upcoming-distant-deadline
  '((t :inherit default))
  "Org-upcoming-distant-deadline face.")

(defface corfu-default
  '((t :inherit default))
  "Corfu default face.")

(defface corfu-bar
  '((t :inherit default))
  "Corfu Scrollbar face.")

(defface corfu-current
  '((t :inherit default))
  "Corfu default select face.")

(defface eldoc-box-body
  '((t :inherit default))
  "Corfu default select face.")

(defface eldoc-box-border
  '((t :inherit default))
  "Corfu default select face.")

(defface mono-complete-preview-face
  '((t :inherit default))
  "Corfu default select face.")

(defface org-modern-priority
  '((t :inherit default))
  "Corfu default select face.")
