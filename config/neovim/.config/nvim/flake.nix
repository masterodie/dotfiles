{
  description = "A dev environment";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-20.03;

  outputs = { self, nixpkgs }: {
    devShell.x86_64-linux =
      # Notice the reference to nixpkgs here.
      with import nixpkgs { system = "x86_64-linux"; };
      mkShell {
        buildInputs = with pkgs; [
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
      };

  };
}
