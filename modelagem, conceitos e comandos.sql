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

/* ENDEREÇO - OBRIGATORIO
CADASTRO DE SOMENTE UM 

TELEFONE - NÃO OBRIGATORIO
CADASTRO DE MAIS DE UM OPCIONAL */

/* 
CHAVE ESTRANGEIRA - É A CHAVE PRIMARIA DE UMA TABELA
QUE VAI ATE A OUTRA TABELA PARA FAZER REFERENCIA ENTRE
REGISTROS */

/* EM RELACIONAMENTO 1 x 1 A CHAVE ESTRANGEIRA FICA NA TABELA MAIS FRACA */

/* EM RELACIONAMENTO 1 x n A CHAVE ESTRANGEIRA FICARA SEMPRE NA
CARDINALIDADE n */
  

desc cliente;

INSERT INTO CLIENTE VALUES(NULL,'JOAO','M','JOAO@IG.COM.BR','76567587887');
INSERT INTO CLIENTE VALUES(NULL,'CARLOS','M','CARLOS@IG.COM.BR','1020304050');
INSERT INTO CLIENTE VALUES(NULL,'ANA','F','ANA@IG.COM.BR','60708090100');
INSERT INTO CLIENTE VALUES(NULL,'CLARA','F',NULL,'110120130140');
INSERT INTO CLIENTE VALUES(NULL,'JORGE','M','JORGE@IG.COM.BR','150160170180');
INSERT INTO CLIENTE VALUES(NULL,'CELIA','F','CELIA@IG.COM.BR','190200210220');

select * from cliente;


+-----------+--------+------+------------------+--------------+
| IDCLIENTE | NOME   | SEXO | EMAIL            | CPF          |
+-----------+--------+------+------------------+--------------+
|         1 | JOAO   | M    | JOAO@IG.COM.BR   | 13374939708  |
|         2 | CARLOS | M    | CARLOS@IG.COM.BR | 1020304050   |
|         3 | ANA    | F    | ANA@IG.COM.BR    | 60708090100  |
|         4 | CLARA  | F    | NULL             | 110120130140 |
|         5 | JORGE  | M    | JORGE@IG.COM.BR  | 150160170180 |
|         6 | CELIA  | F    | CELIA@IG.COM.BR  | 190200210220 |
+-----------+--------+------+------------------+--------------+

desc endereco;

INSERT INTO ENDERECO VALUES (NULL,'RUA ANTONIO SÁ','CENTRO','BELO HORIZONTE','MG',4);
INSERT INTO ENDERECO VALUES (NULL,'RUA CAPITÃO HERMES','CENTRO','RIO DE JANEIRO','RJ',1);
INSERT INTO ENDERECO VALUES (NULL,'RUA PRESIDENTE VARGAS','JARDINS','SÃO PAULO','SP',3);
INSERT INTO ENDERECO VALUES (NULL,'RUA ALFANDEGA','ESTACIO','RIO DE JANEIRO','RJ',2);
INSERT INTO ENDERECO VALUES (NULL,'RUA OUVIDOR','FLAMENGO','RIO DE JANEIRO','RJ',6);
INSERT INTO ENDERECO VALUES (NULL,'RUA URUGUAIANA','CENTRO','VITORIA','ES',5);


select * from endereco;

desc telefone;

INSERT INTO TELEFONE VALUES(NULL,'CEL','78458743',5);
INSERT INTO TELEFONE VALUES(NULL,'RES','93314430',5);
INSERT INTO TELEFONE VALUES(NULL,'CEL','38686255',1);
INSERT INTO TELEFONE VALUES(NULL,'COM','97318461',2);
INSERT INTO TELEFONE VALUES(NULL,'RES','93314440',1);
INSERT INTO TELEFONE VALUES(NULL,'CEL','99667573',3);
INSERT INTO TELEFONE VALUES(NULL,'CEL','66687899',3);
INSERT INTO TELEFONE VALUES(NULL,'COM','21458796',1);
INSERT INTO TELEFONE VALUES(NULL,'RES','49986668',5);
INSERT INTO TELEFONE VALUES(NULL,'CEL','36921472',2);

select * from telefone;

/* SELEÇÃO, PROJEÇÃO E JUNÇÃO */

select now() as data_atual;

select 2 + 2 as soma;

select 2 + 2 as soma, nome, now()
from cliente;

/* PROJECAO -> É TUDO QUE VOCE QUER VER NA TELA */

SELECT NOW() AS DATA_ATUAL;

SELECT 2 + 2 AS SOMA;

SELECT 2 + 2 AS SOMA, NOME, NOW()
FROM CLIENTE;

/* SELECAO -> É UM SUBCONJUNTO DO CONJUNTO TOTAL DE REGISTROS DE UMA TABELA
A CLAUSULA DE SELECAO É O WHERE
*/

