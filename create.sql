CREATE DATABASE `mydb`;

CREATE TABLE IF NOT EXISTS `mydb`.`Clan_organizacije` (
  `jmbg` VARCHAR(13) NOT NULL,
  `ime` VARCHAR(20) NOT NULL,
  `prezime` VARCHAR(20) NOT NULL,
  `email` VARCHAR(20) NOT NULL,
  `br_tel` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`jmbg`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Ucesnik_na_projektu` (
  `jmbg` VARCHAR(13) NOT NULL,
  `ime` VARCHAR(20) NOT NULL,
  `prezime` VARCHAR(20) NOT NULL,
  `email` VARCHAR(20) NOT NULL,
  `br_tel` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`jmbg`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Ucesnik` (
  `Ucesnik_na_projektu_jmbg` VARCHAR(13) NOT NULL,
  `fakultet` VARCHAR(20) NOT NULL,
  `univerzitet` VARCHAR(20) NOT NULL,
  `god_studija` TINYINT(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`Ucesnik_na_projektu_jmbg`),
  INDEX `fk_Ucesnik_Ucesnik_na_projektu1_idx` (`Ucesnik_na_projektu_jmbg` ASC),
  CONSTRAINT `fk_Ucesnik_Ucesnik_na_projektu1`
    FOREIGN KEY (`Ucesnik_na_projektu_jmbg`)
    REFERENCES `mydb`.`Ucesnik_na_projektu` (`jmbg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Gost` (
  `Ucesnik_na_projektu_jmbg` VARCHAR(13) NOT NULL,
  `naziv_kompanije` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Ucesnik_na_projektu_jmbg`),
  INDEX `fk_Gost_Ucesnik_na_projektu1_idx` (`Ucesnik_na_projektu_jmbg` ASC),
  CONSTRAINT `fk_Gost_Ucesnik_na_projektu1`
    FOREIGN KEY (`Ucesnik_na_projektu_jmbg`)
    REFERENCES `mydb`.`Ucesnik_na_projektu` (`jmbg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Volonter` (
  `Ucesnik_na_projektu_jmbg` VARCHAR(13) NOT NULL,
  INDEX `fk_Volonter_Ucesnik_na_projektu1_idx` (`Ucesnik_na_projektu_jmbg` ASC),
  PRIMARY KEY (`Ucesnik_na_projektu_jmbg`),
  CONSTRAINT `fk_Volonter_Ucesnik_na_projektu1`
    FOREIGN KEY (`Ucesnik_na_projektu_jmbg`)
    REFERENCES `mydb`.`Ucesnik_na_projektu` (`jmbg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Radionica` (
  `sifra` INT NOT NULL,
  `naziv` VARCHAR(60) NOT NULL,
  `vreme_pocetka` VARCHAR(5) NOT NULL,
  `vreme_zavrsetka` VARCHAR(5) NOT NULL,
  `datum_odrzavanja` DATE NOT NULL,
  PRIMARY KEY (`sifra`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Lokacija` (
  `ptt` INT NOT NULL,
  `adresa` VARCHAR(45) NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ptt`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Projekat` (
  `id_projekta` INT NOT NULL,
  `naziv` VARCHAR(20) NOT NULL,
  `opis` VARCHAR(20) NOT NULL,
  `datum_pocetka` DATE NOT NULL,
  `datum_zavrsetka` DATE NOT NULL,
  `budzet` FLOAT NOT NULL,
  `br_ucesnika` SMALLINT(3) NOT NULL DEFAULT 0,
  `Lokacija_ptt` INT NOT NULL,
  `Clan_organizacije_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`id_projekta`),
  INDEX `fk_Projekat_Lokacija1_idx` (`Lokacija_ptt` ASC),
  INDEX `fk_Projekat_Clan_organizacije1_idx` (`Clan_organizacije_jmbg` ASC),
  CONSTRAINT `fk_Projekat_Lokacija1`
    FOREIGN KEY (`Lokacija_ptt`)
    REFERENCES `mydb`.`Lokacija` (`ptt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Projekat_Clan_organizacije1`
    FOREIGN KEY (`Clan_organizacije_jmbg`)
    REFERENCES `mydb`.`Clan_organizacije` (`jmbg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Trosak` (
  `rbr` INT NOT NULL,
  `opis` VARCHAR(120) NOT NULL,
  `iznos` FLOAT NOT NULL,
  `Projekat_id_projekta` INT NOT NULL,
  `Clan_organizacije_jmbg` VARCHAR(13) NOT NULL,
  INDEX `fk_Trosak_Projekat1_idx` (`Projekat_id_projekta` ASC),
  INDEX `fk_Trosak_Clan_organizacije1_idx` (`Clan_organizacije_jmbg` ASC),
  CONSTRAINT `fk_Trosak_Projekat1`
    FOREIGN KEY (`Projekat_id_projekta`)
    REFERENCES `mydb`.`Projekat` (`id_projekta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trosak_Clan_organizacije1`
    FOREIGN KEY (`Clan_organizacije_jmbg`)
    REFERENCES `mydb`.`Clan_organizacije` (`jmbg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Podrzava` (
  `Projekat_id_projekta` INT NOT NULL,
  `Gost_Ucesnik_na_projektu_jmbg` VARCHAR(13) NOT NULL,
  `Radionica_sifra` INT NOT NULL,
  PRIMARY KEY (`Projekat_id_projekta`, `Gost_Ucesnik_na_projektu_jmbg`, `Radionica_sifra`),
  INDEX `fk_Projekat_has_Gost_Projekat1_idx` (`Projekat_id_projekta` ASC),
  INDEX `fk_Podrzava_Radionica1_idx` (`Radionica_sifra` ASC),
  INDEX `fk_Podrzava_Gost1_idx` (`Gost_Ucesnik_na_projektu_jmbg` ASC),
  CONSTRAINT `fk_Projekat_has_Gost_Projekat1`
    FOREIGN KEY (`Projekat_id_projekta`)
    REFERENCES `mydb`.`Projekat` (`id_projekta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Podrzava_Radionica1`
    FOREIGN KEY (`Radionica_sifra`)
    REFERENCES `mydb`.`Radionica` (`sifra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Podrzava_Gost1`
    FOREIGN KEY (`Gost_Ucesnik_na_projektu_jmbg`)
    REFERENCES `mydb`.`Gost` (`Ucesnik_na_projektu_jmbg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Volontiranje` (
  `Projekat_id_projekta` INT NOT NULL,
  `Volonter_Ucesnik_na_projektu_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Projekat_id_projekta`, `Volonter_Ucesnik_na_projektu_jmbg`),
  INDEX `fk_Projekat_has_Volonter_Projekat1_idx` (`Projekat_id_projekta` ASC),
  INDEX `fk_Volontiranje_Volonter1_idx` (`Volonter_Ucesnik_na_projektu_jmbg` ASC),
  CONSTRAINT `fk_Projekat_has_Volonter_Projekat1`
    FOREIGN KEY (`Projekat_id_projekta`)
    REFERENCES `mydb`.`Projekat` (`id_projekta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Volontiranje_Volonter1`
    FOREIGN KEY (`Volonter_Ucesnik_na_projektu_jmbg`)
    REFERENCES `mydb`.`Volonter` (`Ucesnik_na_projektu_jmbg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `mydb`.`Ucestvovanje` (
  `Ucesnik_Ucesnik_na_projektu_jmbg` VARCHAR(13) NOT NULL,
  `Projekat_id_projekta` INT NOT NULL,
  `Volonter_Ucesnik_na_projektu_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Ucesnik_Ucesnik_na_projektu_jmbg`, `Projekat_id_projekta`, `Volonter_Ucesnik_na_projektu_jmbg`),
  INDEX `fk_Ucesnik_has_Projekat_Projekat1_idx` (`Projekat_id_projekta` ASC),
  INDEX `fk_Ucestvovanje_Ucesnik1_idx` (`Ucesnik_Ucesnik_na_projektu_jmbg` ASC),
  INDEX `fk_Ucestvovanje_Volonter1_idx` (`Volonter_Ucesnik_na_projektu_jmbg` ASC),
  CONSTRAINT `fk_Ucesnik_has_Projekat_Projekat1`
    FOREIGN KEY (`Projekat_id_projekta`)
    REFERENCES `mydb`.`Projekat` (`id_projekta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ucestvovanje_Ucesnik1`
    FOREIGN KEY (`Ucesnik_Ucesnik_na_projektu_jmbg`)
    REFERENCES `mydb`.`Ucesnik` (`Ucesnik_na_projektu_jmbg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ucestvovanje_Volonter1`
    FOREIGN KEY (`Volonter_Ucesnik_na_projektu_jmbg`)
    REFERENCES `mydb`.`Volonter` (`Ucesnik_na_projektu_jmbg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
