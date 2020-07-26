#!/bin/bash
rm -rf $HOME/vpsmanagersetup.sh
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "VPS-MANAGER V3.0" ; tput sgr0
tput setaf 3 ; tput bold ; echo "" ; echo "Este script irá:" ; echo ""
echo "● Instalar y configurar el proxy squid en las puertos 80, 3128, 8080 e 8799" ; echo "  para permitir conexiones SSH a este servidor"
echo "● Configurar OpenSSH para ejecutarse en los puertos 22 e 443"
echo "● Instalar un conjunto de secuencias de comandos y comandos del sistema para la gestión de los usuarios" ; tput sgr0
echo ""
tput setaf 3 ; tput bold ; read -n 1 -s -p "Pulse cualquier tecla para continuar ... " ; echo "" ; echo "" ; tput sgr0
tput setaf 2 ; tput bold ; echo "	Terminos de uso" ; tput sgr0
echo ""
echo "Mediante el uso de 'Administrador de VPS-MANAGER V3.0' está de acuerdo con las siguientes condiciones de uso:"
echo ""
echo "1. Tu puedes:"
echo "a. Instalar y utilizar el 'VPS-MANAGER V3.0' en el servidor ."
echo "b. Crear, administrar y eliminar un número ilimitado de usuarios a través de este conjunto de scripts."
echo ""
tput setaf 3 ; tput bold ; read -n 1 -s -p "Aperte qualquer tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
echo "2. Tu no puedes:"
echo "a. Editar, modificar, compartir o redistribuir"
echo "este conjunto de secuencias de comandos sin autorización desarrollador."
echo "b. Modificar O editar el conjunto de script para hacer que se mira el programador de scripts."
echo ""
echo "3. El usuario acepta que:"
echo "a. El conjunto de scripts no incluye garantías o apoyo adicional,"
echo "pero el usuario puede, promocional y de forma no vinculante, por un tiempo limitado,"
echo "recibir apoyo y ayuda para la solución de problemas, siempre que reúna las condiciones de uso."
echo "b. El usuario de este conjunto de scripts es el único responsable de cualquier tipo de implicación"
echo "legal o ética causada por el uso de este conjunto de secuencias de comandos para cualquier propósito."
echo ""
tput setaf 3 ; tput bold ; read -n 1 -s -p "Aperte qualquer tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
echo "4. El usuario acepta que el promotor no se hace responsable de:"
echo "a. Los problemas causados por el uso de scripts no autorizados distribuidos."
echo "b. Los problemas causados por conflictos entre este conjunto de secuencias de comandos y scripts de desarrollador."
echo "c. Los problemas causados por problemas o modificaciones de código script sin permiso."
echo "d. problemas del sistema causados por programas de terceros o cambios / pruebas con usuarios."
echo "e. Los problemas causados por los cambios en el sistema del servidor."
echo "f. problemas causados por el usuario no sigue las instrucciones del conjunto de documentación de los scripts."
echo "g. problemas ocurrieron durante el uso de scripts para beneficio comercial."
echo "h. Los problemas que pueden ocurrir cuando se utiliza el conjunto de scripts en sistemas que no están en la lista de sistemas a prueba."
echo ""
tput setaf 3 ; tput bold ; read -n 1 -s -p "Presina Cualquier tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
IP=$(wget -qO- ipv4.icanhazip.com)
read -p "Para continuar confirme o IP de este servidor: " -e -i $IP ipdovps
if [ -z "$ipdovps" ]
then
	tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "" ; echo " No ha introducido la dirección IP de este servidor. Inténtalo de nuevo. " ; echo "" ; echo "" ; tput sgr0
	exit 1
fi
if [ -f "/root/usuarios.db" ]
then
tput setaf 6 ; tput bold ;	echo ""
	echo "Se encontró una base de datos de usuario ('usuarios.db')!"
	echo "¿Quieres mantenerlo (preservando el límite de conexiones simultáneas de los usuarios)"
	echo "o crear una nueva base de datos?"
	tput setaf 6 ; tput bold ;	echo ""
	echo "[1] Mantener la base de datos actual"
	echo "[2] Crear una nueva base de datos"
	echo "" ; tput sgr0
	read -p "Opção?: " -e -i 1 optiondb
else
	awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > /root/usuarios.db
fi
echo ""
read -p "¿Quieres activar la compresión de SSH (puede aumentar el consumo de memoria RAM)? [s/n]) " -e -i n sshcompression
echo ""
tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Espere a que la configuración automática" ; echo "" ; tput sgr0
sleep 3
apt-get update -y
apt-get upgrade -y
rm /bin/criarusuario /bin/expcleaner /bin/sshlimiter /bin/addhost /bin/listar /bin/sshmonitor /bin/vps > /dev/null
rm /root/ExpCleaner.sh /root/CriarUsuario.sh /root/sshlimiter.sh > /dev/null
apt-get install squid3 bc screen nano unzip dos2unix wget -y
killall apache2
apt-get purge apache2 -y
if [ -f "/usr/sbin/ufw" ] ; then
	ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp
