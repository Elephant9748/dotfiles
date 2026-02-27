{ pkgs, ... }: {
        programs.nix-ld.enable = true;
        programs.nix-ld.libraries = with pkgs; [
                # libstdc++
                stdenv.cc.cc
                glibc
                # libgcc_s
                libxcb
                libX11
                libXrandr
                libXcursor
                libXi
                libGL
                alsa-lib
                udev
                libxkbcommon
        ];
}
