(require 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(load "~/.emacs.d/lib/helm-projectile")
(helm-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; helm-ag
(setq helm-ag-insert-at-point nil)

(setq helm-ag-fuzzy-match 't)
