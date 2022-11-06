



/*Esse curso foi baseado no curso de SQL- SERVER da B�SON TREINAMENTOS:

segue o link do curso completamente gratuito:
	https://www.youtube.com/watch?v=1YQIRdWkMvs&list=PLucm8g_ezqNqI5cW3alteV5olcMCcHYRK&index=1
*/















--Caso queira ver algum assunto em espec�fico use o comando: 'ctrl'+'F' para pesquisar pelo arquivo.

--N�o delecione os coment�rios caso queira textar o c�digo por partes, pois isso ir� gerar erro!





	-- para criar uma vari�vel � preciso apenas colocar o '@' na frente, como mostrado abaixo

	create rule rl_preco as @valor > 0.00
	 -- essa regra chamada 'rl_preco' impede que a vari�vel @valor seja menor de 0, ou seja, negativo
	 
	 -- as regras devem estar no inicio de arquivos de consulta!!!






CREATE DATABASE db_curso_sql  --NOME DO BANCO DE DADOS  
ON PRIMARY (
NAME= db_curso_sql,   --NOME DO ARQUIVO QUE CONT�M O BANCO DE DADOS 
FILENAME='C:\SQL\db_curso_sql.MDF',  --CAMINHO DO ARQUIVO 
SIZE=6MB,     --TAMANHO INICIAL DO ARQUIVO   

 --SEMPRE DE PREFERENCIA A ASPAS SIMPLES NO SQL SERVER 

MAXSIZE=50MB,  --AT� QUANTO O ARQUIVO PODE CRESCER 
FILEGROWTH=10%  --CASO O ESPA�O ACABE, QUANTO ELE VAI CRESCER, NESSE CASO, DE 10% EM 10% 
)


USE db_curso_sql  --esse comando instrui o sql a usar o banco de dados indicado 
	
	
	sp_helpdb db_curso_sql  --traz informa��es sobre o banco de dados











									/* O que � uma constraints(restri��es)?
											A constraints servem para restringir um tipo de dado para uma coluna informada.
										
										Principais constraints:
											NOT NULL:Impede que o campo seja nulo.

											UNIQUE: Faz com que a informa��o n�o possa quer repetida em todo o banco de dados
											toda primary key � unique, mas nem toda unique � primary key.

											PRIMARY KEY:Chave prim�ria.

											FOREIGN KEY:Chave estrangeira.
											exemplo de c�digo:CONSTRAINT fk_ID_Autor FOREIGN KEY(ID_AUTOR) REFERENCES tbl_autores(ID_Autor)

											CHECK: Faz um filtro para que uma tabela/coluna possa aceitar apenas um tipo de dados espec�fico 
											em um intervalo de valores espec�fico.

											DEFAULT: D� um valor padr�o a um campo, caso esse campo n�o venha a ser preenchido.
									*/

USE db_curso_sql


	CREATE TABLE tbl_livro	
	(ID_livros SMALLINT PRIMARY KEY IDENTITY(100,1),  -- O que est� escrito na linha �: no campo ID_livros 
													  -- determine o tipo de dado como SMALLINT,al�m de definilo como chave prima(Primary key)
													  -- e definir ele como alto incremento que v� de 1 a 100 (IDENTITY(100,1)).
	Nome_Livro VARCHAR(50) NOT NULL,
	ISBN VARCHAR(30) NOT NULL UNIQUE,
	ID_AUTOR SMALLINT NOT NULL,
	Data_Pub DATETIME NOT NULL,
	Preco_livro Money NULL)
		

	create table tbl_autores(
	ID_Autor SMALLINT PRIMARY KEY,
	Nome_Autor VARCHAR(50),
	sobrenome_autor VARCHAR(60)
	)


	
	CREATE TABLE tbl_editoras
	(ID_Editora SMALLINT PRIMARY KEY IDENTITY,
	Nome_editora VARCHAR(50) NOT NULL
	)
	
	sp_help tbl_autores  --Mostra informa��es da tabela



													/*
													Identity: 
													
													oque �? 
														resposta: auto incremento
													regras de uso:
														resposta:1�n�o pode ter mais de um por tabela.
																 2�n�o � possivel altera-lo.
													*/

ALTER TABLE tbl_livro
	DROP COLUMN ID_AUTOR  --EXCLUI A COLUNA ID_AUTOR