select nome, sexo, email /*PROJEÇÃO */
from cliente
where sexo = 'F';  /* SELEÇÃO */

select NUMERO
from telefone
where tipo = 'CEL';


/* JUNÇÃO - JOIN */

select nome, email, IDCLIENTE
from cliente;


select ID_CLIENTE, bairro, CIDADE
from ENDERECO;

+--------+----------------+-----------+
| NOME   | EMAIL          | IDCLIENTE |
+--------+----------------+-----------+
| JOAO   | JOAOA@IG.COM   |         1 |
| CARLOS | CARLOSA@IG.COM |         2 |
| ANA    | ANA@IG.COM     |         3 |
| CLARA  | NULL           |         4 |
| JORGE  | JORGE@IG.COM   |         5 |
| CELIA  | JCELIA@IG.COM  |         6 |
+--------+----------------+-----------+

+------------+----------+----------------+
| ID_CLIENTE | BAIRRO   | CIDADE         |
+------------+----------+----------------+
|          4 | CENTRO   | B. HORIZONTE   |
|          1 | CENTRO   | RIO DE JANEIRO |
|          3 | JARDINS  | SAO PAULO      |
|          2 | ESTACIO  | RIO DE JANEIRO |
|          6 | FLAMENGO | RIO DE JANEIRO |
|          5 | CENTRO   | VITORIA        |
+------------+----------+----------------+

/* nome, sexo, bairro, cidade*/

/* where - seleção */

select nome, sexo, bairro, cidade 
from cliente, endereco
where IDCLIENTE = ID_CLIENTE 
and sexo = 'F';
+--------+------+----------+----------------+
| nome   | sexo | bairro   | cidade         |
+--------+------+----------+----------------+
| JOAO   | M    | CENTRO   | RIO DE JANEIRO |
| CARLOS | M    | ESTACIO  | RIO DE JANEIRO |
| ANA    | F    | JARDINS  | SÃO PAULO      |
| CLARA  | F    | CENTRO   | BELO HORIZONTE |
| JORGE  | M    | CENTRO   | VITORIA        |
| CELIA  | F    | FLAMENGO | RIO DE JANEIRO |
+--------+------+----------+----------------+

/* where IDCLIENTE = ID_CLIENTE
AND SEXO = 'F';  -> TABELA VERDADE */

SELECT NOME, SEXO, BAIRRO, CIDADE /* PROJEÇÃO*/
FROM CLIENTE /* ORIGEM */
	INNER JOIN ENDERECO /* JUNÇÃO */
	ON IDCLIENTE = ID_CLIENTE
WHERE SEXO = 'F'; /* SELEÇÃO */

+--------+------+----------+----------------+
| NOME   | SEXO | BAIRRO   | CIDADE         |
+--------+------+----------+----------------+
| JOAO   | M    | CENTRO   | RIO DE JANEIRO |
| CARLOS | M    | ESTACIO  | RIO DE JANEIRO |
| ANA    | F    | JARDINS  | SÃO PAULO      |
| CLARA  | F    | CENTRO   | BELO HORIZONTE |
| JORGE  | M    | CENTRO   | VITORIA        |
| CELIA  | F    | FLAMENGO | RIO DE JANEIRO |
+--------+------+----------+----------------+

/* MOME, SEXO, EMAIL, TIPO, NUMERO */

SELECT NOME, SEXO, EMAIL, TIPO, NUMERO
FROM CLIENTE
INNER JOIN TELEFONE
ON IDCLIENTE = ID_CLIENTE
WHERE NOME = 'JORGE';

/* NOME, SEXO, BAIRRO, CIDADE, TIPO, NUMERO */

SELECT CLIENTE.NOME, CLIENTE.SEXO, ENDERECO.BAIRRO, ENDERECO.CIDADE, TELEFONE.TIPO, TELEFONE.NUMERO
FROM CLIENTE
INNER JOIN ENDERECO
ON CLIENTE.IDCLIENTE = ENDERECO.ID_CLIENTE
INNER JOIN TELEFONE
ON CLIENTE.IDCLIENTE = TELEFONE.ID_CLIENTE;

+--------+------+---------+----------------+------+----------+
| NOME   | SEXO | BAIRRO  | CIDADE         | TIPO | NUMERO   |
+--------+------+---------+----------------+------+----------+
| JORGE  | M    | CENTRO  | VITORIA        | CEL  | 78458743 |
| JORGE  | M    | CENTRO  | VITORIA        | RES  | 93314430 |
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | CEL  | 38686255 |
| CARLOS | M    | ESTACIO | RIO DE JANEIRO | COM  | 97318461 |
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | RES  | 93314440 |
| ANA    | F    | JARDINS | SÃO PAULO      | CEL  | 99667573 |
| ANA    | F    | JARDINS | SÃO PAULO      | CEL  | 66687899 |
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | COM  | 21458796 |
| JORGE  | M    | CENTRO  | VITORIA        | RES  | 49986668 |
| CARLOS | M    | ESTACIO | RIO DE JANEIRO | CEL  | 36921472 |
+--------+------+---------+----------------+------+----------+

