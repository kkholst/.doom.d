;;; my-org-capture.el --- ...

;; Copyright (C) 2034  Klaus Kähler Holst

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



;; https://orgmode.org/manual/Template-expansion.html
;; http://doc.norang.ca/org-mode.html#Capture

(setq org-capture-templates
      `(


("t" "Personal todo" entry (file+headline +org-capture-todo-file "Inbox") "* [ ] %?
%i
%a"
  :prepend t)

("n" "Personal notes" entry (file+headline +org-capture-notes-file "Inbox") "* %u %?
%c
%i
%a"
 :prepend t)

("j" "Journal" entry (file+olp+datetree +org-capture-journal-file) "* %U %?
%i
%a
"
 :prepend t :time-prompt t :clock-in t :clock-resume t
 :after-finalize org-clock-out
 ) ;; :immediate-finish t)

("c" "Clipboard" entry (file+headline +org-capture-notes-file "Inbox")
  "* %(org-cliplink-capture)\n%? %A")

("b" "Bookmark" entry (file+headline "bookmarks.org" "Inbox")
  "* %i%A")

("s" "Code Snippet" entry (file+headline ,(concat my/snippets "Snippets.org") "New snippets")
	"* %^{topic} %^g
#+BEGIN_SRC %^{language}
%?
#+END_SRC"
 :prepend t :jump-to-captured t)


;;  ("p" "Templates for projects") ("pt" "Project-local todo" entry
;;                                  (file+headline +org-capture-project-todo-file
;;                                                 "Inbox")
;;                                  "* TODO %?
;; %i
;; %a"
;;  :prepend t)

;;  ("pn" "Project-local notes" entry
;;   (file+headline +org-capture-project-notes-file "Inbox") "* %U %?
;; %i
;; %a"
;;   :prepend t)

;;  ("pc" "Project-local changelog" entry
;;   (file+headline +org-capture-project-changelog-file "Unreleased") "* %U %?
;; %i
;; %a"
;;   :prepend t)

 ("p" "Project templates")
 ("pt" "Project todo" entry
                                             #'+org-capture-central-project-todo-file
                                             "* TODO %?
 %i
 %a"
                                             :heading "Tasks" :prepend nil)
 ("pn" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?
 %i
 %a"
  :heading "Notes" :prepend t)
 ("pc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?
 %i
 %a"
  :heading "Changelog" :prepend t)

("k" "Templates for consultancy")
	("kt" "Telefontid" entry (file+olp+datetree ,(concat org-directory "journal.org"))
	 "** %^{Heading} :telefontid:\n:PROPERTIES:\n:Date: %T\n:Type: telefontid\n:Effort: 0\n:END:\n %? \n"
	 :prepend t :jump-to-captured t)
	("kn" "Cimbi/NRU" entry (file+olp+datetree ,(concat org-directory "journal.org"))
	 "** %^{Heading} :konsulent:\n:PROPERTIES:\n:Date: %T\n:Type: cimbi\n:Effort: 0\n:END:\n %? \n"
	 :prepend t :jump-to-captured t)
	("kk" "Konsulent" entry (file+olp+datetree ,(concat org-directory "journal.org"))
	 "** %^{Heading} :konsulent:\n:PROPERTIES:\n:Date: %T\n:Type: konsulent\n:Effort: 0\n:END:\n %? \n"
	 :prepend t :jump-to-captured t)

))

;;(global-set-key (kbd "C-c c") 'org-capture)


(provide 'my-org-capture)

;; Local Variables:
;;   mode: emacs-lisp
;;   outline-regexp: "^;;;_\([,. ]+\)"
;; End:

;;; my-org-capture.el ends here
