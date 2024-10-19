(global-set-key [remap next-buffer] 'my-next-buffer)
(global-set-key [remap previous-buffer] 'my-previous-buffer)
;; (general-def
;;   "C-j" 'nil
;;   "C-l" 'nil
;;   "C-k" 'nil)

(general-def
  "M-a" 'mark-whole-buffer
  "M-i" 'toggle-term-eat
  "M-o" 'open-in-terminal
  "M-," 'which-key-abort
  ;; "M-n" 'lsp-ui-find-next-reference
  ;; "M-S-n" 'lsp-ui-find-prev-reference
  "C-;" 'embark-become
  "C-<return>" 'embark-act
  "<escape>" 'keyboard-escape-quit)

(general-create-definer e/leader-keys
  :keymaps '(normal insert visual emacs)
  :prefix "SPC"
  :global-prefix "C-SPC"
  )

(general-create-definer e/goto-keys
  :keymaps '(normal insert)
  :prefix "g"
  :global-prefix "C-g"
  )

(e/leader-keys
  "SPC" '(execute-extended-command :which-key "  M-x  ")
  "k" '(eldoc-box-help-at-point :which-key "  hover  ")
  ;; "k" '(lsp-ui-doc-glance :which-key "  hover  ")
  )

(e/leader-keys
  "c"  '(:ignore t :which-key "󰅱  code  ")
  "ca"  '(eglot-code-actions :which-key "  code actions  ")
  "cr"  '(eglot-rename :which-key "󰑕  rename symbol  ")
  "ce"  '(org-ctrl-c-ctrl-c :which-key "󰅱  execute code in org  ")
  "cs"  '(iedit-mode :which-key "󰅱  execute code in org  ")
  "cc"  '(compile :which-key "  compile code  ")
  "cf"  '(apheleia-format-buffer :which-key "  format buffer using lsp ")
  "cF" '((lambda () (interactive) (indent-region (point-min) (point-max))) :wk "  format default  "))

(e/leader-keys
  "a"  '(:ignore t :which-key "  avy  ")
  "aa" '(evil-avy-goto-word-1 :which-key "󰀫  avy char  ")
  "al" '(avy-goto-line :which-key "󰂶  avy line  ")
  "am"  '(:ignore t :which-key "  avy move  ")
  "aml" '(avy-move-line :which-key "󰂶  avy move line  "))

(e/leader-keys
  "p"  '(:ignore t :which-key "  projectile  ")
  "ps" '(projectile-switch-project :which-key "󰀫  Switch to project  ")
  "pf"  '(:ignore t :which-key "  projectile files ")
  "pfr" '(projectile-recentf :which-key "󰀫  open project recents  ")
  "pff" '(projectile-dired :which-key "󰀫  open project folder  ")
  "pr" '(projectile-run-project :which-key "󰀫  Run project  "))


(e/leader-keys
  "f"  '(:ignore t :which-key "󰈔  files  ")
  "fd" '(find-file :which-key "󰈞  find a file  ")
  "fr" '(consult-buffer :which-key "󰣜  recent files  ")
  "ff" '(dired-jump :which-key "󰉓   open dired  ")
  "fi" '(evil-show-file-info :which-key "  file info  ")
  "fot" '(org-babel-tangle :which-key "󰗆  org tangle")
  "fn" '(org-roam-node-find :which-key "󰣜  find nodes  ")
  "fc"  '(:ignore t :which-key "󰈔  current file  ")
  "fcr"  '(recover-this-file :which-key "󰑕  rename current file  "))

(e/leader-keys
  "o"  '(:ignore t :which-key "󰉋  org  ")
  "oe" '(e/org-babel-edit :which-key "󰕪  open agendas  ")
  "od" '(hm/convert-org-to-docx-with-pandoc :which-key "󰕪  open convert org to docx  ")
  "oa" '(org-agenda :which-key "󰕪   open agendas  ")
  "oc" '(org-capture :which-key "󰄄   open capture  ")
  "oi"  '(:ignore t :which-key "󰉋  org insert  ")
  "ois" '(org-schedule :which-key "󰾖   insert schedule  ")
  "oid" '(org-deadline :which-key "󰾕   insert deadline  ")
  "oil" '(org-insert-link :which-key "   insert link  ")
  "on" '(org-roam-node-insert :which-key "   insert link  ")
  "og"  '(org-roam-ui-open :which-key "󱁉  Open graph  "))

(e/leader-keys
  "g"  '(:ignore t :which-key "  get  ")
  "gi" '(consult-imenu :which-key "󰮫  get imenu  ")
  "gf" '(list-faces-display :which-key " 󰙃  get faces")
  "gc" '(zenity-cp-color-at-point-dwim :which-key " 󰙃  colors picker")
  "gk" '(consult-yank-from-kill-ring :which-key "  get kill ring and yank  "))

(e/leader-keys
  "l"  '(:ignore t :which-key "󰃷  Latex Commands  ")
  "lv"  '(TeX-view :which-key "󰃷  Latex View  ")
  "lc" '(compile-latex-doc :wk "  Latex Compile  "))

(e/leader-keys
  "x"  '(:ignore t :which-key "󰃷  execute  ")
  "xr" '((lambda () (interactive) (load-file "~/.config/emacs/init.el")) :wk "  Reload emacs config  ")
  "x"  '(:ignore t :which-key "󰃷  execute latex commands  "))

(e/leader-keys
  "i" '(:ignore t :which-key "󰡁  insert  ")
  "ii" '(all-the-icons-insert :which-key "󰭟   insert icons  ")
  "it" '(org-insert-time-stamp :which-key "   insert time stamp   ")
  )

(e/leader-keys
  "b"  '(:ignore t :which-key "  buffer navigation  ")
  "bd" '(kill-buffer-and-window :which-key "󰆴  kill the current buffer and window  ")
  "bk" '(kill-some-buffers :which-key "󰛌  kill all other buffers and windows  ")
  "bn" '(next-buffer :which-key "󰛂   switch buffer  ")
  "bp" '(previous-buffer :which-key "󰛁   switch buffer  ")
  "bb" '(consult-buffer :which-key "󰕰  view buffers  "))

(e/leader-keys
  "s"  '(:ignore t :which-key "  search  ")
  "ss" '(consult-line :which-key "󰱼  line search  ")
  "sr" '(consult-ripgrep :which-key "󰟥   search with rg  ")
  "sp" '(consult-fd :which-key "   search with fd  ")
  "sd" '(dictionary-search :which-key "  search in dictionary  "))

(e/leader-keys
  "e"  '(:ignore t :which-key "󰈈   evaluate  ")
  "eb" '(eval-buffer :which-key "󰷊  evaluate buffer  ")
  "ee" '(eval-last-sexp :which-key "󰷊  evaluate last expression  ")
  "er" '(eval-region :which-key "󰨺  evaluate region  "))

(e/leader-keys
  "h"  '(:ignore t :which-key "󰞋   help  ")
  "ht" '(helpful-at-point :which-key "  describe this  ")
  "hF" '(describe-face :which-key "󱗎  describe face  ")
  "hf" '(helpful-function :which-key "󰯻  describe function  ")
  "hh" '(devdocs-lookup :which-key "󰯻  describe function  ")
  "hb" '(embark-bindings :which-key "󰌌  describe bindings  ")
  "hk" '(helpful-key :which-key "󰯻  describe this key  ")
  "hv" '(helpful-variable :which-key "  describe variable  ")
  "hrb" '(revert-buffer-quick :which-key "󰄸  reload buffer  "))

(e/leader-keys
  "t"  '(:ignore t :which-key "   toggles/switches  ")
  "tt"  '(toggle-truncate-lines :which-key "󰖶  toggle word wrap mode  ")
  "tv" '(visual-line-mode :which-key "  visual line mode ")
  "tR" '(read-only-mode :which-key "󰑇  read only mode  ")
  "tc"  '(:ignore t :which-key "󰮫  toggle corfu  ")
  "tce" '((lambda () (interactive) (setq-default corfu-auto t) (corfu-mode 1)) :wk "   enable  ")
  "tcd" '((lambda () (interactive) (setq-default corfu-auto nil) (corfu-mode 1)) :wk "   disable  ")
  "tf"  '(flymake-mode :which-key "  toggle flymake  ")
  "tb"  '(breadcrumb-mode :which-key "  toggle breadcrumbs  ")
  "tr"  '(org-roam-buffer-toggle :which-key "  Roam Buffer  ")
  "to"  '(:ignore t :which-key "󰮫  toggle org  ")
  "tol" '(org-toggle-link-display :which-key "  Toggle Link Display  ")
  "tm"  '(minimap-mode :which-key "󰍍  minimap toggles  "))

(e/goto-keys
  "n"  '(flymake-goto-next-error :which-key " next error")
  "p"  '(flymake-goto-prev-error :which-key " prev error"))

(general-def
  :keymaps 'evil-normal-state-map
  "M-d"  '(duplicate-dwim :which-key "  code duplicate  ")
  "C-u" #'evil-scroll-up
  "C-d" #'evil-scroll-down
  "C-s" (lambda () (interactive) (evil-ex "%s/"))
  "<tab>" 'my-next-buffer
  "<backtab>" 'my-previous-buffer
  "C-l" 'clear
  "C-n" 'iedit-next-occurrence
  "C-S-n" 'iedit-prev-occurrence
  "RET" 'org-open-at-point-global
  "M-k" 'drag-stuff-up
  "M-j" 'drag-stuff-down
  "M-h" 'drag-stuff-left
  "M-l" 'drag-stuff-right
  "C-/" #'consult-line-multi
  "gcc" #'evil-commentary-line
  "gca" (lambda () (interactive) (comment-indent) (just-one-space) (evil-append-line 1))
  )
(general-def
  :keymaps 'evil-insert-state-map
  "C-h" 'nil
  "C-l" 'completion-at-point
  "C-k" 'corfu-previous
  "C-j" 'corfu-next
  "C-." 'yas-expand
  "C-f" 'find-file-at-point
  )
(general-def
  :keymaps 'evil-visual-state-map
  "gc" #'evil-commentary
  )
(general-def
  :keymaps 'org-mode-map
  "C-h" 'nil
  "C-S-h" 'nil
  )
(general-def
  :keymaps 'vertico-map
  "C-l" '(lambda () (interactive) (vertico-insert) )
  "C-S-l" '(lambda () (interactive) (vertico-insert) (minibuffer-force-complete-and-exit))
  "C-k" #'vertico-next
  "C-j" #'vertico-previous
  "C-h" #'vertico-directory-up
  )

(general-def 
  :keymaps 'comint-mode-map
  "M-n" 'nil
  "M-i" 'nil
  "M-S-n" 'nil
  )

(general-def 
  :keymaps 'eat-semi-char-mode-map
  "M-n" 'nil
  "M-i" 'toggle-term-eat
  "M-S-n" 'nil
  )
