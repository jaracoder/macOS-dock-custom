#!/bin/bash

# Obtiene el nombre de usuario del usuario actualmente conectado a la consola
LOGGED_USER=$(stat -f%Su /dev/console)

# Define una función para generar el código XML para un elemento de la barra de tareas
dock_item() {
    local app_path="$1"
    printf '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>%s</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>' "$app_path"
}

# Define una función para generar el código XML para un separador en la barra de tareas
spacer_item() {
    printf '{tile-data={}; tile-type="spacer-tile";}'
}

# Genera el código XML para un separador
spacer=$(spacer_item)

# Comunicación
appOutlook=$(dock_item "/Applications/Microsoft Outlook.app")
appTelegram=$(dock_item "/Applications/Telegram.app")
appGoogleChrome=$(dock_item "/Applications/Google Chrome.app")
appSafari=$(dock_item "/Applications/Safari.app")

# Gestión
appKeePassXC=$(dock_item "/Applications/KeePassXC.app")
appGnucash=$(dock_item "/Applications/Gnucash.app")
appAsana=$(dock_item "/Applications/Asana.app")

# Desarrollo
appVMwareFusion=$(dock_item "/Applications/VMware Fusion.app")
appVisualStudio=$(dock_item "/Applications/Visual Studio.app")
appAzureDataStudio=$(dock_item "/Applications/Azure Data Studio.app")
appAndroidStudio=$(dock_item "/Applications/Android Studio.app")
appXcode=$(dock_item "/Applications/Xcode.app")

# Utilidades
appFilezilla=$(dock_item "/Applications/Filezilla.app")
appOpenMTP=$(dock_item "/Applications/OpenMTP.app")

# Video & audio
appOBS=$(dock_item "/Applications/OBS.app")
appFilmora=$(dock_item "/Applications/Wondershare Filmora X.app")
appAvidemux=$(dock_item "/Applications/Avidemux_2.8.1.app")
appKdenlive=$(dock_item "/Applications/kdenlive.app")
appAudacity=$(dock_item "/Applications/Audacity.app")

# Configuración
appLaunchpad=$(dock_item "/System/Applications/Launchpad.app")
appSettings=$(dock_item "/System/Applications/System Settings.app")

# Ejecuta el comando "defaults write" como usuario sudo y guarda la configuración en el archivo de preferencias del Dock
sudo su "$LOGGED_USER" -c "defaults write com.apple.dock persistent-apps \
  -array '$appLaunchpad' '$appSettings' '$spacer' '$appOutlook' '$appTelegram' '$appGoogleChrome' '$appSafari' '$spacer' '$appKeePassXC' '$appGnucash' '$appAsana' '$spacer' \
  '$appVMwareFusion' '$appVisualStudio' '$appAzureDataStudio' '$appAndroidStudio' '$appXcode' '$spacer' '$appOBS' '$appFilmora' '$appAvidemux' '$appKdenlive' '$appAudacity' '$spacer' '$appFilezilla' '$appOpenMTP' '$spacer'"

# Reinicia el Dock para aplicar los cambios
killall Dock