#!/bin/bash

# Consider breaking your script into functions, then calling the functions as needed.
# Example: My script for installing Arch Linux:
# https://gitlab.com/TheLinuxNinja/arch-install
resposta="S"

# Throughout this script, there are double and triple lines spaces. Considering trimming these.

# A simple `echo` will do. No string needed.
echo " "
echo "ATUALIZANDO PACOTES...."
# A simple `echo` will do. No string needed.
echo " "
# Don't force a user to wait through an unnecessary SLEEP command
sleep 3

# This line is completely unnecessary
touch READ-ME 

# Not sure why you're writing text from your script into a READ-ME file.
# By the way, the more common filename would be README.TXT
echo "Meu Script de Instalação Linux" > READ-ME
echo "Todo usuário linux tem um script de instalação, estou compartilhando o meu para distribuições linux">> READ-ME
echo "" >> READ-ME
echo "PACOTES">> READ-ME 
echo "">> READ-ME
echo "* instalação de interface gráfica (xfce4, gnome, kde)">> READ-ME
echo "* net-tools">> READ-ME
echo "* spotify">> READ-ME
echo "* Google">> READ-ME
echo "* Pacotes secundários wget, curl, snapd">> READ-ME

# It's uncommon to put the '-y' at the end of the line. It should go where [options] are specified, typically after the `apt` command
# If you run `apt --help`, you'll see the proper syntax is `apt [options] command`
# You aren't doing any error checking. If the `apt update` fails, you should not follow up with `apt upgrade`. This might be where you'd
# want to abort the script on error.
apt update && apt upgrade -y

apt install wget curl -y
# Never clear the screen during script execution. The user needs to see the output to be able to troubleshoot errors.
clear
echo "instalar o gerenciador de pacote snap"
# Sleeping is unnecessary and irritates users.
sleep 3

apt install snapd -y

clear
echo ""
echo "Instalando o pacote net-tools"
sleep 3
echo ""
apt install net-tools -y

clear
echo ""
echo "Instalar o pacote do instalador tasksel"
sleep 3
apt install tasksel -y
clear

echo "Deseja instalar o spotify ? <S>"
# Consider removing interactive prompts and read them from options given during execution, or allow the user to set variables at the
# top of the script (or both).
read resp

declare -u resposta=${resp}


if [ $resposta == "S" ]
then
	
# Why hide curl's output? User would usually like feedback on what is happening. Also, look at using `-L` to follow redirects.
# Blindly piping web content into a `sudo` command is a security hazard. Download the file and inspect it for expected content, first.
	curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
	echo ""
	echo "criando e editando o arquivo  /etc/apt/sources.list.d/spotify.list"
	sleep 3


# This looks like a copy/paste from a "How to install Spotify on Ubuntu" web page. It's not the ideal command for a script.
 	echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list
# Again, no error checking/handling.
	apt-get update && apt-get install spotify-client
	
	clear
	echo "Spotify Instalado ! "
	sleep 3
	clear


else 
	echo "Sem spotify"
	sleep 3
	clear
	

fi


echo "Deseja instalar o google chrome  ? <S>"
read resp

declare -u resposta=${resp}


if [ $resposta == "S" ]
then

# Make up your mind. Either use `wget` or `curl` - be consistent. Use the proper options.
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        dpkg -i google-chrome-stable_current_amd64.deb
# If you're going to install Chrome this way (and this is not the recommended way), clean up the downloaded file.
	clear
	echo "Google Instalado !"


else 
        echo "Sem google chrome"
        sleep 3
        clear


fi



echo "Deseja configurar seu teclado ? <S> "
read resp

declare -u resposta=${resp}

if [ $resposta == "S" ]
then

# This is interactive - consider scripting the response
        dpkg-reconfigure keyboard-configuration
        clear

else 
        echo "Sem configurar o teclado"

fi


echo "Escolha uma interface gráfica"
echo "[1] - kde plasma"
echo "[2] - gnome-desktop environment"
echo "[3] - xfce4-desktop environment"
echo "[4] - Não instalar e encerrar o programa"
while :
do 
        read escolha
        case $escolha in
                1)
# Consider defining a variable that contains the package list and place the variable definition at the top of the script.
                        apt-get install kde-full kdm kde-l10n-ptbr
			taskel install laptop
			clear
			echo "Habilitando o KDE para iniciar após o boot"
			sleep 3
			systemctl set-default graphical.target
                        break
                        ;;
                2)
                        tasksel install desktop gnome-desktop
			tasksel install laptop
			clear
			echo "Habilitando o gnome para iniciar após o boot"
			sleep 3
			systemctl set-default graphical.target

                        break
                        ;;

                3)
                        apt install task-xfce-desktop
                        break
                        ;;
                4) 
                        echo "não instalar"
                        break
                        ;;
                esac
done
clear

echo "Deseja reiniciar a maquina ? <S>"
read resp

declare -u resposta=${resp}


if [ $resposta == "S" ]
then

# This is not what users expect to happen at the end of a script. I would remove it entirely. 5 seconds of delay is annoying.
	echo "O seu computador será reiniciado em 5"
	sleep 1
	clear
	echo "O seu computador será reiniciado em 4"
	sleep 1
	clear
	echo "O seu computador será reiniciado em 3"
	sleep 1
	clear
	echo "O seu computador será reiniciado em 2"
	sleep 1
	clear
	echo "O seu computador será reiniciado em 1"
	sleep 1
	echo "reboot" 

else 
	echo "Vejo você em breve!"
fi 



# Blank lines at the end of the script should be cleaned up.