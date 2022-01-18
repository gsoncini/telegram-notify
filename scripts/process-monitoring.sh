#!/bin/sh

# SCRIPT PARA MONITORAMENTO DE PROCESSOS.

# NOME DO PROCESSO A SER MONITORADO:

PROCESSO="mysql"

# NUMERO DE COPIAS DE PROCESSOS RODANDO:

OCORRENCIAS=`ps ax | grep $PROCESSO | grep -v grep| wc -l`

if [ $OCORRENCIAS -eq 0 ]

then

echo "O processo $PROCESSO esta DOWN!" | /usr/local/sbin/telegram-notify --error --text "*PROBLEMA* -- Processo Mysql SRV-X DOWN!"

fi
