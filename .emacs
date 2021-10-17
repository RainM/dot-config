(message "START: config load")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;General GUI settings;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq auto-save-list-file-prefix nil)

(setq inhibit-splash-screen   t)
(setq ingibit-startup-message t)
(setq scroll-step 3)
(set-default 'truncate-lines t)
(setq display-time-24hr-format t)
(display-time-mode	       t)
(size-indication-mode	       nil)

(menu-bar-mode -1) ; disable benu bar at all
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setup MELPA packages ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)

;(package-refresh-contents)
(setq auto-install-packages
      '(color-theme-modern undo-tree nlinum-hl solidity-mode))
(dolist (pkg auto-install-packages)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; IDO MODE
(require 'ido)
(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point t
      ido-max-prospects 10)
(setq ido-save-directory-list-file nil)


(require 'undo-tree)
( global-undo-tree-mode )

(require 'color-theme-modern)
(load-theme 'calm-forest t t)
(enable-theme 'calm-forest)

(require 'nlinum-hl)

(setq whitespace-style '(face tabs lines emptytab-mark))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hotkeys ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key "\M-l" 'goto-line) ;
(global-set-key "\M-h" 'highlight-phrase);

(global-set-key (kbd "ESC <down>") 'sm/next-10-lines)
(global-set-key (kbd "<M-down>") 'sm/next-10-lines)
(global-set-key (kbd "ESC <up>") 'sm/prev-10-lines)
(global-set-key (kbd "<M-up>") 'sm/prev-10-lines)

(defun sm/next-10-lines
    () (interactive)
    (next-line 10))

(defun sm/prev-10-lines
    () (interactive)
    (previous-line 10))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;CYRILLIC;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun cfg:reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key local-function-key-map
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))
    (when input-method
      (activate-input-method current))))

(cfg:reverse-input-method 'russian-computer)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;ORG MODE;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(require 'org-install)
;(org-time-stamp-custom-formats (quote ("<%d.%m.%Y>" . "<%Y-%m-%d %H:%M>")))
(setq org-log-done t)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(fset 'yes-or-no-p 'y-or-n-p)
(setq org-directory "~/Developer/org")
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
	      ("BLOCKED" ("BLOCKED" . t))
	      ("HOLD" ("BLOCKED") ("HOLD" . t))
	      (done ("BLOCKED") ("HOLD"))
	      ("TODO" ("BLOCKED") ("CANCELLED") ("HOLD"))
	      ("MEETING" ("CANCELLED") ("HOLD"))
	      ("DONE" ("BLOCKED") ("CANCELLED") ("HOLD")))))
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("MEETING" :foreground "blue" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("BLOCKED" :foreground "orange" :weight bold)
	      ("HOLD" :foreground "magenta" :weight bold)
	      ("CANCELLED" :foreground "forest green" :weight bold))))
(setq org-log-done (quote time))
(setq org-log-into-drawer t)
(setq org-log-state-notes-insert-after-drawers nil)
(setq org-agenda-files (file-expand-wildcards "~/org_notes/*.org"))

(setq org-todo-keywords
      '(
	(sequence "TODO" "BLOCKED" "HOLD" "MEETING" "|" "DONE" "CANCELLED")
	)
      )
(setq org-tag-alist
      '(
	("HOME" . ?h)
	("CODING" . ?c)
	("WRITING" . ?w)
	("FUN" . ?f)
	("MD" . ?m)
	("YANDEX" . ?y)
	("INTEL" . ?i)
	("RAFIK" . ?r)
	("FREELANCE" . ?f)
	("MIREA")
	("REPORT" . ?r)
	)
      )



(message "DONE: config load")
