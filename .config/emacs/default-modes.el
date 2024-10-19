(menu-bar-mode -1)
(blink-cursor-mode -1)
(global-display-line-numbers-mode t)
(recentf-mode 1)                                   ; Remember recently opened files
(save-place-mode 1)                                ; Remember the last traversed point in file
(global-auto-revert-mode 1)                        ; Automatically revert buffers when the underlying file is changed
(if (fboundp 'scroll-bar-mode) (set-scroll-bar-mode nil))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