ALTER TABLE tbl_livro
	DROP CONSTRAINT	ID_Autor --EXCLUI UMA CONSTRAINT

ALTER TABLE tbl_livro
	ADD ID_Autor SMALLINT NOT NULL CONSTRAINT fk_ID_Autor FOREIGN KEY(ID_Autor) REFERENCES tbl_autores								   
	
																										/*adicione a tabela 'tbl_livros' o campo ID_Autor 
																									   como um tipo de dado SMALLINT, N�O NULO,COM UMA CONSTRAINT
																									   de nome de: fk_ID_Autor; onde na verdade � 
																									   a primary key da tabela tbl_autores, assim sendo uma foreign key
																									   nessa tabela, escreva isso no campo que acabou de criar que � ID_Autor.*/




ALTER TABLE tbl_Livro
	ADD ID_editora SMALLINT NOT NULL CONSTRAINT fk_ID_editora FOREIGN KEY(ID_editora) REFERENCES tbl_editoras





	create table clientes(
	ID_Clientes int identity,
	Nome VARCHAR(50),
	sobrenome VARCHAR(60)
	)


	ALTER TABLE Clientes
		ALTER COLUMN ID_Clientes SMALLINT not null --altera o tipo da tabela

ALTER TABLE Clientes
   ADD CONSTRAINT PK_ID_Clientes PRIMARY KEY (ID_Clientes); --transforma em chave primaria

	ALTER TABLE clientes
		DROP COlUMN nome --exclui coluna

	select * from clientes

	DROP TABLE clientes --exclui a tabela clientes



																		--inserir dados na tabela

INSERT INTO tbl_Autores (ID_Autor, Nome_Autor, SobreNome_Autor)
VALUES
(1, 'Daniel', 'Barret'),
(2, 'Gerald', 'Carter'),
(3, 'Mark', 'Sobell'),
(4, 'William', 'Stanek'),
(5, 'Richard', 'Blum');


INSERT INTO tbl_Editoras (Nome_Editora)
VALUES
('Prentice Hall'),
('O�Reilly'),
('Microsoft Press'),
('Wiley');


INSERT INTO tbl_Livro (Nome_Livro, ISBN, Data_Pub, Preco_Livro, ID_Autor, ID_editora) VALUES
('Linux Command Line and Shell Scripting','143856969','20091221', 68.35, 5, 4),
('SSH, the Secure Shell','127658789','20091221', 58.30, 1, 2),
('Using Samba','123856789','20001221', 61.45, 2, 2),
('Fedora and Red Hat Linux','123346789', '20101101', 62.24, 3, 1),
('Windows Server 2012 Inside Out','123356789','20040517', 66.80, 4, 3),
('Windows Server 2013 Inside Out','123356745','20040517', NULL, 4, 3),
('Windows Server 2014 Inside Out','123356782','20040517', NULL, 4, 3),
('Microsoft Exchange Server 2010','123366789','20001221', 45.30, 4, 3);




sp_help	tbl_Livro










SELECT COUNT(*) AS Tabela_antes from tbl_livro		--traga o numero de registros contidos na tabela tbl_livro com o nome Tabela_antes
GO													-- O comando 'go' faz com que o script j� escrito execute











TRUNCATE TABLE tbl_livro							-- Excluir todos os registros contidos na tabela tbl_livro
GO










SELECT COUNT(*) AS Tabela_depois from tbl_livro		----traga o numero de registros contidos na tabela tbl_livro com o nome Tabela_depois
GO














SELECT * FROM tbl_livro ORDER BY ID_livros ASC --traga tudo da tabela tbl_livro em ordem acendente
GO
SELECT * FROM tbl_livro ORDER BY ID_livros DESC --traga tudo da tabela tbl_livro em ordem Descente
GO












SELECT DISTINCT ID_Autor FROM tbl_livro -- selecione todos os valores da coluna ID_Autor da tabela tbl_livro, mas n�o traga elementos repetidos
GO
SELECT ID_Autor FROM tbl_livro
GO















SELECT ID_Autor FROM tbl_autores WHERE sobrenome_autor like 'Stanek' --selecione o campo ID_Autores da tabela tbl_autores onde sobrenome_autor � igual a: Stanek















SELECT * FROM tbl_livro where ID_livros > 2 OR ID_AUTOR <3 --selecione tudo da tabela tbl_livro onde o ID_livros for maior que 2 ou ID_AUTOR for menor que 3 
SELECT * FROM tbl_livro where ID_livros > 2 AND ID_AUTOR <3 --selecione tudo da tabela tbl_livro onde o ID_livros for maior que 2 e ID_AUTOR for menor que 3 











