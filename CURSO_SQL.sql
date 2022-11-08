



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

	 create rule nota_aluno as @valor >= 0.00 and @valor <=10.00





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



	CREATE TABLE Customer
	(SID integer CHECK (SID > 0),  --o check faz a com que o registro aceite valores apenas maiores que um determinado valor, nesse caso, '0'
	Last_Name varchar (30),
	First_Name varchar (30));







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

--Cast:
--um exemplo fala mais que mil palavras, exemplo:
select 'o pre�o do livro' + Nome_Livro + ' � de R$' + CAST(Preco_livro as varchar(6)) as Item from tbl_livro
where ID_autor = 2

--convert:
-- O operador 'convert' permite trabalhar com mais tipos de conver��o do que o operador 'cast'
--exemplo:
select 'o pre�o do livro ' + Nome_Livro + ' � de: R$' + CONVERT(varchar(6),Preco_livro) from tbl_livro


--edi��o de data com o convert:
--antes:
select 'A data de publica��o ' + CONVERT(varchar(18),Data_Pub) from tbl_livro where ID_livros = 102
--depois:
select'A data de publica��o ' + CONVERT(varchar(18),Data_Pub,103) from tbl_livro where ID_livros = 102




/* segue o link que cont�m informa��es do que pode ou n�o ser convertido e os estilos de edi��o de dado:
http://msdn.microsoft.com/pt-br/library/ms187928.aspx
*/

























-- if e else no sql server
--exemplo:
	declare @numero int,
	@texto varchar (10)

	set @numero = 20
	set @texto = 'Nilton'

if @numero = 20
	select 'n�mero correto!'

	if @texto = 'Nilton'
		begin --come�a o c�digo
			set @numero = 30
			select @numero
	end;  --finaliza o c�digo
else 
	begin 
		set @numero = 40
		select 'N�mero incorreto'
end;







--outro exemplo:

 DECLARE @NOMELIVRO VARCHAR (50),
           @VALOR REAL,
           @STATUS VARCHAR (6)

  SELECT @NOMELIVRO = NOME_LIVRO, @VALOR = (TBL_LIVRO.PRECO_LIVRO) FROM tbl_livro WHERE  ID_AUTOR = 4

  IF @VALOR >= 60.00

  BEGIN 

      SELECT @STATUS = ' CARO '
  END;

  ELSE 

 BEGIN 

      SELECT @STATUS = 'BARATO'
	 END;

	  SELECT 'O PRE�O DO LIVRO ' + @NOMELIVRO  +char(13)+char(10)+ ' � ' + @STATUS + CAST(@VALOR AS VARCHAR ) AS VALOR;

	  -- o c�digo: '+char(13)+char(10)+' quebra a linha de uma string em sql




--while no sql server





--exemplo(imprimir os numeros de 0 � 10):
declare @valor int
set @valor =  0
while @valor<= 10
	begin
		print'N�mero:'+cast(@valor as varchar(2))
		set @valor = @valor+1
	end;


--exemplo(imprimir livro e pre�o dos livros de IDs de 100 a 105):
declare @valor int
set @valor =  100
while @valor<= 105
	begin
		select ID_livros as ID,Nome_Livro as livro,Preco_livro as pre�o 
		from tbl_livro where ID_livros = @valor
		set @valor = @valor+1
	end;












-- Stored Proceures 

/*o que �:
	s�o lotes(batches) de declara��es SQL que podem ser executadas como um subrotina.
	Permitem centralizar a l�gica de acesso aos dados em um �nico local, facilitando 
	a manuten��o e otimiza��o de c�digos.
	Tamb�m � poss�vel ajustar permiss�es de acesso aos usu�rios, definindo quem pode 
	ou n�o execut�las.
*/














--exemplo1:

--criando o procedimento(procedure)
CREATE PROCEDURE teste 
as 
select 'B�son Treinamentos' as Nome

--executando a procedure
exec teste



--exemplo2:
create procedure p_LivroValor
as
select Nome_Livro,Preco_livro from tbl_livro


exec p_LivroValor















--traz informa��es da procedure
exec sp_helptext p_Livrovalor


--criar um procedure criptografado
create procedure p_LivroISBN
with encryption
as
select Nome_Livro,ISBN from tbl_livro

--n�o se pode ver a procedure com o sp_helptext, pois foi colocado o comando 'with encryption'.

exec sp_helptext p_LivroISBN















/*alterar um procedure,basicamente voc� vai re-escrever todo o c�digo da procedure, entretanto isso permite
que voc� possa manter as permi��es j� dadas a procedure*/

alter procedure teste(@parl as int)
as
select @parl as 'valor da variavel'

exec teste 22









alter procedure p_LivroValor(@ID smallint)
as
select Nome_Livro as Livro, Preco_Livro as Pre�o from tbl_livro where ID_livros = @ID

