(defun sanityinc/utf8-locale-p (v)
  "Return whether locale string V relates to a UTF-8 locale."
  (and v (string-match "UTF-8" v)))

(defun sanityinc/locale-is-utf8-p ()
  "Return t iff the \"locale\" command or environment variables prefer UTF-8."
  (or (sanityinc/utf8-locale-p (and (executable-find "locale") (shell-command-to-string "locale")))
      (sanityinc/utf8-locale-p (getenv "LC_ALL"))
      (sanityinc/utf8-locale-p (getenv "LC_CTYPE"))
      (sanityinc/utf8-locale-p (getenv "LANG"))))

(when (or window-system (sanityinc/locale-is-utf8-p))
  (set-language-environment 'utf-8)
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-selection-coding-system (if (eq system-type 'windows-nt) 'utf-16-le 'utf-8))
  (prefer-coding-system 'utf-8))

(defun my/markdown-preview-file ()
  "use Marked 2 to preview the current file"
  (interactive)
  (shell-command
   (format "open -a 'Marked 2.app' %s"
           (shell-quote-argument (buffer-file-name)))))
(global-set-key "\C-cm" 'my/markdown-preview-file)

(require 'evil)

(custom-set-variables
 '(markdown-command "/usr/local/bin/pandoc"))
(provide 'init-locales)

(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

(setq org-agenda-files (list "~/Dropbox/org-mode/work.org" "~/Dropbox/org-mode/home.org"))

(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))