SELECT * FROM tbl_livro
GO
UPDATE tbl_livro SET Preco_livro = (Preco_livro*1.1) WHERE ID_livros is not null --atualize o campo Preco_livro da tabela tbl_livro com um aumento de 10% onde 
GO																			 --ID_livros n�o tem um valor nulo
SELECT * FROM tbl_livro
GO











SELECT TOP  10 PERCENT Nome_Livro from tbl_livro -- traga os 10 porcento de todos os elementos da tabela tbl_livros

SELECT TOP  2 Nome_Livro from tbl_livro -- traga os dois primeiros elementos da tabela tbl_livros













SELECT ID_Autor FROM tbl_autores UNION SELECT ID_Autor FROM tbl_livro --selecione todos os valores de ambos os select sem repeti��o
SELECT ID_Autor FROM tbl_autores UNION ALL SELECT ID_Autor FROM tbl_livro --selecione todos os valores de ambos os select com repeti��o
																				
																				/* Para o comando union funcionar direito deve-se:
																				as colunas serem do mesmo tipo e
																				ter o mesmo n�mero de colunas em ambos os lados*/











											
SELECT Nome_livro,ID_Autor INTO livroAutor FROM tbl_livro WHERE ID_livros > 2 --crie uma tabela de nome LivroAutor com os valores de Nome_livro e ID_Autor da 
																			  --tbl_livro onde ID_livros � maior que 2

																			  --O select into � usado para fazer backup de tabelas
SELECT * FROM livroAutor











SELECT COUNT(*) AS quantidade_de_linha FROM tbl_autores		--Conte todas as linhas da tabela autores
SELECT MAX(Preco_livro) AS MAIOR_VALOR FROM tbl_livro		--Qual � o maior valor da coluna Preco_livro na tabela tbl_livro
SELECT MIN(Preco_livro) AS MENOR_VALOR FROM tbl_livro		--Qual � o menor valor da coluna Preco_livro na tabela tbl_livro
SELECT AVG(Preco_livro) AS M�DIA_ARITM�TICA FROM tbl_livro	--Qual � a m�dia aritm�tica da coluna Preco_livro na tabela tbl_livro
SELECT SUM(Preco_livro) AS SOMA_TOTAL FROM tbl_livro		--Qual � a soma de todos os valores da coluna Preco_livro na tabela tbl_livro







SELECT * FROM tbl_livro WHERE Data_Pub BETWEEN '20040517' AND '20100217'
								--selecione todos os valores da tabela tbl_livros onde Data_Pub est� entre os valores 
								--(nesse caso datas): 20040517 e 20100217







								--INNER JOIN: RETORNA VALORES QUE TENHAM REFERENCIA NA OUTRA TABELA

								/*OUTER JOIN: RETORNA VALORES MESMO QUE N�O TENHAM REFERENCIA NA OUTRA TABELA,ELE SE DIVIDE EM:
								lEFT JOIN,RIGHT JOIN E FULL JOIN*/





--INNER JOIN

SELECT * FROM tbl_livro INNER JOIN tbl_autores ON tbl_livro.ID_AUTOR = tbl_autores.ID_Autor
--traga todos os valores das tabelas tbl_livro e tbl_Autores onde o campo ID_autor da tabela 
--tbl_autor for igual e n�o nulo ao campo ID_autores da tabela tbl_livros


SELECT tbl_livro.Nome_Livro, tbl_livro.ISBN, tbl_autores.Nome_Autor FROM tbl_livro INNER JOIN tbl_autores ON tbl_livro.ID_Autor = tbl_autores.ID_Autor;
--traga apenas os campos campos: tbl_livro.Nome_Livro, tbl_livro.ISBN, tbl_autores.Nome_Autor da 
--tabela da tabela: tbl_livro, onde tbl_livro.ID_Autor = tbl_autores.ID_Autor


	--usando aliases
-- eliases nada mais � que vo�� dar nome a um nome a tabela para encurtar o tamanho do comando como pode ser vista na linha abaixo.

SELECT L.Nome_Livro AS Livros, E.Nome_editora AS Editoras FROM tbl_livro AS L INNER JOIN tbl_editoras 
AS E ON L.ID_editora = E.ID_editora WHERE E.Nome_Editora LIKE 'M%';

