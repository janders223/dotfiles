;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jim Anders"
      user-mail-address "jim.anders@kroger.com")

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

(map! :leader
       :desc "elfeed" "o n" #'=rss)

(setq elfeed-search-filter "@6-months-ago +unread")
(setq elfeed-feeds
      (quote
       ("https://www.timetestedtools.net/feed/"
        ("https://www.calhoun.io/rss/index.xml" golang)
        ("https://arslan.io/index.xml" golang)
        ("https://www.goinggo.net/index.xml" golang)
        ("http://blog.golang.org/feeds/posts/default" golang)
        ("http://dave.cheney.net/feed" golang)
        "https://superorganizers.substack.com/feed/"
        "http://feeds.feedburner.com/rudiusmedia/rch"
        "https://feeds.feedburner.com/TheArtOfManliness"
        "https://fs.blog/feed/"
        "https://medium.com/feed/@RyanHoliday"
        "https://feeds.feedburner.com/lifehacker/full.xml"
        "https://bulletjournal.com/blogs/bulletjournalist.atom"
        "http://feeds.feedburner.com/BenGreenfieldFitness"
        "http://www.fourhourworkweek.com/blog/feed/"
        "http://feeds.arstechnica.com/arstechnica/index/"
        "http://www.bulletproofexec.com/feed/"
        "http://markmanson.net/feed"
        "http://jamesclear.com/feed"
        "http://fivefilters.org/content-only/makefulltextfeed.php?url=http%3A//feeds.feedburner.com/StudyHacks"
        "https://www.gatesnotes.com/rss"
        "http://davidbarronfurniture.blogspot.com/feeds/posts/default"
        "http://www.popularwoodworking.com/feed"
        "https://redrosereproductions.com/feed/"
        "https://accidentalwoodworker.blogspot.com/feeds/posts/default"
        "http://paulsellers.com/feed/"
        "http://jayscustomcreations.com/feed/"
        "http://www.toolsforworkingwood.com/Merchant/merch_rss_start.mvc"
        "http://mortiseandtenonmag.com/blogs/blog.atom"
        "https://overthewireless.com/feed/"
        "http://blog.woodworkingtooltips.com/feed/"
        "http://feeds.feedburner.com/TWW"
        "http://www.mattcremona.com/feed"
        "http://pfollansbee.wordpress.com/feed/"
        "http://brfinewoodworking.com/feed/"
        "https://eclecticmechanicals.com/feed/"
        "http://blog.lostartpress.com/feed/"
        "http://woodandshop.com/feed/"
        "https://pegsandtails.wordpress.com/feed/"
        "http://www.finewoodworking.com/feeds/rss/all.xml"
        "https://www.youtube.com/feeds/videos.xml?channel_id=UChYK4HS3hVQmsr6OEHZDDzQ"
        "http://feeds.thewoodwhisperer.com/tww"
        "http://www.byhandandeye.com/feed/"
        "http://feeds.feedburner.com/TheUnpluggedWoodshop"
        "https://msbickford.com/feed/"
        "https://unpluggedshop.com/feed/"
        "https://www.johnmalecki.com/post/rss.xml"
        "https://www.youtube.com/feeds/videos.xml?channel_id=UC47EhkMV18WlRqV3VhUH3yg"
        "http://www.theenglishwoodworker.com/?feed=rss2"
        "http://nrhiller.wordpress.com/feed/"
        "https://sheworkswood.com/feed/"
        "http://norsewoodsmith.com/?q=aggregator/rss"
        "http://rudemechanicalspress.wordpress.com/feed/"
        "http://renaissancewoodworker.com/feed"
        "http://feeds.feedburner.com/DilbertDailyStrip"
        "http://theoatmeal.com/feed/rss"
        "http://feeds.feedburner.com/thechangelog"
        "http://blog.pragmaticengineer.com/rss/"
        "http://brikis98.blogspot.com/feeds/posts/default"
        "https://news.ycombinator.com/rss"
        "https://medium.com/feed/@copyconstruct"
        "http://blog.jessitron.com/feeds/posts/default"
        "http://nullprogram.com/feed/"
        "https://lobste.rs/rss"
        "https://www.discoverdev.io/rss.xml"
        "https://www.bakewithjack.co.uk/blog-1?format=rss"
        "http://feeds.seriouseats.com/seriouseatsfeaturesvideos"
        "https://thetakeout.com/rss"
        "https://food52.com/blog.rss"
        "http://feeds.feedburner.com/apartmenttherapy/thekitchn"
        "http://feeds.feedburner.com/HighScalability"
        "https://www.eigenbahn.com/atom.xml"
        "https://karl-voit.at/feeds/lazyblorg-all.atom_1.0.links-only.xml"
        "http://planet.emacslife.com/atom.xml"
        "http://irreal.org/blog/?feed=rss2"
        "http://planet.lisp.org/rss20.xml"
        "http://feeds.feedburner.com/XahsEmacsBlog"
        "https://zwischenzugs.wordpress.com/feed/"
        "http://sachachua.com/wp/category/emacs/feed/"
        "http://charity.wtf/feed/")))

