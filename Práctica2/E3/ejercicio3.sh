------------------------------------------------------------
EJERCICIO 3
------------------------------------------------------------
#Desarrollar un script que reciba como argumento el nombre de un fichero de texto y extraiga cada palabra u ́nica que aparezca en ese fichero. Cada palabra se debera ́ mostrar en una l ́ınea diferente y debera ́n estar ordenadas por orden alfabe ́tico. Adema ́s de la palabra, en cada l ́ınea semostrara ́elnu ́merodeordenylalongituddelapalabra.Recuerdarealizarloscontrolesde erroresoportunos.

#!/bin/bash
#Antes de todo crea un fcihero x.txt con algo escrito dentro para que lo lea y saque las palabras.

if [ $# -ne 1 ]
then
	echo "Argumentos incorrectos. Inserte algo parecido a: 
./ejer3.sh <fichero_de_texto>"
	exit
fi

for i in $(cat x.txt|sed 's/\,//g'|sed 's/\.//g'|sed 's/\s\+/\n/g'|sed -e 's/\(.*\)/\L\1/')
do
	echo "$i ${#i}"
done| sort -k1,1 -k2,2nr|uniq|column -t -s " "|nl

