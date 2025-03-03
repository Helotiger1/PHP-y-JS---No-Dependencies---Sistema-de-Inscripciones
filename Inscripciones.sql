-- MySQL Script generated by MySQL Workbench
-- Mon Mar  3 10:26:20 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Inscripciones
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Inscripciones` ;

-- -----------------------------------------------------
-- Schema Inscripciones
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Inscripciones` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `Inscripciones` ;

-- -----------------------------------------------------
-- Table `Inscripciones`.`paises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inscripciones`.`paises` (
  `idPais` INT NOT NULL AUTO_INCREMENT,
  `estatus` VARCHAR(100) NOT NULL,
  `nombrePais` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idPais`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Inscripciones`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inscripciones`.`estados` (
  `idEstado` INT NOT NULL AUTO_INCREMENT,
  `nombreEstado` VARCHAR(100) NOT NULL,
  `paises_idPais` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idEstado`),
  CONSTRAINT `fk_estados_paises1`
    FOREIGN KEY (`paises_idPais`)
    REFERENCES `Inscripciones`.`paises` (`idPais`)
    ON DELETE SET NULL)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_estados_paises1_idx` ON `Inscripciones`.`estados` (`paises_idPais` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Inscripciones`.`municipios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inscripciones`.`municipios` (
  `nombreMunicipio` VARCHAR(100) NOT NULL,
  `idMunicipio` INT NOT NULL AUTO_INCREMENT,
  `estados_idEstado` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idMunicipio`),
  CONSTRAINT `fk_municipios_estados1`
    FOREIGN KEY (`estados_idEstado`)
    REFERENCES `Inscripciones`.`estados` (`idEstado`)
    ON DELETE SET NULL)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_municipios_estados1_idx` ON `Inscripciones`.`municipios` (`estados_idEstado` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Inscripciones`.`parroquias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inscripciones`.`parroquias` (
  `nombreParroquia` VARCHAR(100) NOT NULL,
  `idParroquia` INT NOT NULL AUTO_INCREMENT,
  `municipios_idMunicipio` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idParroquia`),
  CONSTRAINT `fk_parroquias_municipios1`
    FOREIGN KEY (`municipios_idMunicipio`)
    REFERENCES `Inscripciones`.`municipios` (`idMunicipio`)
    ON DELETE SET NULL)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_parroquias_municipios1_idx` ON `Inscripciones`.`parroquias` (`municipios_idMunicipio` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Inscripciones`.`ciudades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inscripciones`.`ciudades` (
  `idCiudad` INT NOT NULL AUTO_INCREMENT,
  `nombreCiudad` VARCHAR(100) NOT NULL,
  `parroquias_idParroquia` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idCiudad`),
  CONSTRAINT `fk_ciudades_parroquias1`
    FOREIGN KEY (`parroquias_idParroquia`)
    REFERENCES `Inscripciones`.`parroquias` (`idParroquia`)
    ON DELETE SET NULL)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_ciudades_parroquias1_idx` ON `Inscripciones`.`ciudades` (`parroquias_idParroquia` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Inscripciones`.`contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inscripciones`.`contacto` (
  `telefonoPrincipal` VARCHAR(300) NOT NULL,
  `telefonoSecundario` VARCHAR(300) NOT NULL,
  `emailPrincipal` VARCHAR(300) NOT NULL,
  `emailSecundario` VARCHAR(300) NOT NULL,
  `idContacto` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idContacto`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Inscripciones`.`personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inscripciones`.`personas` (
  `idPersona` INT NOT NULL AUTO_INCREMENT,
  `nombrePersona` VARCHAR(300) NOT NULL,
  `apellidoPersona` VARCHAR(300) NOT NULL,
  `cedulaPersona` VARCHAR(300) NOT NULL,
  `sexoPersona` VARCHAR(300) NOT NULL,
  `fechaNac` VARCHAR(300) NOT NULL,
  `ciudades_idCiudad` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idPersona`),
  CONSTRAINT `fk_personas_ciudades1`
    FOREIGN KEY (`ciudades_idCiudad`)
    REFERENCES `Inscripciones`.`ciudades` (`idCiudad`)
    ON DELETE SET NULL)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `cedulaPersona` ON `Inscripciones`.`personas` (`cedulaPersona` ASC) VISIBLE;

