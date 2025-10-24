;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a "Module Index" link where you'll find
;;      a comprehensive list of Doom's modules and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).



(doom! :input
      
       :completion
       (corfu  ; complete with cap(f), cape and a flying feather!
        +orderless)
       (vertico           ; the search engine of the future
        +childframe
        +icons)
       
       :ui
       deft              ; notational velocity for Emacs
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       ;;fill-column       ; a `fill-column' indicator
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       indent-guides     ; highlighted indent columns
       modeline          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink cursor line after big motions
       ophints           ; highlight the region an operation acts on
       unicode         ; extended unicode support for various languages
       (vc-gutter +pretty) ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       ;; (window-select ; visually switch windows
        ;; +switch-window)
       workspaces        ; tab emulation, persistence & separate workspaces

       :editor
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       snippets          ; my elves. They type so I don't have to
       ;;word-wrap         ; soft wrapping with language-aware indent
       (whitespace +guess +trim)  ; a butler for your whitespace

       :emacs
       dired             ; making dired pretty [functional]
       ;; +icons
       ;;+ranger))
       electric          ; smarter, keyword-based electric-indent
       ;;ibuffer         ; interactive buffer management
       tramp             ; remote files at your arthritic fingertips
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       vterm             ; the best terminal emulation in Emacs

       :checkers
       syntax              ; tasing you for every semicolon you forget
       (spell             ; tasing you for misspelling mispelling
        +hunspell
        +flyspell        ; flyspell instead of fuspell
        )
       grammar           ; tasing grammar mistake every you make

       :tools   
       ;;ansible
       ;;debugger          ; FIXME stepping through code, to help you add bugs
       biblio            ; Writes a PhD for you (citation needed)
       ;;collab            ; buffers with friends
       ;;direnv
       docker
       editorconfig      ; let someone else argue about tabs vs spaces
       (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation
       (lsp
        +eglot
        )
       magit             ; a git porcelain for Emacs
       make              ; run make tasks from Emacs
       pdf               ; pdf enhancements
       ;;rgb               ; creating color strings
       ;;terraform         ; infrastructure as code
       ;;tmux              ; an API for interacting with tmux
       ;;upload            ; map local to remote projects via ssh/ftp
       tree-sitter       ; syntax and parsing, sitting in a tree...

       :os      
       (:if (featurep :system 'macos) macos)
       tty               ; improve the terminal Emacs experience

       :lang    
       (cc                ; C/C++/Obj-C madness
	+lsp)
       data              ; config/data formats
       elm               ; care for a cup of TEA?
       emacs-lisp        ; drown in parentheses
       (ess               ; emacs speaks statistics
        ;;+stan
        +tree-sitter
        +lintr
        +lsp
       )
       (julia             ; a better, faster MATLAB
        +lsp)
       (latex             ; writing papers in Emacs has never been so fun
	+cdlatex
	+fold
        ;;+latexmk
        )
       markdown          ; writing docs for people to ignore
       ;;nix               ; I hereby declare "nix geht mehr!"
       (org               ; organize your plain life in plain text
        +pretty
	+hugo
        +noter
	+present
	+roam2
        +pandoc            ; export-with-pandoc support
        )
       (python
        ;; +pyenv             ; Python virtual environment support
	;;+poetry            ; Python packaging, dependency management, and virtual environment
        +lsp
        +tree-sitter
        ;;+pyright
        )
       (sh                ; she sells {ba,z,fi}sh shells on the C xor
        +zsh)
       ;;terra             ; Earth and Moon in alignment for performance.
       yaml              ; JSON, but readable


       :email
       ;;(mu4e +org +gmail)

       :app

       :config
       ;; For literate config users. This will tangle+compile a config.org
       ;; literate config in your `doom-private-dir' whenever it changes.
       literate

       ;; The default module set reasonable defaults for Emacs. It also provides
       ;; a Spacemacs-inspired keybinding scheme, a custom yasnippet library,
       ;; and additional ex commands for evil-mode. Use it as a reference for
       ;; your own modules.
       (default +bindings
	 +smartparens)
            
       )

