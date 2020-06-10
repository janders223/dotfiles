;;; init.el -*- lexical-binding: t; -*-

(doom! :input

       :completion
       company
       (ivy
        +fuzzy
        +prescient
        +icons)               ; a search engine for love and life

       :ui
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       ;;fill-column       ; a `fill-column' indicator
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       ;;indent-guides     ; highlighted indent columns
       modeline          ; snazzy, Atom-inspired modeline, plus API
       ophints           ; highlight the region an operation acts on
       (popup
        +all
        +defaults)   ; tame sudden yet inevitable temporary windows
       (pretty-code +hasklig)       ; ligatures or substitute text with pretty symbols
       vc-gutter         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       workspaces

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       (format +onsave)  ; automated prettiness
       snippets          ; my elves. They type so I don't have to

       :emacs
       (dired +icons)             ; making dired pretty [functional]
       ;; electric          ; smarter, keyword-based electric-indent
       (ibuffer +icons)         ; interactive buffer management
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       eshell            ; the elisp shell that works everywhere

       :checkers
       syntax              ; tasing you for every semicolon you forget

       :tools
       ansible
       ;;debugger          ; FIXME stepping through code, to help you add bugs
       (docker +lsp)
       editorconfig      ; let someone else argue about tabs vs spaces
       (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation
       (lsp +peek)
       macos             ; MacOS-specific commands
       (magit +forge)             ; a git porcelain for Emacs
       make              ; run make tasks from Emacs
       pdf               ; pdf enhancements
       (terraform +lsp)         ; infrastructure as code
       neuron
       direnv

       :lang
       (clojure +lsp)
       emacs-lisp        ; drown in parentheses
       (go +lsp)         ; the hipster dialect
       (json +lsp)              ; At least it ain't XML
       (javascript +lsp)        ; all(hope(abandon(ye(who(enter(here))))))
       lua               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
       nix               ; I hereby declare "nix geht mehr!"
       (org +hugo)               ; organize your plain life in plain text
       rest              ; Emacs as a REST client
       (sh +lsp)                ; she sells {ba,z,fi}sh shells on the C xor
       (yaml +lsp)              ; JSON, but readable

       :email
       notmuch

       :app
       ;;calendar
       ;;irc               ; how neckbeards socialize
       (rss +org)        ; emacs as an RSS reader

       :config
       (default +bindings +smartparens))