exec p_LivroValor 104



--o comando 'ctrl'+'K'+'C'  comenta um bloco de c�digo
--o comando 'ctrl'+'K'+'U' descomenta um bloco de c�digo










alter procedure teste(@par1 as int,@par2 as varchar(20))
as

select @par1 as 'valor da variavel 1'
select @par2 as 'valor da variavel 2'

--por posi��o:
exec teste 2, 'laranja'


--por chamada:
exec teste @par2 = 'laranja', @par1 = 2 







alter procedure p_LivroValor(@ID smallint,@Preco money)
as
select Nome_Livro as Livro, Preco_Livro as Pre�o from tbl_livro 
where ID_livros > @ID and Preco_livro > @Preco

exec p_LivroValor 103,60





alter procedure p_LivroValor(@ID smallint,@Quantidade smallint)
as
select Nome_Livro as Livro, Preco_Livro*@Quantidade as Pre�o from tbl_livro 
where ID_livros = @ID 


exec p_LivroValor 100,3













--inser��o de valores com procedures
create procedure p_insere_editora(@nome varchar(50))
as
insert into tbl_editoras(Nome_editora) values(@nome)

exec p_insere_editora 'livrosfantasticos'


select * from tbl_editoras














--cria��o de procedures com valores padr�o (ou pr� estabelecidos, se preferir) 
create procedure p_teste_valor_padr�o(@param1 int, @param2 varchar(20)='Valor Padr�o!')
as
select 'valor do par�metro 1:' + Cast(@param1 as varchar)
select 'valor do par�metro 2:'+@param2

exec p_teste_valor_padr�o 3

exec p_teste_valor_padr�o 3,'arroz doce'














--par�metro de sa�da no procedure
--cria��o
alter procedure teste(@parl as int output)
as
select @parl*2
return  
	--return termina a procedure incondicionalmente, � usado para retornar status de sucesso ou falha


--execu��o
declare @valor as int = 15
exec teste @valor output
print @valor













--cria��o:
alter procedure p_LivroValor(@Quantidade smallint, @ID smallint,@cod smallint = -10)
as
set nocount on --impede que conte as linhas
if @ID >=100
	begin
		select Nome_Livro as livros, Preco_livro*@Quantidade as pre�o from tbl_livro
		where ID_livros = @ID
		return 1 
	end
else
	return @cod


--execu��o:
declare @codigo int
exec @codigo = p_LivroValor @ID = 102, @Quantidade = 5
print @codigo




















--                                    Fun��es

--Fun��es escalares 
	/*
	o que fazem?
	Retornam um �nico valor espec�fico
	*/ 

	--prepara��o
	create table tbl_alunos(
	id_aluno smallint identity not null,
	nota1 smallint not null,
	nota2 smallint not null,
	nota3 smallint not null,
	nota4 smallint not null,
	nome_aluno varchar(30) not null
	constraint pk_id_aluno primary key (id_aluno)
	)

	execute sp_bindrule nota_aluno, 'tbl_alunos.nota1'
	execute sp_bindrule nota_aluno, 'tbl_alunos.nota2'
	execute sp_bindrule nota_aluno, 'tbl_alunos.nota3'
	execute sp_bindrule nota_aluno, 'tbl_alunos.nota4'






	insert into tbl_alunos(nota1,nota2,nota3,nota4,nome_aluno) values
	(10,4,3,7,'Maria Roaquina'),
	(9,7,2,7,'pedro Roaquina'),
	(1,10,1,7,'paulo Roaquina'),
	(7,1,3,3,'silvio Roaquina'),
	(5,2,3,7,'ana Roaquina'),
	(3,3,3,8,'paula Roaquina'),
	(8,4,3,9,'marcela Roaquina'),
	(2,5,3,6,'marcelo Roaquina'),
	(8,6,3,10,'andr� Roaquina'),
	(4,7,3,8,'maicon Roaquina');


	--cria��o
	create function nota_media(@nome varchar(30))
	returns real
	as
		begin
		declare @media real 
		select @media=(nota1+nota2+nota3+nota4*2)/5.00 from tbl_alunos where nome_aluno = @nome
		return @media
		end

		select dbo.nota_media('maicon Roaquina') as media_do_aluno






		--fun��o com valores de tabela  embutida(inline)
		/*
		o que faz? 
		S�o similares a uma exibi��o, por�m permitem 
		 utilizar par�metros. retornam um conjunto completo de dados
		*/



--cria��o
		create function retorna_itens (@valor real)  --ele retorna todos as tabelas do select, ou seja, 
		returns table								 --as tabelas: l.Nome_Livro,a.Nome_Autor,e.ID_Editora
		as
		return(
			select l.Nome_Livro,a.Nome_Autor,e.ID_Editora 
			from tbl_livro as l
			inner join tbl_autores as a
			on l.ID_Autor = a.ID_Autor
			inner join tbl_editoras as e
			on l.ID_editora like e.ID_Editora
			where l.Preco_livro>@valor)


