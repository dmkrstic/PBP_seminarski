USE `mydb`;

SELECT p.`naziv`, u.`ime`, u.`prezime`, r.`naziv`
FROM `Projekat` p JOIN `Podrzava` po ON p.`id_projekta`=po.`Projekat_id_projekta`
    JOIN `Gost` g ON po.`Gost_Ucesnik_na_projektu_jmbg`=g.`Ucesnik_na_projektu_jmbg`
    JOIN `Ucesnik_na_projektu` u ON u.`jmbg`=g.`Ucesnik_na_projektu_jmbg`
    JOIN `Radionica` r ON r.`sifra`=po.`Radionica_sifra`
WHERE p.`id_projekta`=1;

SELECT `opis`, `iznos`
FROM `Trosak` 
WHERE `Projekat_id_projekta`=1;

SELECT uc.`ime`, uc.`prezime`, p.`naziv`
FROM `Ucestvovanje` u JOIN `Projekat` p ON u.`Projekat_id_projekta`=p.`id_projekta`
    JOIN `Ucesnik_na_projektu` uc ON u.`Ucesnik_Ucesnik_na_projektu_jmbg`=uc.`jmbg`
WHERE uc.`ime`='Nikola' and uc.`prezime`='Zivkovic';
