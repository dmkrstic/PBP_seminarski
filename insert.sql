USE mydb;
 /*
    • Upit koji za Projekat izdvaja sve Goste i Radionice koje će biti održane na Projektu
    • Upit koji za Projekat izdvaja sve Troškove
    • Upit koji za Učesnika izdvaja sve projekte na kojima je učestvovao 
    */
    
insert into Clan_organizacije values('2705994715101','Dusica','Krstic',
                                    'dkrstic@gmail.com','062/863-71-92');
                                    
insert into Ucesnik_na_projektu values('1102994715101','Nikola','Zivkovic',
                                    'nzivko@gmail.com','062/123-456');
    
insert into Ucesnik_na_projektu values('1102994715102','Aleksandar','Himel',
                                    'ahimel@gmail.com','062/123-456');
                                    
insert into Ucesnik_na_projektu values('1102994715103','Aleksandar','Muljaic',
                                    'muljke@gmail.com','062/123-456');
                                    
update Ucesnik_na_projektu set email = 'amuljaic@gmail.com' where jmbg = '1102994715103';
                                    
insert into Ucesnik values('1102994715101', 'MATF', 'BG', 3);
  
insert into Volonter values('1102994715102');

insert into Gost values('1102994715103','Surcin DOO');
 
insert into Lokacija values(11070,'Adresa','Mesto');
    
insert into Projekat values(1, 'MatHack', 'Opis', '2017-05-13', '2017-05-14', 99800.0, 0, 11070, 
                            '2705994715101');
                            
insert into Radionica values(1, 'Naziv', '12:00', '13:00', '2017-05-13');

/*
insert into Volontiranje values(1,'1102994715102');                        
    
insert into Ucestvovanje values('1102994715101',1,'1102994715102');
    
insert into Trosak values(1,'Opis',123.4,1,'2705994715101'); */

/*
select * 
from Trosak t
where t.Projekat_id_projekta = id_projekta;

select p.naziv
from Projekat p join Ucestvovanje u on p.id_projekta = u.Projekat_id_projekta
where u.Ucesnik_Ucesnik_na_projektu_jmbg = jmbg
*/
