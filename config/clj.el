(require 'evil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun helm-clojure-headlines ()
  "Display headlines for the current Clojure file."
  (interactive)
  (helm-mode t)
  (helm :sources '(((name . "Clojure Headlines")
                    (volatile)
                    (headline "^[;(]")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Minor mode definition
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-minor-mode always-be-clojing-mode
  "Additional customizations for Clojure by Justin Holguin."
  :lighter " ABClj"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c h") 'helm-clojure-headlines)
            (define-key map (kbd "M-.") 'cider-jump-to-var)
            map)
  (evil-leader/set-key-for-mode 'always-be-clojing-mode "h" 'helm-clojure-headlines)
  (define-key evil-insert-state-local-map (kbd "RET") 'paredit-newline))

(add-hook 'clojure-mode-hook 'always-be-clojing-mode)

(provide 'always-be-clojing-mode)
