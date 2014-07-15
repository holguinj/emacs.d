(defvar my-packages
  '(linum-relative rainbow-delimiters cl-lib evil evil-leader evil-numbers evil-surround cm-mode markdown-mode ac-nrepl auto-complete clojurescript-mode clojure-mode cider better-defaults paredit eldoc smex cl ido-ubiquitous git-gutter-fringe magit anaphora change-inner erc-tweet expand-region hy-mode diminish flx-ido flycheck puppet-mode slamhound)
  "A list of packages to ensure are installed at launch.")

;; M-h v package-activated-list RET
;; package-activated-list is a variable defined in `package.el'.
;; Its value is
;; (anaphora change-inner color-theme-molokai dash-at-point erc-image erc-tweet expand-region hy-mode use-package diminish bind-key)

;; add package management
(require 'package)
;; add sources
(dolist (source '(("melpa" . "http://melpa.milkbox.net/packages/")
;                  ("marmalade" . "http://marmalade-repo.org/packages/") ;;"mess of out-dated and duplicated packages"
;                  ("elpa" . "http://tromey.com/elpa/") ;;"not maintained anymore"
                  ("gnu" . "http://elpa.gnu.org/packages/")
                  ("org" . "http://orgmode.org/elpa/")))
  (add-to-list 'package-archives source t))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Not strictly package management, but hey:
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))


;; Load Powerline
;;(load "~/.emacs.d/lib/powerline/powerline-themes")
;;(load "~/.emacs.d/lib/powerline/powerline-separators")
;;(load "~/.emacs.d/lib/powerline/powerline")
