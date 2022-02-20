;;; slideshow.el --- setup emacs to display a slideshow  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Corwin Brust

;; Author: Corwin Brust <corwin@bru.st>
;; Keywords: multimedia

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; using org-tree-slide from MELPA, which is where I got most of this
;; see issues #13: https://github.com/takaxp/org-tree-slide/issues/13
;; so also bring in hide-linesy
;; finally org-superstart

;;; Code:
(require 'org-src)

(eval-when-compile
  (require 'hide-lines)
  (require 'org-superstar)
  (require 'org-tree-slide))

(defvar my:slide-left-margin 10
  "Left margin during slideshow.")

(defvar my:slide-right-margin 10
  "Right margin during slideshow.")

(defvar my:slide-top-margin 500
  "Top margin, for face `header-line' :height.")

(defvar my:slide-fill-column-save nil
  "Max characters in a line when not displaying slideshow.")

(defvar my:slide-fill-column 42
  "Max characters in a line of paragraph text on a slide.")

(defvar my:org-src-block-faces nil
  "Stores src-block faces while presenting.")

(defvar my:org-slider-src-block-faces
  '(("emacs-lisp" (:background "black" :box nil)))
  "Override faces for source blocks during slideshow.")

(defvar my:slide-background nil ;;"#000000"
  "When non-nil, override background color.")

(defun my:show-headers ()
  "Called when stopping the slideshow."
  ;; restore org's source-block faces
  (setq org-src-block-faces my:org-src-block-faces)
  ;; restore fill-col
  (setq fill-column my:slide-fill-column-save)
  ;; turn off the fringe
  (set-fringe-mode nil)
  ;; tear-down headerline
  (setq header-line-format nil)
  (merge-face-attribute 'header-line :height 1)
  ;; remove margins
  (set-window-margins (get-buffer-window (current-buffer)) 0 0)
  ;; restore hidden block headers
  (hide-lines-show-all)
  ;; expand everything when exiting the presentation
  (org-show-all))

(defun my:hide-headers ()
  "Called when starting the slideshow."
  ;; preserve org's source block faces then overide them
  (visual-line-mode -1)
  (org-tree-slide-header -1)
  (setq-local org-image-actual-width  nil)
  (setq my:org-src-block-faces org-src-block-faces)
  (setq org-src-block-faces my:org-slider-src-block-faces)
  ;; preserve then set fill-column
  (setq my:slide-fill-column-save fill-column)
  (setq fill-column my:slide-fill-column)

  ;; expressly turn off boxing and restyle background (thanks Drew)
  ;; https://stackoverflow.com/questions/19201358/how-to-get-emacs-background-color
  (let ((bg (or my:slide-background
		(face-attribute 'default :background))))
    (set-face-attribute 'header-line nil
			:height my:slide-top-margin
			:box nil
			:background bg)
    (dolist (aface '(org-code org-tree-slide-header-overlay-face))
      (merge-face-attribute aface :background bg)))

  ;; turn off the fringe
  (set-fringe-mode (cons 0 0))
  ;; use header-line for top-margin
  (setq header-line-format "")
  ;; setup margins
  (set-window-margins (get-buffer-window (current-buffer))
		      my:slide-left-margin
		      my:slide-right-margin)
  ;; hide block begin/end/attr markers
  ;; not sure why but hide-lines *really* needs
  ;; loaded each time we call this..
  (load-library "hide-lines")
  (hide-lines-matching
   ;;"#\\+\\(BEGIN\\|END\\)_\\(SRC\\|EXAMPLE\\|VERSE\\|QUOTE\\)"))
   (rx "#+" (or "begin" "end" "attr") (* nonl) "\n"))

;; help us hide the begin/end blocks
(use-package hide-lines :ensure t :demand)
(use-package org-superstar :ensure t
  :config (add-hook 'org-mode-hook  'org-superstar-mode))

(provide 'slideshow)
;;; slideshow.el ends here
