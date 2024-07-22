{ fetchFromGitHub, lib, linux, stdenv }:

let
  version = lib.importJSON ./version.json;

in stdenv.mkDerivation {
  name = "wsl2-linux-kernel";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "WSL2-Linux-Kernel";
    rev = version.rev;
    sha256 = version.sha256;
  };

  makeFlags = [ "KCONFIG_CONFIG=Microsoft/config-wsl" ];
  nativeBuildInputs = linux.nativeBuildInputs;

  enableParallelBuilding = true;

  postPatch = ''
    patchShebangs ./scripts/bpf_doc.py;
  '';

  installPhase = ''
    mkdir -p $out
    cp ./vmlinux $out/vmlinux
  '';
}
