  { stdenv, lib, fetchurl, fetchFromGitHub, ncurses, pkgconfig, texinfo, libxml2
  , gnutls, gettext, autoconf, automake, autoreconfHook, jansson, imagemagick
  , librsvg, AppKit, GSS, ImageIO }:

  stdenv.mkDerivation rec {
    name = "emacs-${version}";
    version = "27.1";

    src = fetchFromGitHub {
      owner = "emacs-mirror";
      repo = "emacs";

      # 27.1
      rev = "86d8d76aa36037184db0b2897c434cdaab1a9ae8";
      sha256 = "1i50ksf96fxa3ymdb1irpc82vi67861sr4xlcmh9f64qw9imm3ks";
    };

    enableParallelBuilding = true;

    patches = [
      ./patches/clean-env.patch
      ./patches/no-title-bars.patch
      ./patches/fix-window-role.patch
      ./patches/no-frame-refocus.patch
    ];

    CFLAGS = "-DMAC_OS_X_VERSION_MAX_ALLOWED=101200";
    LDFLAGS = "-O3 -L${ncurses.out}/lib";

    nativeBuildInputs = [ pkgconfig autoconf automake autoreconfHook texinfo ];

    buildInputs = [
      ncurses
      libxml2
      gnutls
      gettext
      imagemagick
      librsvg
      AppKit
      GSS
      ImageIO
      jansson
    ];

    hardeningDisable = [ "format" ];

    configureFlags = [
      "LDFLAGS=-L${ncurses.out}/lib"
      "--disable-ns-self-contained"
      "--disable-build-details"
      "--with-gnutls=yes"
      "--with-xml2=yes"
      "--with-modules"
      "--with-json"
    ];

    preConfigure = ''
      substituteInPlace lisp/international/mule-cmds.el \
        --replace /usr/share/locale ${gettext}/share/locale
      for makefile_in in $(find . -name Makefile.in -print); do
          substituteInPlace $makefile_in --replace /bin/pwd pwd
      done
    '';

    installTargets = [ "tags" "install" ];

    postInstall = ''
      mkdir -p $out/share/emacs/site-lisp
      cp ${./site-start.el} $out/share/emacs/site-lisp/site-start.el
      $out/bin/emacs --batch -f batch-byte-compile $out/share/emacs/site-lisp/site-start.el
      rm -rf $out/var
      rm -rf $out/share/emacs/${version}/site-lisp
      mkdir -p $out/Applications
      mv nextstep/Emacs.app $out/Applications
    '';

    meta = with stdenv.lib; {
      description = "Recent Emacs builds with some community patches.";
      homepage = "https://www.gnu.org/software/emacs/";
      license = licenses.gpl3Plus;
      maintainers = with maintainers; [ cmacrae ];
      platforms = platforms.darwin;

      longDescription = ''
        This is a recent build of GNU Emacs with some community patches, oriented around
        making it a nicer experience on macOS when using a tiling window manager.
        Included patches
        - fix-window-role: in lieu of the modifications from emacs-mac, this allows for better
                           window recognition/control
        - no-frame-refocus: don't refocus on other frames once one is closed
        - no-title-bars: removes title bars/window decorations; nice when using with a tiling WM
      '';
    };
  }
