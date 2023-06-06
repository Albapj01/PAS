#Desarrolla un script que permita configurar los permisos de los ficheros y subdirectorios de
#una determinada carpeta de la siguiente forma:
#El directorio y todos los subdirectorios debera ́n tener todos los permisos para el usuario, lecturayejecucio ́nparaelgrupoyningunoparaotros.
#Los archivos cuya extensio ́n sea .sh debera ́n recibir permisos de ejecucio ́n para el usuario. Losficherosconextensio ́n.keydebera ́nasegurarse,restringiendolospermisosdemanera
#queso ́loelusuariopropietariopuedaaccederaellos.

#!/bin/bash

dir="$1"

if [ $# -ne 1 ] || [ ! -s $dir ]
then
    echo "Argumentos incorrecto. Uso: ./ejercicio2.sh <ruta_directorio>"
    exit
fi

echo "Cambiando permisos de directorios..."
echo ""

for x in $(find $dir)
do
    if [ -d $x ]
    then
        echo "$x"
        chmod u+rwx $x #El 1 da los 3 permisos al usuario
        chmod g+rx-w $x #El 2 da los permisos de lectura y ejecución pero quita los de escritura al grupo
        chmod o-rwx $x #Y el 3 quita todos los permisos 
    fi
done

echo ""
echo ""
echo "Añadiendo permisos de ejecución a scrips..."
echo ""

for x in $(find $dir)
do
    if [ -d $x ]
    then
        for y in $(find $x)
        do
            echo "$y"
            chmod u+rwx $y/*.sh
        done
    fi
done

echo ""
echo ""
echo "Restringiendo permisos de ficheros de claves..."
echo ""

for x in $(find $dir)
do
    if [ -d $x ]
    then
        for y in $(find $x)
        do
            echo "$y"
            chmod u+rwx $y/*.key
            chmod g-rxw $y/*.key
            chmod o-rwx $y/*.key
        done
    fi
done
