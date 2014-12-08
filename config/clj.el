(require 'evil)
(require 'evil-leader)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun new-lein-project (name &optional template)
  "Interactively ask for a project and optional template name, then creates a
  Leiningen project with the parameters. Opens the project.clj file."
  (interactive "sProject name: \nMTemplate (optional): ")
  (shell-command-to-string
    (concat "cd ~/src && "
            "lein new "
            template
            " " name))
  (find-file (concat "~/src/" name "/project.clj")))

(defun helm-clojure-headlines ()
  "Display headlines for the current Clojure file."
  (interactive)
  (helm-mode t)
  (jit-lock-fontify-now) ;; https://groups.google.com/forum/#!topic/emacs-helm/YwqsyRRHjY4
  (helm :sources '(((name . "Clojure Headlines")
                    (volatile)
                    (headline "^(\\|testing\\|^;.*[A-Za-z]+")))))

(defun make-string-replacer-fn (match replacement)
  (lambda (start end)
    (interactive "r")
    (narrow-to-region start end)
    (goto-char 1)
    (let ((case-fold-search nil))
      (while (search-forward-regexp match replacement t)
        (replace-match ""
                       t nil)))))

(defun remove-spyscope-traces (start end)
  "Remove all #spy/... calls from the region/buffer.
  Cribbed from http://wikemacs.org/wiki/Emacs_Lisp_Cookbook#Scripted_Use"
  (interactive "r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char 1)
    (let ((case-fold-search nil))
      (while (search-forward-regexp "#spy/[pdt] " nil t)
        (replace-match ""
                       t nil)))))

(defun text-inserter (text)
  "Returns a function that can be called interactively (with no args)
  to insert the given string"
  (lambda (&args) (interactive "P")
    (insert text)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Minor mode definition
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-minor-mode always-be-clojing-mode
  "Additional customizations for Clojure by Justin Holguin."
  :lighter " ABClj"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c h") 'helm-clojure-headlines)
            (define-key map (kbd "C-x 3") (lambda (&args) (interactive "P") (split-window-horizontally) (helm-projectile)))
            (define-key map (kbd "C-x 2") (lambda (&args) (interactive "P") (split-window-vertically) (helm-projectile)))
            map)
  (evil-leader/set-leader "<SPC>")

  (evil-leader/set-key-for-mode 'clojure-mode "h"   #'helm-clojure-headlines)
  (evil-leader/set-key-for-mode 'clojure-mode "s p" (lambda (&args) (interactive "P") (insert "#spy/p ")))
  (evil-leader/set-key-for-mode 'clojure-mode "s d" (lambda (&args) (interactive "P") (insert "#spy/d ^{:marker \"\"} ") (backward-char 3)))
  (evil-leader/set-key-for-mode 'clojure-mode "s t" (lambda (&args) (interactive "P") (insert "#spy/t ")))

  (fill-keymap evil-normal-state-local-map
    "M-." 'cider-jump-to-var
    "M-," 'cider-jump-back
    "C-c h" 'helm-clojure-headlines
    "C-c C-d d" 'cider-doc
    "C-c C-d a" 'cider-apropos-documentation
    "C-c C-d g" 'cider-grimoire-web
    "C-c C-d j" 'cider-docview-javadoc)
  ;; (define-key evil-normal-state-local-map (kbd "M-.") 'cider-jump-to-var)
  (define-key evil-insert-state-local-map (kbd "RET") 'paredit-newline)
  
  ;; other customizations
  ;;
  ;; break -> and ->> so Dan will be happy
  (define-clojure-indent
    (->  1)
    (->> 1)
    (\([a-z]  1))
  
  ;; preserve "proper" two-space indentation when functions are on their own lines
;  (setq lisp-indent-offset 2)
  )

(add-hook 'clojure-mode-hook 'always-be-clojing-mode)

(provide 'always-be-clojing-mode)