SELECT C.NOME, C.SEXO, E.BAIRRO, E.CIDADE, T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+--------+------+---------+----------------+------+----------+
| NOME   | SEXO | BAIRRO  | CIDADE         | TIPO | NUMERO   |
+--------+------+---------+----------------+------+----------+
| JORGE  | M    | CENTRO  | VITORIA        | CEL  | 78458743 |
| JORGE  | M    | CENTRO  | VITORIA        | RES  | 93314430 |
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | CEL  | 38686255 |
| CARLOS | M    | ESTACIO | RIO DE JANEIRO | COM  | 97318461 |
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | RES  | 93314440 |
| ANA    | F    | JARDINS | SÃO PAULO      | CEL  | 99667573 |
| ANA    | F    | JARDINS | SÃO PAULO      | CEL  | 66687899 |
| JOAO   | M    | CENTRO  | RIO DE JANEIRO | COM  | 21458796 |
| JORGE  | M    | CENTRO  | VITORIA        | RES  | 49986668 |
| CARLOS | M    | ESTACIO | RIO DE JANEIRO | CEL  | 36921472 |
+--------+------+---------+----------------+------+----------+


/*
	DML = DATA MANIPULATION LANGUAGE
	DDL = DATA DEFINITION LANGUAGE
	DCL = DATA CONTROL LANGUAGE
	TCL	= TRANSACTION CONTROL LANGUAGE

*/

/* INSERT */

INSERT INTO CLIENTE VALUES (NULL,'PAULA','M',NULL,'77437493');
INSERT INTO ENDERECO VALUES (NULL,'RUA JOAQUIM SILVA','ALVORADA','NITEROI','RJ',7);

/* FILTROS*/

select * from cliente
where sexo = 'M';

/* UPDATE*/

SELECT * FROM CLIENTE
WHERE IDCLIENTE = 7;

UPDATE CLIENTE
SET SEXO = 'F'
WHERE  IDCLIENTE = 7;

/*DELETE*/

INSERT INTO CLIENTE VALUES (NULL,'XXX','M',NULL,'XXX');

SELECT * FROM CLIENTE
WHERE IDCLIENTE = 8;

DELETE FROM CLIENTE
WHERE IDCLIENTE = 8;

/*
 DDL - DATA DEFINITION LANGUAGE
*/

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME_PRODUTO VARCHAR(30) NOT NULL,
	PRECO INT,
	FRETE FLOAT(10,2) NOT NULL
);

/* ALTER TABLE */

/* ALTERANDO O NOME DE UMA COLUNA - CHANGE */

ALTER TABLE PRODUTO
CHANGE PRECO VALOR_UNITARIO INT NOT NULL;
 
DESC PRODUTO;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | int(11)     | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

ALTER TABLE PRODUTO
CHANGE VALOR_UNITARIO VALOR_UNITARIO INT ;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | int(11)     | YES  |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

DESC PRODUTO;


/* MODIFY - ALTERANDO O TIPO */

ALTER TABLE PRODUTO 
MODIFY VALOR_UNITARIO VARCHAR(50) NOT NULL;

DESC PRODUTO;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | varchar(50) | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

/* ADCIONANDO COLUNAS */

ALTER TABLE PRODUTO
ADD PESO FLOAT(10,2) NOT NULL;

desc produto;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | varchar(50) | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
| PESO           | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

/* APAGANDO UMA COLUNA */

ALTER TABLE PRODUTO
DROP COLUMN PESO;

desc produto;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | varchar(50) | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

/* ADCIONANDO UMA COLUNA NA ORDEM ESPECIFICA */

ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT(10,2) NOT NULL
AFTER NOME_PRODUTO;

desc produto;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| PESO           | float(10,2) | NO   |     | NULL    |                |
| VALOR_UNITARIO | varchar(50) | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+


ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT(10,2) NOT NULL
FIRST;

desc produto;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| PESO           | float(10,2) | NO   |     | NULL    |                |
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | varchar(50) | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+


desc cliente;
desc endereco;
desc telefone;


/* EX 1 */
select C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF,
E.IDENDERECO, E.RUA, E.BAIRRO, E.CIDADE, E.ESTADO,
T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

update cliente
set sexo = 'F'	
WHERE IDCLIENTE IN (12,13,14,18,19);

update cliente 
set sexo = 'M'
where IDCLIENTE = 16;

/* EX 2 */
select C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF,
E.IDENDERECO, E.RUA, E.BAIRRO, E.CIDADE, E.ESTADO,
T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'M';

/* EX 3 */
select C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF,
E.IDENDERECO, E.RUA, E.BAIRRO, E.CIDADE, E.ESTADO,
T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'M';

