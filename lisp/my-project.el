
;;; my-project.el --- ...

;; Copyright (C) 2013-2017  Klaus Kähler Holst

;; Authors: Klaus Kähler Holst <klaus@holst.it>
;; 
;; Keywords: tools

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

;;; Code:

;;{{{ faces

    ;; (custom-set-faces
  ;;  '(superman-next-project-button-face ((t (:inherit font-lock-reference-face :inverse-video nil 
  ;;                                                 :weight bold :slant italic :inverse-video nil 
  ;;                                                 :height 0.85
  ;;                                        :box (:line-width 1 :color "gray30" :style released-button)
  ;;                                                 ))) t))

  ;; (custom-set-faces
  ;;  '(superman-capture-button ((t (:background "SeaGreen4" :foreground "white smoke" :inverse-video nil :box (:line-width 2 :color "yellow" :style pressed-button) :weight bold))) t)
  ;;  '(superman-project-button ((t (:background "white smoke" :foreground "Darkblue" :inverse-video nil :box (:line-width 2 :color "orange" :style pressed-button) :weight bold))) t))




  ;; (Set-face-attribute 
  ;;  'superman-branch-button-face nil :inherit 'font-lock-comment-face 
  ;;  :inverse-video nil :slant 'normal
  ;;  :box '(:line-width 1 :color "gray30" :style 'pressed-button))
  ;; (set-face-attribute 
  ;;  'superman-branch-button nil :inherit 'font-lock-reference-face 
  ;;  :inverse-video nil :weight 'bold
  ;;  :box '(:line-width 1 :color "gray30" :style 'pressed-button))
  ;; (set-face-attribute 
  ;;  'superman-git-button nil :inherit 'font-lock-reference-face 
  ;;  :inverse-video nil :weight 'bold
  ;;  :box '(:line-width 1 :color "gray30" :style 'pressed-button))
  (face-spec-reset-face 'superman-capture-button-face nil)
  (set-face-attribute 
   'superman-capture-button-face nil :inherit 'font-lock-other-type-face 
   :inverse-video nil :weight 'bold :slant 'italic :height 0.85
   :box '(:line-width 2 :color "gray30" :style 'pressed-button))


  (face-spec-reset-face 'superman-header-button-face nil)
  (set-face-attribute 
   'superman-header-button-face nil :inherit 'font-lock-type-face 
   :inverse-video nil :weight 'bold 
   :box '(:line-width 1 :color "gray30" :style 'released-button))


  (face-spec-reset-face 'superman-free-text-face nil)
  (set-face-attribute 'superman-free-text-face nil :inherit 'font-lock-type-face :height 1.0)

  (face-spec-reset-face 'superman-project-button-face nil)
  (set-face-attribute 
   'superman-project-button-face nil :inherit 'font-lock-reference-face
   :inverse-video nil :weight 'bold :slant 'normal
   :box '(:line-width 1 :color "gray30" :style 'released-button))

  (face-spec-reset-face 'superman-next-project-button-face nil)
  (set-face-attribute 
   'superman-next-project-button-face nil :inherit 'font-lock-reference-face
   :inverse-video nil :weight 'bold :slant 'italic :inverse-video nil :height 1.0 ;;0.85
  )
  ;; :box '(:line-width 1 :color "gray30" :style 'released-button))

  (face-spec-reset-face 'superman-git-keyboard-face-d nil)
  (set-face-attribute 'superman-git-keyboard-face-d nil :inherit 'font-lock-type-face :height 1.0)

  (face-spec-reset-face 'superman-git-keyboard-face-a nil)
  (set-face-attribute 'superman-git-keyboard-face-a nil :inherit font-lock-keyword-face :height 1.0)

  (face-spec-reset-face 'superman-git-keyboard-face-l nil)
  (set-face-attribute 'superman-git-keyboard-face-l nil :inherit font-lock-constant-face :height 1.0)

  (face-spec-reset-face 'superman-git-keyboard-face-c nil)
  (set-face-attribute 'superman-git-keyboard-face-c nil :inherit font-lock-doc-face :height 1.0)

  (face-spec-reset-face 'superman-git-keyboard-face-x nil)
  (set-face-attribute 'superman-git-keyboard-face-x nil :inherit font-lock-warning-face :underline nil :height 1.0)

  (face-spec-reset-face 'superman-git-keyboard-face-r nil)
  (set-face-attribute 'superman-git-keyboard-face-r nil :inherit font-lock-comment-face :height 1.0)

  (face-spec-reset-face 'superman-git-keyboard-face-s nil)
  (set-face-attribute 'superman-git-keyboard-face-s nil :inherit font-lock-keyword-face :height 1.0)

  (face-spec-reset-face 'superman-git-keyboard-face-i nil)
  (set-face-attribute 'superman-git-keyboard-face-i nil :height 1.0)

;;}}}

;;{{{ superman misc

;;(define-key superman-view-mode-map [(control return)] 'dired-open-file)
(define-key superman-mode-map " " 'superman-switch-to-project)

;;(setq superman-unison-cmd "unison")

;; Format of the entries of the completion-list when selecting a
;; project.
(setq superman-select-project-completion-format
      "%n/%c - %o")
;; /%o/%n")
  ;; (setq superman-select-project-completion-format "%n %c -- %o")
;; (setq superman-select-project-completion-format "%n %o")


(setq superman-default-cat "Krypton")
(setq superman-project-kal-el t) ;; 

(setq superman-default-action-buttons
      ;;      '((" HelloWorld " . (lambda () (interactive) (message "Hello, World!")))
      '(
	(" Make " my/compile)
	(" New " superman-new-item)))


  ;; Use popup/tooltip for messages
  ;; (defun superman-popup-tip (msg)
  ;;   (save-excursion
  ;;     (goto-char (point-min))
  ;; ;;    (tooltip-show msg)))
  ;;     (popup-tip msg)))




   ;; (setq org-todo-keyword-faces
   ;;        (quote (("TODO" :foreground "red" :weight bold)
   ;;                ("URGENT" :foreground "goldenrod1" :weight bold)
   ;;                ("IN PROGRESS" :foreground "blue" :weight bold)
   ;;                ("ACTIVE" :foreground "red" :weight bold)
   ;;                ("WAITING" :foreground "purple" :weight bold)
   ;;                ("PERMANENT" :foreground "SkyBlue3" :weight bold)
   ;;                ("DONE" :foreground "forest green" :weight bold)
   ;;                ("CANCELED" :foreground "slate grey" :weight bold))))


   (setq org-todo-keyword-faces
          (quote (("TODO" :inherit font-lock-warning-face :weight bold)
                  ("URGENT" :inherit :font-lock-keyword-face :weight bold)
                  ("IN PROGRESS" :inherit font-lock-reference-face :weight bold)
                  ("ACTIVE" :inherit font-lock-type-face :weight bold)
                  ("WAITING" :inherit font-lock-string-face :weight bold)
                  ("PERMANENT" :foreground "SkyBlue3" :weight bold)
                  ("DONE" :foreground font-lock-stromgface :weight bold)
                  ("CANCELED" :foreground font-lock-comment-face :weight bold))))


  (setq superman-hl-line t)
  (setq superman-save-buffers nil)
  (setq superman-unison-cmd "unison -ui graphic ")
  (setq superman-google-cmd
    "export PYTHONUSERBASE=~/local/; ~/local/bin/google")

  (setq superman-select-project-summary-format "%n/%c;%o")
  (setq org-capture-bookmark t) ;; Seems to be needed ?!?
  ;;(setq superman-config "INDEX | LOCATION") ;; "INDEX | LOCATION / TIMELINE | TODO")
  ;;(setq superman-config nil)
  ;;(setq superman-default-config nil)
  (setq superman-sticky-config nil)
  ;;(setq superman-default-config "INDEX")

  (setq superman-mark-face 'font-lock-warning-face) ;;'italic )

  (setq superman-include-keywords '("ACTIVE" "URGENT" "DONE" "WAITING" "PERMANENT"))
  ;;(ignore-errors (superman-parse-projects)(superman-parse-projects))

  (superman-parse-projects)


  (add-hook 'org-mode-hook (lambda ()
                             (local-set-key (kbd "C-x c") 'superman-view-mode)))

  ;;(lambda () (interactive) (superman-goto-project-documents t)))



  (setq superman-default-project-content
  "
  ,#+BEGIN_SRC emacs-lisp :results list
  (org-directory-files \"org$\" \"export\" t nil \"time\" nil)
  ,#+END_SRC

  ,#+BEGIN_SRC emacs-lisp :results list
  (org-directory-files \"R$\" \"export\" t nil \"time\" nil)
  ,#+END_SRC

  ,#+BEGIN_SRC emacs-lisp :results list
  (org-directory-files \"pdf$\" \"export\" nil nil \"time\" nil)
  ,#+END_SRC
  ")

  (setq superman-project-directories '("analysis" "data" "export" "misc"))

;;}}}

;;{{{ deft

(use-package deft
  :ensure t
  :commands (deft)
  :bind (("<f10>" . deft)
	 (:map deft-mode-map
	  ("C-c C-g" . kill-this-buffer)
	  ("<f10>" . kill-this-buffer)))	  
  :config  
  (setq deft-directory superman-home)
  (when (require 'deft nil 'noerror) 
    (setq
     deft-extension "org"
     deft-use-filename-as-title t
     deft-text-mode 'org-mode)
    ;; (global-set-key (kbd "<f10>") 'deft)
    (add-hook 'deft-mode-hook 
	      (lambda ()
		(visual-line-mode -1)))))

(setq org-default-notes-file (concat superman-home "Notes.org"))

(setq my-superman-alist nil)
  (loop for pp in superman-project-alist do 
        (add-to-list 'my-superman-alist (superman-get-index pp)))

(defcustom my-deft-extras nil
  "Extra files to deft list"
  :type 'list
  :group 'data)
(setq my-deft-extras '((concat superman-home "Journal.org")))

(setq my-deft-extras (append my-deft-extras my-superman-alist))

(defun deft-find-all-files ()
  "Return a list of all files in the Deft directory."
  (if (file-exists-p deft-directory)
      (let (files result)
	;; List all files
	(setq files
	      (directory-files deft-directory t
			       (concat "\." deft-extension "$") t))
	(setq files (append files my-deft-extras))
	;; Filter out files that are not readable or are directories
	(dolist (file files)
	  (when (and (file-readable-p file)
		     (not (file-directory-p file)))
	    (setq result (cons file result))))
	result)
    )
  )

(defun howto ()
  (interactive)
  (switch-to-buffer "*deft-howto*")
  ;; (unless (eq major-mode 'deft-mode)
  (deft-local-setup)
  (setq deft-directory "~/Howto/")
  (setq deft-find-all-files-function 'deft-find-all-files-local)
  (setq deft-buffer (current-buffer))
  (deft-local-mode))


(defun browse-org ()
  (interactive)
  (switch-to-buffer "*deft-browse-org*")
  (deft-local-setup)
  (setq deft-directory "~/research/OkDoc/")
  (setq deft-find-all-files-function 'deft-find-all-files-local)
  (setq deft-buffer (current-buffer))
  (deft-local-mode))

;;}}}

;;{{{ publish

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; publish
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq superman-export-subdirectory "export")
(setq superman-public-directory "~/public_html/")
(setq superman-public-server-home superman-public-directory)
(superman-set-publish-alist)
(setq query-to-create nil)
(setq org-link-search-must-match-exact-headline nil)
;; (org-open-link-from-string "file:EmotationalBrain.org::*TODO")

;; (setq org-link-search-must-match-exact-headline nil)

;; (setq ibuffer-never-show-predicates nil)
;; (add-to-list 'ibuffer-never-show-predicates "^\\*")
(setq ibuffer-never-show-predicates nil)
(setq ibuffer-never-show-predicates (append ibuffer-never-show-predicates
                                            (loop for (key . value) in superman-project-alist collect (concat key ".org"))))
(add-to-list 'ibuffer-never-show-predicates "^\\*")
(add-to-list 'ibuffer-never-show-predicates "flagged.org")

;;}}}

;;{{{ agenda

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; agenda
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; The following snippet makes emacs display the agenda if emacs has
;; been idle for 10 minutes
(defun my/jump-to-org-agenda ()
  (interactive)
  (let ((buf (get-buffer "*Org Agenda*"))
	wind)
    (if buf
	(if (setq wind (get-buffer-window buf))
	    (select-window wind)
	  (if (called-interactively-p)
	      (progn
		(select-window (display-buffer buf t t))
		(org-fit-window-to-buffer)
		;; (org-agenda-redo)
		)
	    (with-selected-window (display-buffer buf)
	      (org-fit-window-to-buffer)
	      ;; (org-agenda-redo)
	      )))
      (progn
	(call-interactively 'org-agenda-list)
	)
      ;;      (push ?d unread-command-events)) ;; Day view only
      ))
  ;;(let ((buf (get-buffer "*Calendar*")))
  ;;  (unless (get-buffer-window buf)
  ;;    (org-agenda-goto-calendar)))
  )
;;(run-with-idle-timer 600 t 'my/jump-to-org-agenda) 



;;
(setq org-agenda-window-setup 'current-window)

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("URGENT" :foreground "goldenrod1" :weight bold)
	      ("IN PROGRESS" :foreground "blue" :weight bold)
	      ("ACTIVE" :foreground "red" :weight bold)
	      ("WAITING" :foreground "purple" :weight bold)
	      ("PERMANENT" :foreground "SkyBlue3" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("CANCELED" :foreground "slate grey" :weight bold)
	      ("PUBLISHED" :foreground "forest green" :weight bold)
	      ("ACCEPTED" :foreground "SkyBlue3" :weight bold)
	      ("REVISION" :foreground "goldenrod1" :weight bold)
	      ("SUBMITTED" :foreground "pale green" :weight bold)
	      ("--" :foreground "slate grey" :weight bold)
	      )))

(setq org-todo-keyword-faces
      (quote (("TODO" :inherit error :weight bold)
	      ("URGENT" :inherit font-lock-keyword-face :weight bold)
	      ("IN PROGRESS" :inherit font-lock-function-name-face :weight bold)
	      ("ACTIVE" :inherit error :weight bold)
	      ("WAITING" :inherit font-lock-doc-face :weight bold)
	      ("PERMANENT" :inherit escape-glyph :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("CANCELED" :inhert default :weight bold)
	      ("PUBLISHED" :foreground "forest green" :weight bold)
	      ("ACCEPTED" :foreground "SkyBlue3" :weight bold)
	      ("REVISION" :foreground "goldenrod1" :weight bold)
	      ("SUBMITTED" :foreground "pale green" :weight bold)
	      ("--" :foreground "slate grey" :weight bold)
	      )))



(defvar my-agenda-register
  ?b
  "The register to store the current window configuration in when
  entering my agenda.")
(defvar my-org-agenda-split-counter 0 "Counter for the split screen agenda function")
(setq my-org-agenda-split-counter 0)
(defun my/org-agenda-split ()
  "Open my custom split screen agenda"
  (interactive)
  ;; TODO: Here we should check whether we are already in the agenda split view, in which case we should do a winner-undo call instead...
  (my/org-sync)
  (if (or (eq my-org-agenda-split-counter 0) (not (or (string= (buffer-name) "*Org Agenda(N)*") (string= (buffer-name) "*Org Agenda(p)*") (string= (buffer-name) "*S-TODO*"))))
      (progn
	(org-toggle-sticky-agenda t)            
	(window-configuration-to-register my-agenda-register)
	(push ?p unread-command-events) 
	(call-interactively 'org-agenda)
	(push ?N unread-command-events)
	(call-interactively 'org-agenda)
	(setq my-org-agenda-split-counter 1)
	(delete-other-windows)
	(superman-todo)
	(let ((split-height-threshold nil))
	  (split-window-vertically))
	(other-window 1)
	(switch-to-buffer "*Org Agenda(p)*")
	(let ((split-width-threshold nil))
	  (split-window-horizontally))
	(switch-to-buffer "*Org Agenda(N)*")
	(other-window -1)
	)
    (progn
      (setq my-org-agenda-split-counter 0)
      (jump-to-register my-agenda-register)
      (if (get-buffer "*Org Agenda(N)*")
	  (kill-buffer "*Org Agenda(N)*"))
      (if (get-buffer "*Org Agenda(p)*")
	  (kill-buffer "*Org Agenda(p)*"))
      )
    (org-toggle-sticky-agenda nil)
    ))



(setq org-agenda-custom-commands nil)
(setq org-agenda-custom-commands
      '(
	;;             ("n" search "*"
	;;              ((org-agenda-files '(concat superman-home ("Notes.org")))
	;;               (org-agenda-text-search-extra-files nil)))          
	("N" "Mixed"
	 (
	  ;; (todo ""
	  ;;            ((org-agenda-overriding-header
	  ;;            "--== Tasks ==--")
	  ;;             ))
	  (search "*"
		  ((org-agenda-files `(,(concat superman-home "Notes.org")
				       ;;,(concat superman-home "flagged.org")
				       ))
		   (org-agenda-text-search-extra-files nil)
		   (org-agenda-overriding-header
		    "--== Notes ==--")
		   ))                    
	  )
	 )
	))
(add-to-list 'org-agenda-custom-commands
	     `("p" "Projects"
	       ,(mapcar #'(lambda (key)
                            (list 'todo key
                                  `((org-agenda-files '(,superman-profile))
                                    (org-agenda-overriding-header (concat ,key " Projects")))))
			'("SuperManager" "URGENT" "ACTIVE" "WAITING" "PERMANENT" "DONE" "CANCELED"))))



;; (add-to-list 'org-agenda-custom-commands
;;           `("P" "Projects"
;;             ((todo "TODO"))
;;             ,(mapcar '(lambda (cat)
;;                         (list 'todo "TODO"
;;                               `((org-agenda-overriding-header  (concat "Project category: ",(car cat)))
;;                                 (org-agenda-files (quote ,(supermanject-manager-list-projects (car cat)))))))
;;                      (supermanject-manager-parse-categories))))


(defvar org-active-list nil)
;;(setq org-active-list (list "agenda" "todo" "projects" "project-list"))
;;(setq org-active-list (list "agenda" "todo" "projects" "project-list"))
(setq org-active-list (list "todo+notes" "Project-list"))
(defun org (&optional arg)
  (interactive "p")
  (unless org-agenda-files (org-read-agenda-files))
  (if (and arg (> arg 1)) (org-agenda)
    (when (eq last-command 'org)
      (org-cycle-list))
    (message (car org-active-list))
    (cond ((string= (car org-active-list) "agenda")
	   (push ?a unread-command-events)
	   (call-interactively 'org-agenda))
	  ((string= (car org-active-list) "todo")
	   (push ?t unread-command-events)
	   (call-interactively 'org-agenda))
	  ((string= (car org-active-list) "Project-list")
	   (push ?p unread-command-events)
	   (call-interactively 'org-agenda))
	  ((string= (car org-active-list) "todo+notes")
	   (push ?N unread-command-events)
	   (call-interactively 'org-agenda))
	  ((string= (car org-active-list) "projects")
	   (superman-agenda))
	  ((string= (car org-active-list) "journal")
	   (find-file (concat superman-home "Journal.org")))
	  ((string= (car org-active-list) "project-list")
	   (superman-manager-project-home)))))

(defun org-cycle-list ()
  (interactive)
  (let ((cur (car org-active-list))
	(rest (cdr org-active-list)))
    (setq org-active-list rest)
    (add-to-list 'org-active-list cur 'append)))


;; ;;(setq org-agenda-custom-commands nil)
;; ;; (setq org-agenda-block-separator '61)
;; (setq org-agenda-custom-commands
;;      `(
;; ;;("c" "calendar"
;; ;;    ((agenda "" ((org-agenda-files '("~/Tasks.org"))))
;; ;;     (todo "TODO" ((org-agenda-files '("~/Tasks.org"))
;; ;;                   (org-agenda-block-separator '66)))))
;;      ;; ("U" "Undervisning"
;;      ;;  (todo "TODO"  ((org-agenda-files '("~/public_html/Teaching/Undervis.org")))))
;;      ;; ;; ("P" . "Project + Class") 
;;      ;; ;; ("Pm" (agenda "" (supermanject-list "Methods")))
;;      ("P" "Projects"
;;       ;; (agenda "" ((org-agenda-include-diary nil)
;;       ;; (org-agenda-files (supermanject-manager-project-list))))
;;       ,(mapcar '(lambda (cat)
;;                   (list 'todo "TODO"
;;                         `((org-agenda-block-separator ,(string-to-char (car cat)))
;;                           (org-agenda-files (quote ,(supermanject-manager-list-projects (car cat)))))))
;;                (supermanject-manager-parse-categories)))
;;      ;; ("f" "familie"
;;      ;;  ((todo "TODO" ((org-agenda-files '("~/privat/Familie.org"))))))
;;      ("t" "todo"
;;       ((alltodo)))))


(defun org-read-agenda-files ()
  (interactive)
  ;;  (setq org-agenda-files (directory-files "~/research/OkDoc" 'full org-agenda-file-regexp))
  (setq org-agenda-files (delete-dups (append `(,(concat superman-home "Tasks.org") ,(concat superman-home "Journal.org") ,(superman-index-list nil "ACTIVE") ,(superman-index-list nil "URGENT")));; 'full org-agenda-file-regexp))
	))
  ;;(add-to-list 'org-agenda-files (concat superman-home "org/tasks.org"))
  )
;;(org-read-agenda-files)

(setq org-agenda-files (delete-dups (append `(,(concat superman-home "Tasks.org") ,(concat superman-home "Journal.org")) ;;(superman-index-list nil "ACTIVE") (superman-index-list nil "URGENT"
			       (superman-index-list))))
;;(add-to-list 'org-agenda-files (concat superman-home "org/tasks.org"))

;; (setq org-agenda-files (delq nil (loop for x in org-agenda-files
;;       collect (if (string-match "\.org$" x) x nil))))

;; (setq org-agenda-files (
;;                      loop for x in org-agenda-files
;;                           when (string-match "\.org$" x)
;;                           collect x))
;;(message (car org-agenda-files))

;;}}}

;;{{{ org sync

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; mobileorg
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;;Temporarily disable org-mobile
  ;; (setq org-mobile-directory "~/Dropbox/MobileOrg.DISABLED")
  ;; (if (file-exists-p org-mobile-directory) (progn
  ;; ;; (setq org-mobile-files (quote (org-agenda-files "~/Journal.org")))
  ;; (setq org-mobile-files '((concat superman-home "Tasks.org") (concat superman-home "Journal.org") (concat superman-home "flagged.org")))
  ;; ;;(setq org-mobile-files-exclude-regexp "Tasks.org")
  ;; (setq org-mobile-directory "~/Dropbox/MobileOrg")
  ;; ;; Set to the name of the file where new notes will be stored
  ;; (setq org-mobile-inbox-for-pull (concat superman-home "flagged.org"))
  ;; ;; Set to <your Dropbox root directory>/MobileOrg
  ;; ;; (org-mobile-pull)
  ;; ;; (add-hook 'after-init-hook 'org-mobile-pull)
  ;; ;; (add-hook 'kill-emacs-hook 'org-mobile-push)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; mobileorg
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my/org-sync()
  (interactive)
  (save-window-excursion
    (let ((org-agenda-old org-agenda-files))
      ;;(setq org-agenda-files (delete (concat superman-home "org/tasks.org") org-agenda-files))
      (setq org-agenda-files (delete-dups org-agenda-files))
      (org-toggle-sticky-agenda t)            
      (window-configuration-to-register my-agenda-register)
      (push ?t unread-command-events) 
      (call-interactively 'org-agenda)      
      (org-agenda-write (concat superman-home "agenda.org") nil nil (current-buffer))
      (org-agenda-quit)
      (setq org-agenda-file org-agenda-old)
;;      (async-shell-command (concat my/emacshome "../scripts/gitsync 1"))
			   )))
    

;;(add-hook 'after-init-hook 'org-mobile-pull)
;; Disable for now...
;;(add-hook 'kill-emacs-hook 'my/org-sync)

;;}}}

(provide 'my-project)

;; Local Variables:
;;   mode: emacs-lisp
;;   outline-regexp: "^;;;_\([,. ]+\)"
;; End:

;;; my-project.el ends here
