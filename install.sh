#!/bin/bash

CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config-backup/$(date +%s)"
THEME_NAME="Gruvbox-Material-Dark"
FONT_NAME="Px437 IBM VGA 8x16-2x"
CURSOR_NAME="Adwaita"

install_core() {
    echo "[*] Instalando dotfiles (i3, kitty, rofi)..."
    mkdir -p "$BACKUP_DIR"
    for folder in i3 kitty rofi; do
        if [ -d "$CONFIG_DIR/$folder" ]; then
            mv "$CONFIG_DIR/$folder" "$BACKUP_DIR/"
        fi
    done
    cp -r i3 kitty rofi "$CONFIG_DIR/"
    mkdir -p "$HOME/.local/bin"
    cp scripts/* "$HOME/.local/bin/"
    chmod +x "$HOME/.local/bin/"*
    echo "[OK] Dotfiles instalados!"
}

install_fonts() {
    echo "[*] Instalando fontes..."
    mkdir -p ~/.local/share/fonts
    cp fonts/* ~/.local/share/fonts/
    fc-cache -fv
    echo "[OK] Fonte $FONT_NAME instalada!"
}

install_theme() {
    echo "[*] Instalando tema GTK $THEME_NAME..."
    mkdir -p ~/.themes
    cp -r themes/$THEME_NAME ~/.themes/
    mkdir -p ~/.icons
    # Cursor padrão Adwaita já existe, apenas definindo
    if command -v gsettings >/dev/null; then
        gsettings set org.gnome.desktop.interface gtk-theme "$THEME_NAME"
        gsettings set org.gnome.desktop.interface font-name "$FONT_NAME"
        gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_NAME"
    else
        mkdir -p ~/.config/gtk-3.0
        echo -e "[Settings]\ngtk-theme-name=$THEME_NAME\ngtk-font-name=$FONT_NAME\ngtk-cursor-theme-name=$CURSOR_NAME" > ~/.config/gtk-3.0/settings.ini
    fi
    echo "[OK] Tema GTK e fonte aplicados!"
}

install_all() {
    install_core
    install_fonts
    install_theme
}

case "$1" in
    --all) install_all ;;
    --core) install_core ;;
    --fonts) install_fonts ;;
    --theme) install_theme ;;
    --fakeboot-only)
    mkdir -p "$HOME/.local/bin"
    cp scripts/serwod_boot.sh "$HOME/.local/bin/"
    chmod +x "$HOME/.local/bin/serwod_boot.sh"
    echo "[OK] Fakeboot instalado!"
    ;;

#    *) echo "Uso: $0 [--all | --core | --fonts | --theme | --fakeboot]" ;;
esac


