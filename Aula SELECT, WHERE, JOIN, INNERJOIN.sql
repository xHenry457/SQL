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