/* EX 4 */

select count(*) as QUANTIDADE, SEXO from cliente
group by sexo;

/* EX 5 */

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, T.TIPO, E.BAIRRO, E.ESTADO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'F'
AND BAIRRO = 'CENTRO' AND CIDADE = 'RIO DE JANEIRO';

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, T.TIPO, E.BAIRRO, E.ESTADO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE SEXO = 'F'
AND BAIRRO = 'CENTRO' AND CIDADE = 'RIO DE JANEIRO'
AND (TIPO = 'RES' OR TIPO = 'COM');

/* EX 6 */

SELECT C.NOME, C.EMAIL, T.NUMERO as CELULAR
from cliente C
inner join telefone T
on C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
where E.ESTADO = 'RJ'
and T.Tipo = 'CEL';

SELECT   C.NOME, C.EMAIL, T.NUMERO AS CELULAR 
FROM CLIENTE C 
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE 
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE 
WHERE TIPO = 'CEL' AND ESTADO = 'RJ';


/* EX 7 */

SELECT   C.NOME, C.EMAIL, T.NUMERO AS CELULAR 
FROM CLIENTE C 
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE 
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE 
WHERE SEXO = 'F'
AND TIPO = 'CEL' AND ESTADO = 'SP';


/* nome, email, numero. estado */

select c.nome, c.email, e.estado, t.numero
from cliente c
inner join endereco  e
on c.IDCLIENTE = e.ID_CLIENTE
inner join telefone t
on c.IDCLIENTE = t.ID_CLIENTE;

+---------+-------------------+--------+-----------+
| nome    | email             | estado | numero    |
+---------+-------------------+--------+-----------+
| JORGE   | JORGE@IG.COM.BR   | ES     | 78458743  |
| JORGE   | JORGE@IG.COM.BR   | ES     | 93314430  |
| JOAO    | JOAO@IG.COM.BR    | RJ     | 38686255  |
| CARLOS  | CARLOS@IG.COM.BR  | RJ     | 97318461  |
| JOAO    | JOAO@IG.COM.BR    | RJ     | 93314440  |
| ANA     | ANA@IG.COM.BR     | SP     | 99667573  |
| ANA     | ANA@IG.COM.BR     | SP     | 66687899  |
| JOAO    | JOAO@IG.COM.BR    | RJ     | 21458796  |
| JORGE   | JORGE@IG.COM.BR   | ES     | 49986668  |
| CARLOS  | CARLOS@IG.COM.BR  | RJ     | 36921472  |
| FLAVIO  | FLAVIO@IG.COM     | MG     | 68976565  |
| FLAVIO  | FLAVIO@IG.COM     | MG     | 99656675  |
| GIOVANA | NULL              | RJ     | 33567765  |
| GIOVANA | NULL              | RJ     | 88668786  |
| GIOVANA | NULL              | RJ     | 55689654  |
| KARLA   | KARLA@GMAIL.COM   | RJ     | 88687979  |
| DANIELE | DANIELE@GMAIL.COM | ES     | 88965676  |
| EDUARDO | NULL              | PR     | 89966809  |
| ANTONIO | ANTONIO@IG.COM    | SP     | 88679978  |
| ANTONIO | ANTONIO@UOL.COM   | PR     | 99655768  |
| ELAINE  | ELAINE@GLOBO.COM  | SP     | 89955665  |
| CARMEM  | CARMEM@IG.COM     | RJ     | 77455786  |
| CARMEM  | CARMEM@IG.COM     | RJ     | 89766554  |
| ADRIANA | ADRIANA@GMAIL.COM | RJ     | 77755785  |
| ADRIANA | ADRIANA@GMAIL.COM | RJ     | 44522578  |
| JOICE   | JOICE@GMAIL.COM   | RJ     | 445574181 |
+---------+-------------------+--------+-----------+


/* IFNULL() FUNÇÃO */

SELECT C.NOME,
 	   IFNULL(C.EMAIL,'***********'),
  	   E.ESTADO,
       T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO  E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+---------+-------------------------------+--------+-----------+
