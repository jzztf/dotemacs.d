;; packages
;;----------------------------------------------------------------------------

;; set packages source
(when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
		      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; cl - Common Lisp Extension
(require 'cl)

 ;; Add Packages
(defvar jzztf/packages '(
		;; --- Auto-completion ---
		company
		;; --- Better Editor ---
		popwin
		hungry-delete
		swiper
		counsel
		smartparens
		pomidor
		org-pomodoro
		;; --- Major Mode ---
		magit
		flycheck
		py-autopep8
		elpy
		markdown-mode
		
		;; --- Themes ---
		dracula-theme
		;;monokai-theme
		powerline
		;; solarized-theme
		) "Default packages")

(setq package-selected-packages jzztf/packages)

(defun jzztf/packages-installed-p ()
     (loop for pkg in jzztf/packages
	   when (not (package-installed-p pkg)) do (return nil)
	   finally (return t)))

(unless (jzztf/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg jzztf/packages)
       (when (not (package-installed-p pkg))
	 (package-install pkg))))

;; better dired
(require 'dired-x)

;; powerline
(require 'powerline)

;; recentf
(require 'recentf)
(recentf-mode 1)
(setq recenf-max-menu-item 25)

;;dired-mode
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
(put 'dired-find-alternate-file 'disabled nil)

;; swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; smartparens
(require 'smartparens-config)
(smartparens-strict-mode t)

(setq magit-view-git-manual-method 'man)

;; better default
;;----------------------------------------------------------------------------

;;set default directory
(setq default-directory "~/")

;;automatic new line
(setq-default auto-fill-function 'do-auto-fill)
(setq fill-column 80)

;;show time in modeline
(display-time-mode 1)
(setq display-time-format "%H:%M")


;; global line number
(global-linum-mode t)

;; autoload writed file
(global-auto-revert-mode t)

;; close autosave
(setq auto-save-default nil)

;; close backup
(setq make-backup-files nil)

;;install company-mode first: "M-x" -> "package-install" -> "company"
(global-company-mode 1)

;; hippie自动补全，强化company
(setq hippie-expand-try-function-list '(try-expand-debbrev
					try-expand-debbrev-all-buffers
					try-expand-debbrev-from-kill
					try-complete-file-name-partially
					try-complete-file-name
					try-expand-all-abbrevs
					try-expand-list
					try-expand-line
					try-complete-lisp-symbol-partially
					try-complete-lisp-symbol))

;;delete-selection-mode
(delete-selection-mode 1)

;; 缩写补全,当填写缩写字符,并以“空格”结束,就会自动补全
(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ;; keybingding
					    ("8kbd" "(global-set-key (kbd \"C-\") ')")
					    ;; Shifu
					    ("8zl" "zilongshanren")
					    ;; Tudi
					    ("8lxy" "lixinyang")
					    ))

;; 延迟加载
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;;"How emacs Choose a Major Mode"
;;[[https://www.gnu.org/software/emacs/manual/html_node/elisp/Auto-Major-Mode.html]]
(setq auto-mode-alist
      (append
       '(("\\.org\\'" . org-mode)
	 ("\\.md\\'" . markdown-mode))
       auto-mode-alist))

;; hungry-delete
(require 'hungry-delete)
(global-hungry-delete-mode t)

;; auto move cursor to new window
(require 'popwin)
(popwin-mode 1)

;; close bi-bi-bi
(setq ring-bell-function 'ignore)

;; set y or n
(fset 'yes-or-no-p 'y-or-n-p)
(setq org-cycle-separator-lines t)

;; smartparens
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;;pomidor
(setq alert-default-style 'libnotify)

;;functions
;;----------------------------------------------------------------------------

;; indent
(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indent selected region."))
      (progn
	(indent-buffer)
	(message "Indent buffer.")))))

;; open-init-file
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;;keybingding
;;----------------------------------------------------------------------------

(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(global-set-key (kbd "s-/") 'hippie-expand)
(global-set-key (kbd "<f2>") 'open-init-file)
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

;;swiper
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)

;; set short key for agenda
(global-set-key (kbd "C-c a") 'org-agenda)

;; self setting
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

;;magit
(global-set-key (kbd "C-x g") 'magit-status)

;;pomidor
;; enter -> start
;; space -> break
;; Q -> quit
;; R -> reset
(global-set-key (kbd "<f12>") #'pomidor)

;;org-pomodro
(global-set-key (kbd "C-c C-p") 'org-pomodoro)


;;ui
;;----------------------------------------------------------------------------

;;take off menu bar
(menu-bar-mode -1)

;; take off tool bar
(tool-bar-mode -1)

;; take off scroll bar
;;(scroll-bar-mode -1)

;; set the font size
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 130)

;; full screen
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; hightlight line
(global-hl-line-mode 1)

;; close help screen
(setq inhibit-splash-screen 1)

;; powerline
(powerline-default-theme)

;; load-theme
;;(load-theme 'monokai t)
(load-theme 'dracula t)

;; 解决在org-mode下，编辑中文tables时无法对齐
;; Setting English Font
(set-face-attribute
'default nil :font "Consolas 11")
;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
(set-fontset-font (frame-parameter nil 'font)
charset
(font-spec :family "Microsoft Yahei" :size 16)))

;;org
;;----------------------------------------------------------------------------

;; hightlight in org source block
(require 'org)
(setq org-src-fontify-natively t)

;; set default agenda file directory
(setq org-agenda-files '("~/org"))

;;python
;;----------------------------------------------------------------------------

(elpy-enable)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-pomodoro pomodoro org-clock-today pomidor magit smartparens smart-mode-line-powerline-theme py-autopep8 popwin nodejs-repl monokai-theme markdown-mode+ hungry-delete flycheck exec-path-from-shell elpy ein counsel)))
 '(timeclock-mode-line-display t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;20181230
