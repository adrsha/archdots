;;; Code:
;;; Code for ob-rust needed for org babel
(require 'ob)
(require 'ob-eval)
(require 'ob-ref)


;; optionally define a file extension for this language
(defvar org-babel-tangle-lang-exts)
(add-to-list 'org-babel-tangle-lang-exts '("rust" . "rs"))

(defvar org-babel-default-header-args:rust '())

(defun org-babel-execute:rust (body params)
  "Execute a block of Template code with org-babel.
This function is called by `org-babel-execute-src-block'."
  (message "executing Rust source code block")
  (let* ((tmp-src-file (org-babel-temp-file "rust-src-" ".rs"))
         (processed-params (org-babel-process-params params))
         (_flags (alist-get :flags processed-params ""))
         (_args (alist-get :args processed-params ""))
         (coding-system-for-read 'utf-8) ;; use utf-8 with subprocesses
         (coding-system-for-write 'utf-8)
         (wrapped-body (if (string-match-p "fn main()" body) body (concat "fn main() {\n" body "\n}"))))
    (with-temp-file tmp-src-file (insert wrapped-body))
    (let ((results
     (org-babel-eval
      (format "rust-script %s -- %s %s" _flags tmp-src-file _args)
            "")))
      (when results
        (org-babel-reassemble-table
         (if (or (member "table" (cdr (assoc :result-params processed-params)))
           (member "vector" (cdr (assoc :result-params processed-params))))
       (let ((tmp-file (org-babel-temp-file "rust-")))
         (with-temp-file tmp-file (insert (org-babel-trim results)))
         (org-babel-import-elisp-from-file tmp-file))
     (org-babel-read (org-babel-trim results) t))
         (org-babel-pick-name
    (cdr (assoc :colname-names params)) (cdr (assoc :colnames params)))
         (org-babel-pick-name
    (cdr (assoc :rowname-names params)) (cdr (assoc :rownames params))))))))

;; This function should be used to assign any variables in params in
;; the context of the session environment.
(defun org-babel-prep-session:rust (_session _params)
  "This function does nothing as Rust is a compiled language with no
support for sessions."
  (error "Rust is a compiled languages -- no support for sessions"))
;;; ob-rust ends here

(require 'org-tempo)
(with-eval-after-load 'org


  ;; ORG MODE
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (js . t)
     (C . t)
     (python . t)))


  ;; ShortCuts
  (add-to-list 'org-structure-template-alist '("sh" . "src shell :results verbatim :session \n "))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp \n "))
  (add-to-list 'org-structure-template-alist '("py" . "src python :results output :session sPython\n"))
  (add-to-list 'org-structure-template-alist '("rs" . "src rust :results output :session sRust\n"))
  (add-to-list 'org-structure-template-alist '("cpp" . "src C++ :results verbatim \n\n  #include <iostream>\n  using namespace std;\n\n  int main(){\n    return 0;\n}"))
  (add-to-list 'org-structure-template-alist '("cl" . "src C :results verbatim \n\n  #include <iostream>\n  using namespace std;\n\n  int main(){\n    return 0;\n}"))
  (add-to-list 'org-structure-template-alist '("asm" . "src asm :results verbatim"))

  (setq org-capture-templates
	`(("t" "Task" entry (file "~/Documents/OrgRoamNotes/tasks.org")
           "* TODO %?\n  %i")
          ("h" "Homework" entry (file "~/Documents/OrgRoamNotes/tasks.org")
           "* HOMEWORK %?\n  %i")))
  (setq org-roam-directory (file-truename "~/Documents/OrgRoamNotes"))
  (setq org-roam-capture-templates
	'(("d" "default" plain
	   "%?"
	   :if-new (file+head "${slug}.org" "#+title: ${title}\n#+Author:Adarsha Acharya")
	   :unnarrowed t)
	  ;; ("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
	  ;; 	:if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project")
	  ;; 	:unnarrowed t)
	  ))

  (setq org-roam-ui-update-on-save t)
  (setq org-roam-ui-follow t)
  (setq org-roam-ui-custom-theme
	'((bg . "#1E1E2E")
	  (bg-alt . "#0E0E16")
	  (fg . "#CDD6F4")
	  (fg-alt . "#89B4FA")
	  (red . "#F38BA8")
	  (orange . "#F9E2AF")
	  (yellow ."#F9E2AF")
	  (green . "#A6E3A1")
	  (cyan . "#94E2D5")
	  (blue . "#F5C2E7")
	  (violet . "#7DA3E2")
	  (magenta . "#BAC2DE")))

  ;; (setq org-directory "~/Documents/OrgRoamNotes")
  (setq org-agenda-files '("~/Documents/OrgRoamNotes")) ; DO not add backslash at the end
  ;; (setq org-agenda-block-separator 32)                  ; Make it space
  (setq org-agenda-block-separator " ")                  ; Make it space
  (setq org-agenda-window-setup 'current-window)              
  (setq org-fancy-priorities-list '("" "󰉀" ""))
  (setq org-agenda-prefix-format "  %s")
  (setq org-agenda-current-time-string "ᐊ┈┈┈┈┈┈┈ Now")
  (setq org-agenda-todo-keyword-format "")
  (setq org-agenda-include-all-todo nil)
  (setq org-agenda-skip-scheduled-if-done nil)
  (setq org-agenda-skip-deadline-if-done t)
  (setq org-agenda-deadline-leaders '("Deadline:  " "In %2d days : " "%2d days ago: "))
  (setq org-agenda-include-diary t)
  (setq org-agenda-info t)
  (setq org-agenda-remove-tags t)
  (setq org-agenda-span 4)		; Number of days
  (setq org-agenda-columns-add-appointments-to-effort-sum t)
  (setq org-agenda-default-appointment-duration 60)
  (setq org-agenda-mouse-1-follows-link t)

  (setq org-deadline-warning-days 7)
  (setq org-agenda-skip-unavailable-files t)
  (setq org-agenda-use-time-grid t)
  (setq org-agenda-breadcrumbs-separator " ❱ ")
  (setq org-agenda-time-leading-zero t)
  (setq org-todo-keywords '
        ((sequence "TODO(t)" "ASSIGNMENT(A)"
                   "|"
                   "DONE(d/!)")))

  (setq org-agenda-todo-keyword-format "%-2s")
  (setq org-agenda-custom-commands
	'(("a" "A better agenda view"
	   ((agenda ""(
		       (org-agenda-timegrid-use-ampm nil)
		       (org-agenda-skip-timestamp-if-done t)
		       (org-agenda-skip-deadline-if-done t)
		       (org-agenda-start-day "-1d")
		       (org-agenda-overriding-header "📅 Calendar")
		       (org-agenda-repeating-timestamp-show-all nil)
		       (org-agenda-remove-tags t)
		       (org-agenda-time)
		       (org-agenda-current-time-string "ᐊ┈┈┈┈┈┈┈ Now")
		       ))

            (todo "TODO" (
                          (org-agenda-overriding-header "🍛 Today")
                          (org-agenda-sorting-strategy '(priority-down))
                          (org-agenda-remove-tags nil)
                          (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp 'scheduled))
                          (org-agenda-prefix-format "   ")
                          ))
	    (todo "ASSIGNMENT"
		  ((org-agenda-overriding-header "✏️ All ASSIGNMENTS")))
	    (todo "TODO"
		  ((org-agenda-overriding-header "🎯 All TODOS")
		   (org-agenda-time)
		   ))
	    )))
	)
  (setq org-agenda-sorting-strategy '((agenda habit-down time-up ts-up
					      priority-down category-keep)
                                      (todo priority-down category-keep)
                                      (tags priority-down category-keep)
                                      (search category-keep)))
  (defvar org-agenda--todo-keyword-regex
    (cl-reduce (lambda (cur acc)
		 (concat acc "\\|" cur))
	       (mapcar (lambda (entry) (concat "\\* " entry))
		       '("TODO" "ASSIGNMENT" "QUESTION" "DONE")))
    "Regex which filters all TODO keywords")
  )


;; How is a buffer opened when calling `org-edit-special'.
(setq org-src-window-setup 'current-window)
(defun e/org-babel-edit ()
  "Edit python src block with lsp support by tangling the block and
  then setting the org-edit-special buffer-file-name to the
  absolute path. Finally load the lsp."
  (interactive)

  ;; org-babel-get-src-block-info returns lang, code_src, and header
  ;; params; Use nth 2 to get the params and then retrieve the :tangle
  ;; to get the filename
  (setq mb/tangled-file-name (expand-file-name (assoc-default :tangle (nth 2 (org-babel-get-src-block-info)))))

  ;; tangle the src block at point
  (org-babel-tangle '(4))
  (org-edit-special)
  ;;(org-edit-src-code)

  ;; Now we should be in the special edit buffer with python-mode. Set
  ;; the buffer-file-name to the tangled file so that pylsp and
  ;; plugins can see an actual file.
  (setq-local buffer-file-name mb/tangled-file-name)
  (eglot-ensure)
  )
(eval-after-load 'org-agenda
  '(progn
     (evil-set-initial-state 'org-agenda-mode 'normal)
     (evil-define-key 'normal org-agenda-mode-map
       (kbd "<RET>") 'org-agenda-switch-to
       (kbd "\t") 'org-agenda-goto

       "q" 'org-agenda-quit
       "r" 'org-agenda-redo
       "S" 'org-save-all-org-buffers
       "gj" 'org-agenda-goto-date
       "gJ" 'org-agenda-clock-goto
       "gm" 'org-agenda-bulk-mark
       "go" 'org-agenda-open-link
       "s" 'org-agenda-schedule
       "+" 'org-agenda-priority-up
       "," 'org-agenda-priority
       "-" 'org-agenda-priority-down
       "y" 'org-agenda-todo-yesterday
       "n" 'org-agenda-add-note
       "t" 'org-agenda-todo
       ":" 'org-agenda-set-tags
       ";" 'org-timer-set-timer
       "I" 'helm-org-task-file-headings
       "i" 'org-agenda-clock-in-avy
       "O" 'org-agenda-clock-out-avy
       "u" 'org-agenda-bulk-unmark
       "x" 'org-agenda-exit
       "j"  'org-agenda-next-line
       "k"  'org-agenda-previous-line
       "vt" 'org-agenda-toggle-time-grid
       "va" 'org-agenda-archives-mode
       "vw" 'org-agenda-week-view
       "vl" 'org-agenda-log-mode
       "vd" 'org-agenda-day-view
       "vc" 'org-agenda-show-clocking-issues
       "g/" 'org-agenda-filter-by-tag
       "o" 'delete-other-windows
       "gh" 'org-agenda-holiday
       "gv" 'org-agenda-view-mode-dispatch
       "f" 'org-agenda-later
       "b" 'org-agenda-earlier
       "c" 'helm-org-capture-templates
       "e" 'org-agenda-set-effort
       "n" nil  ; evil-search-next
       "{" 'org-agenda-manipulate-query-add-re
       "}" 'org-agenda-manipulate-query-subtract-re
       "A" 'org-agenda-toggle-archive-tag
       "." 'org-agenda-goto-today
       "0" 'evil-digit-argument-or-evil-beginning-of-line
       "<" 'org-agenda-filter-by-category
       ">" 'org-agenda-date-prompt
       "F" 'org-agenda-follow-mode
       "D" 'org-agenda-deadline
       "H" 'org-agenda-holidays
       "J" 'org-agenda-next-date-line
       "K" 'org-agenda-previous-date-line
       "L" 'org-agenda-recenter
       "P" 'org-agenda-show-priority
       "R" 'org-agenda-clockreport-mode
       "Z" 'org-agenda-sunrise-sunset
       "T" 'org-agenda-show-tags
       "X" 'org-agenda-clock-cancel
       "[" 'org-agenda-manipulate-query-add
       "g\\" 'org-agenda-filter-by-tag-refine
       "]" 'org-agenda-manipulate-query-subtract)))
