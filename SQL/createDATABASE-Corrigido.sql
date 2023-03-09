-- MySQL Workbench Forward Engineering

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
-- -----------------------------------------------------
-- Schema login
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema login
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `login` DEFAULT CHARACTER SET utf8mb4 ;
-- -----------------------------------------------------
-- Schema phpmyadmin
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema phpmyadmin
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
-- -----------------------------------------------------
-- Schema test
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Departamento` (
  `Nome Depto` VARCHAR(40) NOT NULL,
  `CPF gerente` CHAR(11) NOT NULL,
  `E-mail` VARCHAR(45) NOT NULL,
  `idDepto` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idDepto`),
  UNIQUE INDEX `Nome Depto_UNIQUE` (`Nome Depto` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Telefone Depto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Telefone Depto` (
  `Telefone Depto` CHAR(11) NOT NULL,
  `Departamento_idDepto` INT NOT NULL,
  PRIMARY KEY (`Telefone Depto`, `Departamento_idDepto`),
  INDEX `fk_Telefone Depto_Departamento1_idx` (`Departamento_idDepto` ASC) VISIBLE,
  CONSTRAINT `fk_Telefone Depto_Departamento1`
    FOREIGN KEY (`Departamento_idDepto`)
    REFERENCES `mydb`.`Departamento` (`idDepto`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pessoa` (
  `CPF` CHAR(11) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Sexo` CHAR(1) NOT NULL,
  `E-mail` VARCHAR(45) NOT NULL,
  `Telefone` CHAR(11) NOT NULL,
  `idPessoa` VARCHAR(45) NOT NULL,
  `tipoPessoa` CHAR(1) NOT NULL,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  PRIMARY KEY (`idPessoa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
/* CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `Id Cliente` INT NOT NULL,
  `CPF Cliente` CHAR(11) NOT NULL,
  `CEP` CHAR(8) NOT NULL,
  `Estado Cliente` VARCHAR(45) NOT NULL,
  `Cidade Cliente` VARCHAR(45) NOT NULL,
  `Rua e Num Cliente` VARCHAR(45) NOT NULL,
  `CPF` CHAR(11) NOT NULL,
  `Pessoa_idPessoa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id Cliente`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  INDEX `fk_Cliente_Pessoa1_idx` (`Pessoa_idPessoa` ASC) VISIBLE,
  UNIQUE INDEX `Pessoa_idPessoa_UNIQUE` (`Pessoa_idPessoa` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Pessoa1`
    FOREIGN KEY (`Pessoa_idPessoa`)
    REFERENCES `mydb`.`Pessoa` (`idPessoa`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
*/
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `Id Cliente` INT NOT NULL,
  `CEP` CHAR(8) NOT NULL,
  `Estado Cliente` VARCHAR(45) NOT NULL,
  `Cidade Cliente` VARCHAR(45) NOT NULL,
  `Rua e Num Cliente` VARCHAR(45) NOT NULL,
  `CPF Cliente` CHAR(11) NOT NULL,
  `Pessoa_idPessoa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id Cliente`, `Pessoa_idPessoa`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF Cliente` ASC) VISIBLE,
  INDEX `fk_Cliente_Pessoa1_idx` (`Pessoa_idPessoa` ASC) VISIBLE,
  UNIQUE INDEX `Pessoa_idPessoa_UNIQUE` (`Pessoa_idPessoa` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Pessoa1`
    FOREIGN KEY (`Pessoa_idPessoa`)
    REFERENCES `mydb`.`Pessoa` (`idPessoa`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Funcionario` (
  `Carga Horaria` FLOAT NOT NULL,
  `Salario` FLOAT NOT NULL,
  `TipoFunc` CHAR(1) NOT NULL,
  `Data Inicio` DATE NOT NULL,
  `CPF Func` CHAR(11) NOT NULL,
  `Pessoa_idPessoa` VARCHAR(45) NOT NULL,
  `Departamento_idDepto` INT NOT NULL,
  PRIMARY KEY (`CPF Func`, `Departamento_idDepto`, `Pessoa_idPessoa`),
  INDEX `fk_Funcionario_Pessoa1_idx` (`Pessoa_idPessoa` ASC) VISIBLE,
  INDEX `fk_Funcionario_Departamento1_idx` (`Departamento_idDepto` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_Pessoa1`
    FOREIGN KEY (`Pessoa_idPessoa`)
    REFERENCES `mydb`.`Pessoa` (`idPessoa`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_Departamento1`
    FOREIGN KEY (`Departamento_idDepto`)
    REFERENCES `mydb`.`Departamento` (`idDepto`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Atendente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Atendente` (
  `Id Cliente` INT NOT NULL,
  `Num Problemas` INT NOT NULL,
  `CPF Aten` CHAR(11) NOT NULL,
  PRIMARY KEY (`CPF Aten`),
  INDEX `fk_Atendente_Funcionario1_idx` (`CPF Aten` ASC) VISIBLE,
  CONSTRAINT `fk_Atendente_Funcionario1`
    FOREIGN KEY (`CPF Aten`)
    REFERENCES `mydb`.`Funcionario` (`CPF Func`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fornecedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedores` (
  `CNPJ Forne` CHAR(11) NOT NULL,
  `Nome Forne` VARCHAR(45) NOT NULL,
  `E-mail Forne` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CNPJ Forne`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Telefone Forne`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Telefone Forne` (
  `Telefone Forne` CHAR(11) NOT NULL,
  `CNPJ Forne` CHAR(14) NOT NULL,
  PRIMARY KEY (`Telefone Forne`, `CNPJ Forne`),
  INDEX `fk_Telefone Forne_Fornecedores1_idx` (`CNPJ Forne` ASC) VISIBLE,
  CONSTRAINT `fk_Telefone Forne_Fornecedores1`
    FOREIGN KEY (`CNPJ Forne`)
    REFERENCES `mydb`.`Fornecedores` (`CNPJ Forne`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos em Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos em Estoque` (
  `Id Produto` INT NOT NULL,
  `Nome Produto` VARCHAR(45) NOT NULL,
  `Preço` FLOAT NOT NULL,
  `QTD. Produto` INT NOT NULL,
  `Descrição` VARCHAR(45) NOT NULL,
  `Produtos em Estoquecol` VARCHAR(100) NOT NULL,
  `Tipo Produto` CHAR(1) NOT NULL,
  `Genero Produto` VARCHAR(45) NOT NULL,
  `Tensão Produto` INT NOT NULL,
  `Produtos em Estoquecol1` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id Produto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos em Estoque_has_Fornecedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos em Estoque_has_Fornecedores` (
  `Produtos em Estoque_Id Produto` INT NOT NULL,
  `Fornecedores_CNPJ Forne` CHAR(11) NOT NULL,
  PRIMARY KEY (`Produtos em Estoque_Id Produto`, `Fornecedores_CNPJ Forne`),
  INDEX `fk_Produtos em Estoque_has_Fornecedores_Fornecedores1_idx` (`Fornecedores_CNPJ Forne` ASC) VISIBLE,
  INDEX `fk_Produtos em Estoque_has_Fornecedores_Produtos em Estoque_idx` (`Produtos em Estoque_Id Produto` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos em Estoque_has_Fornecedores_Produtos em Estoque1`
    FOREIGN KEY (`Produtos em Estoque_Id Produto`)
    REFERENCES `mydb`.`Produtos em Estoque` (`Id Produto`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produtos em Estoque_has_Fornecedores_Fornecedores1`
    FOREIGN KEY (`Fornecedores_CNPJ Forne`)
    REFERENCES `mydb`.`Fornecedores` (`CNPJ Forne`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente_has_Atendente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente_has_Atendente` (
  `Cliente_CPF` CHAR(11) NOT NULL,
  `Atendente_CPF Aten` CHAR(11) NOT NULL,
  PRIMARY KEY (`Cliente_CPF`, `Atendente_CPF Aten`),
  INDEX `fk_Cliente_has_Atendente_Atendente1_idx` (`Atendente_CPF Aten` ASC) VISIBLE,
  INDEX `fk_Cliente_has_Atendente_Cliente1_idx` (`Cliente_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_has_Atendente_Cliente1`
    FOREIGN KEY (`Cliente_CPF`)
    REFERENCES `mydb`.`Cliente` (`CPF Cliente`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Atendente_Atendente1`
    FOREIGN KEY (`Atendente_CPF Aten`)
    REFERENCES `mydb`.`Atendente` (`CPF Aten`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos em Estoque_has_Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos em Estoque_has_Funcionario` (
  `Produtos em Estoque_Id Produto` INT NOT NULL,
  `Funcionario_CPF Func` CHAR(11) NOT NULL,
  PRIMARY KEY (`Produtos em Estoque_Id Produto`, `Funcionario_CPF Func`),
  INDEX `fk_Produtos em Estoque_has_Funcionario_Funcionario1_idx` (`Funcionario_CPF Func` ASC) VISIBLE,
  INDEX `fk_Produtos em Estoque_has_Funcionario_Produtos em Estoque1_idx` (`Produtos em Estoque_Id Produto` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos em Estoque_has_Funcionario_Produtos em Estoque1`
    FOREIGN KEY (`Produtos em Estoque_Id Produto`)
    REFERENCES `mydb`.`Produtos em Estoque` (`Id Produto`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produtos em Estoque_has_Funcionario_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF Func`)
    REFERENCES `mydb`.`Funcionario` (`CPF Func`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Carrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Carrinho` (
  `qtdProdutos` INT NOT NULL,
  `idCarrinho` INT NOT NULL,
  `Cliente_Id Cliente` INT NOT NULL,
  PRIMARY KEY (`idCarrinho`),
  INDEX `fk_Carrinho_Cliente1_idx` (`Cliente_Id Cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Carrinho_Cliente1`
    FOREIGN KEY (`Cliente_Id Cliente`)
    REFERENCES `mydb`.`Cliente` (`Id Cliente`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos em Estoque_has_Carrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos em Estoque_has_Carrinho` (
  `Produtos em Estoque_Id Produto` INT NOT NULL,
  `Carrinho_idCarrinho` INT NOT NULL,
  PRIMARY KEY (`Produtos em Estoque_Id Produto`, `Carrinho_idCarrinho`),
  INDEX `fk_Produtos em Estoque_has_Carrinho_Carrinho1_idx` (`Carrinho_idCarrinho` ASC) VISIBLE,
  INDEX `fk_Produtos em Estoque_has_Carrinho_Produtos em Estoque1_idx` (`Produtos em Estoque_Id Produto` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos em Estoque_has_Carrinho_Produtos em Estoque1`
    FOREIGN KEY (`Produtos em Estoque_Id Produto`)
    REFERENCES `mydb`.`Produtos em Estoque` (`Id Produto`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produtos em Estoque_has_Carrinho_Carrinho1`
    FOREIGN KEY (`Carrinho_idCarrinho`)
    REFERENCES `mydb`.`Carrinho` (`idCarrinho`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `login` ;

-- -----------------------------------------------------
-- Table `login`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `login`.`users` (
  `usersId` INT(11) NOT NULL AUTO_INCREMENT,
  `usersName` VARCHAR(128) NOT NULL,
  `usersEmail` VARCHAR(128) NOT NULL,
  `usersUid` VARCHAR(128) NOT NULL,
  `usersPWD` VARCHAR(128) NOT NULL,
  `usersnumero` VARCHAR(128) NOT NULL,
  `userscpf` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`usersId`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;

USE `phpmyadmin` ;

-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__bookmark`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__bookmark` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `dbase` VARCHAR(255) NOT NULL DEFAULT '',
  `user` VARCHAR(255) NOT NULL DEFAULT '',
  `label` VARCHAR(255) CHARACTER SET 'utf8' NOT NULL DEFAULT '',
  `query` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Bookmarks';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__central_columns`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__central_columns` (
  `db_name` VARCHAR(64) NOT NULL,
  `col_name` VARCHAR(64) NOT NULL,
  `col_type` VARCHAR(64) NOT NULL,
  `col_length` TEXT NULL DEFAULT NULL,
  `col_collation` VARCHAR(64) NOT NULL,
  `col_isNull` TINYINT(1) NOT NULL,
  `col_extra` VARCHAR(255) NULL DEFAULT '',
  `col_default` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`db_name`, `col_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Central list of columns';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__column_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__column_info` (
  `id` INT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `db_name` VARCHAR(64) NOT NULL DEFAULT '',
  `table_name` VARCHAR(64) NOT NULL DEFAULT '',
  `column_name` VARCHAR(64) NOT NULL DEFAULT '',
  `comment` VARCHAR(255) CHARACTER SET 'utf8' NOT NULL DEFAULT '',
  `mimetype` VARCHAR(255) CHARACTER SET 'utf8' NOT NULL DEFAULT '',
  `transformation` VARCHAR(255) NOT NULL DEFAULT '',
  `transformation_options` VARCHAR(255) NOT NULL DEFAULT '',
  `input_transformation` VARCHAR(255) NOT NULL DEFAULT '',
  `input_transformation_options` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `db_name` (`db_name` ASC, `table_name` ASC, `column_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Column information for phpMyAdmin';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__designer_settings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__designer_settings` (
  `username` VARCHAR(64) NOT NULL,
  `settings_data` TEXT NOT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Settings related to Designer';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__export_templates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__export_templates` (
  `id` INT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(64) NOT NULL,
  `export_type` VARCHAR(10) NOT NULL,
  `template_name` VARCHAR(64) NOT NULL,
  `template_data` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `u_user_type_template` (`username` ASC, `export_type` ASC, `template_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Saved export templates';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__favorite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__favorite` (
  `username` VARCHAR(64) NOT NULL,
  `tables` TEXT NOT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Favorite tables';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__history` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(64) NOT NULL DEFAULT '',
  `db` VARCHAR(64) NOT NULL DEFAULT '',
  `table` VARCHAR(64) NOT NULL DEFAULT '',
  `timevalue` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `sqlquery` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `username` (`username` ASC, `db` ASC, `table` ASC, `timevalue` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'SQL history for phpMyAdmin';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__navigationhiding`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__navigationhiding` (
  `username` VARCHAR(64) NOT NULL,
  `item_name` VARCHAR(64) NOT NULL,
  `item_type` VARCHAR(64) NOT NULL,
  `db_name` VARCHAR(64) NOT NULL,
  `table_name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`username`, `item_name`, `item_type`, `db_name`, `table_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Hidden items of navigation tree';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__pdf_pages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__pdf_pages` (
  `db_name` VARCHAR(64) NOT NULL DEFAULT '',
  `page_nr` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `page_descr` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL DEFAULT '',
  PRIMARY KEY (`page_nr`),
  INDEX `db_name` (`db_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'PDF relation pages for phpMyAdmin';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__recent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__recent` (
  `username` VARCHAR(64) NOT NULL,
  `tables` TEXT NOT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Recently accessed tables';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__relation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__relation` (
  `master_db` VARCHAR(64) NOT NULL DEFAULT '',
  `master_table` VARCHAR(64) NOT NULL DEFAULT '',
  `master_field` VARCHAR(64) NOT NULL DEFAULT '',
  `foreign_db` VARCHAR(64) NOT NULL DEFAULT '',
  `foreign_table` VARCHAR(64) NOT NULL DEFAULT '',
  `foreign_field` VARCHAR(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`master_db`, `master_table`, `master_field`),
  INDEX `foreign_field` (`foreign_db` ASC, `foreign_table` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Relation table';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__savedsearches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__savedsearches` (
  `id` INT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(64) NOT NULL DEFAULT '',
  `db_name` VARCHAR(64) NOT NULL DEFAULT '',
  `search_name` VARCHAR(64) NOT NULL DEFAULT '',
  `search_data` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `u_savedsearches_username_dbname` (`username` ASC, `db_name` ASC, `search_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Saved searches';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__table_coords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__table_coords` (
  `db_name` VARCHAR(64) NOT NULL DEFAULT '',
  `table_name` VARCHAR(64) NOT NULL DEFAULT '',
  `pdf_page_number` INT(11) NOT NULL DEFAULT 0,
  `x` FLOAT UNSIGNED NOT NULL DEFAULT 0,
  `y` FLOAT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`db_name`, `table_name`, `pdf_page_number`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Table coordinates for phpMyAdmin PDF output';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__table_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__table_info` (
  `db_name` VARCHAR(64) NOT NULL DEFAULT '',
  `table_name` VARCHAR(64) NOT NULL DEFAULT '',
  `display_field` VARCHAR(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`db_name`, `table_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Table information for phpMyAdmin';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__table_uiprefs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__table_uiprefs` (
  `username` VARCHAR(64) NOT NULL,
  `db_name` VARCHAR(64) NOT NULL,
  `table_name` VARCHAR(64) NOT NULL,
  `prefs` TEXT NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  PRIMARY KEY (`username`, `db_name`, `table_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Tables\' UI preferences';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__tracking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__tracking` (
  `db_name` VARCHAR(64) NOT NULL,
  `table_name` VARCHAR(64) NOT NULL,
  `version` INT(10) UNSIGNED NOT NULL,
  `date_created` DATETIME NOT NULL,
  `date_updated` DATETIME NOT NULL,
  `schema_snapshot` TEXT NOT NULL,
  `schema_sql` TEXT NULL DEFAULT NULL,
  `data_sql` LONGTEXT NULL DEFAULT NULL,
  `tracking` SET('UPDATE', 'REPLACE', 'INSERT', 'DELETE', 'TRUNCATE', 'CREATE DATABASE', 'ALTER DATABASE', 'DROP DATABASE', 'CREATE TABLE', 'ALTER TABLE', 'RENAME TABLE', 'DROP TABLE', 'CREATE INDEX', 'DROP INDEX', 'CREATE VIEW', 'ALTER VIEW', 'DROP VIEW') NULL DEFAULT NULL,
  `tracking_active` INT(1) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`db_name`, `table_name`, `version`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Database changes tracking for phpMyAdmin';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__userconfig`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__userconfig` (
  `username` VARCHAR(64) NOT NULL,
  `timevalue` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `config_data` TEXT NOT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'User preferences storage for phpMyAdmin';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__usergroups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__usergroups` (
  `usergroup` VARCHAR(64) NOT NULL,
  `tab` VARCHAR(64) NOT NULL,
  `allowed` ENUM('Y', 'N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`usergroup`, `tab`, `allowed`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'User groups with configured menu items';


-- -----------------------------------------------------
-- Table `phpmyadmin`.`pma__users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `phpmyadmin`.`pma__users` (
  `username` VARCHAR(64) NOT NULL,
  `usergroup` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`username`, `usergroup`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
COMMENT = 'Users and their assignments to user groups';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
