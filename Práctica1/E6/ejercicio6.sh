-----------------------------------
EJERCICIO 6
-----------------------------------
#Desarrolla un script que simule la creacio ́n de nuevos usuarios. La gestio ́n de usuarios es unatareamuycomu ́nparaunadministradordesistemas.Sinembargo,enlosservidoresdela universidad no tenemos la posibilidad de crear o eliminar usuarios. Por ello, en este ejercicio se pretende crear un sistema de usuarios, muy sencillo, que simule el sistema utilizado en Linux.
#El sistema constara ́ de un fichero (por ejemplo users.txt) que almacenara ́ los usuarios exis- tentes. Por otro lado, cada usuario tendra ́ su home dentro de un directorio (por ejemplo dentro de./homes).Adema ́s,habra ́undirectorioquecontendra ́losficherospordefectoquesean ̃aden al home de un usuario al crearlo (por ejemplo ./skel).
#Dentrodenuestroscriptdeberemosimplementarunafuncio ́ncrearusuarioqueseencar- guedean ̃adirunnuevousuarioalsistemaconelnombreindicadoensuprimerargumento.Al crearlo,loan ̃adira ́alficherodetexto,lecreara ́suhomeymetera ́losarchivospordefectoquese encuentren en el directorio skel. Si se intenta crear un usuario que ya existe, no debera ́ volver a crearlo.
#Una vez creada dicha funcio ́n, el script debera ́ llamarla utilizando como nombre el primer argumento con el que se invoque el script . Recuerda realizar los controles de errores oportunos.

#!/bin/bash

entorno=$(pwd)

function crearUsuario(){
	nombreUsuario=$1
	if [ -d "$homes"/"$nombreUsuario" ] #-s f1 ¿f1 tiene tamaño mayor que cero?
	then
		echo "El usuario ya existe."
		exit
	fi
	echo -e "$nombreUsuario" >> users.txt #-e ¿existe el fichero?
	mkdir "$homes"/"$nombreUsuario"
	cp $entorno/skel/* $entorno/"$homes"/$nombreUsuario/ #cp creo que es copiar
}

if [ ! -d $entorno/homes ] #-l f1 ¿es f1 un enlace simbolico? #! significa no #-a significa y #-o significa o
then
	echo "Creando directorio homes...."
	mkdir homes
	echo "Hecho."
fi

if [ ! -d $entorno/skel ] #-d ¿es un directorio?
then
	echo "Creando directorio skel...."
	mkdir skel
	echo "Hecho."
fi
#Se tienen que crear unos cuantos .txt dentro de skel

if [ $# -ne 1 ] #-r permisos de lectura -w de escritura -x permisos de ejecucion
then
	echo "Argumentos mal metidos. Inserte algo parecido a: 
./ejer6.sh <nombreUsuario>"
	exit 
fi
homes=homes

if [ ! -f users.txt ] #-f ¿es un fichero normal?
then 
	touch users.txt
fi
crearUsuario ${1}
echo "Usuario ${1} creado correctamente."

#chmod u+x nombrefichero.sh
#ls -l
#./nombrefichero.sh
#otro: cat /etc/group ejemplo
