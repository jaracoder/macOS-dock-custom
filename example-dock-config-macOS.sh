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
appSafari=$(dock_item "/Applications/Safari.app")

# Configuración
appLaunchpad=$(dock_item "/System/Applications/Launchpad.app")
appSettings=$(dock_item "/System/Applications/System Settings.app")

# Ejecuta el comando "defaults write" como usuario sudo y guarda la configuración en el archivo de preferencias del Dock
sudo su "$LOGGED_USER" -c "defaults write com.apple.dock persistent-apps \
  -array '$appLaunchpad' '$appSettings' '$spacer' '$appSafari' '$spacer'"

# Reinicia el Dock para aplicar los cambios
killall Dock