--execu��o:

--n�o especificando campos:
select * from retorna_itens(60)

-- especificando campos:
select Nome_Livro,Nome_Autor from retorna_itens(60)





--Fun��es com valor de tabela com v�rias intru��es

/*
O que faz?

combina a habilidade da fun��o escalar de conter c�digos complexos com a habilidade da fun��o com
valor de tabela de retornar um resultset.
O valor de fun��o cria uma vari�vel do tipo table e a popula a partir do c�digo. Essa tabela � ent�o 
passada de volta � fun��o, de modo que possa ser usada em declara��es select.
*/

--segue exemplo:


--voc� define quais s�o as tabelas que a fun��o ir� trazer


--cria��o:

create function multi_tabela ()
	returns @valores table
		(Nome_livro varchar(50),
		Data_Pub datetime,                    
		Nome_Editora varchar(50),
		Preco_Livro money)
	AS
	begin
	insert @valores (Nome_livro,Data_Pub,Nome_Editora,Preco_livro)
		select l.Nome_Livro,l.Data_Pub,e.Nome_Editora,l.Preco_livro
		from tbl_livro as l
		inner join tbl_editoras as e 
		on l.ID_editora like e.ID_Editora
		return
	end
	


--execu��o

select * from multi_tabela()

--criou uma nova tabela temporaria que cont�m os campos setados, nesse caso os campos:      (Nome_livro varchar(50),
																							--Data_Pub datetime,                    
																							--Nome_Editora varchar(50),
																							--Preco_Livro money)




























                         --Triggers

/*
O que �?


Um Trigger(Gatilho) � um tipo especial de Stored Procedure qe � executada automaticamente quando
um usu�rio realiza uma opera��o de modifica��o de dados em uma tabela especificada.

As opera��es que podem disparar um trigger s�o:
-INSERT
-UPDATE
-DELETE



Triggers DML:


Os triggers n�o s�o executados diretamente disparam apenas em resposta a enentos como insert, 
update ou delete em uma tabela.

**No SQL Server, os triggers disparam uma vez para cada opera��o de modifica��o -e n�o uma vez por linha 
afetada (no Oracle h� as duas op��es).**



Modo de disparo de um trigger:

Um trigger no SQL Server pode ser disparado de dois modos diferentes:

after - O c�digo presente no trigger e executado ap�s todas as a��es terem sido completadas na tabela 
especificada

instead of- O c�digo presente no trigger � executado no lugar da opera��o que causou seu disparo.

A imagem img_trigger1.png compara os dois tipos de triggers (ela est� na mesma pasta que essa consulta)



Fluxo de transa��es:

Para desenvolver Triggers, � necess�rio conhecimento do fluxo geral da transa��o, para evitar conflitos 
entre os triggers e contraints.

As transa��es se movem atrav�s de verifica��es e c�digos na ordem mostrada abaixo:

1.Verifica��o de IDentity Insert
2.Restri��o (Constraint)  de Nulos(NULL)
3.Checagem de tipos de dados
4.Execu��o de trigger INSTEAD OF(a execu��o do DML p�ra aqui; esse trigger n�o � recursivo)
5.Restri��o de Chave Prim�ria
6.Restri��o de "Check"
7.Restri��o de chave Estrangeira
8.Execu��o do DML e atualiza��o do log de tramsa��es
9.Execu��o do trigger after 
10.Commit da Transa��o (Confirma��o)

*/








/*
sintaxe do trigger:

Create Trigger nome_trigger
on tabela | view
[with encryption]
	after|instead of
		[insert,update,delete]
as
c�digo do trigger
*/



								--trigger after

--cria��o:

create trigger teste_trigger_after 
on tbl_editoras
after insert
as
print 'Ol� mundo!';


--teste do trigger:
insert into tbl_editoras values ('editoras23')

select * from tbl_editoras



--cria��o:
create trigger trigger_after 
on tbl_editoras
after insert
as
insert into tbl_autores values(25,'Jos�','da Silva');
insert into tbl_livro values('livro1','123456000','20001010',77,25,2);



--teste:
insert into tbl_editoras values ('editoras24')


select* from tbl_autores
select* from tbl_livro
select* from tbl_editoras







							--trigger instead of

--cria��o:
create trigger teste_trigger_insteadof
on tbl_autores
instead of insert
as
print'Ol� de novo! n�o inseri o 
registro desta vez!'

--quando coloca na linha de baixo automaricamente quebra a linha.


--teste
insert into tbl_autores values(26,'jo�o','moura')

select * from tbl_autores


--exclui trigger

drop trigger teste_trigger_after 













