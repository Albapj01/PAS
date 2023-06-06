#include <grp.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include <pwd.h>
#include <ctype.h>
#include <getopt.h>
#include <stdio.h>

int main(int argc, char **argv)
{
    int c;

    // Deshabilitar la impresion de errores por defecto
    opterr = 0;

    // Declaracion de las estructuras que almacenarán la informarción de un usuario y de un grupo
    char *lgn;
    int uid;
    char *gname;
    int gid;
    char *name;
    struct passwd *pw;
    struct group *gr;

    // Estructura a utilizar por getoptlong
    static struct option long_options[] = {
        {"user", required_argument, NULL, 'u'},
        {"group", required_argument, NULL, 'g'},
        {"active", no_argument, NULL, 'a'},
        {"maingroup", no_argument, NULL, 'm'},
        {"allgroups", no_argument, NULL, 's'},
        {"help", no_argument, NULL, 'h'},
        {0, 0, 0, 0}};

    // Estas variables son creadas para almacenar el resultado de procesar la línea de comandos
    char *uvalue = NULL;
    char *gvalue = NULL;
    bool aflag = false;
    bool mflag = false;
    bool sflag = false;
    bool hflag = false;

    while ((c = getopt_long(argc, argv, "u:g:amsh", long_options, NULL)) != -1)
    {
        switch (c)
        {
        case 'u':
            uvalue = optarg;
            break;

        case 'g':
            gvalue = optarg;
            break;

        case 'a':
            aflag = true;
            break;

        case 'm':
            mflag = true;
            break;

        case 's':
            sflag = true;
            break;

        case 'h':
            hflag = true;
            break;
        }
    }

    if (argc == 1)
    {
        if ((lgn = getenv("USER")) == NULL || (pw = getpwnam(lgn)) == NULL)
        {
            fprintf(stderr, "Error, no se ha podido obtener información de usuario.\n");
            exit(-1);
        }

        if ((gr = getgrgid(pw->pw_gid)) == NULL)
        {
            fprintf(stderr, "Error, no se ha podido obtener información de grupo.\n");
            exit(-1);
        }

        printf("\nUsuario:\n");
        printf("Nombre: %s\n", strtok(pw->pw_gecos, ",")); 
        printf("Login: %s\n", pw->pw_name);
        printf("Password: %s\n", pw->pw_passwd);
        printf("UID: %d\n", pw->pw_uid);
        printf("Home: %s\n", pw->pw_dir);
        printf("Shell: %s\n", pw->pw_shell);
        printf("Número de grupo principal: %d\n", pw->pw_gid);

        printf("\nGrupo:\n");
        printf("Nombre del grupo principal: %s\n", gr->gr_name);
        printf("GID: %d\n", gr->gr_gid);
        printf("Miembros secundarios: %s\n", *gr->gr_mem);

        exit(0);
    }

    else
    {
        if (hflag)
        {

            printf("Opciones:\n");
            printf("-h, --help                   Imprimir esta ayuda:\n");
            printf("-u, --user (<nombre>|<uid>)  Información sobre el usuario\n");
            printf("-a, --active                 Información sobre el usuario activo actual\n");
            printf("-m, --maingroup              Además de info de usuario, imprimir la info de su grupo principal\n");
            printf("-g, --group (<nombre>|<gid>) Información sobre el grupo\n");
            printf("-s, --allgroups              Muestra info de todos los grupos del sistema\n");

            exit(0);
        }

        else if ((uvalue != NULL) && (gvalue == NULL) && (!aflag) && (!mflag) && (!sflag) && (!hflag))
        {
            if (isdigit(*uvalue))
            {
                uid = atoi(uvalue);

                if ((pw = getpwuid(uid)) == NULL) // DEVUELVE LA ESTRUCTURA TRAS RECIBIR lgn COMO PARÁMETRO
                {
                    fprintf(stderr, "Error, no se ha podido información de usuario.\n");
                    exit(-1);
                }
            }

            else
            {
                lgn = uvalue;

                if ((pw = getpwnam(lgn)) == NULL) // DEVUELVE LA ESTRUCTURA TRAS RECIBIR lgn COMO PARÁMETRO
                {
                    fprintf(stderr, "Error, no se ha podido obtener información de usuario.\n");
                    exit(-1);
                }
            }

            printf("\nUsuario:\n");
            printf("Nombre: %s\n", strtok(pw->pw_gecos, ",")); 
            printf("Login: %s\n", pw->pw_name);
            printf("Password: %s\n", pw->pw_passwd);
            printf("UID: %d\n", pw->pw_uid);
            printf("Home: %s\n", pw->pw_dir);
            printf("Shell: %s\n", pw->pw_shell);
            printf("Número de grupo principal: %d\n", pw->pw_gid);

            exit(0);
        }

        else if ((uvalue != NULL) && (gvalue == NULL) && (!aflag) && (mflag) && (!sflag) && (!hflag))
        {
            if (isdigit(*uvalue))
            {
                uid = atoi(uvalue);

                if ((pw = getpwuid(uid)) == NULL) // DEVUELVE LA ESTRUCTURA TRAS RECIBIR lgn COMO PARÁMETRO
                {
                    fprintf(stderr, "Error, no se ha podido obtener información de usuario.\n");
                    exit(-1);
                }
            }

            else
            {
                lgn = uvalue;

                if ((pw = getpwnam(lgn)) == NULL) // DEVUELVE LA ESTRUCTURA TRAS RECIBIR lgn COMO PARÁMETRO
                {
                    fprintf(stderr, "Error, no se ha podido obtener información de usuario.\n");
                    exit(-1);
                }
            }

            printf("\nUsuario:\n");
            printf("Nombre: %s\n", strtok(pw->pw_gecos, ",")); 
            printf("Login: %s\n", pw->pw_name);
            printf("Password: %s\n", pw->pw_passwd);
            printf("UID: %d\n", pw->pw_uid);
            printf("Home: %s\n", pw->pw_dir);
            printf("Shell: %s\n", pw->pw_shell);
            printf("Número de grupo principal: %d\n", pw->pw_gid);

            if ((gr = getgrgid(pw->pw_gid)) == NULL)
            {
                fprintf(stderr, "Error, no se ha podido obtener información de grupo.\n");
                exit(-1);
            }

            printf("\nGrupo:\n");
            printf("Nombre del grupo principal: %s\n", gr->gr_name);
            printf("GID: %d\n", gr->gr_gid);
            printf("Miembros secundarios: %s\n", *gr->gr_mem);

            exit(0);
        }

        else if ((uvalue == NULL) && (gvalue == NULL) && (aflag) && (!mflag) && (!sflag) && (!hflag))
        {
            if ((lgn = getenv("USER")) == NULL || (pw = getpwnam(lgn)) == NULL)
            {
                fprintf(stderr, "Error, no se ha podido obtener información de usuario.\n");
                exit(-1);
            }

            printf("\nUsuario:\n");
            printf("Nombre: %s\n", strtok(pw->pw_gecos, ",")); 
            printf("Login: %s\n", pw->pw_name);
            printf("Password: %s\n", pw->pw_passwd);
            printf("UID: %d\n", pw->pw_uid);
            printf("Home: %s\n", pw->pw_dir);
            printf("Shell: %s\n", pw->pw_shell);
            printf("Número de grupo principal: %d\n", pw->pw_gid);

            exit(0);
        }

        else if ((uvalue == NULL) && (gvalue == NULL) && (aflag) && (mflag) && (!sflag) && (!hflag))
        {
            if ((lgn = getenv("USER")) == NULL || (pw = getpwnam(lgn)) == NULL)
            {
                fprintf(stderr, "Error, no se ha podido obtener información de usuario.\n");
                exit(-1);
            }

            printf("\nUsuario:\n");
            printf("Nombre: %s\n", strtok(pw->pw_gecos, ",")); 
            printf("Login: %s\n", pw->pw_name);
            printf("Password: %s\n", pw->pw_passwd);
            printf("UID: %d\n", pw->pw_uid);
            printf("Home: %s\n", pw->pw_dir);
            printf("Shell: %s\n", pw->pw_shell);
            printf("Número de grupo principal: %d\n", pw->pw_gid);

            if ((gr = getgrgid(pw->pw_gid)) == NULL)
            {
                fprintf(stderr, "Error, no se ha podido obtener información de grupo.\n");
                exit(-1);
            }

            printf("\nGrupo:\n");
            printf("Nombre del grupo principal: %s\n", gr->gr_name);
            printf("GID: %d\n", gr->gr_gid);
            printf("Miembros secundarios: %s\n", *gr->gr_mem);

            exit(0);
        }

        else if ((uvalue == NULL) && (gvalue != NULL) && (!aflag) && (!mflag) && (!sflag) && (!hflag))
        {
            if (isdigit(*gvalue))
            {
                gid = atoi(gvalue);

                if ((gr = getgrgid(gid)) == NULL) // Devuelve la estructura tras recibir lgn como parametro
                {
                    fprintf(stderr, "Error, no se ha podido obtener información de usuario.\n");
                    exit(-1);
                }
            }

            else
            {
                gname = gvalue;

                if ((gr = getgrnam(gname)) == NULL) // Devuelve la estructura tras recibir lgn como parametro
                {
                    fprintf(stderr, "Error, no se ha podido obtener información de usuario.\n");
                    exit(-1);
                }
            }

            printf("\nGrupo:\n");
            printf("Nombre del grupo principal: %s\n", gr->gr_name);
            printf("GID: %d\n", gr->gr_gid);
            printf("Miembros secundarios: %s\n", *gr->gr_mem);

            exit(0);
        }

        else if ((uvalue == NULL) && (gvalue == NULL) && (!aflag) && (!mflag) && (sflag) && (!hflag))
        {
            int num;
            FILE *f;

            f = fopen("/etc/group", "r");

            if (f == NULL)
            {
                printf("Error al abrir el fichero /etc/group");
                exit(-1);
            }
            char buffer[256];
            char *groupname;
            char *password;
            char *groupid;
            char *groupmembers;
            printf("Grupo:\n");

            while (fgets(buffer, 256, f) != NULL)
            {
                groupname = strtok(buffer, ":");
                password = strtok(NULL, ":");
                groupid = strtok(NULL, ":");
                strtok(NULL, ":");
                groupmembers = strtok(NULL, ":");

                printf("Nombre del grupo principal: %s\n", groupname);
                printf("GID: %s\n", groupid);
                printf("Miembros secundarios: %s\n", groupmembers);
            }

            exit(0);
        }
        else
        {
            printf("Las únicas combinaciones posibles son:\n");
            printf("--help, junto con cualquier otra\n");
            printf("vacío\n");
            printf("--user <usuario>\n");
            printf("--user <usuario> --maingroup\n");
            printf("--active\n");
            printf("--active --maingroup\n");
            printf("--group <grupo>\n");
            printf("--allgroups\n");
            exit(-1);
        }
    }
    exit(0);
}
