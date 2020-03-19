;; prevent script-mode from dying
(fset 'real-kill-emacs (symbol-function 'kill-emacs))

(defvar actually-kill-emacs nil "…")

(defun kill-emacs (&optional arg)
  (interactive)
  (when actually-kill-emacs (real-kill-emacs arg)))

;; add current directory to load-path
(add-to-list 'load-path (concat default-directory "sophoslib"))

;; Get minimal package support
(package-initialize)
(setq debug-on-error t)
(setq inhibit-splash-screen t)

;; bootstrap straight.el
(let ((bootstrap-file (concat user-emacs-directory "straight/repos/straight.el/bootstrap.el"))
      (bootstrap-version 3))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(straight-use-package 'use-package)

;; dependencies
(use-package git)
(use-package anaphora)
(use-package dash)
(use-package eredis)
(use-package f)
(use-package hide-lines)
(use-package s)

;; initialize
(require 'sophos)
(sophos-config-load-from-environment)

(load-file "startup.el")
