{ stdenv, fetchFromGitHub, fetchpatch, ocaml, findlib, ocamlbuild
, ocaml_lwt # optional lwt support
, ounit, fileutils # only for tests
}:

stdenv.mkDerivation rec {
	version = "2.3";
	name = "ocaml${ocaml.version}-inotify-${version}";

	src = fetchFromGitHub {
		owner = "whitequark";
		repo = "ocaml-inotify";
		rev = "v${version}";
		sha256 = "1s6vmqpx19hxzsi30jvp3h7p56rqnxfhfddpcls4nz8sqca1cz5y";
	};

	patches = [ (fetchpatch {
		url = "https://github.com/whitequark/ocaml-inotify/commit/716c8002cc1652f58eb0c400ae92e04003cba8c9.patch";
		sha256 = "04lfxrrsmk2mc704kaln8jqx93jc4bkxhijmfy2d4cmk1cim7r6k";
	}) ];

	buildInputs = [ ocaml findlib ocamlbuild ocaml_lwt ];
	checkInputs = [ ounit fileutils ];

	configureFlags = [ "--enable-lwt"
	  (stdenv.lib.optionalString doCheck "--enable-tests") ];

	doCheck = true;
	checkTarget = "test";

	createFindlibDestdir = true;

	meta = {
		description = "Bindings for Linux’s filesystem monitoring interface, inotify";
		license = stdenv.lib.licenses.lgpl21;
		maintainers = [ stdenv.lib.maintainers.vbgl ];
		inherit (src.meta) homepage;
		platforms = stdenv.lib.platforms.linux;
	};
}
