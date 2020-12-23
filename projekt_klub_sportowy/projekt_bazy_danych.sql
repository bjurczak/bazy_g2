-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema jurczakb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema jurczakb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jurczakb` DEFAULT CHARACTER SET utf8 ;
USE `jurczakb` ;

-- -----------------------------------------------------
-- Table `jurczakb`.`stadion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jurczakb`.`stadion` (
  `id_stadion` INT NOT NULL AUTO_INCREMENT,
  `nazwa_stadionu` VARCHAR(45) NOT NULL,
  `ilosc_miejsc` VARCHAR(45) NOT NULL,
  `miasto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_stadion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurczakb`.`liga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jurczakb`.`liga` (
  `id_liga` INT NOT NULL AUTO_INCREMENT,
  `nazwa_ligi` VARCHAR(45) NOT NULL,
  `kraj` VARCHAR(45) NOT NULL,
  `klasa_rozgrywkowa` VARCHAR(45) NOT NULL,
  `ilosc_druzyn` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_liga`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurczakb`.`projekt_klub_sportowy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jurczakb`.`projekt_klub_sportowy` (
  `id_projekt_klub_sportowy` INT NOT NULL AUTO_INCREMENT,
  `nazwa_klubu` VARCHAR(45) NOT NULL,
  `przydomek` VARCHAR(45) NOT NULL,
  `rok_zalozenia` INT NOT NULL,
  `stadion_id_stadion` INT NOT NULL,
  `liga_id_liga` INT NOT NULL,
  PRIMARY KEY (`id_projekt_klub_sportowy`, `stadion_id_stadion`, `liga_id_liga`),
  INDEX `fk_projekt_klub_sportowy_stadion1_idx` (`stadion_id_stadion` ASC) VISIBLE,
  INDEX `fk_projekt_klub_sportowy_liga1_idx` (`liga_id_liga` ASC) VISIBLE,
  CONSTRAINT `fk_projekt_klub_sportowy_stadion1`
    FOREIGN KEY (`stadion_id_stadion`)
    REFERENCES `jurczakb`.`stadion` (`id_stadion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projekt_klub_sportowy_liga1`
    FOREIGN KEY (`liga_id_liga`)
    REFERENCES `jurczakb`.`liga` (`id_liga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurczakb`.`zawodnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jurczakb`.`zawodnik` (
  `id_zawodnik` INT NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `data_urodzenia` DATE NOT NULL,
  `kraj_pochodzenia` VARCHAR(45) NOT NULL,
  `pozycja` ENUM('napastnik', 'obronca', 'pomocnik', 'bramkarz') NOT NULL,
  `projekt_klub_sportowy_id_projekt_klub_sportowy` INT NULL,
  PRIMARY KEY (`id_zawodnik`),
  INDEX `fk_zawodnik_projekt_klub_sportowy1_idx` (`projekt_klub_sportowy_id_projekt_klub_sportowy` ASC) VISIBLE,
  CONSTRAINT `fk_zawodnik_projekt_klub_sportowy1`
    FOREIGN KEY (`projekt_klub_sportowy_id_projekt_klub_sportowy`)
    REFERENCES `jurczakb`.`projekt_klub_sportowy` (`id_projekt_klub_sportowy`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
ROW_FORMAT = REDUNDANT;


-- -----------------------------------------------------
-- Table `jurczakb`.`sztab_szkoleniowy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jurczakb`.`sztab_szkoleniowy` (
  `id_sztab_szkoleniowy` INT NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `rola` ENUM('trener_glowny', 'asystent', 'fizjoterapeuta', 'trener_bramkarzy') NOT NULL,
  `projekt_klub_sportowy_id_projekt_klub_sportowy` INT NULL,
  PRIMARY KEY (`id_sztab_szkoleniowy`),
  INDEX `fk_sztab_szkoleniowy_projekt_klub_sportowy1_idx` (`projekt_klub_sportowy_id_projekt_klub_sportowy` ASC) VISIBLE,
  CONSTRAINT `fk_sztab_szkoleniowy_projekt_klub_sportowy1`
    FOREIGN KEY (`projekt_klub_sportowy_id_projekt_klub_sportowy`)
    REFERENCES `jurczakb`.`projekt_klub_sportowy` (`id_projekt_klub_sportowy`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jurczakb`.`transfer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `jurczakb`.`transfer` (
  `id_transfer` INT NOT NULL,
  `data_przyjscia` DATE NULL,
  `data_odejscia` DATE NULL,
  `kwota` VARCHAR(45) NULL,
  `zawodnik_id_zawodnik` INT NULL,
  PRIMARY KEY (`id_transfer`),
  INDEX `fk_transfer_zawodnik1_idx` (`zawodnik_id_zawodnik` ASC) VISIBLE,
  CONSTRAINT `fk_transfer_zawodnik1`
    FOREIGN KEY (`zawodnik_id_zawodnik`)
    REFERENCES `jurczakb`.`zawodnik` (`id_zawodnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
