USE `mydb`;   

/* • Ažuriranje ukupnog broja prisutnih na projektu */

delimiter #
    
CREATE TRIGGER `bi_trosak`
BEFORE INSERT ON `Trosak`
FOR EACH ROW
BEGIN
    IF (
        SELECT `budzet`
        FROM `Projekat`
        WHERE `id_projekta` = new.`Projekat_id_projekta`
    ) > new.`iznos`
    THEN
        UPDATE `Projekat` SET `budzet` = `budzet` - new.`iznos` WHERE `id_projekta`=new.`Projekat_id_projekta`;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Prekoracen budzet, nedozvoljen trosak';
    END IF;
END
#

CREATE TRIGGER `ai_ucestvovanje`
BEFORE INSERT ON `Ucestvovanje`
FOR EACH ROW
BEGIN
    UPDATE `Projekat` SET `br_ucesnika` = `br_ucesnika` + 1 WHERE `id_projekta`=new.`Projekat_id_projekta`;
END
#

CREATE TRIGGER `ai_volontiranje`
BEFORE INSERT ON `Volontiranje`
FOR EACH ROW
BEGIN
    UPDATE `Projekat` SET `br_ucesnika` = `br_ucesnika` + 1 WHERE `id_projekta`=new.`Projekat_id_projekta`;
END
#

CREATE TRIGGER `ai_podrzava`
BEFORE INSERT ON `Podrzava`
FOR EACH ROW
BEGIN
    UPDATE `Projekat` SET `br_ucesnika` = `br_ucesnika` + 1 WHERE `id_projekta`=new.`Projekat_id_projekta`;
END
#

CREATE TRIGGER `ad_ucestvovanje`
AFTER DELETE ON `Ucestvovanje`
FOR EACH ROW
BEGIN
    UPDATE `Projekat` SET `br_ucesnika` = `br_ucesnika` - 1 WHERE `id_projekta`=old.`Projekat_id_projekta`;
END
#

CREATE TRIGGER `ad_volontiranje`
AFTER DELETE ON `Volontiranje`
FOR EACH ROW
BEGIN
    UPDATE `Projekat` SET `br_ucesnika` = `br_ucesnika` - 1 WHERE `id_projekta`=old.`Projekat_id_projekta`;
END
#

CREATE TRIGGER `ad_podrzava`
AFTER DELETE ON `Podrzava`
FOR EACH ROW
BEGIN
    UPDATE `Projekat` SET `br_ucesnika` = `br_ucesnika` - 1 WHERE `id_projekta`=old.`Projekat_id_projekta`;
END
#

delimiter ;
