;;
;; Install straight-use-package
;;
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package '(use-package :ensure t))
(setq straight-use-package-by-default t
      use-package-always-ensure t)

(use-package doom-themes
  :config
  (load-theme 'doom-one t))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  (display-battery-mode 1))

(use-package projectile
  :config
  (setq projectile-mode-line-prefix " Proj "
        projectile-project-search-path '("/storage/src/unnsvc")
        projectile-globally-ignored-file-suffixes '(".log" ".gz" ".zip")
        projectile-enable-caching t
        projectile-completion-system 'default
        projectile-switch-project-action 'projectile-dired)
  (projectile-mode +1))

(use-package dashboard
  :config
  (setq dashboard-banner-logo-title "Welcome to Rust Emacs"
        dashboard-items '((recents . 5)
                          (projects . 5)
                          (bookmarks . 5)
                          (agenda . 5)
                          (registers . 5))
        dashboard-footer-message '("Happy hacking!")
        dashboard-set-heading-icons t
        dashboard-set-file-icons t
        dashboard-center-content t)
  (dashboard-setup-startup-hook))

(use-package orderless)

(use-package vertico
  :init
  (vertico-mode)
  :custom
  (vertico-reverse-list nil)
  (vertico-cycle t)
  (vertico-count 100)
  (vertico-resize nil)
  (vertico-history nil))

(use-package minibuffer
  :straight nil
  :after (orderless vertico)
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles . (partial-completion))))))

(use-package savehist
  :straight nil
  :config
  ;;(setq savehist-additional-variables '(vertico-sort-function
  ;;                                      vertico-recency-type))
  (savehist-mode 1))

(use-package which-key
  :config
  (which-key-mode))

(use-package menu-bar
  :straight nil
  :config
  (menu-bar-mode -1))

(use-package helpful
  :bind (("C-h f" . #'helpful-callable)
         ("C-h v" . #'helpful-variable)
         ("C-h k" . #'helpful-key)))
