(require 'evil)
(load "~/.emacs.d/lib/cofi-util")
(require 'cofi-util)
;(add-to-loadpath "~/.emacs.d/lib/powerline/") ;make this work please
(load "~/.emacs.d/lib/powerline/powerline-separators")
(load "~/.emacs.d/lib/powerline/powerline-themes")
(load "~/.emacs.d/lib/powerline/powerline")
(require 'powerline)
(require 'powerline-themes)
(require 'powerline-separators)
(evil-mode 1)
(evilnc-default-hotkeys)
;; (global-evil-tabs-mode t) ;;this works, but it's kind of annoying
;; (powerline-evil-vim-color-theme)
(powerline-center-evil-theme)

;; Nav https://code.google.com/p/emacs-nav/
(require 'nav)
(nav-disable-overeager-window-splitting)
(evil-leader/set-key "b" 'nav-toggle)
(evil-leader/set-key "gs" 'magit-status)

;; <leader> ev opens a new split to edit this file.
(evil-leader/set-key "ev" (lambda (arg) (interactive "P") (evil-window-vsplit 100 "~/.emacs.d/config/evil-config.el")))

;; stolen from cofi https://github.com/cofi/dotfiles/blob/master/emacs.d/config/cofi-evil.el
(setq evil-leader/leader ","
      evil-leader/in-all-states t)

(global-evil-leader-mode)

;;; evil-surround
(require-and-exec 'surround
  (setq-default surround-pairs-alist '((?\( . ("(" . ")"))
                                       (?\[ . ("[" . "]"))
                                       (?\{ . ("{" . "}"))

                                       (?\) . ("( " . " )"))
                                       (?\] . ("[ " . " ]"))
                                       (?\} . ("{ " . " }"))
                                       (?> . ("< " . " >"))

                                       (?# . ("#{" . "}"))
                                       (?p . ("(" . ")"))
                                       (?b . ("[" . "]"))
                                       (?B . ("{" . "}"))
                                       (?< . ("<" . ">"))
                                       (?t . surround-read-tag)))

  (defun cofi/surround-add-pair (trigger begin-or-fun &optional end)
    "Add a surround pair.
If `end' is nil `begin-or-fun' will be treated as a fun."
    (push (cons (if (stringp trigger)
                    (string-to-char trigger)
                  trigger)
                (if end
                    (cons begin-or-fun end)
                  begin-or-fun))
          surround-pairs-alist))

  (global-surround-mode 1)
  (add-to-hooks (lambda ()
                  (cofi/surround-add-pair "`" "`" "'"))
                '(emacs-lisp-mode-hook lisp-mode-hook))
  (add-to-hooks (lambda ()
                  (cofi/surround-add-pair "~" "``" "``"))
                '(markdown-mode-hook rst-mode-hook python-mode-hook))
  (add-hook 'LaTeX-mode-hook (lambda ()
                               (cofi/surround-add-pair "~" "\\texttt{" "}")
                               (cofi/surround-add-pair "=" "\\verb=" "=")
                               (cofi/surround-add-pair "/" "\\emph{" "}")
                               (cofi/surround-add-pair "*" "\\textbf{" "}")
                               (cofi/surround-add-pair "P" "\\(" "\\)")))
  (add-to-hooks (lambda ()
                  (cofi/surround-add-pair "c" ":class:`" "`")
                  (cofi/surround-add-pair "f" ":func:`" "`")
                  (cofi/surround-add-pair "m" ":meth:`" "`")
                  (cofi/surround-add-pair "a" ":attr:`" "`")
                  (cofi/surround-add-pair "e" ":exc:`" "`"))
                '(rst-mode-hook python-mode-hook)))


(cl-loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
                                 (fundamental-mode . emacs)
                                 (nav-mode . emacs)
                                 (pylookup-mode . emacs)
                                 (cider-repl-mode . emacs)
                                 (cider-stacktrace-mode . emacs)
                                 (comint-mode . emacs)
                                 (ebib-entry-mode . emacs)
                                 (ebib-index-mode . emacs)
                                 (ebib-log-mode . emacs)
                                 (elfeed-show-mode . emacs)
                                 (elfeed-search-mode . emacs)
                                 (gtags-select-mode . emacs)
                                 (git-commit-mode . emacs)
                                 (git-rebase-mode . emacs)
                                 (shell-mode . emacs)
                                 (term-mode . emacs)
                                 (bc-menu-mode . emacs)
                                 (magit-status-mode . emacs)
                                 (magit-branch-manager-mode . emacs)
                                 (semantic-symref-results-mode . emacs)
                                 (rdictcc-buffer-mode . emacs)
                                 (erc-mode . normal))
         do (evil-set-initial-state mode state))

(fill-keymap evil-normal-state-map
             "Y" (kbd "y$")
             "+" 'evil-numbers/inc-at-pt
             "-" 'evil-numbers/dec-at-pt
             "go" 'goto-char
             "C-t" 'transpose-chars
             "C-:" 'eval-expression
             "C-u" 'evil-scroll-up
             "D" 'paredit-kill
             ;":" 'evil-repeat-find-char-reverse
             "gH" 'evil-window-top
             "gL" 'evil-window-bottom
             "gM" 'evil-window-middle
             "H" 'beginning-of-line
             "L" 'end-of-line
             )

(fill-keymap evil-motion-state-map
             "y" 'evil-yank
             "Y" (kbd "y$")
             "_" 'evil-first-non-blank
             "C-e" 'end-of-line
             "C-S-d" 'evil-scroll-up
             "C-S-f" 'evil-scroll-page-up
             "_" 'evil-first-non-blank
             "C-y" nil)
;; end cofi
;; move between windows like a civilized fucking human being
(define-key evil-normal-state-map (kbd "C-l") 'windmove-right)
(define-key evil-normal-state-map (kbd "C-h") 'windmove-left)
(define-key evil-normal-state-map (kbd "C-j") 'windmove-down)
(define-key evil-normal-state-map (kbd "C-k") 'windmove-up)

;; remap k to gk and j to gj
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "gk") 'evil-previous-line)
(define-key evil-normal-state-map (kbd "gj") 'evil-next-line)


;; remap SPC and RET so that they won't be active in evil mode (since they just duplicate j and l)
(defun my-move-key (keymap-from keymap-to key)
	"Moves key binding from one keymap to another, deleting from the old location. "
	(define-key keymap-to key (lookup-key keymap-from key))
	(define-key keymap-from key nil))
(my-move-key evil-motion-state-map evil-normal-state-map (kbd "RET"))
(my-move-key evil-motion-state-map evil-normal-state-map " ")

;; Show red box if in Emacs mode
;; WRONG. This makes the cursor red all the time!
(setq evil-emacs-state-cursor '("violet" box))
;; Fixing it, I think.
(setq evil-normal-state-cursor '("gray" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("gray" bar))
(setq evil-motion-state-cursor '("gray" box))

;; (defcustom evil-insert-state-modes
;;   '(git-commit-mode comint-mode erc-mode eshell-mode geiser-repl-mode gud-mode inferior-apl-mode inferior-caml-mode inferior-emacs-lisp-mode inferior-j-mode inferior-python-mode inferior-scheme-mode inferior-sml-mode internal-ange-ftp-mode prolog-inferior-mode reb-mode shell-mode slime-repl-mode term-mode wdired-mode)
;;   "Modes that should come up in Insert state."
;;   :type  '(repeat symbol)
;;   :group 'evil)