--Habilitar e dasabilitar triggers

--alterar triggers

/*

sintaxe:

alter table nome_tabela
enable | Disable trigger nome trigger


obs: vale salientar que esse comando s� desabilita o trigger, mas n�o o exclui!
*/

--cria��o:
alter table tbl_editoras
 Disable trigger trigger_after

 
--pesquisa de triggers

	--pesquisar as informa��es sobre um trigger em uma tabela:
 
		 --sintaxe: exec sp_helptrigger @tabname = nome da tabela
		 exec sp_helptrigger @tabname = tbl_editoras


	--pesquisar as informa��es sobre um trigger no banco de dados todo:

		--traz todos que est�o ativados no banco de dados todo
		use db_curso_sql
			select * from sys.triggers where is_disabled=0

		--traz todos que est�o desativados no banco de dados todo
		use db_curso_sql
			select * from sys.triggers where is_disabled=1




--triggers determinando as colunas atualizadas
	--A fun��o Update() retorna True se uma coluna especfica dor afetada por uma transa��o DML 
		/*Podemos criar um gatinho que executa um c�digo caso a colina especificada seja alterada
		por um comando DML usando essa fun��o*/


		--cria��o de tabela
	create trigger trigger_after_autores 
	on tbl_autores
	after insert,update
	as
	if update(nome_autor)
		begin
		print'O nome do autor foi alterado'
		end
	else
		begin
			print'nome n�o foi modificado'
		end
		--teste
		update tbl_autores set nome_autor = 'jo�o' where id_autor = 10




































--alinhamento de triggers DML
	/*
	o que �? 
		Resposta:� quando um trigger ao ser ativado leva ao ativamento de outros triggers.
	
	Para isso, a op��o de servidor "Permitir que Gatilhos disparem outros gatilhos", em Propriedades do
	Servidor -> Avan�ado deve estar configurada como True (� o padr�o)

	Para desabilitar/habilitar a op��o de aninhamento de triggers, use o comando:
	
	exec sp_configure 'Nested Triggers', 0|1;
	reconfigure;


	imagem referencial no arquivo raiz com o nome de: img_trigger2
	*/

	
	exec sp_configure 'Nested Triggers', 1; 
	reconfigure;







	--Triggers Recursivos

	/*
	Um gatilho recursivo � um tipo especial de trigger after aninhado.
	O trigger recurivo ocorre quando um trigger executa uma declara��o DML que o dispara novamente.
	Podemos habilitar ou desabilitar os triggers recursivos com o comando alter database:

	alter database nome_banco_dados set recursive_triggers on|off
	*/

	alter database db_curso_sql set recursive_triggers on


	create table tbl_trigger_recursivo(
	codigo int primary key)


	create trigger trigger_rec on tbl_trigger_recursivo
	after insert
	as
	declare @cod int
	select @cod=max(codigo) from tbl_trigger_recursivo
	if @cod<10
		begin
			insert into tbl_trigger_recursivo select max(codigo)+1 from tbl_trigger_recursivo
		end
	else
		begin
		print'Trigger REcursivo Finalizado'
		end


		select * from tbl_trigger_recursivo

		insert into tbl_trigger_recursivo values (1);

		select * from tbl_trigger_recursivo



	
















	--renomear tabelas e colunas

	--mostra todas as tabelas no banco de dados selecionado:
	use db_curso_sql
	select * from sys.tables;



	--comando para renomear coluna:
	--sp_rename 'nometabela.nomeatualcoluna','NovoNomeColuna', 'column';

	sp_rename 'tbl_livro.Nome_livro','Livro', 'column';

	select * from tbl_livro

	sp_rename 'tbl_livro.Livro','Nome_livro', 'column';

	select * from tbl_livro


	--comando para renomear tabela:
	--sp_rename 'nometabelaAntiga','NovoNometabela';

	sp_rename 'tbl_livro','Livros';

	select * from livros

	select * from tbl_livro

	sp_rename 'Livros','tbl_livro';

	select * from livros

	select * from tbl_livro






















	--trabalhando com time

	--sintaxe:nome_coluna time[(fra��es de segundo)]


	create table tbl_visitas(
	id_visita int primary key identity,
	nome_visitante varchar(50) not null,
	cpf varchar(11) not null,
	cj_visitado smallint not null,
	data_visita date not null,
	hora_entr time(0) not null,
	hora_sai time(0) not null
	)

	insert into tbl_visitas(nome_visitante,cpf,cj_visitado,data_visita,hora_entr,hora_sai) 
	values ('nilton_Final_arquivo',45678936985,12,getdate(),'14:05:00','18:15:00')

	select * from tbl_visitas


	--calcula a diferen�a de tempo entre duas datas

	select datediff(minute,hora_entr,hora_sai) as 'permanencia(em minutos)' from tbl_visitas

















