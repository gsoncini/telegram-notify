#!/bin/bash
 
> /root/output_aux.txt
 
iplist=($( cat /root/lista.txt ))
 
for each in ${iplist[@]}
do    
        echo "SERVIDOR ${each}" >> /root/output_aux.txt
            /root/blacklistnator.sh ${each} >> /root/output_aux.txt
                    
                    sed -i '/---/d' /root/output_aux.txt
                       
                    iplist_number=$( cat /root/lista.txt | wc -l )
                            iplist_output=$( cat /root/output_aux.txt | wc -l )
 
                                #if [[ ${iplist_output} -gt ${iplist_number} ]] 
                                    if [[ $( cat /root/output_aux.txt | wc -l) -gt 3 ]]         
                                                  then
                             # ADICIONA AQUI A LINHA DO TELEGRAM
                        output=$( cat /root/output_aux.txt )
                                /usr/local/sbin/telegram-notify --error --icon 212C --silent --text "$output"
                        fi
                                                sleep 5        
                             > /root/output_aux.txt    
                                    done

