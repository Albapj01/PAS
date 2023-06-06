#Alba Palomino Jimenez

------------------------------------------------------------
EJERCICIO 1
------------------------------------------------------------
#Desarrolla un script que muestre el porcentaje de uso de CPU de cada uno de los usuarios quehayaconectadosenelsistema.Paraello,puedesutilizarlasalidadelcomandops aux.Ten en cuenta que este comando te proporciona el uso de CPU de cada proceso, por lo que debera ́s calcular la suma de los procesos de cada usuario. La salida debera ́ estar ordenada por orden alfabe ́tico segu ́n el nombre de usuario.
#Nota: para quedarte con los elementos u ́nicos de una lista puedes usar el comando uniq mediante una tuber ́ıa.
#Nota 2: las operaciones aritme ́ticas en bash no admiten operaciones con nu ́meros decimales. Para realizar este tipo de operaciones, puedes usar la herramienta bc, que resuelve una opera- cio ́nqueeste ́indicadacomocadenadetexto.Porejemplo:echo "5.3 + 2.4"| bcdara ́como resultado 7.7.

#!/bin/bash

for user in $(ps haux | sed -rne '1!s/^([^ ]+)[ ]+[^ ]+[ ]+([^ ]+).*/\1/p' | sort | uniq)
do
    contador=0.0
    for x in $(ps haux | sed -rne '1!s/^(['$user']+)[ ]+[^ ]+[ ]+([^ ]+).*/\2/p' | sort | uniq)
    do
        contador=$(echo "$contador+$x" | bc)
    done
    echo "El user <$user> consume <$contador>"
done
