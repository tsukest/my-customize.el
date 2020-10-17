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

(defun my-customize-select-shell ()
  "Select shell to run."
  (interactive)
  (ivy-read "Use: " '("shell-command"
                      "eshell-command")
            :preselect "^shell-command"
            :action (lambda (user-input)
                      (counsel-M-x-action user-input))
            :caller 'my-customize-select-shell))

(provide 'my-customize)
;;; my-customize.el ends here
