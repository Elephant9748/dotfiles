{ pkgs, neovim-nightly, ... }: {
        programs = {
                neovim = {
                        enable = true;
                        package = neovim-nightly.packages.${system}.default;
                };
        };
}
