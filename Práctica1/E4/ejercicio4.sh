-----------------------------------
EJERCICIO 4
-----------------------------------
#Desarrolla un script que permita listar todos los ficheros de un directorio sin mostrar los sub- directorios pero incluyendo los ficheros que estos puedan contener. El nombre del fichero debera ́ mostrar sin su ruta, solo incluyendo el nombre. Adema ́s, se debera ́ an ̃adir un nu ́mero que indi- cara ́ el orden de cada fichero y tambie ́n otro nu ́mero que indicara ́ el nu ́mero de caracteres del mismo, tal y como se muestra en el siguiente ejemplo:

#!/bin/bash
#./ejer4.sh ejemplo
cont=0

if [ $# -eq 1 ];
then
	if [ -d $1 ]; # $1 se refiere al primer argumento de la linea
	then	
	echo "Formato correcto. "	
	for x in $(find $1) 
	do
		if [ -f $x ];
		then
			let cont=cont+1 #se usa para operaciones aritmeticas 
	        	nombre_sin_ruta=$(basename $x) #basename devuelve el nombre del fichero sin la ruta donde se encuentra
	        	echo -n "$cont    $nombre_sin_ruta      "	
			#printf "%10s            %10s" $cont $nombre_sin_ruta
	        	caracteres=$(echo -n $nombre_sin_ruta | wc -m )	
	        	if [ $caracteres -eq 1 ] #comparacion singular o plural
	        	then
	        		#echo "$caracteres caracter"
				printf "%10s %10s \n" $caracteres "caracter" 
	        	else
	            		#echo "$caracteres caracteres"
				printf "%10s %10s \n" $caracteres "caracteres" 
	        	fi
	        fi   
    	done
	fi
else
   echo "Formato incorrecto. Tiene que insertar algo como: ./ejer4.sh nombre_directorio  "
   exit 1
fi 

