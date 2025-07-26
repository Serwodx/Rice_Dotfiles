#!/bin/bash
# =====================================================
# Fakeboot Script - Inspirado no estilo "Serwod"
# Personalizável por variáveis no topo
# =====================================================

# ================== CONFIGURAÇÃO =====================
USER_NAME="Operator"                # Nome mostrado no boot
OS_NAME="Arch Linux (x86_64)"       # Nome do sistema
DEVICE_NAME="Generic Device"        # Nome do host
ASCII_IMAGE="./assets/boot.png"     # Caminho da imagem (pode ser ASCII ou PNG)
WELCOME_MSG="Welcome back, operator. The machine is yours."
# =====================================================

# Requer: lolcat, kitty (para imagem), tput, sleep
# Opcional: paplay (som)

# --------- Função para digitar texto com delay -------
type_line() {
  local text="$1"
  for ((i=0; i<${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep 0.01
  done
  echo ""
}

# --------- Som opcional de terminal antigo -----------
play_beep() {
  command -v paplay &>/dev/null && paplay /usr/share/sounds/freedesktop/stereo/bell.oga
}

# Limpa tela e toca beep
clear
play_beep

# --------- Mostra imagem se existir -----------------
if [ -f "$ASCII_IMAGE" ] && command -v kitty &>/dev/null; then
  kitty +kitten icat "$ASCII_IMAGE"
fi

sleep 0.2
echo ""
type_line "  > Initializing terminal protocol: [kitty]"
sleep 0.2
type_line "  > Booting $OS_NAME on $DEVICE_NAME..."
sleep 0.2
type_line "  > Bypassing EFI... ✔"
sleep 0.2
type_line "  > Loading Gruvbox interface... ☕"
sleep 0.2
type_line "  > Verifying soul of machine...  [Free...]"
sleep 0.2
type_line "  > 'Think Different'? Nah. Run Arch."
sleep 0.3
echo ""
type_line "  $WELCOME_MSG"
echo ""
echo -e "  🖥️  \033[1;32m$(uname -srmo)\033[0m" | (command -v lolcat &>/dev/null && lolcat || cat)
echo ""
