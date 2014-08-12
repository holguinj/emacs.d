(global-auto-complete-mode -1) ;; ac-mode seems to suck
(add-hook 'after-init-hook 'global-company-mode) ;; company-mode supposedly does not suck

(add-hook 'markdown-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'clojure-mode-hook          #'enable-paredit-mode)
(add-hook 'clojure-mode-hook          #'enable-paredit-mode)
(add-hook 'clojurescript-mode-hook    #'enable-paredit-mode)
(add-hook 'cider-repl-mode-hook       #'enable-paredit-mode)
(add-hook 'clojure-mode-hook          #'rainbow-delimiters-mode)

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)


;; I disabled eldoc-mode because I thought it was messing with CIDER. But I now think it was ac-mode.
;; Leaving the following here in case I change my mind again.
;; ;; ElDoc mode SUCKS
;; (defun disable-eldoc-mode ()
;;   (eldoc-mode -1))

;; (add-hook 'clojure-mode-hook          #'disable-eldoc-mode)
;; (add-hook 'cider-repl-mode-hook       #'disable-eldoc-mode)

;; Disabling auto-complete-mode
;; (add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
;; (add-hook 'cider-repl-mode-hook 'set-auto-complete-as-completion-at-point-function)
;; (add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)