| NOME    | IFNULL(C.EMAIL,'***********') | ESTADO | NUMERO    |
+---------+-------------------------------+--------+-----------+
| JORGE   | JORGE@IG.COM.BR               | ES     | 78458743  |
| JORGE   | JORGE@IG.COM.BR               | ES     | 93314430  |
| JOAO    | JOAO@IG.COM.BR                | RJ     | 38686255  |
| CARLOS  | CARLOS@IG.COM.BR              | RJ     | 97318461  |
| JOAO    | JOAO@IG.COM.BR                | RJ     | 93314440  |
| ANA     | ANA@IG.COM.BR                 | SP     | 99667573  |
| ANA     | ANA@IG.COM.BR                 | SP     | 66687899  |
| JOAO    | JOAO@IG.COM.BR                | RJ     | 21458796  |
| JORGE   | JORGE@IG.COM.BR               | ES     | 49986668  |
| CARLOS  | CARLOS@IG.COM.BR              | RJ     | 36921472  |
| FLAVIO  | FLAVIO@IG.COM                 | MG     | 68976565  |
| FLAVIO  | FLAVIO@IG.COM                 | MG     | 99656675  |
| GIOVANA | ***********                   | RJ     | 33567765  |
| GIOVANA | ***********                   | RJ     | 88668786  |
| GIOVANA | ***********                   | RJ     | 55689654  |
| KARLA   | KARLA@GMAIL.COM               | RJ     | 88687979  |
| DANIELE | DANIELE@GMAIL.COM             | ES     | 88965676  |
| EDUARDO | ***********                   | PR     | 89966809  |
| ANTONIO | ANTONIO@IG.COM                | SP     | 88679978  |
| ANTONIO | ANTONIO@UOL.COM               | PR     | 99655768  |
| ELAINE  | ELAINE@GLOBO.COM              | SP     | 89955665  |
| CARMEM  | CARMEM@IG.COM                 | RJ     | 77455786  |
| CARMEM  | CARMEM@IG.COM                 | RJ     | 89766554  |
| ADRIANA | ADRIANA@GMAIL.COM             | RJ     | 77755785  |
| ADRIANA | ADRIANA@GMAIL.COM             | RJ     | 44522578  |
| JOICE   | JOICE@GMAIL.COM               | RJ     | 445574181 |
+---------+-------------------------------+--------+-----------+

SELECT C.NOME,
 	   IFNULL(C.EMAIL,'***********') as "E-MAIL",
  	   E.ESTADO,
       T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO  E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;


SELECT C.NOME,
 	   C.SEXO,
       C.EMAIL,
       T.TIPO,
       T.NUMERO,
       E.BAIRRO,
       E.CIDADE,
       E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;


/* VIEW -  */

CREATE VIEW RELATORIO AS 
SELECT C.NOME,
 	   C.SEXO,
       C.EMAIL,
       T.TIPO,
       T.NUMERO,
       E.BAIRRO,
       E.CIDADE,
       E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;

SELECT * FROM RELATORIO;

SHOW TABLES;
SHOW DATABASES;

/* APAGANDO UMA VIEW */

drop view relatorio;
/* INSERINDO UM PREFIXO */

CREATE VIEW V_RELATORIO AS 
SELECT C.NOME,
 	   C.SEXO,
       IFNULL(C.EMAIL,"CLIENTE SEM EMAIL") AS "E-MAIL",
       T.TIPO,
       T.NUMERO,
       E.BAIRRO,
       E.CIDADE,
       E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;

SELECT NOME, NUMERO, ESTADO
FROM V_RELATORIO;

/* UPDATE, INSERT E DELETE - DML */

INSERT INTO V_RELATORIO VALUES(
'ANDREIA','F','ANDREIA@UOL.COM.BR','CEL','873547864','CENTRO','VITORIA','ES'	
);

CREATE TABLE JOGADORES(
	IDJOGADOR INT,
	NOME VARCHAR(30),
	ESTADO CHAR(2)
);

INSERT INTO JOGADORES VALUES(1,'GUERRERO','RS');
INSERT INTO JOGADORES VALUES(2,'GABIGOL','RJ');
INSERT INTO JOGADORES VALUES(3,'GANSO','RJ');
INSERT INTO JOGADORES VALUES(4,'NENÊ','RJ');
INSERT INTO JOGADORES VALUES(5,'LOVE','SP');

CREATE VIEW V_JOGADORES AS
SELECT NOME, ESTADO
FROM JOGADORES;

select * from v_jogadores;

/* order by*/

create table ALUNOS(
	NUMERO INT,
	NOME VARCHAR(30)
);


INSERT INTO ALUNOS VALUES(1,'JOAO');
INSERT INTO ALUNOS VALUES(1,'MARIA');
INSERT INTO ALUNOS VALUES(2,'ZOE');
INSERT INTO ALUNOS VALUES(2,'ANDRE');
INSERT INTO ALUNOS VALUES(3,'CLARA');
INSERT INTO ALUNOS VALUES(1,'CLARA');
INSERT INTO ALUNOS VALUES(4,'MAFRA');
INSERT INTO ALUNOS VALUES(5,'JANAINA');
INSERT INTO ALUNOS VALUES(1,'JANAINA');
INSERT INTO ALUNOS VALUES(3,'MARCELO');
INSERT INTO ALUNOS VALUES(4,'GIOVANI');
INSERT INTO ALUNOS VALUES(5,'ANTONIO');
INSERT INTO ALUNOS VALUES(6,'ANA');
INSERT INTO ALUNOS VALUES(6,'VIVIANE'); 

