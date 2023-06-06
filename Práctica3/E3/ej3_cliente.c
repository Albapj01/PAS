#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <mqueue.h>
#include <time.h>
#include <errno.h>
#include <signal.h>   
#include "ej3_common.h"

mqd_t mq_server;
mqd_t mq_client;

// Creamos el Buffer para intercambiar mensajes
char writeBuffer[MAX_SIZE];
char readBuffer[MAX_SIZE];

char serverQueue[100];
char clientQueue[100];

void funcionLog(char *);

FILE *fLog = NULL; // Apuntador al fichero de log.

void stop(int signal);

int main(int argc, char **argv)
{
	if (signal(SIGINT, stop) == SIG_ERR)
   {
		printf("No puedo asociar la señal SIGINT al manejador!\n");
	    funcionLog("No puedo asociar la señal SIGINT al manejador!");
	}

   if (signal(SIGTERM, stop) == SIG_ERR)
	{
   		printf("No puedo asociar la señal SIGTERM al manejador!\n");
   		funcionLog("No puedo asociar la señal SIGTERM al manejador!");
	}

	// Cola del servidor
	sprintf(serverQueue, "%s-%s", SERVER_QUEUE, getenv("USER"));
    printf ("(Cliente) El nombre de la cola del servidor es: %s\n", serverQueue);

	sprintf(clientQueue, "%s-%s", CLIENT_QUEUE, getenv("USER"));
    printf ("(Cliente) El nombre de la cola del cliente es: %s\n", clientQueue);

    mq_server = mq_open(serverQueue, O_WRONLY);
    mq_client = mq_open(clientQueue, O_RDONLY);

	if(mq_server == (mqd_t)-1 )
	{
      perror("Error al abrir la cola del servidor");
      funcionLog("Error al abrir la cola del servidor");
      exit(-1);
	}

	if(mq_client == (mqd_t)-1 )
	{
      perror("Error al abrir la cola del cliente");
      funcionLog("Error al abrir la cola del cliente");
      exit(-1);
	}

    printf ("(Cliente) El descriptor de la cola del servidor es: %d\n", (int) mq_server);
    printf ("(Cliente) El descriptor de la cola del cliente es: %d\n", (int) mq_client);

	printf("Mandando mensajes al servidor (escribir \"%s\" para parar):\n", MSG_STOP);
	do
	{
		printf("> ");

		//Leer por teclado
		fgets(writeBuffer, MAX_SIZE, stdin);

		// Enviar y comprobar si el mensaje se manda
		if(mq_send(mq_server, writeBuffer, MAX_SIZE, 0) != 0)
		{
			perror("Error al enviar el mensaje");
			funcionLog("Error al enviar el mensaje");
			exit(-1);
		}
		funcionLog(strtok(writeBuffer,"\n"));

		// Número de bytes leidos
		ssize_t bytes_read;

		// Recibir el mensaje
		bytes_read = mq_receive(mq_client, readBuffer, MAX_SIZE, NULL);
		// Comprar que la recepción es correcta (bytes leidos no son negativos)
		if(bytes_read < 0)
		{
			perror("Error al recibir el mensaje");
			funcionLog("Error al recibir el mensaje");
			exit(-1);
		}
		// Cerramos la cadena
		//buffer[bytes_read] = '\0';
		printf("%s\n", readBuffer);

	// Iteramos hasta escribir el código de salida
	}
	while (strncmp(writeBuffer, MSG_STOP, strlen(MSG_STOP)));

	// Cerramos la cola del servidor
	if(mq_close(mq_server) == (mqd_t)-1)
	{
		perror("Error al cerrar la cola del servidor");
		funcionLog("Error al cerrar la cola del servidor");
		exit(-1);
	}

	if(mq_close(mq_client) == (mqd_t)-1)
	{
		perror("Error al cerrar la cola del cliente");
		funcionLog("Error al cerrar la cola del cliente");
		exit(-1);
	}

	return 0;
}

void funcionLog(char *mensaje)
{
	int result;
	char fileName[100];
	char date[100];
	char messajeToWritte[300];
	time_t t;

	// Abrir el fichero
	sprintf(fileName,"log-cliente.txt");
	if(fLog==NULL)
	{
		fLog = fopen(fileName,"at");
		if(fLog==NULL)
		{
			perror("Error abriendo el fichero de log");
			exit(1);
		}
	}

	// Obtenemos la hora actual
	t = time(NULL);
	struct tm * p = localtime(&t);
	strftime(date, 1000, "[%Y-%m-%d, %H:%M:%S]", p);

	// Incluimos la hora y el mensaje que nos pasan
	snprintf(messajeToWritte, (sizeof(messajeToWritte)+6),"%s ==> %s\n", date, mensaje);

	// Finalemente escribimos en el fichero
	result = fputs(messajeToWritte,fLog);
	if (result < 0)
		perror("Error escribiendo en el fichero de log");

	fclose(fLog);
	fLog=NULL;
}

void stop(int signal)
{
	sprintf(writeBuffer, "Capturada la señal con identificador: %d", signal);
	funcionLog(writeBuffer);
	sprintf(writeBuffer, "exit\n");

	if(mq_send(mq_server, writeBuffer, MAX_SIZE, 0) != 0)
	{
		perror("Error al enviar el mensaje");
		funcionLog("Error al enviar el mensaje");
		exit(-1);
	}

	funcionLog(writeBuffer);
	printf("\n");

	if(mq_close(mq_server) == (mqd_t)-1)
	{
		perror("Error al cerrar la cola del servidor");
		funcionLog("Error al cerrar la cola del servidor");
		exit(-1);
	}

	if(mq_close(mq_client) == (mqd_t)-1)
	{
		perror("Error al cerrar la cola del cliente");
		funcionLog("Error al cerrar la cola del cliente");
		exit(-1);
	}
	exit(0);
}
