{ stdenv, fetchFromGitHub, lib, cmake, libevent, openssl, pth, oniguruma }:
stdenv.mkDerivation rec {
  name = "libevhtp";
  version = "1.2.18";

  src = fetchFromGitHub {
    owner = "criticalstack";
    repo = "libevhtp";
    rev = version;
    sha256 = "sha256:085yzrawn0gkfgiz02vwmlhawyaba4yqx98q3y4p95fhzs5wqwcb";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ libevent pth openssl oniguruma ];
  # fix pkgconfig librarypath generation
  cmakeFlags = [ "-DEVHTP_DISABLE_SSL=OFF" "-DBUILD_SHARED_LIBS=ON" ];
  outputs = [ "dev" "out" ];

  meta = {
    description =
      "Create extremely-fast and secure embedded HTTP servers with ease.";
    homepage = "https://github.com/ellzey/libevhtp";
    license = lib.licenses.bsd3;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [ schmittlauch greizgh ];
  };
}
