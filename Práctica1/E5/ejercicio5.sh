------------------------------------------------------------
EJERCICIO 5
------------------------------------------------------------
#Desarrollar un script que reciba como parametros la ruta de un directorio y un numero entero N de horas, y liste todos los ficheros que se encuentren dentro de dicho directorio que hayan sido modificados en las N horas anteriores. Recuerda realizar los controles de errores oportunos.

 #!/bin/bash
if [ $# == 2 ] ; then
    if [ -d $1 ]; then
        if `echo $2 | grep -q '[0-9]\+'`; then
            hours=$2;
            minutes=$((hours*60));
            find $1 -mmin -$minutes -type f
        else
            echo "Introduzca como segundo parametro un número entero"
        fi
    else
       echo "El directorio $1 no existe"
    fi
else
    echo "Son necesarios dos parámetros"
    echo "Uso: ./ejercicio5.sh <ruta_directorio> <num_horas>"
fi
#sort [fichero]: ordena la entrada estándar o un fichero. 
#sort -r: inverso. sort -n: orden numérico. sort -t c: cambia el caracter separador al caracter c. sort -k 3: cambia la clave de ordenación a la tercera columna 
