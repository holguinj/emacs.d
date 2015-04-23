;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Molokai theme
(load "~/.emacs.d/lib/molokai-theme/molokai-theme")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Monokai theme
;; (load "~/.emacs.d/lib/monokai-emacs/monokai-theme")
;; (load-theme 'monokai t)

;; show the current line in the left margin
(linum-mode)

;; linum font size shouldn't depend on default-face
;; this is a fix for linum + text-sale-increase
(set-face-attribute 'linum nil :height 160)

(defun jhh--decrease-scale (args)
  (interactive "p")
  (text-scale-decrease)
  ;; (let ((new-height (cond
  ;;                    ((zerop text-scale-mode-amount) 160)
  ;;                    ((> text-scale-mode-amount 0) 160)
  ;;                    ((< text-scale-mode-amount 0) (- (face-attribute 'linum :height) 10)))))
  ;;   (set-face-attribute 'linum nil :height new-height))
  )

;; Show useless whitespace
(setq-default show-trailing-whitespace t)

;; highlight the current line
(global-hl-line-mode)

;; Disable toolbars
(tool-bar-mode -1)

;; Highlight the current line
;; (hl-line-mode 't)

;; Git gutter fringe
(global-git-gutter+-mode t)
(require 'git-gutter-fringe+)

(setq-default indicate-buffer-boundaries 'left)
(setq-default indicate-empty-lines +1)
;; set transparency
;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
(set-frame-parameter (selected-frame) 'alpha '(98 85))
(add-to-list 'default-frame-alist '(alpha 90 85))

;; replace selection when yanking
(delete-selection-mode)

;; company-mode customization
(require 'color)

;; (let ((bg (face-attribute 'default :background)))
;;   (custom-set-faces
;;    `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
;;    `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
;;    `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
;;    `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
;;    `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))

;; Why are these broken?
(define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)
(define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)

;; linum-relative doesn't provide a nice way to customize this.
(defface linum-relative-current-face
  '((t :inherit linum :foreground "DarkOrange2" :background "grey11" :weight bold))
  "Face for displaying current line."
  :group 'linum-relative)

;; Move focus to new split (duh)
(defadvice split-window (after move-point-to-new-window activate)
  "Moves the point to the newly created window after splitting."
  (other-window 1))

;; font stuff
(add-to-list 'default-frame-alist '(font . "Ubuntu Mono-16"))
(set-frame-font "Ubuntu Mono-15" nil t)

;; window size http://www.jesshamrick.com/2013/03/31/macs-and-emacs/
(defun custom-set-frame-size ()
  (add-to-list 'default-frame-alist '(height . 35))
  (add-to-list 'default-frame-alist '(width . 150)))
(custom-set-frame-size)
(add-hook 'before-make-frame-hook 'custom-set-frame-size)

;; Fix popups by disabling them. Otherwise they crash emacs!
(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent yes-or-no-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))
(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))

;; Disable overeager scrolling
(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; Ignore prompt when killing a process
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

;; Display date and time in status bar
(setq display-time-day-and-date t)
(display-time)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Shell
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Don't allow shell prompt to be deleted
(setq comint-prompt-read-only t)

;; Don't echo line in comint-mode
(defun echo-false-comint ()
  (setq comint-process-echoes t))
(add-hook 'comint-mode-hook 'echo-false-comint)

(require 'linum-relative)
;; (setq linum-relative-current-symbol "->")
(setq linum-relative-current-symbol "") ;; just show the current (absolute) line number
(global-linum-mode)

;; turn off annoying visible bell
(setq visible-bell nil)

;; Highlight hex codes with their color
(defun xah-syntax-color-hex ()
"Syntax color hex color spec such as 「#ff1100」 in current buffer."
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[abcdef[:digit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-fontify-buffer))

(add-hook 'css-mode-hook 'xah-syntax-color-hex)
(add-hook 'emacs-lisp-mode-hook 'xah-syntax-color-hex)
(add-hook 'html-mode-hook 'xah-syntax-color-hex)
