;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(put 'narrow-to-region 'disabled nil)

(setq Info-additional-directory-list '("/run/current-system/sw/share/info"))

(setq user-full-name "Jim Anders"
      user-mail-address "jimanders223@gmail.com"
      epa-file-select-keys t)

(setq doom-font (font-spec :family "Hasklig" :size 18))

(setq doom-theme 'doom-nord)

(setq display-line-numbers-type 'relative)
(setq browse-url-browser-function 'eww-browse-url)

(setq treemacs-width 20)

(setq org-directory "~/Documents/org")

(map! :leader
      :desc "elfeed" "o n" #'=rss)

(setq rmh-elfeed-org-files (list "~/Documents/org/elfeed.org"))

(after! elfeed
  (elfeed-goodies/setup)
  (require 'youtube-dl)
  (setq youtube-dl-directory "~/Videos"
        youtube-dl-arguments '("--restrict-filenames" "-o%(title)s.%(ext)s"))
  (setq elfeed-search-filter "@1-month-ago +unread")

  (defun elfeed-youtube-watch (&optional use-generic-p)
    "Youtube-Watch link"
    (interactive "P")
    (let ((entries (elfeed-search-selected)))
      (cl-loop for entry in entries
               do (elfeed-untag entry 'unread)
               when (elfeed-entry-link entry)
               do (vlc/enqueue it))
      (mapc #'elfeed-search-update-entry entries)
      (unless (use-region-p) (forward-line))))

  (defun elfeed-youtube-dl (&optional use-generic-p)
    "Youtube-DL link"
    (interactive "P")
    (let ((entries (elfeed-search-selected)))
      (cl-loop for entry in entries
               do (elfeed-untag entry 'unread)
               when (elfeed-entry-link entry)
               do (youtube-dl it))
      (mapc #'elfeed-search-update-entry entries)
      (unless (use-region-p) (forward-line))))

  (defun  ar/elfeed-search-browse-background-url ()
    "Open current ` elfeed ' entry (or region entries) in browser without losing focus."
    (interactive)
    (let ((entries (elfeed-search-selected)))
      (mapc (lambda (entry)
              (assert (memq system-type '(darwin)) t  "open command is macOS only")
              (start-process (concat  "open " (elfeed-entry-link entry))
                             ;;  macOS only. Modify for linux.
                             nil  "open"  "--background" (elfeed-entry-link entry))
              (elfeed-untag entry 'unread)
              (elfeed-search-update-entry entry))
            entries)
      (unless (or elfeed-search-remain-on-entry (use-region-p))
        (forward-line))))

  (map! :map elfeed-search-mode-map
        :n "d" 'elfeed-youtube-dl
        :n "p" 'elfeed-youtube-watch
        :n "B" 'ar/elfeed-search-browse-background-url)
  (add-hook 'elfeed-new-entry-hook
            (elfeed-make-tagger :feed-url "youtube\\.com"
                                :add '(video youtube)))
  (add-hook 'elfeed-new-entry-hook
            (elfeed-make-tagger :before "1 month ago"
                                :remove 'unread)))

(add-hook! 'elfeed-search-mode-hook 'elfeed-update)

(after! notmuch
  (setq +notmuch-sync-backend 'mbsync))

;; gls is installed and managed by nix
(after! dired
  (if-let (gls (executable-find "ls"))
      (setq insert-directory-program gls)))
(defun xah-dired-sort ()
  "Sort dired dir listing in different ways.
Prompt for a choice.
URL `http://ergoemacs.org/emacs/dired_sort.html'
Version 2018-12-23"
  (interactive)
  (let ($sort-by $arg)
    (setq $sort-by (ido-completing-read "Sort by:" '( "date" "size" "name" )))
    (cond
     ((equal $sort-by "name") (setq $arg "-vhAFl "))
     ((equal $sort-by "date") (setq $arg "-hAFl -t"))
     ((equal $sort-by "size") (setq $arg "-hAFlr -S"))
     (t (error "Logic error 09535" )))
    (dired-sort-other $arg )))

(setq dired-listing-switches "-vhAFl --group-directories-first")

(map! :map dired-mode-map
      :ng "C-c C-s" 'xah-dired-sort
      :ng "C-c C-p" 'add-video-to-queue)

(require 'vlc)
(setq vlc-program-name "VLC")
(defun add-video-to-queue ()
  "Add the video at point to the VLC queue."
  (interactive)
  (let ((videos (dired-get-marked-files)))
    (cl-loop for video in videos
             do (vlc/enqueue video))))

(after! magit
  (setq magit-view-git-manual-method 'man))

(after! forge
  (add-to-list 'forge-alist
               '("gitlab.kroger.com"
                 "gitlab.kroger.com/api/v4"
                 "gitlab.kroger.com"
                 forge-gitlab-repository)))

(after! envrc
  (envrc-global-mode))

(after! ynab
  (setq ynab-personal-token "7aec2ef6916cdb9ef37d07a5de8f64de016c048d5830444a76426b9fed56b21a"))

(after! org
  (setq org-agenda-span 'day
        org-duration-format '((special . h:mm))
        org-agenda-start-on-weekday 1
        org-agenda-start-day nil))

(add-hook 'emacs-lisp-mode 'paredit-mode)
(add-hook 'paredit-mode 'evil-paredit-mode)
