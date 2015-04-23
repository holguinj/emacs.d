(require 'evil)
(require 'helm)
(require 'evil-leader)
(require 'clj-refactor)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Example:
(defun current-datestamp ()
  ;; 2014 01 14 13 17 03
  ;;   %Y %m %d %H %M %S
  (let ((datestamp-format "%Y%m%d%H%M%S"))
    (format-time-string datestamp-format (current-time))))

(defun create-migration (name directory)
  (interactive "sMigration name: \nDWhere?")
  (let* ((base (concat (current-datestamp) "-" name))
         (up (concat base ".up.sql"))
         (down (concat base ".down.sql")))
    (shell-command (concat "touch " up)) 
    (shell-command (concat "touch " down)) 
    (message "Created %s and %s" up down)
    (find-file up)))

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

(defun sort-words (reverse beg end)
  "Sort words in region alphabetically, in REVERSE if negative.
  Prefixed with negative \\[universal-argument], sorts in reverse.
  
  The variable `sort-fold-case' determines whether alphabetic case
  affects the sort order.
  
  See `sort-regexp-fields'."
  (interactive "*P\nr")
  (sort-regexp-fields reverse "\\w+" "\\&" beg end))

(defun helm-clojure-headlines ()
  "Display headlines for the current Clojure file."
  (interactive)
  (setq helm-current-buffer (current-buffer)) ;; Fixes bug where the current buffer sometimes isn't used
  (jit-lock-fontify-now) ;; https://groups.google.com/forum/#!topic/emacs-helm/YwqsyRRHjY4
  (helm :sources (helm-build-in-buffer-source "Clojure Headlines"
                   :data (with-helm-current-buffer
                           (goto-char (point-min))
                           (cl-loop while (re-search-forward "^(\\|testing\\|^;.*[a-zA-Z]+" nil t)
                                    for line = (buffer-substring (point-at-bol) (point-at-eol))
                                    for pos = (line-number-at-pos)
                                    collect (propertize line 'helm-realvalue pos)))
                   :get-line 'buffer-substring
                   :action (lambda (c) (helm-goto-line c)))
        :buffer "helm-clojure-headlines"))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Minor mode definition
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-minor-mode always-be-clojing-mode
  "Additional customizations for Clojure by Justin Holguin."
  :lighter " ABClj"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c h") 'helm-clojure-headlines)
            (define-key map (kbd "C-c C-d") 'ac-cider-popup-doc)
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
    "C-c h" 'helm-clojure-headlines)
  ;; (define-key evil-normal-state-local-map (kbd "M-.") 'cider-jump-to-var)
  (define-key evil-insert-state-local-map (kbd "RET") 'paredit-newline)
  
  ;; other customizations
  ;;
  ;; break -> and ->> so Dan will be happy
  (define-clojure-indent
    (try 1)
    (->  1)
    (->> 1)
    (\([a-z]  1))
  
  ;; preserve "proper" two-space indentation when functions are on their own lines
  ;; Use the :repl profile. If you want to add/remove Leiningen
  ;; profiles to/from CIDER, do it in the string below (in th concat expression)
  (setq cider-lein-parameters
        (if (string-match-p "with-profile" cider-lein-parameters)
            cider-lein-parameters
            (concat "with-profile +repl " cider-lein-parameters))))



;; cribbed from http://emacs-fu.blogspot.com/2008/12/highlighting-todo-fixme-and-friends.html
(add-hook 'clojure-mode-hook
               (lambda ()
                (font-lock-add-keywords nil
                 '(("\\<\\(FIXME\\|TODO\\|BUG\\)" 1 font-lock-warning-face t)))))

(add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               (cljr-add-keybindings-with-prefix "C-c C-r")))

(add-hook 'clojure-mode-hook 'always-be-clojing-mode)

(provide 'always-be-clojing-mode)
