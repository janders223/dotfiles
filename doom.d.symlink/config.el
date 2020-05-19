;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jim Anders"
      user-mail-address "jimanders223@gmail.com")

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
(setq doom-font (font-spec :family "Hasklug Nerd Font" :size 18))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(load "~/.doom.d/prolog.el")
(add-to-list 'auto-mode-alist '("\\.pl$" . prolog-mode))
(setq prolog-electric-if-then-else-flag t)

(setq treemacs-width 20)

(setq org-directory "/Volumes/data/emacs/org")

(map! :leader
      :desc "elfeed" "o n" #'=rss)

(setq rmh-elfeed-org-files (list "/Volumes/data/emacs/org/elfeed.org"))
(setq elfeed-db-directory "/Volumes/data/emacs/elfeed/db")
(setq elfeed-enclosure-default-dir "/Volumes/data/emacs/elfeed/enclosures/")
(setq +rss-initial-search-filter "@1-month-ago +unread")
(setq elfeed-search-title-max-width 150)
(setq elfeed-search-trailing-width 30)
;; Mark all YouTube entries
(add-hook 'elfeed-new-entry-hook
         (elfeed-make-tagger :feed-url "youtube\\.com"
                             :add '(video youtube)))
;; Mark old entries as read
(add-hook 'elfeed-new-entry-hook
         (elfeed-make-tagger :before "1 month ago"
                     :remove 'unread))

(add-hook! 'elfeed-search-mode-hook 'elfeed-update)

(set-email-account! "GMAIL"
                    '((mu4e-sent-folder       . "/gmail/sent")
                      (mu4e-trash-folder      . "/gmail/trash")
                      (mu4e-drafts-folder     . "/gmail/drafts")
                      (mu4e-refile-folder     . "/gmail/archive")
                      (smtpmail-smtp-user     . "jimanders223@gmail.com")
                      (mu4e-compose-signature . "janders"))
                    t)

(set-email-account! "INGAGE"
                    '((mu4e-sent-folder       . "/ingage/sent")
                      (mu4e-trash-folder      . "/ingage/trash")
                      (mu4e-drafts-folder     . "/ingage/drafts")
                      (mu4e-refile-folder     . "/ingage/archive")
                      (smtpmail-smtp-user     . "jim.anders@ingagepartners.com")))
