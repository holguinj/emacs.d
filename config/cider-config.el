;; autocomplete
(require 'auto-complete-config) ;; not sure this is necessary
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://stackoverflow.com/a/26809011
(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
    '(add-to-list 'ac-modes 'cider-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; make the REPL prettier
(setq cider-repl-use-clojure-font-lock t)

(setq nrepl-hide-special-buffers t)

;; Pretty printing
(setq cider-repl-use-pretty-printing 't)
;;(add-hook 'cider-repl-mode-hook 'cider-repl-toggle-pretty-printing)

;;================================================================================
;; Disabling ac-shit because it sucks ============================================
;;================================================================================

;; ;; Popup autocomplete
;; (add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
;; (add-hook 'cider-mode-hook 'ac-nrepl-setup)
;; (eval-after-load "auto-complete"
;;   '(add-to-list 'ac-modes 'cider-repl-mode))

;; ;; Trigger AC with TAB does this break things
;; (defun set-auto-complete-as-completion-at-point-function ()
;;   (setq completion-at-point-functions '(auto-complete)))

;; ===============================================================================
;; ac-nrepl docs maybe don't suck ================================================
;; ===============================================================================
(eval-after-load "cider"
  '(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))

