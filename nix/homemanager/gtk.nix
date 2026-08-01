{ pkgs, version, lib,  ... }: {
    gtk = {
        gtk2 = {
                enable = true;
                theme.name = "Kripton-standard-buttons-v40";
                iconTheme.name = "cosmic-icons";
                font.name = "Cantarell 10";
                cursorTheme.name = "breeze_cursors";
                cursorTheme.size = 16;
                extraConfig = {
                        gtk-toolbar-style="GTK_TOOLBAR_BOTH_HORIZ";
                        gtk-toolbar-icon-size="GTK_ICON_SIZE_LARGE_TOOLBAR";
                        gtk-button-images=0;
                        gtk-menu-images=0;
                        gtk-enable-event-sounds=1;
                        gtk-enable-input-feedback-sounds=0;
                        gtk-xft-antialias=1;
                        gtk-xft-hinting=1;
                        gtk-xft-hintstyle="hintslight";
                        gtk-xft-rgba="rgb";
                };
        };
        gtk3 = {
                enable = true;
                theme.name = "Kripton-standard-buttons-v40";
                iconTheme.name = "cosmic-icons";
                font.name = "Cantarell 10";
                cursorTheme.name = "breeze_cursors";
                cursorTheme.size = 16;
                extraConfig = {
                        gtk-toolbar-style= "GTK_TOOLBAR_BOTH_HORIZ";
                        gtk-toolbar-icon-size= "GTK_ICON_SIZE_LARGE_TOOLBAR";
                        gtk-button-images=0;
                        gtk-menu-images=0;
                        gtk-enable-event-sounds=1;
                        gtk-enable-input-feedback-sounds=0;
                        gtk-xft-antialias=1;
                        gtk-xft-hinting=1;
                        gtk-xft-hintstyle="hintslight";
                        gtk-xft-rgba="rgb";
                        gtk-application-prefer-dark-theme=1;
                        gtk-enable-primary-paste=false;
                };
        };
        gtk4 = {
                enable = true;
                cursorTheme.size = 14;
                cursorTheme.name = "Pop";
                iconTheme.name = "Materia-Manjaro-2";
                extraConfig = {
                        gtk-application-prefer-dark-theme = 1;
                };
        };
    };
}
