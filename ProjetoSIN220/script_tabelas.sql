
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb`;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Instituto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Instituto` (
    `idInstituto` INT NOT NULL,
    `nome` VARCHAR(45),
    PRIMARY KEY (`idInstituto`)
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`curso` (
    `idCurso` INT NOT NULL,
    `Instituto_idInstituto` INT NOT NULL,
    `nome_curso` VARCHAR(45),
    PRIMARY KEY (`idCurso` , `Instituto_idInstituto`),
    FOREIGN KEY (`Instituto_idInstituto`)
        REFERENCES `mydb`.`Instituto` (`idInstituto`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`aluno` (
    `matricula` INT NOT NULL AUTO_INCREMENT,
    `curso_idCurso` INT NOT NULL,
    `anoConclusaoEnsMed` YEAR(4),
    `escola2oGrau` VARCHAR(45),
    PRIMARY KEY (`matricula` , `curso_idCurso`),
    FOREIGN KEY (`curso_idCurso`)
        REFERENCES `mydb`.`curso` (`idCurso`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`funcionario` (
    `idFuncionario` INT NOT NULL AUTO_INCREMENT,
    `atua` ENUM('tecnico', 'professor'),
    `funcionario_idFuncionario` INT,
    PRIMARY KEY (`idFuncionario`)
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`registro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`registro` (
    `aluno_matricula` INT,
    `funcionario_idFuncionario` INT,
    `nome` VARCHAR(45),
    `sexo` ENUM('M', 'F'),
    `cpf` INT(9),
    `identidade` VARCHAR(10),
    `UFidentidade` ENUM('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'),
    `orgaoExpedidor` VARCHAR(5),
    `endereço` VARCHAR(45),
    `DataNascimento` DATE,
    `mae` VARCHAR(45),
    `pai` VARCHAR(45),
    `cidade` VARCHAR(45),
    `nacionalidade` VARCHAR(45) DEFAULT 'brasileiro(a)',
    `nrTituloEleitor` VARCHAR(14),
    `sessaoTituloEleitor` VARCHAR(3),
    `zonaTituloEleitor` VARCHAR(4),
    `dataEmissaoTituloEleitor` DATE,
    `localTituloEleitor` VARCHAR(45),
    `cidadeNascimento` VARCHAR(45),
    `telefone` VARCHAR(11),
    FOREIGN KEY (`aluno_matricula`)
        REFERENCES `mydb`.`aluno` (`matricula`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`funcionario_idFuncionario`)
        REFERENCES `mydb`.`funcionario` (`idFuncionario`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`dependente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dependente` (
    `funcionario_idFuncionario` INT,
    `funcionario_registro_aluno_matricula` INT,
    `nome` VARCHAR(45),
    `nascimento` DATE,
    `sexo` ENUM('M', 'F'),
    `cpf` VARCHAR(9),
    `identidade` VARCHAR(10),
    FOREIGN KEY (`funcionario_idFuncionario`)
        REFERENCES `mydb`.`funcionario` (`idFuncionario`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`disciplina` (
    `idDisciplina` VARCHAR(6) NOT NULL,
    `aluno_matricula` INT,
    `aluno_curso_idCurso` INT,
    `nome_discipilina` VARCHAR(45),
    `creditos` INT,
    `carga_hora_teorica` INT,
    `carga_hora_pratica` INT,
    `semestreOfertado` ENUM('1', '2', '3'),
    PRIMARY KEY (`idDisciplina`),
    FOREIGN KEY (`aluno_matricula` , `aluno_curso_idCurso`)
        REFERENCES `mydb`.`aluno` (`matricula` , `curso_idCurso`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`periodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`periodo` (
    `idPeriodo` INT NOT NULL,
    `curso_idCurso` INT,
    `disciplina_idDisciplina` VARCHAR(6),
    `anoPeriodo` YEAR(4) DEFAULT '2018',
    PRIMARY KEY (`idPeriodo`),
    FOREIGN KEY (`disciplina_idDisciplina`)
        REFERENCES `mydb`.`disciplina` (`idDisciplina`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`curso_idCurso`)
        REFERENCES `mydb`.`curso` (`idCurso`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`turma` (
    `disciplina_idDisciplina` VARCHAR(6),
    `periodo_disciplina_idDisciplina` VARCHAR(6),
    `periodo_curso_idCurso` INT,
    `nrSala` VARCHAR(10),
    `dia` DATE,
    `hora` TIME,
    FOREIGN KEY (`disciplina_idDisciplina`)
        REFERENCES `mydb`.`disciplina` (`idDisciplina`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`periodo_disciplina_idDisciplina`)
        REFERENCES `mydb`.`periodo` (`disciplina_idDisciplina`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`periodo_curso_idCurso`)
        REFERENCES `mydb`.`periodo` (`curso_idCurso`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cargo` (
    `cargo_idCargo` INT,
    `data_inicio` DATE,
    `data_fim` DATE,
    `funcionario_idFuncionario` INT,
    FOREIGN KEY (`funcionario_idFuncionario`)
        REFERENCES `mydb`.`funcionario` (`idFuncionario`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`cargo_idCargo`)
        REFERENCES `mydb`.`cargosDisponiveis` (`idCargo`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `mydb`.`cargosDisponiveis` (
    
    `idCargo` INT NOT NULL auto_increment,
    `nomeCargo` VARCHAR(45),
    primary key(`idCargo`)
    
)  ENGINE=INNODB;

-- -----------------------------------------------------
-- Table `mydb`.`disciplina_has_curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`disciplina_has_curso` (
    `curso_idCurso` int ,
    `disciplina_idDisciplina` varchar(6),
   
   FOREIGN KEY (`curso_idCurso`)
        REFERENCES `mydb`.`curso` (`idCurso`)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION,
    
    FOREIGN KEY (`disciplina_idDisciplina`)
        REFERENCES `mydb`.`disciplina` (`idDisciplina`)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`prerequisito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prerequisito` (
    `disciplina_idDisciplina` varchar(6) NOT NULL,
    `nomePrerequisito` VARCHAR(35),
    PRIMARY KEY (`disciplina_idDisciplina`),
    
    FOREIGN KEY (`disciplina_idDisciplina`)
        REFERENCES `mydb`.`disciplina` (`idDisciplina`)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION
)  ENGINE=INNODB;



SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