SELECT * FROM ALUNOS
ORDER BY NUMERO;

SELECT * FROM ALUNOS
ORDER BY 1;

SELECT * FROM ALUNOS
ORDER BY 2;

/* ORDENANDO POR MAIS DE UMA COLUNA*/

SELECT * FROM ALUNOS
ORDER BY 1;

SELECT * FROM ALUNOS 
ORDER BY NOME, NUMERO;

SELECT * FROM ALUNOS 
ORDER BY 1, 2;

/* MESCLANDO ORDER BY COM PROJEÇÂO*/

SELECT NOME FROM ALUNOS
ORDER BY 1, 2;

SELECT NOME FROM ALUNOS
ORDER BY NUMERO, NOME;

/* ORDER BY DESC/ ASC */

SELECT * FROM ALUNOS 
ORDER BY 1, 2;

SELECT * FROM ALUNOS 
ORDER BY 1 ASC;

SELECT * FROM ALUNOS 
ORDER BY 1 DESC;

SELECT * FROM ALUNOS 
ORDER BY 1 DESC,2 DESC;


/* Delimitador */

SELECT  C.NOME, 
		C.SEXO, 
		IFNULL(C.EMAIL,'CLIENTE SEM EMAIL') AS "E-MAIL", 
		T.TIPO, 
		T.NUMERO, 
		E.BAIRRO, 
		E.CIDADE, 
		E.ESTADO
FROM CLIENTE C 
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE 
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE
ORDER BY 1;

DELIMITER ;


/* STORED PROCEDURES */

select 'MAFRA';

DELIMITER $

CREATE PROCEDURE NOME()
BEGIN

	QUALQUER PROGRAMACAO;

END
$

CREATE PROCEDURE NOME_EMPRESA()
BEGIN
	
	SELECT 'UNIVERSIDADE DOS DADOS' AS EMPRESA;

END
$		

/* CHAMANDO UMA PROCEDURE */

CALL NOME_EMPRESA()$

DELIMITER ;

CALL NOME_EMPRESA();

/* PROCEDURES COM PARAMETROS */

SELECT 10 + 10 AS CONTA;


CREATE PROCEDURE CONTA()
BEGIN
	
	SELECT 10 + 10 AS CONTA;

END
$

CALL CONTA();	

DROP PROCEDURE CONTA;

CREATE PROCEDURE CONTA(NUMERO1 INT, NUMERO2 INT)
BEGIN
	
	SELECT NUMERO1 + NUMERO2 AS CONTA;

END
$

CALL CONTA(100,50)$
CALL CONTA(400,24)$
CALL CONTA(20,1)$
CALL CONTA(10,51)$


/*  RECAP */

CREATE TABLE ALUNOS(
	NUMERO INT,
	NOME VARCHAR(30)
);


create table cursos(
	IDCURSO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	HORAS INT(3)NOT NULL,
	VALOR FLOAT(10,2) NOT NULL

);

desc cursos;

INSERT INTO CURSOS VALUES(NULL,'JAVA',30,500.00);
INSERT INTO CURSOS VALUES(NULL,'FUNDAMENTOS DE BANCO DE DADOS',40,700.00);
INSERT INTO CURSOS VALUES(NULL,'JAVA',30,500.00)
INSERT INTO CURSOS VALUES(NULL,'JAVA',30,500.00)

SELECT * FROM CURSOS;

DELIMITER #

STATUS

CREATE PROCEDURE CAD_CURSO(P_NOME VARCHAR(30),
							P_HORAS INT(3),
							P_PRECO FLOAT(10,2))
BEGIN
	
		INSERT INTO CURSOS VALUES(NULL,P_NOME, P_HORAS, P_PRECO);
	

END
#

DELIMITER ;

CALL CAD_CURSO('BI SQL SERVER',15,3000.00);
CALL CAD_CURSO('POWER BI',20,1000.00);
CALL CAD_CURSO('TABLEAU',30,1200.00);

/* CRIAR UMA PROCEDURE PARA CONSULTAR CURSOS */



/* A29 FUNCOES DE AGREGACAO NUMERICAS */

CREATE TABLE VENDEDORES(
	IDVENDEDOR INT PRIMARY KEY auto_increment,
	NOME VARCHAR(30),
	SEXO CHAR(1),
	JANEIRO FLOAT(10,2),
	FEVEREIRO FLOAT(10,2),
	MARCO FLOAT(10,2)
);


