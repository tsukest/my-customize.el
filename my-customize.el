;;; my-customize.el -- My customize.el  -*- lexical-binding: t; -*-

;; Author: satake <satake.ts@gmail.com>
;; Maintainer: satake <satake.ts@gmail.com>
;; URL: https://github.com/tsukest/my-customize.el
;; Version: 0.0.1
;; Keywords: my
;; Package-Requires: ((emacs "24.5") (ivy "0.13.0"))

;;; Commentary:

;; This is my setting

;;; Code:

(require 'ivy)
(require 'counsel)
(require 'projectile)

(defun my-select-shell ()
  "Select shell to run."
  (interactive)
  (ivy-read "Use: " '("shell-command"
                      "eshell-command")
            :preselect "^shell-command"
            :action (lambda (user-input)
                      (counsel-M-x-action user-input))
            :caller 'my-customize-select-shell))

(defun my-projectile-counsel-git-grep ()
  "Perform counsel-git-grep in the project."
  (interactive)
  (let ((project-root (projectile-ensure-project (projectile-project-root))))
    (counsel-git-grep nil project-root nil)))

(defun my-projectile-vc ()
  "Open `maigt-status' at the root of the project."
  (interactive)
  (let ((project-root (projectile-ensure-project (projectile-project-root))))
    (magit-status project-root)))

(defun my-other-window-1 ()
  "Select another window in back cyclic ordering of windows."
  (interactive)
  (other-window -1))

(defun my-find-interactive ()
  "Find file."
  (interactive)
  (if (not (magit-toplevel))
      (counsel-fzf)
    (counsel-git)))

(defun my-grep-interactive ()
  "Grep for a string in the directory."
  (interactive)
  (if (not (magit-toplevel))
      (counsel-rg)
    (counsel-git-grep)))

(defun gov-list ()
  "List version of Go."
  (interactive)
  (let ((version (process-lines "gov" "list")))
    (message (mapconcat 'identity version "\n"))))

(defun gov-use ()
  "Change version of Go."
  (interactive)
  (ivy-read "Version: " (process-lines "gov" "list")
            :action (lambda (ver)
                      (progn
                        (process-lines "gov" "use" ver)
                        (message "use go %s" ver)))
            :caller 'gov-use))

(defun gov-install ()
  "Change version of Go."
  (interactive)
  (ivy-read "Version: " nil
            :action (lambda (ver)
                      (start-process "gov-install-process" "*gov-install*" "gov" "install" ver))
            :caller 'gov-install))

(provide 'my-customize)
;;; my-customize.el ends here
