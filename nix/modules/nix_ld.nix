# find package that missing lib:
# nix run github:nix-community/nix-index-database -- lib/libxkbcommon.so.0 --top-level

{ pkgs, ... }: {
        programs.nix-ld.enable = true;
        programs.nix-ld.libraries = with pkgs; [
                # stdenv.cc.cc
                # glibc
                # libxcb
                # libX11
                # libXrandr
                # libXcursor
                # libXi
                # libGL
                # alsa-lib
                # udev
                # libxkbcommon
                # libstdc++
                # libgcc_s
        ];
}
