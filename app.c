#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include <stdarg.h>
#include <errno.h>

#define QUERY_SIZE 256

#define BUFFER_SIZE 80


static void error_fatal (char *format, ...)
{
  va_list arguments;
  va_start (arguments, format);
  vfprintf (stderr, format, arguments);
  va_end (arguments);
  exit (EXIT_FAILURE);
}

int main(int argc, char** argv) {
    MYSQL *connection;
    MYSQL_RES *result;
    MYSQL_ROW row;
    MYSQL_FIELD *field;
    
    int i;
    int option;

    char query[QUERY_SIZE];
    char buffer[BUFFER_SIZE];
    
    connection = mysql_init(NULL);

    if(mysql_real_connect(connection, "localhost","root","","mydb",0, NULL,0) == NULL) {
        error_fatal ("Greska u konekciji. %s\n", mysql_error (connection));
    }

    while(1) {
          fprintf(stdout,"Odaberite sta zelite da uradite:");
          fprintf(stdout,"1 - spisak i informacije svih clanova studentske organizacije\n");
    }
    
    mysql_close (connection);

    return 0;
}
