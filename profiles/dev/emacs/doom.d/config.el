;;; $DOOMDIR/config.el --- My personal configuration -*- lexical-binding: t; -*-
;;; Commentary:

;;; Code:
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ahmet Cemal Özgezer"
      user-mail-address "ozgezer@gmail.com"

      ;; There are two ways to load a theme. Both assume the theme is installed and
      ;; available. You can either set `doom-theme' or manually load a theme with the
      ;; `load-theme' function. This is the default:
      doom-theme 'modus-operandi
      ;; modus-operandi modus-vivendi doom-one doom-gruvbox doom-tomorrow-night

      ;; This determines the style of line numbers in effect. If set to `nil', line
      ;; numbers are disabled. For relative line numbers, set this to `relative'.
      ;;
      ;; Line numbers are pretty slow all around. The performance boost of
      ;; disabling them outweighs the utility of always keeping them on.
      display-line-numbers-type nil

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
      ;; (setq doom-font (font-spec :family "Iosevka" :size 14)
      ;;       doom-variable-pitch-font (font-spec :family "Ubuntu Nerd Font" :size 14))
      doom-font (font-spec :family "Iosevka Nerd Font" :size 13)
      doom-big-font (font-spec :family "Iosevka Nerd Font" :size 26)
      doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :size 13)
      doom-serif-font (font-spec :family "BlexMono Nerd Font" :weight 'light)

      fancy-splash-image (concat doom-private-dir "splash.png")

      auth-sources '("~/.authinfo.gpg")
      auth-source-cache-expiry nil ; default is 7200 (2h)

      calendar-location-name "Istanbul, Turkey"
      calendar-latitude 41.168602
      calendar-longitude 29.047024

      delete-by-moving-to-trash t  ; Delete files to trash
      window-combination-resize t  ; take new window space from all other windows (not just current)
      x-stretch-cursor t           ; Stretch cursor to the glyph width
      undo-limit 80000000          ; Raise undo-limit to 80Mb
      evil-want-fine-undo t        ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t          ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…" ; Unicode ellispis are nicer than "...", and also save /precious/ space

      ;; Switch to the new window after splitting
      evil-vsplit-window-right t
      evil-split-window-below t

      +ivy-buffer-preview t

      frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-roam-directory (or buffer-file-name ""))
             (replace-regexp-in-string
              ".*/[0-9]*-?" "☰ "
              (subst-char-in-string ?_ ?  buffer-file-name))
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))

;; (if (equal "Battery status not available"
;;            (battery))
;;     (display-battery-mode 1)                        ; On laptops it's nice to know how much power you have
;;   (setq password-cache-expiry nil))               ; I can trust my desktops ... can't I? (no battery = desktop)

(global-subword-mode 1)                           ; Iterate through CamelCase words

(setq-default custom-file (expand-file-name ".custom.el" doom-private-dir))
(when (file-exists-p custom-file)
  (load custom-file))

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

;; Prevents some cases of Emacs flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(add-to-list 'default-frame-alist '(alpha . (95)))
(set-frame-parameter (selected-frame) 'alpha '(95))

(when (daemonp)
  (add-hook 'after-make-frame-functions
            (lambda (frame)
              (with-selected-frame frame
                (modus-themes-load-operandi)))))

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
                    ("^\\*Anaconda\\*" :side right :size 82 :quit t :ttl t)))

(after! ivy-posframe
  (setq ivy-posframe-border-width 3))

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override nil)
  (defun display-workspaces-in-minibuffer ()
    (with-current-buffer " *Minibuf-0*"
      (erase-buffer)
      (insert (+workspace--tabline))))
  (run-with-idle-timer 1 t #'display-workspaces-in-minibuffer)
  (+workspace/display))

;; (defconst ac/c-or-c++-mode--regexp
;;   (eval-when-compile
;;     (let ((id "[a-zA-Z0-9_]+") (ws "[ \t\r]+") (ws-maybe "[ \t\r]*"))
;;       (concat "^" ws-maybe "\\(?:"
;;                     "using"     ws "\\(?:namespace" ws "std;\\|std::\\)"
;;               "\\|" "namespace" "\\(:?" ws id "\\)?" ws-maybe "{"
;;               "\\|" "class"     ws id ws-maybe "[:{\n]"
;;               "\\|" "template"  ws-maybe "<.*>"
;;               "\\|" "#include"  ws-maybe "<\\(?:string\\|iostream\\|map\\)>"
;;               "\\)")))
;;   "A regexp applied to C header files to check if they are really C++.")

;; (defconst ac/make-mode--regexp
;;   (eval-when-compile
;;     (let ((id "[A-Z0-9_]+") (ws-maybe "[ \t\r]*"))
;;       (concat "^" ws-maybe "\\(?:"
;;               "include"  ws-maybe ".*"
;;               "\\|" id ws-maybe "=" ws-maybe ".*"
;;               "\\)")))
;;   "A regexp applied to files to check if they are really Makefiles.")

;; (defun ac/c-or-make-mode ()
;;   "Analyze buffer and enable either C or C++ mode.
;; Some people and projects use .h extension for C++ header files
;; which is also the one used for C header files.  This makes
;; matching on file name insufficient for detecting major mode that
;; should be used.
;; This function attempts to use file contents to determine whether
;; the code is C or C++ and based on that chooses whether to enable
;; `c-mode' or `c++-mode'."
;;   (save-excursion
;;     (save-restriction
;;       (save-match-data
;;         (widen)
;;         (goto-char (point-min))
;;         (if (re-search-forward ac/c-or-c++-mode--regexp
;;                                (+ (point) 50000) t)
;;             (c++-mode)
;;           (goto-char (point-min))
;;           (if (re-search-forward ac/make-mode--regexp
;;                                  (+ (point) 50000) t)
;;               (makefile-mode)
;;             (c-mode)))))))

