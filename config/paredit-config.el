;; First, make sure paredit mode is freaking enabled.
(enable-paredit-mode)

;; more bindings!
(define-key paredit-mode-map (kbd "C-M-w") 'paredit-backward-up)
(define-key paredit-mode-map (kbd "C-M-e") 'paredit-forward-up)
(define-key paredit-mode-map (kbd "C-M-s") 'paredit-backward-down)
(define-key paredit-mode-map (kbd "C-M-d") 'paredit-backward-down)
(define-key paredit-mode-map (kbd "\\") (lambda () (interactive) (insert "\\")))

(defun disable-paredit-backslash ()
  (local-set-key [remap paredit-backslash]
                 (lambda ()
                   (interactive)
                   (insert "\\"))))

;; GANGSTA WRAP
(define-key paredit-mode-map (kbd "M-[") 'paredit-wrap-square)
