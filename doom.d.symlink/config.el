;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Jim Anders"
      user-mail-address "jimanders223@gmail.com")

(setq doom-font (font-spec :family "Hasklug Nerd Font" :size 18))

(setq doom-theme 'doom-nord)

(setq display-line-numbers-type 'relative)
(setq browse-url-browser-function 'eww-browse-url)
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
(after! youtube-dl-emacs
  (setq youtube-dl-directory "~/Videos"
        youtube-dl-arguments '("--netrc" "--mark-watched")))

(after! elfeed
  (setq elfeed-search-filter "@1-month-ago +unread")
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

  (map! :map elfeed-search-mode-map
        :n "d" 'elfeed-youtube-dl)
  (add-hook 'elfeed-new-entry-hook
            (elfeed-make-tagger :feed-url "youtube\\.com"
                                :add '(video youtube)))
  (add-hook 'elfeed-new-entry-hook
            (elfeed-make-tagger :before "1 month ago"
                                :remove 'unread)))

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

(defun xah-dired-sort ()
  "Sort dired dir listing in different ways.
Prompt for a choice.
URL `http://ergoemacs.org/emacs/dired_sort.html'
Version 2018-12-23"
  (interactive)
  (let ($sort-by $arg)
    (setq $sort-by (ido-completing-read "Sort by:" '( "date" "size" "name" )))
    (cond
     ((equal $sort-by "name") (setq $arg "-hAFl "))
     ((equal $sort-by "date") (setq $arg "-hAFl -t"))
     ((equal $sort-by "size") (setq $arg "-hAFlr -S"))
     (t (error "logic error 09535" )))
    (dired-sort-other $arg )))

(setq dired-listing-switches "-hAFl --group-directories-first")

(map! :map dired-mode-map
      :ng "C-c C-s" 'xah-dired-sort
      :ng "C-c C-p" 'add-video-to-queue)

(require 'vlc)
(defun add-video-to-queue ()
  "Add the video at point to the VLC queue"
  (interactive)
  (let ((videos (dired-get-marked-files)))
    (cl-loop for video in videos
             do (vlc/enqueue video)))
  (vlc/play))
