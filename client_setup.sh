#!/bin/bash
# script to download and setup the desktop files for FTB_Launcher

if [ ! -d ~/ftb ]; then
  mkdir -p ~/ftb
fi

cd ~/ftb

curl http://ftb.forgecdn.net/FTB2/launcher/FTB_Launcher.jar -o FTB_Launcher.jar
curl -k https://apexminecrafthosting.com/wp-content/uploads/2015/09/ftb-logo-square_565.png -o ftb_logo.png

cat << EOF > ~/.local/share/applications/FTB.desktop
#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Terminal=false
Type=Application
Name=FTB
Exec=java -jar ${HOME}/ftb/FTB_Launcher.jar
Icon=${HOME}/ftb/ftb_logo.png
EOF
