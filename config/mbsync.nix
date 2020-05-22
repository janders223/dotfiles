{ pkgs }: ''
  Create Both
  Expunge Both
  SyncState *

  IMAPAccount gmail
  Host imap.gmail.com
  User jimanders223@gmail.com
  PassCmd "security find-generic-password -a jimanders223@gmail.com -s imap.gmail.com -w"
  AuthMechs LOGIN
  SSLType IMAPS
  SSLVersions SSLv3
  CertificateFile ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt

  IMAPAccount ingage
  Host imap.gmail.com
  User jim.anders@ingagepartners.com
  PassCmd "security find-generic-password -a jim.anders@ingagepartners.com -s imap.gmail.com -w"
  AuthMechs LOGIN
  SSLType IMAPS
  SSLVersions SSLv3
  CertificateFile ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt

  IMAPStore gmail-remote
  Account gmail

  MaildirStore gmail-local
  Path ~/.mail/gmail/
  Inbox ~/.mail/gmail/INBOX

  Channel gmail-inbox
  Master :gmail-remote:
  Slave :gmail-local:
  Patterns "INBOX"

  Channel gmail-trash
  Master :gmail-remote:"[Gmail]/Trash"
  Slave :gmail-local:"trash"

  Channel gmail-sent
  Master :gmail-remote:"[Gmail]/Sent Mail"
  Slave :gmail-local:"sent"

  Channel gmail-archive
  Master :gmail-remote:"[Gmail]/All Mail"
  Slave :gmail-local:"archive"

  Channel gmail-starred
  Master :gmail-remote:"[Gmail]/Starred"
  Slave :gmail-local:"starred"

  Group gmail
  Channel gmail-inbox
  Channel gmail-sent
  Channel gmail-trash
  Channel gmail-archive
  Channel gmail-starred

  IMAPStore ingage-remote
  Account ingage

  MaildirStore ingage-local
  Path ~/.mail/ingage/
  Inbox ~/.mail/ingage/INBOX

  Channel ingage-inbox
  Master :ingage-remote:
  Slave :ingage-local:
  Patterns "INBOX"

  Channel ingage-trash
  Master :ingage-remote:"[Gmail]/Trash"
  Slave :ingage-local:"trash"

  Channel ingage-sent
  Master :ingage-remote:"[Gmail]/Sent Mail"
  Slave :ingage-local:"sent"

  Channel ingage-archive
  Master :ingage-remote:"[Gmail]/All Mail"
  Slave :ingage-local:"archive"

  Channel ingage-starred
  Master :ingage-remote:"[Gmail]/Starred"
  Slave :ingage-local:"starred"

  Group ingage
  Channel ingage-inbox
  Channel ingage-sent
  Channel ingage-trash
  Channel ingage-archive
  Channel ingage-starred
''
