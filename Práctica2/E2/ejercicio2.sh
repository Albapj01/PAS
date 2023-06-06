------------------------------------------------------------
EJERCICIO 2
------------------------------------------------------------
#Los servidores DNS (Domain Name System) se encargan de resolver un nombre de dominio en
#una direccio ́n IP. Este proceso se lleva a cabo automa ́ticamente mientras navegamos por Internet 1    
#gracias a los servidores DNS que tengamos configurados en nuestro equipo. Debido a que es unaoperacio ́nqueserealizaconfrecuencia,lavelocidadderespuestadeestosservidorespuede afectar a la velocidad con la que navegamos. Por ello, resulta interesante determinar cual es el servidor ma ́s o ́ptimo para nuestra localizacio ́n geogra ́fica.
#Realiza un script que reciba como argumento un fichero de texto que contendra ́ una serie de direcciones IP de servidores DNS y realizara ́ un ping a cada uno de ellos para comprobar la latenciamediadelosmismos.Adema ́s,sepasara ́notrosdosargumentosqueindicara ́nelnu ́mero de pings realizados a cada IP y el timeout.
#Al final, se debera ́ mostrar una lista de las direcciones y el tiempo medio de respuesta de cada uno ordenados de forma ascendente por el tiempo. Si alguna direccio ́n no ha respondido en el tiempo indicado, se debera ́ mostrar al final de la lista. Recuerda realizar los controles de errores oportunos.

#!/bin/bash

#posibles alternativas para tener la latencia media
#ping -c 4 www.stackoverflow.com | tail -1| awk '{print $4}' | cut -d '/' -f 2
#ping -c 4 www.stackoverflow.com | tail -1| awk -F '/' '{print $5}'
#ping -c 4 www.stackoverflow.com | sed '$!d;s|./\([0-9.]\)/.*|\1|'

fichero="$1"
numero_pings="$2"
timeout="$3"

if [ $# -ne 3 ] || [ ! -e $fichero ]
then
    echo "Argumentos incorrecto. Uso: ./ejercicio2.sh <archivo_ips> <número_ping> <timeout>"
    exit
fi

#IFS= read -r line
for ip in $(cat $fichero) #guarda en $ip cada linea del fichero $fichero
do
    #el comando ping nos da mucha informacion
    #con tail -1 nos quedamos solo con la ultima linea
    #awk te permite sacar la columna que quieras separada por el caracter que esta entre comillas
        #si tienes rtt min/avg/max/mdev = 15.392/23.753/42.119/10.922
        #         |---$1--|$2-|-$3|-----$4------|--$5--|--$6--|--$7--|
    pig=$(ping -c $numero_pings -W $timeout $ip | tail -1| awk -F '/' '{print $5}')

    if [[ $pig < $timeout ]] # no se porque pero hay que poner dobles corchetes
    then
        echo "La IP $ip no respondió en $timeout segundos"
    else
        echo "$ip $pig ms"
    fi
done
