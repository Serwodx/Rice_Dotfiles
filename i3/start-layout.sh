#!/bin/bash

i3-msg "append_layout ~/.config/i3/layouts/meu-layout.json"
kitty --title "kitty"  &
kitty --title "clock" -e ncmpcpp &
kitty --title "htop" -e htop &
kitty --title "ranger" -e ranger &