INSERT INTO VENDEDORES VALUES(NULL,'CARLOS','M',76234.78,88346.87,5756.90);
INSERT INTO VENDEDORES VALUES(NULL,'MARIA','F',5865.78,6768.87,4467.90);
INSERT INTO VENDEDORES VALUES(NULL,'ANTONIO','M',78769.78,6685.87,6664.90);
INSERT INTO VENDEDORES VALUES(NULL,'CLARA','F',5779.78,446886.87,8965.90);
INSERT INTO VENDEDORES VALUES(NULL,'ANDERSON','M',676545.78,77544.87,578665.90);
INSERT INTO VENDEDORES VALUES(NULL,'IVONE','F',57789.78,44774.87,68665.90);
INSERT INTO VENDEDORES VALUES(NULL,'JOAO','M',4785.78,66478.87,6887.90);
INSERT INTO VENDEDORES VALUES(NULL,'CELIA','F',89667.78,57654.87,5755.90);

/* MAX - TRAZ O VALOR MAXIMO DE UMA COLUNA */

SELECT MAX(FEVEREIRO) AS MAIOR_FEV
FROM VENDEDORES;

/* MIN - TRAZ O VALOR MINIMO DE UMA COLUNA */

SELECT MIN(FEVEREIRO) AS MENOR_FEV
FROM VENDEDORES;

/* AVG - TRAZ O VALOR MEDIO DE UMA COLUNA */

SELECT AVG(FEVEREIRO) AS MEDIA_FEV
FROM VENDEDORES;

/* VARIAS FUNCOES */

SELECT MAX(JANEIRO) AS MAX_JAN,
	   MIN(JANEIRO) AS MIN_JAN,
	   AVG(JANEIRO) AS AVG_JAN
FROM VENDEDORES;

/*TRUNCATE*/

SELECT MAX(JANEIRO) AS MAX_JAN,
	   MIN(JANEIRO) AS MIN_JAN,
	   TRUNCATE(AVG(JANEIRO),2) AS MEDIA_JAN
FROM VENDEDORES;


/* A30 - AGREGANDO COM SUM() */

SELECT SUM(JANEIRO) AS TOTAL_JAN
FROM VENDEDORES;

SELECT SUM(JANEIRO) AS TOTAL_JAN,
	   SUM(FEVEREIRO) AS TOTAL_FEV,
	   SUM(MARCO) AS TOTAL_MAR
	   FROM VENDEDORES;



/* VENDAS POR SEXO */

SELECT SEXO, SUM(MARCO) AS TOTAL_MARCO
FROM VENDEDORES
GROUP BY SEXO;

/* A 31 - SUBQUERIES

VENDEDOR QUE VENDEU MENOS EM MARCO E O SEU NOME

NOME E O VALOR QUE VENDEU MAIS EM MARCO

QUEM VENDEU MAIS QUE O VALOR MEDIO DE FEVEREIRO */


/* 1 */


SELECT NOME, MIN(MARCO) AS MIN_MARCO  
FROM VENDEDORES;

SELECT * FROM VENDEDORES;

SELECT MIN(MARCO) FROM VENDEDORES;

SELECT NOME, MARCO FROM VENDEDORES
WHERE MARCO = (SELECT MIN(MARCO) FROM VENDEDORES);


SELECT NOME, MARCO FROM VENDEDORES
WHERE MARCO = (SELECT MAX(MARCO) FROM VENDEDORES);

SELECT NOME, FEVEREIRO FROM VENDEDORES
WHERE FEVEREIRO > (SELECT AVG(FEVEREIRO) FROM VENDEDORES);

SELECT AVG(FEVEREIRO) FROM VENDEDORES;

SELECT NOME, FEVEREIRO FROM VENDEDORES
WHERE FEVEREIRO < (SELECT AVG(FEVEREIRO) FROM VENDEDORES);

/* A32 - OPERACORES EM LINHA */

SELECT * FROM VENDEDORES;

SELECT NOME,
	   JANEIRO,
	   FEVEREIRO,
	   MARCO,
	   (JANEIRO+FEVEREIRO+MARCO) AS "TOTAL",
	   TRUNCATE((JANEIRO+FEVEREIRO+MARCO)/3,2) AS "MEDIA"
	   FROM VENDEDORES;


/* APLICANDO A PORCENTAGEM */


SELECT NOME,
	   JANEIRO,
	   FEVEREIRO,
	   MARCO,
	   (JANEIRO+FEVEREIRO+MARCO) AS "TOTAL",
	   (JANEIRO+FEVEREIRO+MARCO)* .25 AS "PORCENTAGEM" 
	   TRUNCATE((JANEIRO+FEVEREIRO+MARCO)/3,2) AS "MEDIA"
FROM VENDEDORES;



/* A33 - ALTERANDO TABLES */

CREATE TABLE TABELA(
	COLUNA1 VARCHAR(30),
	COLUNA2 VARCHAR(30),
	COLUNA3 VARCHAR(30)
);

/* ADCIONANDO UMA PRIMARY KEY */

ALTER TABLE TABELA
ADD PRIMARY KEY(COLUNA1);

/* ADCIONANDO COLUNA SEM POSIÇÃO, ULTIMA POSICAO */