;; (add-to-list 'auto-mode-alist '("\\.h\\'" . ac/c-or-make-mode))

;; (defun ac/make-mode-p ()
;;   "Analyze buffer and enable Makefile mode.
;; This function attempts to use file contents to determine whether
;; the code is Makefile and based on that chooses whether to enable
;; `makefile-mode'."
;;   (save-excursion
;;     (save-restriction
;;       (save-match-data
;;         (widen)
;;         (goto-char (point-min))
;;         (re-search-forward ac/make-mode--regexp
;;                                  (+ (point) magic-mode-regexp-match-limit) t)))))
;; (add-to-list 'magic-mode-alist '(ac/make-mode-p . makefile-mode))

(setq-default
 delete-by-moving-to-trash t)

;; (windmove-default-keybindings 'control)
;; (windswap-default-keybindings 'control 'shift)
;; (add-hook 'org-shiftup-final-hook 'windmove-up)
;; (add-hook 'org-shiftleft-final-hook 'windmove-left)
;; (add-hook 'org-shiftdown-final-hook 'windmove-down)
;; (add-hook 'org-shiftright-final-hook 'windmove-right)

(add-to-list 'term-file-aliases
             '("alacritty" . "xterm-256color"))

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
  ;; (dired-auto-readme-mode 1)
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
  (dired-async-mode 1)
  ;; Define localleader bindings
  (map!
   ;; Define or redefine dired bindings
   (:map dired-mode-map
     :desc "Up" :n "<left>" #'dired-up-directory
     :desc "Down" :n "<right>" #'dired-find-file)))

(use-package! docker-tramp)
(use-package! docker)

;; Easier to match with a bspwm rule:
;;   bspc rule -a 'Emacs:emacs-everywhere' state=floating sticky=on
(setq emacs-everywhere-frame-name-format "emacs-everywhere")

;; The modeline is not useful to me in the popup window. It looks much nicer
;; to hide it.
(add-hook 'emacs-everywhere-init-hooks #'hide-mode-line-mode)

;; Semi-center it over the target window, rather than at the cursor position
;; (which could be anywhere).
(defadvice! my-emacs-everywhere-set-frame-position (&rest _)
  :override #'emacs-everywhere-set-frame-position
  (cl-destructuring-bind (width . height)
      (alist-get 'outer-size (frame-geometry))
    (set-frame-position (selected-frame)
                        (+ emacs-everywhere-window-x
                           (/ emacs-everywhere-window-width 2)
                           (- (/ width 2)))
                        (+ emacs-everywhere-window-y
                           (/ emacs-everywhere-window-height 2)))))
(use-package! highlight-parentheses
  :init
  (add-hook 'prog-mode-hook #'highlight-parentheses-mode)
  (setq highlight-parentheses-delay 0.2)
  :config
  (set-face-attribute 'hl-paren-face nil :weight 'ultra-bold))

(use-package! journalctl-mode)

(setq +format-on-save-enabled-modes
      '(go-mode))

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
(after! magit
  (magit-add-section-hook 'magit-status-sections-hook
                          'magit-insert-ignored-files
                          'magit-insert-untracked-files
                          nil))

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
        modus-themes-variable-pitch-headings t
        modus-themes-variable-pitch-ui t
        modus-themes-no-mixed-fonts nil
        modus-themes-headings
        '((1 . section)
          (2 . section-no-bold)
          (3 . rainbow-line)
          (t . rainbow-line-no-bold))
        modus-themes-scale-headings t
        modus-themes-fringes nil
        modus-themes-lang-checkers nil
        modus-themes-org-blocks nil
        modus-themes-org-habit nil
        modus-themes-prompts 'subtle-accented
        modus-themes-mode-line 'borderless-3d
        modus-themes-diffs 'desaturated
        modus-themes-syntax 'faint
        modus-themes-hl-line 'accented-background
        modus-themes-subtle-line-numbers t
        modus-themes-paren-match 'subtle-bold
        modus-themes-region 'bg-only-no-extend
        modus-themes-links 'faint-neutral-underline
        modus-themes-completions 'opinionated

        modus-themes-scale-1 1.05
        modus-themes-scale-2 1.1
        modus-themes-scale-3 1.15
        modus-themes-scale-4 1.2
        modus-themes-scale-5 1.3)

  ;; Load the theme files before enabling a theme
  (modus-themes-load-themes)

  :config
  ;; Load the theme of your choice
  ;; (modus-themes-load-operandi)
  ;; ;; OR
  ;; (load-theme 'modus-operandi t)
  :bind ("<f5>" . modus-themes-toggle)
  )

(use-package! org
  :init
  (setq
      ;; If you use `org' and don't want your org files in the default location below,
      ;; change `org-directory'. It must be set before org loads!
      org-directory "~/Documents/org/"
      ;; ;; org-noter-notes-search-path '("~/Documents/org/notes/")
      org-archive-location (concat org-directory ".archive/%s::")
      org-roam-directory (concat org-directory "notes/")
      org-roam-db-location (concat org-roam-directory ".org-roam.db")
      org-journal-encrypt-journal t
      org-journal-file-format "%Y%m%d.org"
      org-startup-folded 'overview
      org-ellipsis " [...] "))

(use-package! rainbow-mode
  :hook
  ((prog-mode . rainbow-mode)
   (org-mode . rainbow-mode)))

(use-package! trashed
  :config
  (add-to-list 'evil-emacs-state-modes 'trashed-mode))

(use-package! treemacs
  :init
  (defvar treemacs-no-load-time-warnings t)
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
