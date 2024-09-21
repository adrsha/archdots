(add-hook 'term-mode-hook #'(lambda () (display-line-numbers-mode -1)))
(add-hook 'dired-mode-hook #'(lambda () (display-line-numbers-mode -1)))
(add-hook 'shell-mode-hook #'(lambda () (display-line-numbers-mode -1)))
(add-hook 'org-mode-hook (lambda () (interactive)
			   (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)
			   (display-line-numbers-mode 0)
			   ))

(add-hook 'org-agenda-mode-hook #'(lambda ()
                                    (display-line-numbers-mode -1)
				    (buffer-face-mode)
                                    ))

(add-hook 'focus-out-hook 'garbage-collect)

(add-hook 'org-src-mode-hook #'(lambda () (interactive) (setq header-line-format 'nil)))
(add-hook 'org-capture-mode-hook #'(lambda () (interactive) (setq header-line-format 'nil)))
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(add-hook 'after-change-major-mode-hook
          (lambda ()
            (unless (derived-mode-p 'dired-mode)
              (set-face-attribute 'default nil :weight 'bold))))

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook #'(lambda () (interactive)
                               (lsp)
                               (prettify-symbols-mode 1) ))


(add-hook 'popper-mode-hook
	  (lambda ()
	    (setq popper-reference-buffers
		  (append popper-reference-buffers
			  '("\\*eat\\*")))))


(add-hook 'after-save-hook #'(lambda () (interactive)
                               (recentf-save-list) ))

(add-hook 'evil-insert-state-entry-hook #'(lambda () (interactive) (flymake-mode 0) ))
(add-hook 'evil-insert-state-exit-hook #'(lambda () (interactive) (flymake-mode 1) ))
