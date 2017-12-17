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
    int idp;
    int god;
    
    char faks[21];
    char uni[21];
    char query[QUERY_SIZE];
    char buffer[BUFFER_SIZE];
    char ans[10];
    char mb[14];
    char name[21];
    char surname[21];
    char mail[21];
    char tel[14];
    char komp[31];
    
    connection = mysql_init(NULL);

    if(mysql_real_connect(connection, "localhost","root","","mydb",0, NULL,0) == NULL) {
        error_fatal ("Greska u konekciji. %s\n", mysql_error (connection));
    }

    while(1) {
          fprintf(stdout,"Odaberite sta zelite da uradite:\n");
          fprintf(stdout,"1 - spisak i informacije svih clanova studentske organizacije;\n");
          fprintf(stdout,"2 - spisak i informacije svih projekata;\n");
          fprintf(stdout,"3 - spisak svih troskova na odredjenom projektu;\n");
          fprintf(stdout,"4 - unos novih ucesnika/volontera/gostiju studentske organizacije;\n");
          fprintf(stdout,"5 - izmena nekog od podataka ucesnika na projektu;\n");
          fprintf(stdout,"6 - unos novog clana organizacije;\n");
          fprintf(stdout,"7 - izlazak iz aplikacije\n");
          
          fscanf(stdin, "%d", &option);
          
          if (option == 1) {
              sprintf(query, "SELECT ime AS `Ime`, prezime AS `Prezime`, email AS `e-mail`, br_tel AS `Telefon` FROM Clan_organizacije");
              if (mysql_query (connection, query) != 0) {
                  error_fatal ("Greska u upitu %s\n", mysql_error (connection));
              }
              result = mysql_use_result (connection);
              field = mysql_fetch_field (result);
              for (i = 0; i < mysql_field_count(connection); i++){
                  printf("%-20s", field[i].name);
                  
            }
            printf("\n");
            
            while ((row = mysql_fetch_row (result)) != 0){
                for(i = 0; i < mysql_field_count(connection); i++){
                    printf ("%-20s", row[i]);
                }
                printf ("\n");
                
            }
            mysql_free_result (result);
              
        } else if (option == 2) {
            sprintf(query, "SELECT naziv AS `Naziv`, opis AS `Opis`, Lokacija_ptt AS `Lokacija`, datum_pocetka `Pocetak`, datum_zavrsetka AS `Kraj`, trim(c.`ime`) || ' ' || trim(c.`prezime`) AS `Organizator` FROM Projekat p join Clan_organizacije c ON c.`jmbg`=p.`Clan_organizacije_jmbg`");
              if (mysql_query (connection, query) != 0) {
                  error_fatal ("Greska u upitu %s\n", mysql_error (connection));
              }
              result = mysql_use_result (connection);
              field = mysql_fetch_field (result);
              for (i = 0; i < mysql_field_count(connection); i++){
                  printf("%-20s", field[i].name);
                  
            }
            printf("\n");
            
            while ((row = mysql_fetch_row (result)) != 0){
                for(i = 0; i < mysql_field_count(connection); i++){
                    printf ("%-20s", row[i]);
                }
                printf ("\n");
                
            }
            mysql_free_result (result);
        } else if (option == 3) {
            fprintf(stdout,"Unesite ID projekta za koje zelite da izlistate troskove:\n");
            fscanf(stdin,"%d",&idp);
            
            sprintf(query, "SELECT opis AS `Opis troska`, iznos AS `IZNOS` FROM Trosak WHERE %d=`Projekat_id_projekta`",idp);
              if (mysql_query (connection, query) != 0) {
                  error_fatal ("Greska u upitu %s\n", mysql_error (connection));
              }
              result = mysql_use_result (connection);
              field = mysql_fetch_field (result);
              for (i = 0; i < mysql_field_count(connection); i++){
                  printf("%-20s", field[i].name);
                  
            }
            printf("\n");
            
            while ((row = mysql_fetch_row (result)) != 0){
                for(i = 0; i < mysql_field_count(connection); i++){
                    printf ("%-20s", row[i]);
                }
                printf ("\n");
                
            }
            mysql_free_result (result);
            
        } else if (option == 4) {
            fprintf(stdout,"Da li zelite da dodate ucesnika? da/ne\n");
            fscanf(stdin,"%s",ans);
            
            if (strcmp(ans,"da") == 0) {
                fprintf(stdout,"Unesite jmbg, ime, prezime, email, kontakt telefon, fakultet, univezitet i godinu studija:\n");
                fscanf(stdin,"%s%s%s%s%s%s%s%d",mb,name,surname,mail,tel,faks,uni,&god);
                
                sprintf(query, "INSERT INTO Ucesnik_na_projektu VALUES('%s','%s','%s','%s','%s');", mb, name, surname, mail, tel);

                if (mysql_query (connection, query) != 0) {
                    error_fatal ("Greska u upitu %s\n", mysql_error (connection));
                }
                
                sprintf(query, "INSERT INTO Ucesnik VALUES('%s','%s','%s',%d);", mb, faks, uni, god);

                if (mysql_query (connection, query) != 0) {
                    error_fatal ("Greska u upitu %s\n", mysql_error (connection));
                }
                
                fprintf(stdout,"Ucesnik uspesno upisan!\n");
                
            }
            
            fprintf(stdout,"Da li zelite da dodate volontera? da/ne\n");
            fscanf(stdin,"%s",ans);
            
            if (strcmp(ans,"da") == 0) {
                fprintf(stdout,"Unesite jmbg, ime, prezime, email, kontakt telefon:\n");
                fscanf(stdin,"%s%s%s%s%s",mb,name,surname,mail,tel);
                
                sprintf(query, "INSERT INTO Ucesnik_na_projektu VALUES('%s','%s','%s','%s','%s');", mb, name, surname, mail, tel);

                if (mysql_query (connection, query) != 0) {
                    error_fatal ("Greska u upitu %s\n", mysql_error (connection));
                }
                
                sprintf(query, "INSERT INTO Volonter VALUES('%s');", mb);

                if (mysql_query (connection, query) != 0) {
                    error_fatal ("Greska u upitu %s\n", mysql_error (connection));
                }
                
                fprintf(stdout,"Volonter uspesno upisan!\n");
                
            }
            
            fprintf(stdout,"Da li zelite da dodate gosta? da/ne\n");
            fscanf(stdin,"%s",ans);
            
            if (strcmp(ans,"da") == 0) {
                fprintf(stdout,"Unesite jmbg, ime, prezime, email, kontakt telefon i ime kompanije:\n");
                fscanf(stdin,"%s%s%s%s%s%s",mb,name,surname,mail,tel,komp);
                
                sprintf(query, "INSERT INTO Ucesnik_na_projektu VALUES('%s','%s','%s','%s','%s');", mb, name, surname, mail, tel);

                if (mysql_query (connection, query) != 0) {
                    error_fatal ("Greska u upitu %s\n", mysql_error (connection));
                }
                
                sprintf(query, "INSERT INTO Gost VALUES('%s','%s');", mb, komp);

                if (mysql_query (connection, query) != 0) {
                    error_fatal ("Greska u upitu %s\n", mysql_error (connection));
                }
                
                fprintf(stdout,"Gost uspesno upisan!\n");
                
            }
            
            
        } else if (option == 5) {
            fprintf(stdout,"Unesite jmbg ucesnika na projektu kojeg zelite da izmenite:\n");
            fscanf(stdin,"%s",mb);
            fprintf(stdout,"Zelite da izmenite: ime/prezime/email/tel?\n");
            fscanf(stdin,"%s",ans);
            
            if (!strcmp(ans,"ime")) {
                fprintf(stdout,"Unesite ime:\n");
                fscanf(stdin,"%s",name);
                sprintf(query, "UPDATE Ucesnik_na_projektu SET ime='%s' WHERE jmbg='%s'",name,mb);
            }
            else if (!strcmp(ans,"prezime")) {
                fprintf(stdout,"Unesite prezime:\n");
                fscanf(stdin,"%s",surname);
                sprintf(query, "UPDATE Ucesnik_na_projektu SET prezime='%s' WHERE jmbg='%s'",surname,mb);
            } else if (!strcmp(ans,"email")) {
                fprintf(stdout,"Unesite email:\n");
                fscanf(stdin,"%s",mail);
                sprintf(query, "UPDATE Ucesnik_na_projektu SET mail='%s' WHERE jmbg='%s'",mail,mb);
            } else if (!strcmp(ans,"tel")) {
                fprintf(stdout,"Unesite telefon:\n");
                fscanf(stdin,"%s",tel);
                sprintf(query, "UPDATE Ucesnik_na_projektu SET br_tel='%s' WHERE jmbg='%s'",tel,mb);
            }

            if (mysql_query (connection, query) != 0) {
                error_fatal ("Greska u upitu %s\n", mysql_error (connection));
            }
                
            fprintf(stdout,"Podaci uspesno izmenjeni!\n");
            
        } else if (option == 6) {
            fprintf(stdout,"Unesite jmbg, ime, prezime, email, kontakt telefon:\n");
            fscanf(stdin,"%s%s%s%s%s",mb,name,surname,mail,tel);
                
            sprintf(query, "INSERT INTO Clan_organizacije VALUES('%s','%s','%s','%s','%s');", mb, name, surname, mail, tel);

            if (mysql_query (connection, query) != 0) {
                error_fatal ("Greska u upitu %s\n", mysql_error (connection));
            }
                
            fprintf(stdout,"Clan organizacije uspesno dodat!\n");
        } else if (option == 7) {
            fprintf(stdout,"Dovidjenja!\n");
            exit(EXIT_SUCCESS);
        }
    }
    
    mysql_close (connection);

    return 0;
}
