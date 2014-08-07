(global-auto-complete-mode t)


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

(add-hook 'markdown-mode-hook 'visual-line-mode)

;; ElDoc mode SUCKS
(defun disable-eldoc-mode ()
  (eldoc-mode -1))

(add-hook 'clojure-mode-hook          #'disable-eldoc-mode)
(add-hook 'cider-repl-mode-hook       #'disable-eldoc-mode)
