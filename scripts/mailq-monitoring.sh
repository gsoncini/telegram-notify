#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

barra=$( df -lh | egrep "/$" | awk '{print $5}' | sed 's/%//' )
varsize=$(  df -lh | grep /var | awk '{print $4}' | sed 's/%//' | sed 's/\./ /' | awk '{print $1}' | sed 's/G//' )
loadaverage=$(top -n 1 -b | grep "load average" | awk '{print $12}' | sed 's/...,.*//')
mailq=$(mailq | grep -i "requests" | awk '{print$5}')

# VAR
if [[ ${varsize} != "" ]] && [[ ${varsize} -lt 11 ]]
then
      /usr/local/sbin/telegram-notify --error --text "*PROBLEMA* -- TAMANHO DO VAR MENOR QUE 10G *MAIL-SERVER*"

fi

# LOAD
if [[ ${loadaverage} -gt 20 ]]
then
     /usr/local/sbin/telegram-notify --error --text "*PROBLEMA* -- LOAD MAIOR DO QUE 20% *MAIL-SERVER*"

fi

# BARRA
if [[ ${barra} -gt 92 ]]
then

    /usr/local/sbin/telegram-notify --error --text "*PROBLEM* -- TAMANHO DO BARRA MAIOR QUE 92% *MAIL-SERVER*"

fi

# MAILQ-50-REQUESTS
if [[ ${mailq} -gt 50 ]]
then
     /usr/local/sbin/telegram-notify --error --text "*PROBLEMA* -- TAMANHO DA FILA DE E-MAILS MAIOR QUE 50 *MAIL-SERVER*"

fi    

# LIMPA MAILER-DAEMON
/usr/bin/mailq | /bin/grep MAILER | /usr/bin/awk '{print "postsuper -d " $1}' | /bin/sed 's/*//g' > /root/limpafila.sh;/root/limpafila.sh
