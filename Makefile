
DIR = mydb
PROGRAM = app.out
SRC = app.c
FLAGS = -g -Wall `mysql_config --cflags --libs`

.PHONY: all create trigger insert clean app

all: create trigger insert $(PROGRAM) 

$(PROGRAM): $(SRC)
	gcc $(SRC) -o $(PROGRAM) $(FLAGS)

create:
	mysql -u root -p <create.sql
	
insert: trigger
	mysql -u root -p -D mydb <insert.sql
	
trigger:
	mysql -u root -p -D mydb <triggers.sql
	
clean:
	-rm -f *.mwb.bak
