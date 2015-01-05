;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RVM
(require 'rvm)
(rvm-use-default)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enhanced ruby mode
(setq enh-ruby-program "/Users/justin/.rvm/rubies/ruby-2.0.0-p353/bin/ruby")
(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))

(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
 
(setq enh-ruby-bounce-deep-indent t)
(setq enh-ruby-hanging-brace-indent-level 2)
 
(require 'cl) ; If you don't have it already
 
(defun* get-closest-gemfile-root (&optional (file "Gemfile"))
  "Determine the pathname of the first instance of FILE starting from the current directory towards root.
This may not do the correct thing in presence of links. If it does not find FILE, then it shall return the name
of FILE in the current directory, suitable for creation"
  (let ((root (expand-file-name "/"))) ; the win32 builds should translate this correctly
    (loop 
     for d = default-directory then (expand-file-name ".." d)
     if (file-exists-p (expand-file-name file d))
     return d
     if (equal d root)
     return nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Robe
(add-hook 'enh-ruby-mode-hook 'robe-mode)
;;(push 'company-robe company-backends) ;; no worky

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom functions
(defun helm-ruby-headlines ()
  "Display headlines for the current Ruby file."
  (interactive)
  (jit-lock-fontify-now) ;; https://groups.google.com/forum/#!topic/emacs-helm/YwqsyRRHjY4
  (helm :sources (helm-build-in-buffer-source "Ruby Headlines"
                   :data (with-helm-current-buffer
                           (goto-char (point-min))
                           (cl-loop while (re-search-forward "^[ ]?+def\\|^#.*[a-zA-Z]+\\|^[ ]?+[C]lass" nil t)
                                    for line = (buffer-substring (point-at-bol) (point-at-eol))
                                    for pos = (line-number-at-pos)
                                    collect (propertize line 'helm-realvalue pos)))
                   :get-line 'buffer-substring
                   :action (lambda (c) (helm-goto-line c)))
        :buffer "helm-ruby-headlines"))
