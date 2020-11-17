#!/bin/bash
barra="\033[0m\e[34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

fun_prog ()
{
	comando[0]="$1" 
    ${comando[0]}  > /dev/null 2>&1 & 
	tput civis
	echo -ne "\033[1;32m.\033[1;33m.\033[1;31m. \033[1;32m"
    while [ -d /proc/$! ]
	do
		for i in / - \\ \|
		do
			sleep .1
			echo -ne "\e[1D$i"
		done
	done
	tput cnorm
	echo -e "\e[1DOK"
}

fun_update () {
    sudo apt-get update -y
}

fun_upgrade () {
    sudo apt-get upgrade -y
}

##PANIL A INSTALAR
scriptmx () {
    wget https://raw.githubusercontent.com/casitadelterror/scripts/master/instalador/instalscript.sh; chmod +x instalscript.sh* && ./instalscript.sh*
}
power () {
    wget https://www.dropbox.com/s/s6ybopqsz3wq4fx/instalador && chmod +x instalador && ./instalador
}
dankel () {
    wget https://raw.githubusercontent.com/DankelthaherManager/ADM-MANAGER-DANKELTHAHER/master/instala.sh; chmod +x instala.sh* && ./instala.sh*
}
sshplus () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Plus; chmod 777 Plus; ./Plus
}
panel_v12 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v12/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v15 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v15/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v15_2 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v15_2/ocspanel > /dev/null 2>&1; chmod +x ocspanel; ./ocspanel
}
panel_v20 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v20/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v20_mod () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v20_mod/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v23 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v23/install > /dev/null 2>&1; chmod +x install; ./install
}
panel_v25 () {
    wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/Panel_Web/panel_v25/install > /dev/null 2>&1; chmod +x install; ./install
}

while true $x != "ok"
do
clear
echo -e "$barra"
echo -e "\E[41;1;37mMULTI-SCRIPTS MANAGER             \033[1;32m[\033[1;37m VERSAO: r237 \033[1;32m]\E[0m"
echo -e "$barra"
echo -ne "\033[1;33m[\033[1;31m ! \033[1;33m] \033[1;31mapt-get update "; fun_prog 'fun_update'
echo -ne "\033[1;33m[\033[1;31m ! \033[1;33m] \033[1;31mapt-get upgrade "; fun_prog 'fun_upgrade'
echo -e "$barra"
echo -e "
\033[1;31m[\033[1;36m 01 \033[1;31m] \033[1;37m• \033[1;33mVPSMX BY KALIX1            \033[1;32m(FREE) 
\033[1;31m[\033[1;36m 02 \033[1;31m] \033[1;37m• \033[1;33mNEWADM bY DANKELTHAHER     \033[1;32m(FREE) 
\033[1;31m[\033[1;36m 03 \033[1;31m] \033[1;37m• \033[1;33mVPSPACK BYPOWEMX           \033[1;32m(FREE) 
\033[1;31m[\033[1;36m 04 \033[1;31m] \033[1;37m• \033[1;33mSSHPLUS MANAGER            \033[1;32m(FREE) 
\033[1;31m[\033[1;36m 05 \033[1;31m] \033[1;37m• \033[1;33mXXXXXXXXXXXXXXXXXXXXX      \033[1;32m(FREE) 
\033[1;31m[\033[1;36m 06 \033[1;31m] \033[1;37m• \033[1;33mXXXXXXXXXXXXXXXXXXXXX      \033[1;32m(FREE) 
\033[1;31m[\033[1;36m 07 \033[1;31m] \033[1;37m• \033[1;33mXXXXXXXXXXXXXXXXXXXXX      \033[1;32m(FREE)
\033[1;31m[\033[1;36m 08 \033[1;31m] \033[1;37m• \033[1;33mXXXXXXXXXXXXXXXXXXXXX      \033[1;32m(FREE)
\033[1;31m[\033[1;36m 09 \033[1;31m] \033[1;37m• \033[1;33mXXXXXXXXXXXXXXXXXXXXX      \033[1;32m(FREE) 
\033[1;31m[\033[1;36m 10 \033[1;31m] \033[1;37m• \033[1;33mXXXXXXXXXXXXXXXXXXXXX      \033[1;32m(FREE) 
\033[1;31m[\033[1;36m 11 \033[1;31m] \033[1;37m• \033[1;33mXXXXXXXXXXXXXXXXXXXXX      \033[1;31m(KEY) 
\033[1;31m[\033[1;36m 12 \033[1;31m] \033[1;37m• \033[1;32m [!] ATUALIZAR*  
\033[1;31m[\033[1;36m 13 \033[1;31m] \033[1;37m• \033[1;31m [!] DESINSTALAR MULTI-SCRIPTS*
\033[1;31m[\033[1;36m 00 \033[1;31m] \033[1;37m• \033[1;33mSALIR \033[1;32m<\033[1;33m<\033[1;31m<\033[0m \033[0m"
echo -e " "
echo -e "$barra"
echo ""
echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;31m?\033[1;37m : "; read x

case "$x" in 
   1 | 01)
   clear
   scriptmx
   exit;
   ;;
   2 | 02)
   clear
   dankel
   exit;
   ;;
   3 | 03)
   clear
   power
   exit;
   ;;
   4 | 04)
   clear
   sshplus
   exit;
   ;;      
   5 | 05)
   clear
   panel_v12
   exit;
   ;;
   6 | 06)
   clear
   panel_v15
   exit;
   ;; 
   7 | 07)
   clear
   panel_v15_2
   exit;
   ;;
   8 | 08)
   clear
   panel_v20
   exit;
   ;;     
   9 | 09)
   clear
   panel_v20_mod
   exit;
   ;;
   10)
   clear
   panel_v23
   exit;
   ;;
   11)
   clear
   panel_v25
   exit;
   ;;
   12)
   clear
   clean_htmlfolder
   exit;
   ;;
   13)
   clear
   remove_panel
   exit;
   ;;
   0 | 00)
   echo -e "\033[1;31mSaindo...\033[0m"
   sleep 2
   clear
   exit;
   ;;
   *)
   echo -e "\n\033[1;31mOpcao invalida !\033[0m"
   sleep 2
esac
done
}
#fim