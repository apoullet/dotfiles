(setq inhibit-startup-screen t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 0)

(setq-default custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-M-b") 'counsel-switch-buffer)

(use-package ivy
	     :diminish
	     :bind (("C-s" . swiper)
		    :map ivy-minibuffer-map
		    ("TAB" . ivy-alt-done)
		    ("C-l" . ivy-alt-done)
		    ("C-j" . ivy-next-line)
		    ("C-k" . ivy-previous-line)
		    :map ivy-switch-buffer-map
		    ("C-k" . ivy-previous-line)
		    ("C-l" . ivy-done)
		    ("C-d" . ivy-switch-buffer-kill)
		    :map ivy-reverse-i-search-map
		    ("C-k" . ivy-previous-line)
		    ("C-d" . ivy-reverse-i-search-kill))
	     :config
	     (ivy-mode 1))

(use-package which-key
	     :init (which-key-mode)
	     :diminish which-key-mode)

(setq which-key-idle-delay 0.1)

(use-package general
	     :config
	     (general-create-definer antoine/leader-keys
				     :keymaps '(normal insert visual emacs)
				     :prefix "SPC"
				     :global-prefix "C-SPC")

	     (antoine/leader-keys
	      "f" '(:ignore f :which-key "files")
	      "ff" '(counsel-find-file :which-key "find file")
	      "fs" '(swiper :which-key "search file")
	      "SPC" '(counsel-M-x :which-key "M-x")
	      "q" '(save-buffers-kill-terminal :which-key "quit emacs")
	      "b" '(:ignore b :which-key "buffers")
	      "bw" '(save-buffer :which-key "write buffer")
	      "bs" '(counsel-switch-buffer :which-key "switch buffer")
	      "bo" '(counsel-switch-buffer-other-window :which-key "other buffer")
	      "w" '(:ignore w :which-key "windows")
	      "wk" '(delete-window :which-key "kill current buffer")
	      "wo" '(delete-window :which-key "kill others buffer")
	      "e" '(:ignore g :which-key "elfeed")
	      "eo" '(elfeed :which-key "open elfeed")
	      "ea" '(elfeed-add-feed :which-key "add feed")))

(use-package evil
	     :init
	     (setq evil-want-C-u-scroll t)
	     (setq evil-want-C-i-jump nil)
	     :config
	     (evil-mode 1)
	     (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
	     (evil-global-set-key 'motion "j" 'evil-next-visual-line)
	     (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package all-the-icons
  :if (display-graphic-p)
  :commands all-the-icons-install-fonts
  :init
  (unless (find-font (font-spec :name "all-the-icons"))
    (all-the-icons-install-fonts t)))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package all-the-icons-ivy-rich
	     :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
	     :init (ivy-rich-mode 1))

(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

(use-package rainbow-delimiters
	     :hook (prog-mode . rainbow-delimiters-mode))

(use-package counsel
	     :bind (("M-x" . counsel-M-x)
		    ("C-x b" . counsel-ibuffer)
		    ("C-x C-f" . counsel-find-file)
		    :map minibuffer-local-map
		    ("C-r" . 'counsel-minibuffer-history))
	     :config
	     (setq ivy-initial-inputs-alist nil))

(use-package helpful
	     :custom
	     (counsel-describe-function-function #'helpful-callable)
	     (counsel-describe-variable-function #'helpful-variable)
	     :bind
	     ([remap describe-function] . counsel-describe-function)
	     ([remap describe-command] . helpful-command)
	     ([remap describe-variable] . counsel-describe-variable)
	     ([remap describe-key] . helpful-key))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "c:\\Users\\antoi\\Documents\\Projects\\Code")
    (setq projectile-project-search-path '("c:\\Users\\antoi\\Documents\\Projects\\Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit)

(use-package evil-magit
  :after magit)

(use-package base16-theme)

(load-theme 'base16-eighties t)

(set-frame-font "Input 16" nil t)

(setq-default c-basic-offset 4)

(use-package rust-mode)

(use-package lua-mode)

(use-package elfeed)

(add-to-list 'evil-emacs-state-modes 'elfeed-search-mode)
(add-to-list 'evil-emacs-state-modes 'elfeed-search-mode)

(setq elfeed-feeds
      '("https://www.tomshardware.com/feeds/all"))
