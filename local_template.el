;;; local.el -*- lexical-binding: t; -*-


;; (setq my/font "LiterationMono Nerd Font Propo")
;; (setq! doom-font (font-spec :family my/font :size 16) ;; :weight 'light)
;;        doom-variable-pitch-font (font-spec :family my/font :size 16)
;;        doom-unicode-font (font-spec :family my/font :size 16)
;;        doom-big-font (font-spec :family my/font :size 20))

(setq! doom-font (font-spec :family "FiraCode Nerd Font" :size 16) ;; :weight 'light)
       doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font" :size 16)
       doom-unicode-font (font-spec :family "FiraCode Nerd Font" :size 16)
       doom-big-font (font-spec :family "FiraCode Nerd Font" :size 20))

(setq user-full-name "Klaus Kähler Holst"
      user-mail-address "klaus@holst.it")
(setq org-crypt-key "3249D6A2848986C7EE3B7CBD606357DB6D474C95")
(setq my/homepage "http://www.holst.it")
(setq my/project-home "~/Projects/")

(setq doom-theme 'doom-oksolar-dark-padded-modeline)
(setq +doom-dashboard-banner-file (expand-file-name "fine_background.jpg" "~/Pictures/this is fine/"))

(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
     (c++ "https://github.com/tree-sitter/tree-sitter-cpp")
     (c "https://github.com/tree-sitter/tree-sitter-c")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))