ALTER TABLE TABELA
ADD COLUNA VARCHAR(30);

/* ADCIONANDO UMA COLUNA COM POSICAO */

ALTER TABLE TABELA
ADD COLUMN COLUNA4 VARCHAR(30) NOT NULL UNIQUE
AFTER COLUNA3;

/* MODIFICANDO O TIPO DE UM CAMPO*/

ALTER TABLE TABELA MODIFY COLUNA2 DATE NOT NULL;

/* RENOMEANDO O NOME DA TABELA */

ALTER TABLE TABELA
RENAME PESSOA;

CREATE TABLE TIME(
	IDTIME INT PRIMARY KEY AUTO_INCREMENT,
	TIME VARCHAR(30),
	ID_PESSOA VARCHAR(30)
);

/* FOREIGN KEY */

ALTER TABLE TIME
ADD FOREIGN KEY(ID_PESSOA)
REFERENCES PESSOA (COLUNA1);

/* VERIFICANDO AS CHAVES */

SHOW CREATE TABLE TIME;

/* A34 - ORGANIZACAO DE CHAVES - CONSTRAINT (REGRA) */

CREATE TABLE JOGADOR(
	IDJOGADOR INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30)
);

CREATE TABLE TIMES(
	IDTIME INT PRIMARY KEY AUTO_INCREMENT,
	NOMETIME VARCHAR(30),
	ID_JOGADOR INT,
	FOREIGN KEY(ID_JOGADOR)
	REFERENCES JOGADOR(IDJOGADOR)
);

INSERT INTO JOGADOR VALUES(NULL,'GUERRERO');
INSERT INTO TIMES VALUES(NULL,'FLAMENGO',1);

SHOW CREATE TABLE JOGADOR;
SHOW CREATE TABLE TIMES;

/* A35 - ORGANIZANDO CHAVES
 AÇÔES DE CONSTRAINTS */

SHOW TABLES;

DROP TABLE ENDERECO;
DROP TABLE TELEFONE;
DROP TABLE CLIENTE;

CREATE TABLE CLIENTE(
	IDCLIENTE INT,
	NOME VARCHAR(30) NOT NULL
);

CREATE TABLE TELEFONE(
	IDTELEFONE INT,
	TIPO CHAR(3) NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE INT
);

ALTER TABLE CLIENTE ADD CONSTRAINT PK_CLIENTE
PRIMARY KEY(IDCLIENTE);

ALTER TABLE TELEFONE ADD CONSTRAINT FK_CLIENTE_TELEFONE
FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE);

SHOW CREATE TABLE TELEFONE;


/* DICIONARIO DE DADOS */

SHOW DATABASES;

USE INFORMATION_SCHEMA;

STATUS

SHOW TABLES;

DESC TABLE_CONSTRAINTS;

SELECT CONSTRAINT_SCHEMA AS "BANCO",
	   TABLE_NAME AS "TABELA",
	   CONSTRAINT_NAME AS "NOMES_REGRA",
	   CONSTRAINT_TYPE AS "TIPO"
	   FROM TABLE_CONSTRAINTS
	   WHERE CONSTRAINT_SCHEMA = 'COMERCIO';


/* APAGANDO CONSTRAINTS */

ALTER TABLE TELEFONE
DROP FOREIGN KEY  FK_CLIENTE_TELEFONE;


/* A39 ENTENDENDO TRIGGERS */

/* ESTRUTURA DE UMA TRIGGER */

/* TRIGGER - GATILHO */


CREATE TRIGGER NOME
BEFORE/AFTER INSERT/DELETE/UPDATE ON TABELA
FOR EACH ROW (PARA CADA LINHA)
BEGIN -> INICIO

		QUALQUER COMANDO SQL


END -> FIM


CREATE DATABASE AULA40;

USE AULA40;

CREATE TABLE USUARIO(
	IDUSUARIO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	LOGIN VARCHAR(30),
	SENHA VARCHAR(100)

);

CREATE TABLE BKP_USUARIO(
	IDBACKUP INT PRIMARY KEY AUTO_INCREMENT,
	IDUSUARIO INT,
	NOME VARCHAR(30),
	LOGIN VARCHAR(30)

);

/* CRIANDO A TRIGGER*/

DELIMITER $

CREATE TRIGGER BACKUP_USER
BEFORE DELETE ON USUARIO
FOR EACH ROW
BEGIN	

	INSERT INTO BKP_USUARIO VALUES
	(NULL,OLD.IDUSUARIO,OLD.NOME,OLD.LOGIN);
END 
$

DELIMITER ;

INSERT INTO USUARIO VALUES(NULL,'ANDRADE','ANDRADE2009','HEXACAMPEAO');

SELECT * FROM USUARIO;

DELETE FROM USUARIO WHERE IDUSUARIO = 1;

SELECT * FROM BKP_USUARIO;


















































































