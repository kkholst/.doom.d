;;; local.el -*- lexical-binding: t; -*-

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
