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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")

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
  (setq ccls-initialization-options
        (append ccls-initialization-options
                `(:cache (:directory ,(file-truename "~/.cache/ccls"))))))

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
  ;; fixes the case of the first line in dired when the cursor jumps
  ;; to the header in dired rather then to the first file in buffer
  (defun dired-subtree-toggle ()
    "Insert subtree at point or remove it if it was not present."
    (interactive)
    (if (dired-subtree--is-expanded-p)
        (progn
          (dired-next-line 1)
          (dired-subtree-remove)
          (if (bobp)
              (dired-next-line 1)))
      (save-excursion (dired-subtree-insert))))

  (defadvice dired-subtree-toggle (after dired-icons-refresh ())
    "Insert an empty line when moving up from the top line."
      (revert-buffer))
  (ad-activate 'dired-subtree-toggle)

  (map!
   (:map dired-mode-map
    :desc "Toggle subtree" :n [tab] #'dired-subtree-toggle))
  )

(after! dired
  ;; Define localleader bindings
  (map!
   ;; Define or redefine dired bindings
   (:map dired-mode-map
     :desc "Up" :n "<left>" #'dired-up-directory
     :desc "Down" :n "<right>" #'dired-find-file)))

(use-package! docker-tramp)
(use-package! docker)

(use-package! highlight-parentheses
    :defer t
    :init
    (progn
      (add-hook 'prog-mode-hook #'highlight-parentheses-mode)
      (setq hl-paren-delay 0.2)
      (setq hl-paren-colors '("Springgreen3"
                              "IndianRed1"
                              "IndianRed3"
                              "IndianRed4")))
    :config
    (set-face-attribute 'hl-paren-face nil :weight 'ultra-bold))

(use-package! journalctl-mode)

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

(defmacro modus-themes-format-sexp (sexp &rest objects)
  `(eval (read (format ,(format "%S" sexp) ,@objects))))

(dolist (theme '("operandi" "vivendi"))
  (modus-themes-format-sexp
   (defun modus-%1$s-theme-load ()
     (setq modus-%1$s-theme-slanted-constructs t
           modus-%1$s-theme-bold-constructs t
           modus-%1$s-theme-fringes nil ; {nil,'subtle,'intense}
           modus-%1$s-theme-mode-line '3d ; {nil,'3d,'moody}
           modus-%1$s-theme-syntax 'alt-syntax-yellow-comments ; {nil,faint,'yellow-comments,'green-strings,'yellow-comments-green-strings,'alt-syntax,'alt-syntax-yellow-comments}
           modus-%1$s-theme-intense-hl-line nil
           modus-%1$s-theme-intense-paren-match nil
           modus-%1$s-theme-links 'no-underline ; {nil,'faint,'neutral-underline,'faint-neutral-underline,'no-underline}
           modus-%1$s-theme-no-mixed-fonts nil
           modus-%1$s-theme-prompts 'subtle ; {nil,'subtle,'intense}
           modus-%1$s-theme-completions 'moderate ; {nil,'moderate,'opinionated}
           modus-%1$s-theme-diffs 'desaturated ; {nil,'desaturated,'fg-only}
           modus-%1$s-theme-org-blocks 'greyscale ; {nil,'greyscale,'rainbow}
           modus-%1$s-theme-headings  ; Read further below in the manual for this one
           '(;; (1 . rainbow)
             ;; (2 . rainbow-highlight)
             (t . highlight))
           modus-%1$s-theme-variable-pitch-headings t
           modus-%1$s-theme-scale-headings t
           modus-%1$s-theme-scale-1 1.1
           modus-%1$s-theme-scale-2 1.15
           modus-%1$s-theme-scale-3 1.21
           modus-%1$s-theme-scale-4 1.27
           modus-%1$s-theme-scale-5 1.33)
     (load-theme 'modus-%1$s t))
   theme))

(defun modus-themes-toggle ()
  "Toggle between `modus-operandi' and `modus-vivendi' themes."
  (interactive)
  (if (eq (car custom-enabled-themes) 'modus-operandi)
      (progn
        (disable-theme 'modus-operandi)
        (modus-vivendi-theme-load))
    (disable-theme 'modus-vivendi)
    (modus-operandi-theme-load)))

(use-package! modus-operandi-theme
  :config
  (modus-operandi-theme-load))

(use-package! rainbow-mode
  :hook
  ((prog-mode . rainbow-mode)
   (org-mode . rainbow-mode)))

;; (use-package! shrface)

(use-package! trashed
  :config
  (add-to-list 'evil-emacs-state-modes 'trashed-mode))

(use-package! vterm
  :config
  (setq vterm-max-scrollback 100000))

;; text mode directory tree
(use-package! ztree
  :bind (:map ztreediff-mode-map
         ("C-<f5>" . ztree-diff))
  :init (setq ztree-draw-unicode-lines t
              ztree-show-number-of-children t))