--nesse caso chamei a tabela 'tbl_livro' de 'L' 
--e a tabela 'tbl_editoras' de 'E'






--LEFT JOIN:TRAZ TODOS OS VALORES DA TABELA CITADA PRIMEIRO.
	ALTER TABLE tbl_livro
		ALTER COLUMN ID_Autor SMALLINT  null --altera o tipo da tabela

		sp_help tbl_livro

		insert into tbl_livro(Nome_Livro,ISBN,Data_Pub,Preco_livro,ID_Autor,ID_editora) values
	('eu amo batata frita',123456789,'20090701',68.45,null,3 )
		insert into tbl_livro(Nome_Livro,ISBN,Data_Pub,Preco_livro,ID_Autor,ID_editora) values
	('eu amo arroz doce',193456789,'20090703',168.45,null,2 )
	/*isso que eu fiz de colocar a chave estrangeira como nula est� errado, mas � apenas para 
	exemplificar o left e riht join*/


	SELECT * FROM tbl_livro
	SELECT * FROM tbl_autores LEFT JOIN tbl_livro ON tbl_livro.ID_AUTOR = tbl_autores.ID_Autor
	-- traga todos as informa��es da primeira tabela citada e tudo o que tiver da segunda tabela onde 
	--tbl_livro.ID_AUTOR = tbl_autores.ID_Autor

--RIGHT JOIN: TRAZ TODOS OS VALORES DA  SEGUNDA TABELA CITADA. 
	SELECT * FROM tbl_livro
	SELECT * FROM tbl_autores
	SELECT * FROM tbl_autores RIGHT JOIN tbl_livro ON tbl_livro.ID_AUTOR = tbl_autores.ID_Autor
	-- traga todos as informa��es da segunda tabela citada e tudo o que tiver da primeira tabela onde 
	--tbl_livro.ID_AUTOR = tbl_autores.ID_Autor
	
	SELECT * FROM tbl_autores RIGHT JOIN tbl_livro ON tbl_livro.ID_AUTOR = tbl_autores.ID_Autor 
	WHERE tbl_autores.ID_Autor IS NULL --O 'NULL' TRABALHA COM O 'IS'

	-- traga todos as informa��es da segunda tabela citada e tudo o que tiver da primeira tabela 
	--onde tbl_livro.ID_AUTOR = tbl_autores.ID_Autor E ONDE tbl_autores.ID_Autor IS NULL




--FULL JOIN: TRAZ TODOS OS VALORES DE AMBAS AS TABELAS CITADAS.

	select li.Nome_Livro,li.ID_Autor,au.Nome_Autor from tbl_livro as li full join tbl_autores as au 
	on li.ID_Autor = au.ID_Autor where li.ID_Autor is null or au.ID_Autor is null
	 /*traga os registros li.Nome_Livro,li.ID_Autor,au.Nome_Autor das tabelas tbl_autores e tbl_livros 
	 mesmo que n�o tenha referencia dos dados em ambas as tabelas e traga apenas os valores que s�o nulos 
	 ou na tabela tbl_autores ou tbl_livros*/








/* o operador'in' pode substituir o operador 'or',segue exemplo:*/

select  * from tbl_livro where ID_Autor in (1,2)
/* selecione tudo da tabla tbl_livros onde id_autor � igual a 1 ou 2*/

select  * from tbl_livro where ID_Autor not in (1,2)
/* selecione tudo da tabla tbl_livros onde id_autor n�o � igual a 1 ou 2*/




