;; -*- emacs-lisp -*-

(setq inhibit-splash-screen t)

(set-face-font 'menu "-UKWN-Iosevka Nerd Font-regular-normal-normal-*-30-*-*-*-d-0-iso10646-1")
(set-face-font 'default "-UKWN-Iosevka Nerd Font-regular-normal-normal-*-30-*-*-*-d-0-iso10646-1")

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Remove the clutter

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Mode line

(column-number-mode)
(display-time)
(display-battery-mode)
(global-display-line-numbers-mode)
(global-hl-line-mode 1)
(which-function-mode)

;; Split the window vertically when opening a status pane

(setq split-height-threshold 0)
(setq split-width-threshold 0)

(require 'spaceline-config)
(spaceline-spacemacs-theme)
