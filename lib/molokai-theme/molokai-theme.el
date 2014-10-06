;;; molokai-theme.el --- Yet another molokai theme for Emacs 24

;; Copyright (C) 2013 Huang Bin

;; Author: Huang Bin <embrace.hbin@gmail.com>
;; URL: https://github.com/hbin/molokai-theme
;; Version: 0.8

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; This is another molokai dark theme for Emacs 24.
;; Equiped with my favorites.

;;; Requirements:
;;
;; Emacs 24

;;; Code:
(deftheme molokai "The molokai color theme for Emacs 24")

(let ((class '((class color) (min-colors 89)))
      ;; molokai palette
      (molokai-white          "#ffffff")
      (molokai-fg             "#f8f8f0")
      (molokai-red            "#ff0000")
      (molokai-pink           "#f92672")
      (molokai-orange+5       "#ef5939")
      (molokai-orange         "#fd971f")
      (molokai-yellow         "#ffff00")
      (molokai-darkgoldenrod  "#e6db74")
      (molokai-wheat          "#c4be89")
      (molokai-olive          "#808000")
      (molokai-chartreuse     "#a6e22e")
      (molokai-lime           "#00ff00")
      (molokai-green          "#008000")
      (molokai-darkwine       "#1e0010")
      (molokai-maroon         "#800000")
      (molokai-wine           "#960050")
      (molokai-teal           "#008080")
      (molokai-aqua           "#00ffff")
      (molokai-blue           "#66d9ef")
      (molokai-slateblue      "#7070f0")
      (molokai-purple         "#ae81ff")
      (molokai-palevioletred  "#d33682")
      (molokai-grey-2         "#bcbcbc")
      (molokai-grey-1         "#8f8f8f")
      (molokai-grey           "#808080")
      (molokai-grey+2         "#403d3d")
      (molokai-grey+3         "#4c4745")
      (molokai-grey+5         "#232526")
      (molokai-bg             "#1b1d1e")
      (molokai-grey+10        "#080808")
      (molokai-dark           "#000000")
      (molokai-base01         "#465457")
      (molokai-base02         "#455354")
      (molokai-base03         "#293739")
      (molokai-dodgerblue     "#13354a"))
  (custom-theme-set-faces
   'molokai

   ;; base
   `(default ((t (:background ,molokai-bg :foreground ,molokai-fg))))
   `(cursor ((t (:background ,molokai-fg :foreground ,molokai-bg))))
   ;; `(fringe ((t (:foreground ,molokai-base02 :background ,molokai-bg))))
   `(fringe ((t (:foreground ,molokai-base02 :background ,molokai-grey+5))))
   `(highlight ((t (:background ,molokai-grey))))
   `(region ((t (:background  ,molokai-grey+2))
             (t :inverse-video t)))
   `(warning ((t (:foreground ,molokai-palevioletred :weight bold))))

   ;; font lock
   `(font-lock-builtin-face ((t (:foreground ,molokai-chartreuse))))
   `(font-lock-comment-face ((t (:foreground ,molokai-base01))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,molokai-base01))))
   `(font-lock-constant-face ((t (:foreground ,molokai-purple))))
   `(font-lock-doc-string-face ((t (:foreground ,molokai-darkgoldenrod))))
   `(font-lock-function-name-face ((t (:foreground ,molokai-chartreuse))))
   `(font-lock-keyword-face ((t (:foreground ,molokai-pink :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,molokai-wine))))
   `(font-lock-preprocessor-face ((t (:inherit (font-lock-builtin-face)))))
   `(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
   `(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
   `(font-lock-string-face ((t (:foreground ,molokai-darkgoldenrod))))
   `(font-lock-type-face ((t (:foreground ,molokai-blue :weight bold))))
   `(font-lock-variable-name-face ((t (:foreground ,molokai-orange))))
   `(font-lock-warning-face ((t (:foreground ,molokai-palevioletred :weight bold))))

   ;; mode line
   `(mode-line ((t (:foreground ,molokai-fg
                                :background ,molokai-base03
                                :box nil))))
   `(mode-line-buffer-id ((t (:weight bold))))
   `(mode-line-inactive ((t (:foreground ,molokai-fg
                                         :background ,molokai-base02
                                         :box nil))))

   ;; search
   `(isearch ((t (:foreground ,molokai-dark :background ,molokai-wheat :weight bold))))
   `(isearch-fail ((t (:foreground ,molokai-wine :background ,molokai-darkwine))))

   ;; linum-mode
   ;; `(linum ((t (:foreground ,molokai-grey-2 :background ,molokai-grey+5))))
   `(linum ((t (:foreground ,molokai-white :background ,molokai-grey+3))))

   ;; hl-line-mode
   `(hl-line-face ((,class (:background ,molokai-grey+5)) (t :weight bold)))
   `(hl-line ((,class (:background ,molokai-grey+5)) (t :weight bold)))
   
   ;; Company mode (from https://github.com/tungd/dotfiles/blob/10e31d2189d567970a40be06a84671f7517d3012/emacs/themes/custom-theme.el)
   ;; added by JHH
   `(company-tooltip ((t :background "white" :foreground "white")))
   `(company-tooltip-selection ((t :background "lightgray" :foreground "black")))
   `(company-tooltip-mouse ((t :background "blue" :foreground "white")))
   `(company-tooltip-common ((t :background "lightgray" :foreground "black")))
   `(company-tooltip-common-selection ((t t :background nil :foreground "black")))
   `(company-tooltip-annotation ((t :background "black" :foreground "yellow")))
   `(company-scrollbar-fg ((t :background "black")))
   `(company-scrollbar-bg ((t :background "lightgray")))
   `(company-preview ((t :background "white" :foreground "lightgray")))
   `(company-preview-common ((t :background nil :foreground "darkgray")))
   `(company-preview-search ((t :background "white" :foreground "white")))

   ;; rainbow delimiters (from https://github.com/tungd/dotfiles/blob/10e31d2189d567970a40be06a84671f7517d3012/emacs/themes/custom-theme.el)
   ;; added by JHH
   `(rainbow-delimiters-depth-1-face ((t :foreground "dark sea green")))
   `(rainbow-delimiters-depth-2-face ((t :foreground "seashell")))
   `(rainbow-delimiters-depth-3-face ((t :foreground "light steel blue")))
   `(rainbow-delimiters-depth-4-face ((t :foreground "palegreen2")))
   `(rainbow-delimiters-depth-5-face ((t :foreground "#11535F")))
   `(rainbow-delimiters-depth-6-face ((t :foreground "#00959e")))
   `(rainbow-delimiters-depth-7-face ((t :foreground "#d97a35")))
   `(rainbow-delimiters-unmatched-face ((t :background "#d13120" :underline t)))


   ;; TODO
   ;; ido-mode
   ;; flycheck
   ;; show-paren
   ;; rainbow-delimiters
   ;; highlight-symbols
   ))

(defcustom molokai-theme-kit nil
  "Non-nil means load molokai-theme-kit UI component"
  :type 'boolean
  :group 'molokai-theme)

(defcustom molokai-theme-kit-file
  (concat (file-name-directory
           (or (buffer-file-name) load-file-name))
          "molokai-theme-kit.el")
  "molokai-theme-kit-file"
  :type 'string
  :group 'molokai-theme)

(if (and molokai-theme-kit
         (file-exists-p molokai-theme-kit-file))
    (load-file molokai-theme-kit-file))

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'molokai)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; molokai-theme.el ends here
