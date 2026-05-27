;;; local_post.el -*- lexical-binding: t; -*-


(defun my/ess-run-loadall ()
         (interactive)
         (ess-eval-linewise "devtools::load_all()"))


;; go to definitions
(defun find-definition-with-prompt ()
  (interactive)
  (call-interactively #'xref-find-definitions))

(global-set-key (kbd "C-c d") #'find-definition-with-prompt)

;; Workaround for languageserver (<=0.3.18) bug where workspace/symbol
;; responses return bare relative paths like "R/cate.R" instead of
;; proper "file:///project/root/R/cate.R" URIs. eglot-uri-to-path
;; falls through on non-file:// URIs, returning the bare path, which
;; expand-file-name then resolves against "/" producing "/R/cate.R".
;; This advice detects that case and prepends the eglot project root.
(defun my/eglot-uri-to-path-fix (orig uri)
  (let ((result (funcall orig uri)))
    (if (and result
             (not (file-exists-p result))
             (not (string-prefix-p "file://" (or uri ""))))
        (let* ((server (eglot-current-server))
               (root (and server (project-root (eglot--project server)))))
          (if root
              (let ((candidate (expand-file-name result root)))
                (if (file-exists-p candidate) candidate result))
            result))
      result)))

(with-eval-after-load 'eglot
  (advice-add 'eglot-uri-to-path :around #'my/eglot-uri-to-path-fix))

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

(map! :leader "m" #'cdlatex-lr-pair)
