;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

(add-load-path! "lisp")
;;(package! f)
;;(package! dash)
;;(package! pkg-info)
;;(package! epl)
;;(unpin! org-roam)
;;(package! docker-tramp)
(package! org-roam-ui)
(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))
(package! websocket)
(package! async-await)
(package! emacs-aichat
  :recipe (:host github :repo "xhcoding/emacs-aichat" :files ("*.el" "snippets/")))
  ;; :recipe (:host github :repo "https://github.com/xhcoding/emacs-aichat.git"))
(package! dired+)
;; (package! emacs-jupyter
  ;; :recipe (:host github :repo "nnicandro/emacs-jupyter"))
(package! jupyter)
(package! peep-dired)
(package! dired-ranger)
(package! dired-narrow)
(package! comment-dwim-2)
(package! google-translate)
;;(package! ivy-yasnippet)
;;(package! counsel-dash)
(package! flycheck-google-cpplint)
(package! flycheck-clang-analyzer)
;; (package! processing-mode)
(package! platformio-mode)
(package! org-fragtog)
;;(package! org-ref)
;;(package! ebib)
(package! ox-tufte)
;; (package! helm)
;; (package! helm-ag)
;; (package! helm-flycheck)
;; (package! helm-bibtex)
;; (package! helm-c-yasnippet)
;;(package! helm-org-rifle)
;;(package! hippie-exp)
;;(package! ace-jump-mode)
;;(package! langtool)
;;(package! ivy-bibtex)
(package! texfrag)
(package! superman
  :recipe (:host github :repo "tagteam/superman"))
(unpin! org-noter)
(package! org-noter
  :recipe (:host github :repo "petermao/org-noter"))
;;(package! org-project-capture)
;;(package! org-projectile)
(package! org-project
  :recipe (:host github :repo "delehef/org-project"))

;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))k


;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