--CAMPO CALCULADO
 
 create table produtos(
	 codProduto smallint, 
	 NomeProduto varchar(20),
	 Preco money,
	 Quant smallint, 
	 total as (Preco * Quant)
 )

 insert into produtos values
	 (1,'mouse',15.00,2),
	 (2,'Teclado ',18.00,1),
	 (3,'Fones',25.00,1),
	 (4,'Pendrive',25.00,3),
	 (5,'Sd card',29.00,2),
	 (6,'DVD-R',1.30,12);

	 select * from produtos




	 --Criando index
	 /*o index permite que as aplica��es de banco de dados encontrem os dados mais rapidamente, 
	 sem ter de ler a tabela toda.
	 
	 vale salientar que � recomendado criar index em tabelas muito consultadas, em registros mais 
	 comuns de consulta, uma vez que tabelas indexadas levam mais tempo para serem atualizadas.*/

	 select * from tbl_autores
		
	create index indice_nome_livro on tbl_livro(Nome_Livro)

	--CRIAR REGRAS

	/*As regras s�o configura��es que permitem especificar como 
	determinados par�metros do banco de dados devem se comportar,por exemplo:
	limitar faixas de valores em colunas, ou 
	especificar valores inv�lidos para registros.
	*/



	-- o sp_bindrule vincula uma regra a um registro de uma tabela
	execute sp_bindrule rl_preco, 'tbl_livro.Preco_livro'

	--a regra que usaremos est� localizada no inicio do arquivo

	-- caso tentemos inserir numeros menores que 0, n�o conseguiremos, pois a regra que criamos n�s impere
	insert into tbl_livro values ('batatinha',123654987,'20221203',-15.20,4,2)


	insert into tbl_livro values ('batatinha',123654987,'20221203',15.20,4,2)


-- Fazer um backup

backup database db_curso_sql to disk ='C:\SQL\backup.bak';

-- with format;
--o 'with format' formata o disco que ser� inserido o backup

--� importante esp�cificar o tipo do arquivo como bak













--concatena��o entre String's e colunas de tabelas

--� poss�vel concaterar Strings usando o operador '+'
--exemplo: string | coluna +String2 | coluna

select 'Nilton comprou os livros:' + 'de nossa livraria'
select * from tbl_autores
select Nome_Autor from tbl_autores




select 'nome do autor: ' + Nome_Autor + ' ' + sobrenome_autor from tbl_autores

select 'eu gosto do livro' + Nome_Livro as 'meu livro' from tbl_livro where ID_Autor like 2



--collation(cola��o/agrupamento)

/*
trata-se da codifica��o dos caracteres em uma ordem padr�o

Muitos sistemas de cola��o s�o baseados em ordem num�rica ou alfab�tica, 
a cola��o usada pelos bancos de dados � configurada durante a instala��o do sistema.

collation-charts.org - site com cartas de agrupamento em v�rios alfabetos e idiomas
*/	


--traz as op��es de cola��es contidas no sistema
	select * from fn_helpcollations()

-- O SERVERPROPERTY pode trazer um informa��o que est� sendo usada pelo sistema,
--nesse caso como especificamos com ' collation' ir� retornar qual � a cola��o usada pelo sistema
select SERVERPROPERTY('collation')	as cola��o_usada


--verificar o esquema de agrupamento(cola��o) de um banco de dados
select DATABASEPROPERTYEX('db_curso_sql','Collation') as cola��o
 
 --alterar o esquema de agrupamento(cola��o) de um banco de dados
 drop table produtos

 alter database db_curso_sql
	collate Greek_CI_AI

alter database db_curso_sql
	collate Latin1_General_CI_AS


 --alterar o esquema de agrupamento(cola��o) de um coluna espec�fica
select * from tbl_livro order by Nome_Livro collate Icelandic_CI_AI













--cl�usula With ties



create table tbl_times(
Nome_time varchar(20),
Pontos smallint,
)

insert into tbl_times values
('Atl�tico Goianiense', 3),
('Atl�tico Mineiro', 29),
('Atl�tico Paranaense', 30),
('Ava�', 15),
('Bahia', 40),
('Botafogo', 7),
('Chapecoense', 29),
('Corinthians', 9),
('Coritiba', 3),
('Cruzeiro', 2 );


  -- A cla�sula with ties � usada como o top e � usada para evitar que se perca um valor repetido
 
 --com with ties:
	select top 3 with TIES Nome_time,Pontos from tbl_times order by Pontos desc

 --sem with ties:
	select top 3 Nome_time,Pontos from tbl_times order by Pontos desc



TRUNCATE TABLE tbl_times
 





















 --VIEWS
 /*
 O que � uma exibi��o(Vis�o) � uma tabela virtual baseada no conjunto de resultados de uma consulta SQL.
 
 Cont�m linhas e colunas como declara��es JOIN, WHERE e fun��es como uma tabela normal.
 
 Mostra sempre resultados de dados atualizados, pois o motor do banco recria os dados toda vez que um
 usu�rio consulta a vis�o.
 */


 --criar view:
 CREATE VIEW vw_LivrosAutores as 
	select 
		 tbl_livro.Nome_Livro as Livro,
		 tbl_autores.Nome_Autor as Autor 
		 from tbl_livro
		 inner join tbl_autores on tbl_autores.ID_Autor = tbl_livro.ID_Autor


