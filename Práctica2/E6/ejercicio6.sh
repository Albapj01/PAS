------------------------------------------------------------
EJERCICIO 6
------------------------------------------------------------
#Desarrollaunscriptque,utilizandoelcomandodf,muestrelasiguienteinformacio ́n:
#1. Sistemasdeficheroscuyonu ́merodebloquestengaalmenosNcifras,dondeNeselprimer argumento de l ́ınea de comandos.
#2. Sistemas de ficheros cuyo porcentaje de uso sea inferior al 10 %.
#3. Sistemas de ficheros cuyo porcentaje de uso sea de al menos el 90 %.

#!/bin/bash
#chmod u+x .sh

variable=${1}


if [ $# -ne 1 ] #Comprueba que se han pasado dos elementos por linea de comandos
then
		echo "Uso: ./ejercicio3.sh <numero>"
		exit
fi

echo "1) Sistemas de ficheros cuyo numero de bloques tenga al menos ${1} cifras"
df | grep -E "^[a-Z0-9/:\\]+[[:space:]]+[0-9]+[[:space:]]+[0-9]{${1},}+[[:space:]]" 

echo ""
echo "2) Sistemas de ficheros cuyo porcentaje de uso sea inferior al 10%"
df | grep -E "^[a-Z0-9/:\\]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]{,1}%" 

echo ""
echo "3) Sistemas de ficheros cuyo porcentaje de uso sea superior a 90%"
df | grep -E "^[a-Z0-9/:\\]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+[0-9]+[[:space:]]+(90|91|92|93|94|95|96|97|98|99|100)%"


EJERCICIO 6 DE OTRA FORMA
#!/bin/bash

echo "1) Sistemas de ficheros cuyo numero de bloques tenga al menos $1 cifras"
df | grep -E "^[^ ]+[[:space:]]+[0-9]{$1}.*"

echo ""
echo "2) Sistemas de ficheros cuyo porcentaje de uso sea inferior al 10%"
df | grep -E "^[^ ]+[[:space:]]+[^ ]+[[:space:]]+[^ ]+[[:space:]]+[^ ]+[[:space:]]+[0-9]{1}%"

echo ""
echo "3) Sistemas de ficheros cuyo porcentaje de uso sea superior a 90%"
df | grep -E "^[^ ]+[[:space:]]+[^ ]+[[:space:]]+[^ ]+[[:space:]]+[^ ]+[[:space:]]+(90|91|92|93|94|95|96|97|98|99|100)%"