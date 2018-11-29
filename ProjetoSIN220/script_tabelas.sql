
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb`;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Instituto`
-- (`idInstituto`,`nome`)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Instituto` (
    `idInstituto` INT NOT NULL,
    `nome` VARCHAR(45),
    PRIMARY KEY (`idInstituto`)
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`curso`
-- (`idCurso`,`Instituto_idInstituto`,`nome_curso`)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`curso` (
    `idCurso` INT NOT NULL auto_increment,
    `Instituto_idInstituto` INT NOT NULL,
    `nome_curso` VARCHAR(45),
    
    PRIMARY KEY (`idCurso` , `Instituto_idInstituto`),
    
    FOREIGN KEY (`Instituto_idInstituto`)
        REFERENCES `mydb`.`Instituto` (`idInstituto`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`aluno`
-- (`matricula`,`nome`,`curso_idCurso`,`anoConclusaoEnsMed`,`escola2oGrau`)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`aluno` (
    `matricula` INT NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(45),
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
-- (idFuncionario,nome,atua)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`funcionario` (
    `idFuncionario` INT NOT NULL AUTO_INCREMENT,
	`nome` VARCHAR(45),
    `atua` ENUM('tecnico', 'professor'),
    `area` varchar(60),

    PRIMARY KEY (`idFuncionario`)
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`registro`
-- (funcionario_idFuncionario,email,sexo,cpf,identidade,UFidentidade,orgaoExpedidor,
-- ,endereço,DataNascimento,mae,pai,cidade,nacionalidade,nrTituloEleitor,sessaoTituloEleitor,
-- ,zonaTituloEleitor,dataEmissaoTituloEleitor,localTituloEleitor,cidadeNascimento,telefone)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`registro` (
    `aluno_matricula` INT,
    `funcionario_idFuncionario` INT,
    `email` VARCHAR(45),
    `sexo` ENUM('M', 'F'),
    `cpf` VARCHAR(11),
    `identidade` VARCHAR(13),
    `UFidentidade` ENUM('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'),
    `orgaoExpedidor` VARCHAR(5),
    `endereço` VARCHAR(45),
    `DataNascimento` DATE,
    `mae` VARCHAR(45),
    `pai` VARCHAR(45),
    `cidade` VARCHAR(45),
    `cep` VARCHAR(8),
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
-- (`funcionario_idFuncionario`,`funcionario_registro_aluno_matricula`,`nome`,`nascimento`, `sexo`,`cpf`,`identidade`)
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
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`disciplina`
-- (`idDisciplina`,`nome_discipilina`, `creditos`,`carga_hora_teorica`,`carga_hora_pratica`,`semestreOfertado`)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`disciplina` (
    `idDisciplina` VARCHAR(6) NOT NULL,
    `nome_discipilina` VARCHAR(55),
    `creditos` INT,
    `carga_hora_teorica` INT,
    `carga_hora_pratica` INT,
    `semestreOfertado` ENUM('1', '2', '3') ,
    
     PRIMARY KEY (`idDisciplina`)

)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`periodo`
-- (`idPeriodo`,`periodo_idCurso`,`periodo_idDisciplina`,`anoPeriodo`)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`periodo` (
    `idPeriodo` enum('1','2'),
    `periodo_idCurso` int,
    `periodo_idDisciplina` VARCHAR(6),
    `anoPeriodo` YEAR(4) DEFAULT '2018',
    
    FOREIGN KEY (`periodo_idDisciplina`)
        REFERENCES `mydb`.`disciplina` (`idDisciplina`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
   
   FOREIGN KEY (`periodo_idCurso`)
        REFERENCES `mydb`.`curso` (`idCurso`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`turma`
-- (disciplina_idDisciplina,periodo_curso_idCurso,nrSala,dia,hora)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`turma` (
    `disciplina_idDisciplina` VARCHAR(6),
    `nrSala` VARCHAR(10),
    `tipo` enum('T','P'),
    `dia` enum('2','3','4','5','6'),
    `hora` enum('14-16','16-18','19-21','21-23'),
   
   FOREIGN KEY (`disciplina_idDisciplina`)
        REFERENCES `mydb`.`disciplina` (`idDisciplina`)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`cargo`
-- (`funcionario_idFuncionario`,`cargo_idCargo`,`data_inicio`,`data_fim`)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cargo` (
	`funcionario_idFuncionario` INT,
    `cargo_idCargo` INT,
    `data_inicio` DATE,
    `data_fim` DATE,
   
   FOREIGN KEY (`funcionario_idFuncionario`)
        REFERENCES `mydb`.`funcionario` (`idFuncionario`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
   
   FOREIGN KEY (`cargo_idCargo`)
        REFERENCES `mydb`.`cargosDisponiveis` (`idCargo`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;
-- -----------------------------------------------------
-- Table `mydb`.`cargosDisponiveis`
-- (`idCargo`,`nomeCargo`)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cargosDisponiveis` (
    
    `idCargo` INT NOT NULL auto_increment,
    `nomeCargo` VARCHAR(45),
    primary key(`idCargo`)
    
)  ENGINE=INNODB;

-- -----------------------------------------------------
-- Table `mydb`.`disciplina_has_curso`
-- (`curso_idCurso`,`disciplina_idDisciplina`)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`disciplina_has_curso` (
    `curso_idCurso` INT,
    `disciplina_idDisciplina` VARCHAR(6),
    FOREIGN KEY (`curso_idCurso`)
        REFERENCES `mydb`.`curso` (`idCurso`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (`disciplina_idDisciplina`)
        REFERENCES `mydb`.`disciplina` (`idDisciplina`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `mydb`.`prerequisito`
-- (`disciplina_idDisciplina`,`nomePrerequisito`)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prerequisito` (
    `disciplina_idDisciplina` varchar(6),
    `nomePrerequisito` VARCHAR(35),
    
    FOREIGN KEY (`disciplina_idDisciplina`)
        REFERENCES `mydb`.`disciplina` (`idDisciplina`)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION
)  ENGINE=INNODB;



SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
