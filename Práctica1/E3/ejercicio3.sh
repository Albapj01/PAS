------------------------------------------------------------
EJERCICIO 3
------------------------------------------------------------
#Desarrolla un script que permita realizar una copia de seguridad de un determinado directorio
#y almacenarla en un fichero comprimido. El programa debera ́ recibir dos argumentos: 2
#de ficheros de claves...   
#1. Directorio que se va a copiar.
#2. Directorio donde se almacenara ́ la copia comprimida.
#El nombre del fichero de copia resultante debera ́ seguir el formato: nombredirectoriooriginal A ̃noMesDia.tar.gz.
#Por ejemplo, si se hace una copia del directorio ejemplo el d ́ıa 20 de marzo de 2022, el fichero
#resultante se llamara ́ ejemplo 20220320.tar.gz. Para comprimir el fichero, debera ́s utilizar la herramienta tar. Consulta los argumentos necesarios para comprimir un directorio.
#Si se intenta realizar una copia de un directorio que ya ha sido copiado en ese mismo d ́ıa, se debera ́ mostrar un mensaje y no hacer nada. Si el directorio de destino de la copia no existe, debera ́s crearlo. Adema ́s, debera ́s realizar los controles de errores que estimes oportunos.

#!/bin/bash
#chmod u+x nombre.sh

if [ -d ${1} ] #El primer elemento debe existir y ser un directorio
then
	echo "correcto"
else
	echo "No existe ${1}" #Si no es directorio o no existe sale del programa
	exit
fi

if [ $# -ne 2 ] #Comprueba que se han pasado dos elementos por linea de comandos
then
		echo "Uso: ./ejercicio3.sh <directorio_origen> <directorio_destino>"
		exit
fi

nombre=`date +"${1}_%Y%m%d"` #Se crea el nombre del .tar.gz
fechamodificacion=`date -r ${1} +"%Y%m%d"` #Fecha de modicicacion del primer directorio introducido
fechadehoy=`date +"%Y%m%d"` #Fecha de hoy para comparar con la fecha de la ultima modicacion

if [ $fechamodificacion -eq $fechadehoy ] #Se compara la fecha de la ultima modificacion con la de hoy y si coincide se produce un error
then
	echo "Ya se ha realizado una modiciacion hoy"
	exit
fi

if [ ! -e ${2} ] #Si el segundo elemento no existe, se crea dicho directorio con la direccion introducida
then 
	mkdir ${2}
fi

tar -cvf ${1}.tar.gz ${1} #Si no hay error se comprime
if [ -e ${1}.tar.gz ] #Si el elemento se ha creado correctamente se cambia el nombre por la variable nombre y se mueve al directorio indicado
then
	mv -i ${1}.tar.gz $nombre.tar.gz #no sensible a mayusculas -i
	mv $nombre.tar.gz ${2}
	echo "Copia realizada en ${2}"
fi
#[ -n s1 ]: true si s1 tiene longitud > 0, sino false. 
#[ -z s2 ]: true si s2 tiene longitud 0, sino false.
#[[ s1 == s2* ]]: true si s1 empieza por s2, sino false.
