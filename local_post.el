;;; local_post.el -*- lexical-binding: t; -*-


(defun my/ess-run-loadall ()
         (interactive)
         (ess-eval-linewise "devtools::load_all()"))


;; go to definitions
(defun find-definition-with-prompt ()
  (interactive)
  (call-interactively #'xref-find-definitions))

(global-set-key (kbd "C-c d") #'find-definition-with-prompt)

(map! :leader "L" #'my/ess-run-loadall)

(map! :leader "R" #'my/split-ess)

(map! "C-<left>" #'windmove-left)
(map! "C-<right>" #'windmove-right)
(map! "C-<up>" #'windmove-up)
(map! "C-<down>" #'windmove-down)

(global-set-key [M-right] 'forward-word)
(global-set-key [M-left] 'backward-word)
(global-set-key [M-up] 'backward-paragraph)
(global-set-key [M-down] 'forward-paragraph)

(after! corfu ;; avoid RET may accidentally commit an automatically selected candidate
  (keymap-unset corfu-map "RET")
  )
