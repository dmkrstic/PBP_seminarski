USE `mydb`;
     
INSERT INTO `Clan_organizacije` VALUES('1000000000000', 'Dusica', 'Krstic', 'dkrstic@gmail.com', '061/123-45-67');
INSERT INTO `Clan_organizacije` VALUES('1000000000005', 'Nikola', 'Pujaz', 'npujaz@gmail.com', '061/123-45-72');
INSERT INTO `Ucesnik_na_projektu` VALUES('1000000000001', 'Nikola', 'Zivkovic', 'nzivko@gmail.com', '061/123-45-68');
INSERT INTO `Ucesnik_na_projektu` VALUES('1000000000002', 'Aleksandar', 'Himel', 'ahimel@gmail.com', '061/123-45-69');
INSERT INTO `Ucesnik_na_projektu` VALUES('1000000000003', 'Bice', 'Obrisan', 'delete@gmail.com', '061/123-45-70');
INSERT INTO `Ucesnik_na_projektu` VALUES('1000000000004', 'Aleksandar', 'Muljaic', 'muljke@gmail.com', '061/123-45-71');

INSERT INTO `Ucesnik` VALUES('1000000000001','MATF','BG',3);
INSERT INTO `Ucesnik` VALUES('1000000000003','MATF','BG',4);
INSERT INTO `Volonter` VALUES('1000000000002');
INSERT INTO `Gost` VALUES('1000000000004', 'Surcin DOO');

INSERT INTO `Lokacija` VALUES(11000,'Nedodjija BB','Kidalica');
INSERT INTO `Lokacija` VALUES(11001,'Ulica BB','Ludilo');

INSERT INTO `Projekat` VALUES(1,'MatHack','Takmicenje','2017-05-13','2017-05-14',150000.0,0,11000,'1000000000000');
INSERT INTO `Projekat` VALUES(2,'JobPrep','Priprema za posao','2017-02-13','2017-02-14',150000.0,0,11000,'1000000000005');

INSERT INTO `Radionica` VALUES(100,'C101','12:00','13:00','2017-05-13');

INSERT INTO `Volontiranje` VALUES(1,'1000000000002');
INSERT INTO `Ucestvovanje` VALUES('1000000000001',1,'1000000000002');
INSERT INTO `Ucestvovanje` VALUES('1000000000001',2,'1000000000002');
INSERT INTO `Ucestvovanje` VALUES('1000000000003',1,'1000000000002');
INSERT INTO `Podrzava` VALUES(1,'1000000000004',100);

UPDATE `Ucesnik_na_projektu` SET `email`='muljaic@gmail.com' WHERE `jmbg`='1000000000004';
DELETE FROM `Ucestvovanje` WHERE `Ucesnik_Ucesnik_na_projektu_jmbg`='1000000000003';

INSERT INTO Trosak VALUES(1,'Sitni troskovi',1024.32,1,'1000000000000');
INSERT INTO Trosak VALUES(1,'Stampa',3024.32,1,'1000000000000');
/*
Test za trigger(ne prolazi):
INSERT INTO Trosak VALUES(1,'Neispravan unos',150000.0,1,'1000000000000');
*/
