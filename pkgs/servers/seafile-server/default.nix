{ stdenv, lib, fetchFromGitHub, pkg-config, python3Packages, autoreconfHook
, libuuid, sqlite, glib, libevent, libsearpc, openssl, fuse, libarchive, which
, vala, cmake, libevhtp, oniguruma }:

stdenv.mkDerivation rec {
  pname = "seafile-server";
  version = "8.0.4";

  src = fetchFromGitHub {
    owner = "haiwen";
    repo = "seafile-server";
    rev = "v${version}-server";
    sha256 = "1lmp3hld3sgfjbzzv0vigpfgyrx37277wwdg2bvm5ipl9as2jga8";
  };

  patches = [ ./recent-libevhtp.patch ];

  nativeBuildInputs = [ autoreconfHook pkg-config ];

  buildInputs = [
    libuuid
    sqlite
    openssl
    glib
    libsearpc
    libevent
    python3Packages.python
    fuse
    libarchive
    which
    vala
    libevhtp
    oniguruma
  ];

  postInstall = ''
    mkdir -p $out/share/seafile/sql
    cp -r scripts/sql $out/share/seafile
  '';

  meta = with lib; {
    description =
      "File syncing and sharing software with file encryption and group sharing, emphasis on reliability and high performance";
    homepage = "https://github.com/haiwen/seafile-server";
    license = licenses.agpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ greizgh schmittlauch ];
  };
}
