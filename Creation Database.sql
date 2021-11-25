create database COMERCIO;

use COMERCIO;

DROP TABLE CLIENTE;

CREATE TABLE CLIENTE(
	IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	SEXO ENUM('M','F') NOT NULL,
	EMAIL VARCHAR(50) UNIQUE,
	CPF VARCHAR(15) UNIQUE
);

CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY AUTO_INCREMENT, 
	RUA VARCHAR(30) NOT NULL,
	BAIRRO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL,
	ESTADO CHAR(2) NOT NULL,
	ID_CLIENTE INT UNIQUE,

	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);

CREATE TABLE TELEFONE(
	IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT, 
	TIPO ENUM('RES','COM','CEL') NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE INT,

	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);


desc cliente;

INSERT INTO CLIENTE VALUES(NULL,'JOAO','M','JOAO@IG.COM.BR','76567587887');
INSERT INTO CLIENTE VALUES(NULL,'CARLOS','M','CARLOS@IG.COM.BR','1020304050');
INSERT INTO CLIENTE VALUES(NULL,'ANA','F','ANA@IG.COM.BR','60708090100');
INSERT INTO CLIENTE VALUES(NULL,'CLARA','F',NULL,'110120130140');
INSERT INTO CLIENTE VALUES(NULL,'JORGE','M','JORGE@IG.COM.BR','150160170180');
INSERT INTO CLIENTE VALUES(NULL,'CELIA','F','CELIA@IG.COM.BR','190200210220');