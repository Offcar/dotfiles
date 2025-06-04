#/bin/bash

prompt(){
	message=$1
	while true
	do
		read -p "$message (Y/n): " choice
		case $choice in
			[yY]* )
				return 0
				;;
			[nN]* )
				return 1
				;;
			* ) 
				clear
				;;
		esac
	done
}

clear
if prompt "= etc/apt/sources.list : ¿Agregar Contrib?"; then
	# if prompt " = ¿Hacer backup de actual etc/apt/sources.list?"; then
	# 	printf "\n - Creando copia de etc/apt/sources.list -> etc/apt/sources.list.bak\n"
	# 	sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
	# 	sleep 3
	# fi

	printf "\n - Reescribiendo /etc/apt/sources.list\n"
	sleep 2
	sudo sh -c "echo 'deb http://deb.debian.org/debian/ bookworm main contrib non-free-firmware' > /etc/apt/sources.list"
	sudo sh -c "echo 'deb-src http://deb.debian.org/debian/ bookworm main contrib non-free-firmware' >> /etc/apt/sources.list"
	sudo sh -c "echo 'deb http://deb.debian.org/debian-security bookworm-security main contrib non-free-firmware' >> /etc/apt/sources.list"
	sudo sh -c "echo 'deb-src http://deb.debian.org/debian-security bookworm-security main contrib non-free-firmware' >> /etc/apt/sources.list"
	sudo sh -c "echo 'deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free-firmware' >> /etc/apt/sources.list"
	sudo sh -c "echo 'deb-src http://deb.debian.org/debian/ bookworm-updates main contrib non-free-firmware' >> /etc/apt/sources.list"
	printf "\n - /etc/apt/sources.list ¡ACTUALIZADO!\n"
	sleep 2
	printf "\n - NALA UPDATE\n"
	sudo nala update
	sleep 3
fi

clear
if prompt "= ¿Instalar SWAY? ="; then
	printf "\n - ¡Instalando Sway con varios paquetes útiles! ... \n"; sleep 2;
	sudo nala update
	sudo nala install sway sway-notification-center swaybg alacritty wofi grimshot wf-recorder waybar lxpolkit python3-i3ipc pamixer brightnessctl -y
	sleep 2
	
	printf "\n - Limpiando archivos prexistentes de Sway y Waybar \n"; sleep 2;
	sudo rm -rf $HOME/.config/sway
	sudo rm -rf $HOME/.config/waybar

	printf "\n - Creando carpeta para ./config/sway \n"; sleep 2;
	mkdir $HOME/.config/sway
	printf "\n - Sway: Descargando config de repo \n";sleep 2;
	curl https://raw.githubusercontent.com/Offcar/dotfiles/refs/heads/main/sway_config -o $HOME/.config/sway/config -s
	curl https://raw.githubusercontent.com/Offcar/dotfiles/refs/heads/main/red_1.jpg -o $HOME/.config/sway/red_1.jpg -s

	sleep 2; printf "\n - Creando carpeta para ./config/sway \n"; sleep 2;
	mkdir $HOME/.config/waybar
	printf "\n - Waybar: Descarga de github \n"; sleep 2
	curl https://raw.githubusercontent.com/Offcar/dotfiles/refs/heads/main/waybar_config.jsonc -o $HOME/.config/waybar/config.jsonc -s
	curl https://raw.githubusercontent.com/Offcar/dotfiles/refs/heads/main/waybar_style.css -o $HOME/.config/waybar/style.css -s

	printf "\n - Autotiling: Descarga de github \n"; sleep 2
	curl https://raw.githubusercontent.com/nwg-piotr/autotiling/refs/heads/master/autotiling/main.py -o $HOME/.config/sway/autotiling -s

	printf "\n - Autotiling: Dando permisos a script autotiling \n"; sleep 2;
	sudo chmod +x $HOME/.config/sway/autotiling
	sleep 3
fi

# clear
# if prompt "= ¿Instalar Flatpaks?"; then
# 	printf "\n - Instalando flatpak \n"; sleep 2;
# fi
# clear
# if prompt "= ¿Instalar elementos DEV?"; then
# 	sudo nala install alacritty tmux
# fi