fi
if [ -d "/etc/squid3/" ]
then
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/Install/squid.txt -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/Install/squid2.txt -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid3/squid.conf
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/Install/payload.txt -O /etc/squid3/payload.txt
	echo " " >> /etc/squid3/payload.txt
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/addhost.sh -O /bin/addhost
	chmod +x /bin/addhost
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/alterarclaveusuario.sh -O /bin/alterarclaveusuario
	chmod +x /bin/alterarclaveusuario
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/socks.sh -O /bin/socked
	chmod +x /bin/socked
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/shadowsocks.sh -O /bin/shadowsocks
	chmod +x /bin/shadowsocks
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/crearusuario2.sh -O /bin/crearusuario
	chmod +x /bin/crearusuario
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/delhost.sh -O /bin/delhost
	chmod +x /bin/delhost
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/expcleaner2.sh -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/mudardata.sh -O /bin/mudardata
	chmod +x /bin/mudardata
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/remover.sh -O /bin/remover
	chmod +x /bin/remover
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/sshlimiter2.sh -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/alterarlimite.sh -O /bin/alterarlimite
	chmod +x /bin/alterarlimite
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/vps.sh -O /bin/vps
	chmod +x /bin/vps
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/sshmonitor2.sh -O /bin/sshmonitor
	chmod +x /bin/sshmonitor
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/extra/speedtest.py -O /bin/speedtest.py
	chmod +x /bin/speedtest.py
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/extra/badvpnsetup.sh -O /bin/badvpnsetup
	chmod +x /bin/badvpnsetup
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/extra/userbackup.sh -O /bin/userbackup
	chmod +x /bin/userbackup
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/extra/openvpn-install.sh -O /bin/openvpn-install
	chmod +x /bin/openvpn-install
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/extra/tcptweaker.sh -O /bin/tcptweaker
	chmod +x /bin/tcptweaker
	if [ ! -f "/etc/init.d/squid3" ]
	then
		service squid3 reload > /dev/null
	else
		/etc/init.d/squid3 reload > /dev/null
	fi
	if [ ! -f "/etc/init.d/ssh" ]
	then
		service ssh reload > /dev/null
	else
		/etc/init.d/ssh reload > /dev/null
	fi
fi
if [ -d "/etc/squid/" ]
then
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/Install/squid1.txt -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/Install/squid.txt -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid/squid.conf
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/Install/payload.txt -O /etc/squid/payload.txt
	echo " " >> /etc/squid/payload.txt
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/2/addhost.sh -O /bin/addhost
	chmod +x /bin/addhost
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/alterarclaveusuario.sh -O /bin/alterarclaveusuario
	chmod +x /bin/alterarclaveusuario
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/crearusuario2.sh -O /bin/crearusuario
	chmod +x /bin/crearusuario
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/2/delhost.sh -O /bin/delhost
	chmod +x /bin/delhost
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/expcleaner2.sh -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/mudardata.sh -O /bin/mudardata
	chmod +x /bin/mudardata
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/remover.sh -O /bin/remover
	chmod +x /bin/remover
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/sshlimiter2.sh -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/alterarlimite.sh -O /bin/alterarlimite
	chmod +x /bin/alterarlimite
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/vps.sh -O /bin/vps
	chmod +x /bin/vps
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/sshmonitor2.sh -O /bin/sshmonitor
	chmod +x /bin/sshmonitor
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/extra/speedtest.py -O /bin/speedtest.py
	chmod +x /bin/speedtest.py
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/extra/badvpnsetup.sh -O /bin/badvpnsetup
	chmod +x /bin/badvpnsetup
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/extra/userbackup.sh -O /bin/userbackup
	chmod +x /bin/userbackup
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/extra/openvpn-install.sh -O /bin/openvpn-install
	chmod +x /bin/openvpn-install
	wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/VPS-MANAGER-V3.0/master/scripts/extra/tcptweaker.sh -O /bin/tcptweaker
	chmod +x /bin/tcptweaker
	if [ ! -f "/etc/init.d/squid" ]
	then
		service squid restart > /dev/null
	else
		/etc/init.d/squid restart > /dev/null
	fi
	if [ ! -f "/etc/init.d/ssh" ]
	then
		service ssh restart > /dev/null
	else
		/etc/init.d/ssh restart > /dev/null
	fi
fi
echo ""
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Proxy squid instalado y en ejecución en los puertos: 80, 3128, 8080 y 8799" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "OpenSSH se ejecuta en los puertos 22 y 443" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "scripts para la gestión de usuarios instalados" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Lea la documentación para evitar preguntas y problemas!" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Para ver los comandos disponibles, usar el comando: vps" ; tput sgr0
echo ""
if [[ "$optiondb" = '2' ]]; then
	awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > /root/usuarios.db
fi
if [[ "$sshcompression" = 's' ]]; then
	grep -v "^Compression yes" /etc/ssh/sshd_config > /tmp/sshcp && mv /tmp/sshcp /etc/ssh/sshd_config
	echo "Compression yes" >> /etc/ssh/sshd_config
fi
if [[ "$sshcompression" = 'n' ]]; then
	grep -v "^Compression yes" /etc/ssh/sshd_config > /tmp/sshcp && mv /tmp/sshcp /etc/ssh/sshd_config
fi
exit 1
rm -rf $HOME/vpsmanagersetup.sh