--selecionar view:
 select * from vw_LivrosAutores where livro like 'S%'



 --alterar view:
  alter view vw_LivrosAutores as 
	 select 
		 tbl_livro.Nome_Livro as Livro,
		 tbl_autores.Nome_Autor as Autor,
		 tbl_livro.Preco_livro as preco_livro
		 from tbl_livro
		 inner join tbl_autores on tbl_autores.ID_Autor = tbl_livro.ID_Autor

select * from vw_LivrosAutores

--excluir view
drop view vw_LivrosAutores















--Subconsultas e CTE

/*Uma subconsulta(subquery) � uma declara��o sql embutida em uma consulta externa.
A subconsulta fornece uma resposta � consulta externa na forma de um valor escalar, 
lista de valores, ou conjunto de dados, equivalentes a uma express�o, lista ou tabela
para a consulta externa. 

exemplo simples: select(select 'F�bio') as Subconsulta;
*/

select * from tbl_autores
select * from tbl_livro
select * from tbl_livro as livro full join tbl_autores as autor on autor.ID_Autor = livro.ID_Autor


--exemplo de subconsulta
select Preco_livro from tbl_livro where ID_Autor = (select ID_Autor from tbl_autores where 
sobrenome_autor = 'Stanek')
	--selecione o registro Preco_livro da tabela tbl_livro, onde o ID_Autor � igual a sele��o do 
	-- ID_Autor onde o registro sobrenome_autor � igual a Stanek


--outro exemplo de subconsulta(embora essa n�o v� funcionar por n�o existir as tabelas)
/*

select resultado.cliente,sum(resultado.total) as Total from 
(
select cl.nome_cliente as cliente,pr.produto*
co.quantidade as total
from clientes as cl
inner join compras as co
on cl.id_cliente = co.id_cliente
inner join produtos pr
on co.id_produto = pt.id_produto
) as resultado
group by Resultado.cliente 
orber by total


me recuso a escrever em linguagem natural esse c�digo leia-o voc� mesmo, n�o � d�ficil!
*/

--CTE (Common table Expression)

/* 
O que � CTE (Common table Expression) ?

varia��o sent�tica de uma subconsulta, similar a uma exibi��o(view).
pode ser acessada m�ltiplas vezes dentro da consulta principal, como se fossse uma exibi��o ou tabela.
*/

/*
exemplo de consulta usando CTE:

with consultaCTE (cliente,Total)
as (select cl.nome_cliente as cliente,
pr.preco_produto * co.quantidade as total
from clientes as cl
inner join compras as co
on cl.id_cliente = co.id_cliente
inner join produtos as pr
on co.id_produto = pr.id_produto 
)

select cliente,sum(total) as valor total
from consultaCTE
group by cliente
orber by valorTotal
*/

















--vari�veis
  /*
  as vari�veis podem ser declaradas no corpo de um batch ou procedimento.
  Pode-se atribuir-lhes valores usando-se declara��es set ou select. 
  As vari�veis s�o inicializadas por padr�o com null.
  */


  --declara vari�vel
DECLARE @valor int,  
		@texto varchar(40),
		@data_nasc date,
		@nada money


	--atribui valor a vari�vel
set @valor = 50
set @texto = 'Nilton'
set @data_nasc = GETDATE()

--l� a vari�vel
select  @valor as valor,
		@texto as nome,
		@data_nasc as data_de_nascimento, 
		@nada as salario 




--usando vari�vel com o select

declare @livro varchar(30)
select @livro = nome_livro from tbl_livro where ID_livros = 101
select @livro as Nome_do_Livro

-- a variavel pode armazenar apenas uma informa��o por vez!

declare @preco money,@quantidade int,@nome varchar(30) set @quantidade = 5
select @preco=Preco_livro,@nome = Nome_Livro from tbl_livro where ID_livros = 101
select @nome as 'nome do livro', @preco*@quantidade as 'pre�o total dos livros'
select @preco as 'pre�o unit�rio'



--Conver��o de dados 

--Cast
--um exemplo fala mais que mil palavras, exemplo:
select 'o pre�o do livro' + Nome_Livro + ' � de R$' + CAST(Preco_livro as varchar(6)) as Item from tbl_livro
where ID_autor = 2
















