-- Matheus Dias de Queiroz
-- Projeto da disciplina de Banco de Dados

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`funcionario` (
  `idFuncionario` INT NULL,
  `cargo` VARCHAR(20) NULL,
  `nome` VARCHAR(45) NULL,
  `cpf` VARCHAR(9) NULL,
  `identidade` INT NULL,
  `UFidentidade` VARCHAR(2) NULL,
  `orgaoExpedidor` VARCHAR(5) NULL,
  `endereço` VARCHAR(45) NULL,
  `telefone` VARCHAR(9) NULL,
  `DataNascimento` DATE NULL,
  `mae` VARCHAR(45) NULL,
  `pai` INT NULL,
  `cidade` VARCHAR(45) NULL,
  `nacionalidade` VARCHAR(45) NULL,
  `nrTituloEleitor` INT NULL,
  `zonaTituloEleitor` INT NULL,
  `localTituloEleitor` VARCHAR(45) NULL,
  `cidadeNascimento` VARCHAR(45) NULL,
  PRIMARY KEY (`idFuncionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dependente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dependente` (
  `nome` VARCHAR(45) NULL,
  `nascimento` DATE NULL,
  `sexo` TINYINT NULL,
  `cpf` VARCHAR(9) NULL,
  `identidade` VARCHAR(10) NULL,
  `funcionario_idFuncionario1` INT NULL,
  `funcionario_idFuncionario` INT NOT NULL,
  INDEX `fk_dependente_funcionario2_idx` (`funcionario_idFuncionario1` ASC) VISIBLE,
  INDEX `fk_dependente_funcionario1_idx` (`funcionario_idFuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_dependente_funcionario2`
    FOREIGN KEY (`funcionario_idFuncionario1`)
    REFERENCES `mydb`.`funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dependente_funcionario1`
    FOREIGN KEY (`funcionario_idFuncionario`)
    REFERENCES `mydb`.`funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`curso` (
  `idCurso` INT NULL,
  `nome_curso` VARCHAR(45) NULL,
  `instituto` VARCHAR(45) NULL,
  `cursocol` VARCHAR(45) NULL,
  PRIMARY KEY (`idCurso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`aluno` (
  `matricula` INT NULL,
  `nomeAluno` VARCHAR(45) NULL,
  `sexo` TINYINT NULL,
  `enderecoLocal` VARCHAR(45) NULL,
  `enderecoResponsavel` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `cpf` VARCHAR(45) NULL,
  `identidade` VARCHAR(45) NULL,
  `orgExpedidor` VARCHAR(5) NULL,
  `ufIdentidade` VARCHAR(2) NULL,
  `anoConclusaoEnsMed` YEAR(4) NULL,
  `escola2oGrau` VARCHAR(45) NULL,
  `pai` VARCHAR(45) NULL,
  `mae` VARCHAR(45) NULL,
  `dataNascimento` DATE NULL,
  `cidadeNascimento` VARCHAR(45) NULL,
  `nacionalidade` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `nrTituloEleitor` VARCHAR(45) NULL,
  `zonaTituloEleitor` INT NULL,
  `localTituloEleitor` VARCHAR(45) NULL,
  `sesaoTituloEleitor` INT NULL,
  `ufTituloEleitor` VARCHAR(2) NULL,
  `curso_idCurso` INT NOT NULL,
  PRIMARY KEY (`matricula`, `curso_idCurso`),
  INDEX `fk_aluno_curso1_idx` (`curso_idCurso` ASC) VISIBLE,
  CONSTRAINT `fk_aluno_curso1`
    FOREIGN KEY (`curso_idCurso`)
    REFERENCES `mydb`.`curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`disciplina` (
  `idDisciplina` INT NULL,
  `nome_discipilina` VARCHAR(45) NULL,
  `creditos` INT NULL,
  `carga_hora_teorica` TIME NULL,
  `carga_hora_pratica` TIME NULL,
  `prerequisito` VARCHAR(45) NULL,
  `semestreOfertado` INT NULL,
  `disciplinacol` VARCHAR(45) NULL,
  `aluno_matricula` INT NOT NULL,
  `funcionario_idFuncionario` INT NOT NULL,
  PRIMARY KEY (`idDisciplina`, `funcionario_idFuncionario`),
  INDEX `fk_disciplina_aluno_idx` (`aluno_matricula` ASC) VISIBLE,
  INDEX `fk_disciplina_funcionario1_idx` (`funcionario_idFuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_disciplina_aluno`
    FOREIGN KEY (`aluno_matricula`)
    REFERENCES `mydb`.`aluno` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disciplina_funcionario1`
    FOREIGN KEY (`funcionario_idFuncionario`)
    REFERENCES `mydb`.`funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`periodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`periodo` (
  `idPeriodo` INT NULL,
  `anoPeriodo` YEAR(4) NULL,
  `disciplina_idDisciplina` INT NOT NULL,
  `curso_idCurso` INT NOT NULL,
  PRIMARY KEY (`disciplina_idDisciplina`, `curso_idCurso`),
  INDEX `fk_periodo_curso1_idx` (`curso_idCurso` ASC) VISIBLE,
  CONSTRAINT `fk_periodo_disciplina1`
    FOREIGN KEY (`disciplina_idDisciplina`)
    REFERENCES `mydb`.`disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_periodo_curso1`
    FOREIGN KEY (`curso_idCurso`)
    REFERENCES `mydb`.`curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`turma` (
  `dia` DATE NULL,
  `hora` TIME NULL,
  `local` VARCHAR(10) NULL,
  `disciplina_idDisciplina` INT NOT NULL,
  `periodo_disciplina_idDisciplina` INT NOT NULL,
  `periodo_curso_idCurso` INT NOT NULL,
  PRIMARY KEY (`disciplina_idDisciplina`, `periodo_disciplina_idDisciplina`, `periodo_curso_idCurso`),
  INDEX `fk_turma_periodo1_idx` (`periodo_disciplina_idDisciplina` ASC, `periodo_curso_idCurso` ASC) VISIBLE,
  CONSTRAINT `fk_turma_disciplina1`
    FOREIGN KEY (`disciplina_idDisciplina`)
    REFERENCES `mydb`.`disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_turma_periodo1`
    FOREIGN KEY (`periodo_disciplina_idDisciplina` , `periodo_curso_idCurso`)
    REFERENCES `mydb`.`periodo` (`disciplina_idDisciplina` , `curso_idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cargo` (
  `data_inicio` DATE NULL,
  `data_fim` DATE NULL,
  `cargo_nome` VARCHAR(45) NULL,
  `funcionario_idFuncionario` INT NULL,
  INDEX `fk_cargo_funcionario1_idx` (`funcionario_idFuncionario` ASC) VISIBLE,
  CONSTRAINT `fk_cargo_funcionario1`
    FOREIGN KEY (`funcionario_idFuncionario`)
    REFERENCES `mydb`.`funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`aluno` (
  `matricula` INT NULL,
  `nomeAluno` VARCHAR(45) NULL,
  `sexo` TINYINT NULL,
  `enderecoLocal` VARCHAR(45) NULL,
  `enderecoResponsavel` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `cpf` VARCHAR(45) NULL,
  `identidade` VARCHAR(45) NULL,
  `orgExpedidor` VARCHAR(5) NULL,
  `ufIdentidade` VARCHAR(2) NULL,
  `anoConclusaoEnsMed` YEAR(4) NULL,
  `escola2oGrau` VARCHAR(45) NULL,
  `pai` VARCHAR(45) NULL,
  `mae` VARCHAR(45) NULL,
  `dataNascimento` DATE NULL,
  `cidadeNascimento` VARCHAR(45) NULL,
  `nacionalidade` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `nrTituloEleitor` VARCHAR(45) NULL,
  `zonaTituloEleitor` INT NULL,
  `localTituloEleitor` VARCHAR(45) NULL,
  `sesaoTituloEleitor` INT NULL,
  `ufTituloEleitor` VARCHAR(2) NULL,
  `curso_idCurso` INT NOT NULL,
  PRIMARY KEY (`matricula`, `curso_idCurso`),
  INDEX `fk_aluno_curso1_idx` (`curso_idCurso` ASC) VISIBLE,
  CONSTRAINT `fk_aluno_curso1`
    FOREIGN KEY (`curso_idCurso`)
    REFERENCES `mydb`.`curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`disciplina_has_curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`disciplina_has_curso` (
  `curso_idCurso` INT NULL,
  `disciplina_idDisciplina` INT NULL,
  PRIMARY KEY (`curso_idCurso`, `disciplina_idDisciplina`),
  INDEX `fk_curso_has_disciplina_disciplina1_idx` (`disciplina_idDisciplina` ASC) VISIBLE,
  INDEX `fk_curso_has_disciplina_curso1_idx` (`curso_idCurso` ASC) VISIBLE,
  CONSTRAINT `fk_curso_has_disciplina_curso1`
    FOREIGN KEY (`curso_idCurso`)
    REFERENCES `mydb`.`curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_has_disciplina_disciplina1`
    FOREIGN KEY (`disciplina_idDisciplina`)
    REFERENCES `mydb`.`disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
