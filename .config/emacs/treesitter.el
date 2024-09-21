;; Syntax Highlighting
(require 'treesit)

(add-to-list 'treesit-language-source-alist '(bash "https://github.com/tree-sitter/tree-sitter-bash.git"))
(add-to-list 'major-mode-remap-alist '(sh-mode . bash-ts-mode))
(add-to-list 'major-mode-remap-alist '(shell-script-mode . bash-ts-mode))

(add-to-list 'treesit-language-source-alist '(python "https://github.com/tree-sitter/tree-sitter-python.git"))
(add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))

(add-to-list 'treesit-language-source-alist '(c "https://github.com/tree-sitter/tree-sitter-c"))
(add-to-list 'major-mode-remap-alist '(c++-mode . c-ts-mode))
(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))

(add-to-list 'treesit-language-source-alist '(css "https://github.com/tree-sitter/tree-sitter-css.git"))
(add-to-list 'major-mode-remap-alist '(css-mode . css-ts-mode))

(add-to-list 'treesit-language-source-alist '(html "https://github.com/tree-sitter/tree-sitter-html.git"))
(add-to-list 'major-mode-remap-alist '(html-mode . html-ts-mode))

(add-to-list 'treesit-language-source-alist '(rust "https://github.com/tree-sitter/tree-sitter-rust.git"))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))

(setq treesit-font-lock-level 4)
