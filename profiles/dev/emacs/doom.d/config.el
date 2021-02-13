;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ahmet Cemal Özgezer"
      user-mail-address "ahmet.ozgezer@andasis.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (when (equal system-type 'gnu/linux)
;;   (setq doom-font (font-spec :family "Iosevka" :size 14)
;;         doom-variable-pitch-font (font-spec :family "Ubuntu Nerd Font" :size 14)))
;; (when (equal system-type 'darwin)
;;   (setq doom-font (font-spec :family "Menlo" :size 14)
;;         doom-variable-pitch-font (font-spec :family "Menlo" :size 14)))
;; (when (equal system-type 'windows-nt)
;;   (setq doom-font (font-spec :family "InputMono" :size 18)
;;         doom-big-font (font-spec :family "InputMono" :size 22)))
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 13)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'modus-operandi)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")
(setq org-noter-notes-search-path '("~/Documents/org/notes/"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(when (window-system)
  (add-to-list 'default-frame-alist '(alpha . (100)))
  (set-frame-parameter (selected-frame) 'alpha '(100)))

(set-popup-rules! '(("^\\*Customize.*" :slot 2 :side right :modeline nil :select t :quit t)
                    (" \\*undo-tree\\*" :slot 2 :side left :size 20 :modeline nil :select t :quit t)
                    ("^\\*Password-Store" :side left :size 0.25)

                    ;; * help
                    ("^\\*info.*" :size 82 :side right :ttl t :select t :quit t)
                    ("^\\*Man.*" :size 82 :side right :ttl t :select t :quit t)
                    ("^\\*tldr\\*" :size 82 :side right :select t :quit t)
                    ("^\\*helpful.*" :size 82 :side right :select t :quit t)
                    ("^\\*Help.*" :size 82 :height 0.6 :side right :select t :quit t)
                    ("^ \\*Metahelp.*" :size 82 :side right :select t :quit t)
                    ("^\\*Apropos.*" :size 82 :height 0.6 :side right :select t :quit t)
                    ("^\\*Messages\\*" :vslot -10 :height 10 :side 'bottom :select t :quit t :ttl nil)

                    ;; ("^ ?\\*NeoTree" :side ,neo-window-position :width ,neo-window-width :quit 'current :select t)
                    ("\\*VC-history\\*" :slot 2 :side right :size 82 :modeline nil :select t :quit t)

                    ;; * web
                    ("^\\*eww.*" :size 82 :side right :select t :quit t)
                    ("\\*xwidget" :side right :size 100 :select t)

                    ;; * lang
                    ;; ** python
                    ("^\\*Anaconda\\*" :side right :size 82 :quit t :ttl t)
                    ))

(after! ivy-posframe
  (setq ivy-posframe-border-width 3))

(setq-default
 delete-by-moving-to-trash t)

(windmove-default-keybindings 'control)
(windswap-default-keybindings 'control 'shift)

; Each path is relative to `+mu4e-mu4e-mail-path', which is ~/.mail by default
(after! mu4e
  (set-email-account! "yahoo"
                      '((mu4e-sent-folder       . "/Yahoo/Sent")
                        (mu4e-drafts-folder     . "/Yahoo/Draft")
                        (mu4e-trash-folder      . "/Yahoo/Trash")
                        (mu4e-refile-folder     . "/Yahoo/Archive")
                        (smtpmail-smtp-user     . "ozgezer@yahoo.com")
                        (mu4e-compose-signature . "---\nAhmet Cemal Özgezer")))
  (set-email-account! "gmail"
                      '((mu4e-sent-folder       . "/Gmail/[Gmail]/Sent Mail")
                        (mu4e-drafts-folder     . "/Gmail/[Gmail]/Drafts")
                        (mu4e-trash-folder      . "/Gmail/[Gmail]/Trash")
                        (mu4e-refile-folder     . "/Gmail/[Gmail]/Archive")
                        (smtpmail-smtp-user     . "ozgezer@gmail.com")
                        (mu4e-compose-signature . "---\nAhmet Cemal Özgezer")))
  (set-email-account! "msn"
                      '((mu4e-sent-folder       . "/MSN/Sent")
                        (mu4e-drafts-folder     . "/MSN/Drafts")
                        (mu4e-trash-folder      . "/MSN/Deleted")
                        (mu4e-refile-folder     . "/MSN/Archive")
                        (smtpmail-smtp-user     . "ozgezer@msn.com")
                        (mu4e-compose-signature . "---\nAhmet Cemal Özgezer")))
  (set-email-account! "andasis"
                      '((mu4e-sent-folder       . "/Andasis/Sent Items")
                        (mu4e-drafts-folder     . "/Andasis/Drafts")
                        (mu4e-trash-folder      . "/Andasis/Trash")
                        (mu4e-refile-folder     . "/Andasis/Archives")
                        (smtpmail-smtp-user     . "ahmet.ozgezer@andasis.com")
                        (mu4e-compose-signature . "---\nAhmet Cemal Özgezer"))
                      t))

(after! ccls
  (setq ccls-initialization-options `(:index (:comments 2)
                                      :completion (:detailedLabel t)
                                      :cache (:directory ,(file-truename "~/.cache/ccls")))))

(setq calendar-location-name "Istanbul, Turkey"
      calendar-latitude 41.168602
      calendar-longitude 29.047024)

;;; :ui doom-dashboard
(setq fancy-splash-image (concat doom-private-dir "splash.png"))

(map! "M-c" #'capitalize-dwim
      "M-l" #'downcase-dwim
      "M-u" #'upcase-dwim)

;; (setq spacemacs-path doom-modules-dir)
;; (load! (concat spacemacs-path "spacemacs/+spacemacs"))

;; (setq comp-deferred-compilation t)

(custom-set-faces!
  '(aw-leading-char-face
    :foreground "white" :background "red"
    :weight bold :height 2.5 :box (:line-width 10 :color "red")))

(use-package! avy
  :init
  (setq avy-all-windows t))

(use-package! beginend :defer t
  :init (beginend-global-mode))

(use-package! daemons
  :config
  ;; (setq daemons-always-sudo t)
  )

;;
;; Dired
;;
;; Hook up dired-x global bindings without loading it up-front
(define-key ctl-x-map "\C-j" 'dired-jump)
(define-key ctl-x-4-map "\C-j" 'dired-jump-other-window)

(setq dired-hide-details-hide-symlink-targets t)
(add-hook! dired-mode
  (dired-hide-details-mode 1)
  ;; (dired-show-readme-mode 1)
  )

(use-package! dired-subtree
  :after dired
  :config
  (defadvice dired-subtree-toggle (after dired-icons-refresh ())
    "Insert an empty line when moving up from the top line."
      (revert-buffer))
  (ad-activate 'dired-subtree-toggle)

  (map!
   (:map dired-mode-map
    :desc "Toggle subtree" :n [tab] #'dired-subtree-toggle)))

(after! dired
  ;; Define localleader bindings
  (map!
   ;; Define or redefine dired bindings
   (:map dired-mode-map
     :desc "Up" :n "<left>" #'dired-up-directory
     :desc "Down" :n "<right>" #'dired-find-file)))

(use-package! docker-tramp)
(use-package! docker)

(use-package! edit-server
  :if (daemonp)
  :defer 10
  :config
  (setq edit-server-new-frame nil)
  (setq edit-server-url-major-mode-alist
        '(("reddit\\.com" . markdown-mode)
          ("github\\.com" . gfm-mode)
          ("gitlab\\.com" . gfm-mode)
          ("gitlab\\.paesslergmbh\\.de" . gfm-mode)
          ("lab\\.ebenefuenf\\.com" . gfm-mode)
          ("jira.paesslergmbh.de" . jira-markup-mode)))
  (edit-server-start))

(use-package! highlight-parentheses
  :init
  (add-hook 'prog-mode-hook #'highlight-parentheses-mode)
  (setq highlight-parentheses-delay 0.2)
  :config
  (set-face-attribute 'hl-paren-face nil :weight 'ultra-bold))

(use-package! journalctl-mode)

(after! lsp-go
  (lsp-register-custom-settings
   '(("gopls.experimentalWorkspaceModule" t t))))

(use-package! lsp-mode
  :config
  (setq lsp-headerline-breadcrumb-enable t
        ;; lsp-lens-enable t
        ;; lsp-enable-file-watchers t
        ;; lsp-signature-auto-activate nil
        ;; lsp-completion-use-last-result nil
        ))

(add-hook! ('magit-mode-hook 'text-mode-hook 'prog-mode-hook)
           (defun acml/set-fringe-widths ()
             (setq-local left-fringe-width 8
                         right-fringe-width 8)))

;;; :tools magit
(setq magit-repository-directories '(("~/Projects" . 2))
      magit-save-repository-buffers nil
      ;; Don't restore the wconf after quitting magit, it's jarring
      magit-inhibit-save-previous-winconf t
      transient-values '((magit-rebase "--autosquash")
                         (magit-pull "--rebase")))

(use-package! turkish
  :commands (turkish-mode)
  ;; :init (evil-leader/set-key (kbd "ot") 'turkish-mode)
  )

(after! counsel-projectile
  (setq counsel-projectile-switch-project-action 'counsel-projectile-switch-project-action-dired))

(after! projectile
  (setq projectile-switch-project-action 'projectile-dired
        projectile-enable-caching t
        projectile-project-search-path '("~/Projects/")
        ;; Follow suggestion to reorder root functions to find the .projectile file
        ;; https://old.reddit.com/r/emacs/comments/920psp/projectile_ignoring_projectile_files/
        ;; projectile-project-root-files-functions #'(projectile-root-top-down
        ;;                                            projectile-root-top-down-recurring
        ;;                                            projectile-root-bottom-up
        ;;                                            projectile-root-local)
        )
  (projectile-register-project-type
   'gimsa '("build.sh")
   :compile "./build.sh"
   :compilation-dir ".")
  (projectile-register-project-type
   'linux '("COPYING" "CREDITS" "Kbuild" "Kconfig" "MAINTAINERS" "Makefile" "README")
   :compile "make O=am43xx_evm ARCH=arm CROSS_COMPILE=arm-openwrt-linux-gnueabi- all"
   :compilation-dir ".")
  (projectile-register-project-type
   'openwrt '("BSDmakefile" "Config.in" "feeds.conf.default" "LICENSE" "Makefile" "README" "rules.mk" "version.date")
   :compile "make world"
   :compilation-dir ".")
  (projectile-register-project-type
   'u-boot '("config.mk" "Kbuild" "Kconfig" "MAINTAINERS" "MAKEALL" "Makefile" "README" "snapshot.commit")
   :compile "make O=am43xx_evm ARCH=arm CROSS_COMPILE=arm-openwrt-linux-gnueabi- all"
   :compilation-dir "."))

(use-package! modus-themes
  :init
  ;; Set customization options to values of your choice
  (setq modus-themes-slanted-constructs t
        modus-themes-bold-constructs t
        modus-themes-fringes nil ; {nil,'subtle,'intense}

        ;; Options for `modus-themes-lang-checkers': nil,
        ;; 'straight-underline, 'subtle-foreground,
        ;; 'subtle-foreground-straight-underline, 'intense-foreground,
        ;; 'intense-foreground-straight-underline, 'colored-background
        modus-themes-lang-checkers 'straight-underline

        ;; Options for `modus-themes-mode-line': nil, '3d, 'moody,
        ;; 'borderless, 'borderless-3d, 'borderless-moody
        modus-themes-mode-line 'borderless-3d

        ;; Options for `modus-themes-syntax': nil, 'faint,
        ;; 'yellow-comments, 'green-strings,
        ;; 'yellow-comments-green-strings, 'alt-syntax,
        ;; 'alt-syntax-yellow-comments
        modus-themes-syntax 'faint

        modus-themes-intense-hl-line nil
        modus-themes-subtle-line-numbers nil
        modus-themes-paren-match 'subtle-bold ; {nil,'subtle-bold,'intense,'intense-bold}

        ;; Options for `modus-themes-links': nil, 'faint,
        ;; 'neutral-underline, 'faint-neutral-underline, 'no-underline,
        ;; 'underline-only
        modus-themes-links 'no-underline

        modus-themes-no-mixed-fonts nil

        ;; Options for `modus-themes-prompts': nil, 'subtle-accented,
        ;; 'intense-accented, 'subtle-gray, 'intense-gray
        modus-themes-prompts 'subtle-accented

        modus-themes-completions 'opinionated ; {nil,'moderate,'opinionated}
        modus-themes-region 'bg-only-no-extend ; {nil,'no-extend,'bg-only,'bg-only-no-extend}
        modus-themes-diffs 'desaturated ; {nil,'desaturated,'fg-only,'bg-only}
        modus-themes-org-blocks nil ; {nil,'grayscale,'rainbow}
        modus-themes-org-habit nil ; {nil,'simplified,'traffic-light}

        modus-themes-headings ; Lots of options---continue reading the manual
        '((1 . section)
          (2 . section-no-bold)
          (3 . rainbow-line)
          (t . rainbow-line-no-bold))

        modus-themes-variable-pitch-ui t
        modus-themes-variable-pitch-headings t
        modus-themes-scale-headings t
        modus-themes-scale-1 1.1
        modus-themes-scale-2 1.15
        modus-themes-scale-3 1.21
        modus-themes-scale-4 1.27
        modus-themes-scale-5 1.33)

  ;; Load the theme files before enabling a theme
  ;; (modus-themes-load-themes)

  :config
  ;; Load the theme of your choice
  ;; (modus-themes-load-operandi)
  ;; ;; OR
  ;; (load-theme 'modus-operandi t)
  :bind ("<f5>" . modus-themes-toggle))

(use-package! rainbow-mode
  :hook
  ((prog-mode . rainbow-mode)
   (org-mode . rainbow-mode)))

;; (use-package! shrface)

(use-package! trashed
  :config
  (add-to-list 'evil-emacs-state-modes 'trashed-mode))

(use-package! treemacs
  :config
  (setq treemacs-collapse-dirs (if (executable-find "python") 3 0)
        treemacs-eldoc-display t
        treemacs-is-never-other-window t
        treemacs-recenter-after-file-follow t
        treemacs-recenter-after-project-expand 'on-distance
        treemacs-show-hidden-files t
        treemacs-silent-filewatch t
        treemacs-silent-refresh t
        treemacs-sorting 'alphabetic-asc
        treemacs-user-mode-line-format 'none
        treemacs-width 40
        treemacs-follow-after-init t)

  ;; set the correct python3 executable path. This is needed for
  ;; treemacs-git-mode extended
  (setq treemacs-python-executable (executable-find "python"))

  ;; highlight current line in fringe for treemacs window
  (treemacs-fringe-indicator-mode)

  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)

  (pcase (cons (not (null (executable-find "git")))
               (not (null treemacs-python-executable)))
    (`(t . t)
     (progn
       (setq +treemacs-git-mode 'deferred)
       (treemacs-git-mode 'deferred)))
    (`(t . _)
     (treemacs-git-mode 'simple))))

(use-package! vterm
  :config
  (setq vterm-max-scrollback 100000))

;; text mode directory tree
(use-package! ztree
  :bind (:map ztreediff-mode-map
         ("C-<f5>" . ztree-diff))
  :init (setq ztree-draw-unicode-lines t
              ztree-show-number-of-children t))
