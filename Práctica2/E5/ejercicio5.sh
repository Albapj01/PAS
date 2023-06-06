------------------------------------------------------------
EJERCICIO 5
------------------------------------------------------------
#Creaunscriptquemuestrelasiguienteinformacio ́nobtenidaapartirdelfichero/etc/group: 1. Grupos que contengan al menos 1 usuario adema ́s del usuario principal del grupo.
#2. Grupos cuyo nombre empiece por u y acabe en s. 3.Gruposquenocontenganningu ́nusuarioadicional.
#4. Grupos con GID menor que 100.

#!/bin/bash

echo "1) Grupos que contengan al menos 1 usuario además del usuario principal del grupo"
echo
echo "$(cat /etc/group | grep -Eo '^[^ ]+:[^ ]+:[^ ]+:[^ ]+')"
echo
echo "2) Grupos cuyo nombre empiece por u y acabe por s"
echo
echo "$(cat /etc/group | grep -Eo '^u.*s:[^_]:.*$')"
#cat /etc/group | awk -F ":" '{print $1}' | grep -E '^u'| grep -E 's$'
#este es el que funciona
echo
echo "3) Grupos que no contengan ningún usuario adicional"
echo
echo "$(cat /etc/group | grep -Eo '^[^ ]+:[^ ]+:[^ ]+:$')" #() Selecciona la secuencia que hay entre paréntesis2
echo
echo "4) Grupos con GID menor que 100"
echo
echo "$(cat /etc/group | grep -Eo '^[^ ]+:[^ ]+:[0-9]{2}:.*$')" #{}Selecciona lo anterior entre n y m veces
#grep [opciones] patron [fichero(s)]:
#patron: “ˆ” significa comienzo de la línea, “$” significa fin de la línea, “.” significa cualquier carácter
#-i: hace que considere igual mayúsculas y minúsculas.
#-o: en lugar de imprimir las líneas completas que cumplen el patrón, solo muestra el emparejamiento del patrón. 
#-v: mostrar las líneas que no cumplen el patrón.
