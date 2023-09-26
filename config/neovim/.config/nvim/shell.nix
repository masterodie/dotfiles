{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = with pkgs; [
      gcc
      gnumake
      cmake
      nodejs
      rustc
      cargo
      go
      unzip
      pkgconfig
      glibc
      stdenv
      stdenv.cc
      stdenv.cc.cc
      stdenv.cc.libc
      stdenv.cc.libc_dev
    ];
}
