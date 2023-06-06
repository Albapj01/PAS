#Alba Palomino Jimenez

------------------------------------------------------------
EJERCICIO 1
------------------------------------------------------------
#Desarrollar un script que permita generar un directorio con ficheros y subdirectorios de ejem-
#plo que podra ́s utilizar en futuros ejercicios de esta pra ́ctica. El script recibira ́ 3 argumentos: 1. Ruta del nuevo directorio que se va a crear.
#2. Nu ́mero de subdirectorios que se creara ́n dentro del directorio principal. 3.Longituddelosnombresdelosficheros(sinextensio ́n)ysubdirectorios.
#Al ejecutarlo, debera ́ crear un directorio principal en la ruta que se haya especificado en el primer para ́metro. Dentro de ese directorio, se debera ́n crear N subdirectorios (indicado por el segun- do para ́metro) con nombres aleatorios de la longitud especificada por el tercer para ́metro. Por u ́ltimo, dentro de cada uno de estos subdirectorios, se creara ́n 4 ficheros (vac ́ıos) con nombres aleatoriosylasextensiones.sh, .html, .keyy.txt.
#En el caso de que se indique el nombre de una carpeta que ya existe, se debera ́ pedir confir- macio ́nparaeliminarlaantesdecrearlanuevacarpeta.

#!/bin/bash

if [ $# -ne 3 ]; #si no son 3 da error
then
  echo "Debe introducir estos tres argumentos:"
  echo "1 ruta del nuevo directorio que se va a crear"
  echo "2 numero de subdirectorios que se crearan dentro del directorio principal"
  echo "3 longitud de los nombres de los ficheros y subdirectorios"
  exit 1
fi

if [ -d $1 ]; #-d es para el direccotrio
then
  echo "El directorio ya existe"
  echo "Desea borrarlo s/n"
  read respuesta #lee la respuesta introducida por pantalla
  if [ $respuesta == "s" ]
  then 
     rm -r $1 #se elimina el directorio
     echo "El directorio se ha eliminado"
     ./ejercicio1.sh $1 $2 $3 #vuelve a ejecutarlo
  fi
  exit 2
fi

mkdir $1 #se crea el primer directorio
for (( i=1; $i<=$2; i=$i+1))
do
  nombre=$(tr -dc A-Za-z0-9 < /dev/urandom | head -c $3)
  mkdir $1/$nombre #se crea la primera carpeta dentro del directorio establecido
  touch $1/$nombre/$(tr -dc A-Za-z0-9 < /dev/urandom | head -c $3).sh #se crean los ficheros en la ruta establecida y el $3 es modificable
  touch $1/$nombre/$(tr -dc A-Za-z0-9 < /dev/urandom | head -c $3).html #funcion que genera nombres aleatotrios
  touch $1/$nombre/$(tr -dc A-Za-z0-9 < /dev/urandom | head -c $3).key
  touch $1/$nombre/$(tr -dc A-Za-z0-9 < /dev/urandom | head -c $3).txt
done
