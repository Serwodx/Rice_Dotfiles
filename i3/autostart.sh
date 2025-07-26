#!/bin/bash

#espera o i3 carregar
sleep 1

#aplica o layout ao workspace 1
i3-msg "workspace --no-autoback-and-forth M; append_layout ~/.config/i3/layouts/startup.json"

(kitty   &)
(tty-clock -c &)
(htop &)
(neofetch &)
