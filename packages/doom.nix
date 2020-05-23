{ fetchgit ? (import <nixpkgs> {}).fetchgit
, runCommand ? (import <nixpkgs> {}).runCommand}:

let
	doom = fetchgit {
		url = "https://github.com/hlissner/doom-emacs.git";
		rev = "a262527a7fff8af13179cb63bf1d49122d2edaee";
		sha256 = "0xcby676v8vay47x2dk6yxn68byl92dsr4l6zqmcwfgzfsvbdxly";
	};
in
	runCommand "doom" {} ''
		mkdir -p $out/share
		cp -r ${doom} $out/share/doom
	''
