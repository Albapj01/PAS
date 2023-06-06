#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sys/wait.h>
#include <errno.h> //Control de errores
#include <string.h> //Para la funcion strerror(), que permite describir el valor de errno como cadena.

int main() 
{
	pid_t pid;
	int flag, status;
	int result;

	float randomNumber1;
	float randomNumber2;
	float randomNumbersAddition;

	int fileDescriptor[2];
	int i=0;

	// Creamos la tubería
	result = pipe(fileDescriptor);

	if(result==-1)
	{
		printf("\nError al crear la tubería.\n");
		exit(1);
	}
	
	pid = fork();

	switch (pid)
	{
		case -1:
			printf ("No se ha podido crear el proceso hijo...\n");
			exit(EXIT_FAILURE);

		case 0:
			printf ("(Hijo) Mi pid es %d y mi ppid es %d\n", getpid(), getppid());
			
			close(fileDescriptor[1]);
	
			//Recibimos un mensaje a través de la cola
			result = read( fileDescriptor[0], &randomNumbersAddition, sizeof(int));
			
			if(result != sizeof(int))
			{
				printf("\n(Hijo) Error al leer de la tubería...\n");
				exit(EXIT_FAILURE);
			}

			printf("(Hijo) El result de la suma leido de la tubería es: %f.\n", randomNumbersAddition);
					
			// Cerramos el extremo que hemos utilizado
			printf("(Hijo) Tubería cerrada ...\n");
			close(fileDescriptor[0]);
			break;

		default:
			printf ("(Padre) Mi PID es %d y el PID de mi hijo es %d \n", getpid(), pid);
			
			close(fileDescriptor[0]);
			
			srand(time(NULL)); // Semilla de los números aleatorios establecida en la hora actual
				
			randomNumber1 =  (((float)rand()/(float)(RAND_MAX))); // Número aleatorio entre 0 y 4999
			randomNumber2 =  (((float)rand()/(float)(RAND_MAX)));

			printf("(Padre) Escribo el result de la suma de los números aleatorios %f y %f en la tubería...\n", randomNumber1, randomNumber2);
			
			randomNumbersAddition = randomNumber1 + randomNumber2;

			// Mandamos el mensaje
			result = write( fileDescriptor[1], &randomNumbersAddition, sizeof(int));
			
			if(result != sizeof(int))
			{
				printf("\n(Padre) Error al escribir en la tubería...\n");
				exit(EXIT_FAILURE);
			}
			
			
			// Cerramos el extremo que hemos utilizado
			close(fileDescriptor[1]);
			printf("(Padre) Tubería cerrada...\n");
			
			/*Espera del padre a los hijos*/
	        while ( (flag=wait(&status)) > 0 ) 
	        {
		        if (WIFEXITED(status)) {
			        printf("Proceso Padre, Hijo con PID %ld finalizado, status = %d\n", (long int)flag, WEXITSTATUS(status));
		        } 
		        else if (WIFSIGNALED(status)) {  //Para seniales como las de finalizar o matar
			        printf("Proceso Padre, Hijo con PID %ld finalizado al recibir la señal %d\n", (long int)flag, WTERMSIG(status));
		        } 		
	        }
	        if (flag==(pid_t)-1 && errno==ECHILD)
	        {
		        printf("Proceso Padre %d, no hay mas hijos que esperar. Valor de errno = %d, definido como: %s\n", getpid(), errno, strerror(errno));
	        }
	        else
	        {
		        printf("Error en la invocacion de wait o waitpid. Valor de errno = %d, definido como: %s\n", errno, strerror(errno));
		        exit(EXIT_FAILURE);
	        }			 
	}
	exit(EXIT_SUCCESS);
}
