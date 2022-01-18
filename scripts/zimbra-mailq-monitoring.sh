#!/bin/bash
# By GSoncini

mailq=$(/opt/zimbra/common/sbin/mailq | grep -i "requests" | awk '{print$5}')

# Verifica Tamanho da Fila de E-mails
if [[ ${mailq} -gt 50 ]]
then
     /usr/local/sbin/telegram-notify --error --text "*PROBLEMA* -- TAMANHO DA FILA DE E-MAILS MAIOR QUE 50 *MAIL-SERVER-X*"

fi