CREATE INDEX `fk_personas_ciudades1_idx` ON `Inscripciones`.`personas` (`ciudades_idCiudad` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Inscripciones`.`representantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inscripciones`.`representantes` (
  `estadoCivil` VARCHAR(300) NOT NULL,
  `parentesco` VARCHAR(300) NOT NULL,
  `estatus` VARCHAR(300) NOT NULL,
  `idRepresentante` INT NOT NULL AUTO_INCREMENT,
  `personas_idPersona` INT NULL DEFAULT NULL,
  `contacto_idContacto` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idRepresentante`),
  CONSTRAINT `fk_representantes_contacto1`
    FOREIGN KEY (`contacto_idContacto`)
    REFERENCES `Inscripciones`.`contacto` (`idContacto`)
    ON DELETE SET NULL,
  CONSTRAINT `fk_representantes_personas1`
    FOREIGN KEY (`personas_idPersona`)
    REFERENCES `Inscripciones`.`personas` (`idPersona`)
    ON DELETE SET NULL)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_representantes_personas1_idx` ON `Inscripciones`.`representantes` (`personas_idPersona` ASC) VISIBLE;

CREATE INDEX `fk_representantes_contacto1_idx` ON `Inscripciones`.`representantes` (`contacto_idContacto` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Inscripciones`.`estudiantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inscripciones`.`estudiantes` (
  `alergias` VARCHAR(100) NOT NULL,
  `enfermedades` VARCHAR(100) NOT NULL,
  `estatura` VARCHAR(300) NOT NULL,
  `peso` VARCHAR(300) NOT NULL,
  `tallaCalzado` VARCHAR(300) NOT NULL,
  `tallaPantalon` VARCHAR(300) NOT NULL,
  `estatus` VARCHAR(300) NOT NULL,
  `idEstudiante` INT NOT NULL AUTO_INCREMENT,
  `personas_idPersona` INT NULL DEFAULT NULL,
  `contacto_idContacto` INT NULL DEFAULT NULL,
  `representantes_idRepresentante` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idEstudiante`),
  CONSTRAINT `fk_estudiantes_contacto1`
    FOREIGN KEY (`contacto_idContacto`)
    REFERENCES `Inscripciones`.`contacto` (`idContacto`)
    ON DELETE SET NULL,
  CONSTRAINT `fk_estudiantes_personas1`
    FOREIGN KEY (`personas_idPersona`)
    REFERENCES `Inscripciones`.`personas` (`idPersona`)
    ON DELETE SET NULL,
  CONSTRAINT `fk_estudiantes_representantes1`
    FOREIGN KEY (`representantes_idRepresentante`)
    REFERENCES `Inscripciones`.`representantes` (`idRepresentante`)
    ON DELETE SET NULL)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_estudiantes_personas1_idx` ON `Inscripciones`.`estudiantes` (`personas_idPersona` ASC) VISIBLE;

CREATE INDEX `fk_estudiantes_contacto1_idx` ON `Inscripciones`.`estudiantes` (`contacto_idContacto` ASC) VISIBLE;

CREATE INDEX `fk_estudiantes_representantes1_idx` ON `Inscripciones`.`estudiantes` (`representantes_idRepresentante` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Inscripciones`.`inscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inscripciones`.`inscripciones` (
  `idInscripcion` INT NOT NULL AUTO_INCREMENT,
  `calificaciones` VARCHAR(100) NOT NULL,
  `fechaInscripcion` VARCHAR(100) NOT NULL,
  `representantes_idRepresentante` INT NULL DEFAULT NULL,
  `estudiantes_idEstudiante` INT NULL DEFAULT NULL,
  `rango` VARCHAR(45) NOT NULL,
  `grado` VARCHAR(45) NOT NULL DEFAULT 'Desconocido',
  PRIMARY KEY (`idInscripcion`),
  CONSTRAINT `fk_inscripciones_estudiantes1`
    FOREIGN KEY (`estudiantes_idEstudiante`)
    REFERENCES `Inscripciones`.`estudiantes` (`idEstudiante`)
    ON DELETE SET NULL,
  CONSTRAINT `fk_inscripciones_representantes1`
    FOREIGN KEY (`representantes_idRepresentante`)
    REFERENCES `Inscripciones`.`representantes` (`idRepresentante`)
    ON DELETE SET NULL)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_inscripciones_representantes1_idx` ON `Inscripciones`.`inscripciones` (`representantes_idRepresentante` ASC) VISIBLE;

CREATE INDEX `fk_inscripciones_estudiantes1_idx` ON `Inscripciones`.`inscripciones` (`estudiantes_idEstudiante` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Inscripciones`.`maestros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inscripciones`.`maestros` (
  `estadoCivil` VARCHAR(300) NOT NULL,
  `cargoActual` VARCHAR(300) NOT NULL,
  `idMaestro` INT NOT NULL AUTO_INCREMENT,
  `personas_idPersona` INT NULL DEFAULT NULL,
  `contacto_idContacto` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idMaestro`),
  CONSTRAINT `fk_maestros_contacto1`
    FOREIGN KEY (`contacto_idContacto`)
    REFERENCES `Inscripciones`.`contacto` (`idContacto`)
    ON DELETE SET NULL,
  CONSTRAINT `fk_maestros_personas1`
    FOREIGN KEY (`personas_idPersona`)
    REFERENCES `Inscripciones`.`personas` (`idPersona`)
    ON DELETE SET NULL)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_maestros_personas1_idx` ON `Inscripciones`.`maestros` (`personas_idPersona` ASC) VISIBLE;

CREATE INDEX `fk_maestros_contacto1_idx` ON `Inscripciones`.`maestros` (`contacto_idContacto` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
