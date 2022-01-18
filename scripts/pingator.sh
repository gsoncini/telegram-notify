#!/bin/bash
# By GSoncini
source=($( cat iplist.txt | awk '{print $1}' ))
sourcesize=$( cat iplist.txt | wc -l )
counter=0

while [[ ${counter} -lt ${sourcesize} ]]
do	

	pinger=$( ping -c 4 ${source[$counter]} | grep "packet loss" | awk '{print $6}' | sed 's/%//' ) 

if [ ${pinger} -eq 0 ]
then
    echo "Pingable"
else
       /usr/local/sbin/telegram-notify --error --text "*PROBLEM* NODE-X ${source[$counter]} NOT PINGABLE"
fi

  let counter++
done
