



/*Esse curso foi baseado no curso de SQL- SERVER da BÓSON TREINAMENTOS:

segue o link do curso completamente gratuito:
	https://www.youtube.com/watch?v=1YQIRdWkMvs&list=PLucm8g_ezqNqI5cW3alteV5olcMCcHYRK&index=1
*/















--Caso queira ver algum assunto em específico use o comando: 'ctrl'+'F' para pesquisar pelo arquivo.

--Não delecione os comentários caso queira textar o código por partes, pois isso irá gerar erro!





	-- para criar uma variável é preciso apenas colocar o '@' na frente, como mostrado abaixo

	create rule rl_preco as @valor > 0.00
	 -- essa regra chamada 'rl_preco' impede que a variável @valor seja menor de 0, ou seja, negativo
	 
	 -- as regras devem estar no inicio de arquivos de consulta!!!

	 create rule nota_aluno as @valor >= 0.00 and @valor <=10.00





CREATE DATABASE db_curso_sql  --NOME DO BANCO DE DADOS  
ON PRIMARY (
NAME= db_curso_sql,   --NOME DO ARQUIVO QUE CONTÉM O BANCO DE DADOS 
FILENAME='C:\SQL\db_curso_sql.MDF',  --CAMINHO DO ARQUIVO 
SIZE=6MB,     --TAMANHO INICIAL DO ARQUIVO   

 --SEMPRE DE PREFERENCIA A ASPAS SIMPLES NO SQL SERVER 

MAXSIZE=50MB,  --ATÉ QUANTO O ARQUIVO PODE CRESCER 
FILEGROWTH=10%  --CASO O ESPAÇO ACABE, QUANTO ELE VAI CRESCER, NESSE CASO, DE 10% EM 10% 
)


USE db_curso_sql  --esse comando instrui o sql a usar o banco de dados indicado 
	
	
	sp_helpdb db_curso_sql  --traz informações sobre o banco de dados











									/* O que é uma constraints(restrições)?
											A constraints servem para restringir um tipo de dado para uma coluna informada.
										
										Principais constraints:
											NOT NULL:Impede que o campo seja nulo.

											UNIQUE: Faz com que a informação não possa quer repetida em todo o banco de dados
											toda primary key é unique, mas nem toda unique é primary key.

											PRIMARY KEY:Chave primária.

											FOREIGN KEY:Chave estrangeira.
											exemplo de código:CONSTRAINT fk_ID_Autor FOREIGN KEY(ID_AUTOR) REFERENCES tbl_autores(ID_Autor)

											CHECK: Faz um filtro para que uma tabela/coluna possa aceitar apenas um tipo de dados específico 
											em um intervalo de valores específico.

											DEFAULT: Dá um valor padrão a um campo, caso esse campo não venha a ser preenchido.
									*/

USE db_curso_sql


	CREATE TABLE tbl_livro	
	(ID_livros SMALLINT PRIMARY KEY IDENTITY(100,1),  -- O que está escrito na linha é: no campo ID_livros 
													  -- determine o tipo de dado como SMALLINT,além de definilo como chave prima(Primary key)
													  -- e definir ele como alto incremento que vá de 1 a 100 (IDENTITY(100,1)).
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
	
	sp_help tbl_autores  --Mostra informações da tabela



	CREATE TABLE Customer
	(SID integer CHECK (SID > 0),  --o check faz a com que o registro aceite valores apenas maiores que um determinado valor, nesse caso, '0'
	Last_Name varchar (30),
	First_Name varchar (30));







													/*
													Identity: 
													
													oque é? 
														resposta: auto incremento
													regras de uso:
														resposta:1ºnão pode ter mais de um por tabela.
																 2ºnão é possivel altera-lo.
													*/

ALTER TABLE tbl_livro
	DROP COLUMN ID_AUTOR  --EXCLUI A COLUNA ID_AUTOR

ALTER TABLE tbl_livro
	DROP CONSTRAINT	ID_Autor --EXCLUI UMA CONSTRAINT

ALTER TABLE tbl_livro
	ADD ID_Autor SMALLINT NOT NULL CONSTRAINT fk_ID_Autor FOREIGN KEY(ID_Autor) REFERENCES tbl_autores								   
	
																										/*adicione a tabela 'tbl_livros' o campo ID_Autor 
																									   como um tipo de dado SMALLINT, NÃO NULO,COM UMA CONSTRAINT
																									   de nome de: fk_ID_Autor; onde na verdade é 
																									   a primary key da tabela tbl_autores, assim sendo uma foreign key
																									   nessa tabela, escreva isso no campo que acabou de criar que é ID_Autor.*/




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
('O´Reilly'),
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
GO													-- O comando 'go' faz com que o script já escrito execute











TRUNCATE TABLE tbl_livro							-- Excluir todos os registros contidos na tabela tbl_livro
GO










SELECT COUNT(*) AS Tabela_depois from tbl_livro		----traga o numero de registros contidos na tabela tbl_livro com o nome Tabela_depois
GO














SELECT * FROM tbl_livro ORDER BY ID_livros ASC --traga tudo da tabela tbl_livro em ordem acendente
GO
SELECT * FROM tbl_livro ORDER BY ID_livros DESC --traga tudo da tabela tbl_livro em ordem Descente
GO












SELECT DISTINCT ID_Autor FROM tbl_livro -- selecione todos os valores da coluna ID_Autor da tabela tbl_livro, mas não traga elementos repetidos
GO
SELECT ID_Autor FROM tbl_livro
GO















SELECT ID_Autor FROM tbl_autores WHERE sobrenome_autor like 'Stanek' --selecione o campo ID_Autores da tabela tbl_autores onde sobrenome_autor é igual a: Stanek















SELECT * FROM tbl_livro where ID_livros > 2 OR ID_AUTOR <3 --selecione tudo da tabela tbl_livro onde o ID_livros for maior que 2 ou ID_AUTOR for menor que 3 
SELECT * FROM tbl_livro where ID_livros > 2 AND ID_AUTOR <3 --selecione tudo da tabela tbl_livro onde o ID_livros for maior que 2 e ID_AUTOR for menor que 3 











SELECT * FROM tbl_livro
GO
UPDATE tbl_livro SET Preco_livro = (Preco_livro*1.1) WHERE ID_livros is not null --atualize o campo Preco_livro da tabela tbl_livro com um aumento de 10% onde 
GO																			 --ID_livros não tem um valor nulo
SELECT * FROM tbl_livro
GO











SELECT TOP  10 PERCENT Nome_Livro from tbl_livro -- traga os 10 porcento de todos os elementos da tabela tbl_livros

SELECT TOP  2 Nome_Livro from tbl_livro -- traga os dois primeiros elementos da tabela tbl_livros













SELECT ID_Autor FROM tbl_autores UNION SELECT ID_Autor FROM tbl_livro --selecione todos os valores de ambos os select sem repetição
SELECT ID_Autor FROM tbl_autores UNION ALL SELECT ID_Autor FROM tbl_livro --selecione todos os valores de ambos os select com repetição
																				
																				/* Para o comando union funcionar direito deve-se:
																				as colunas serem do mesmo tipo e
																				ter o mesmo número de colunas em ambos os lados*/











											
SELECT Nome_livro,ID_Autor INTO livroAutor FROM tbl_livro WHERE ID_livros > 2 --crie uma tabela de nome LivroAutor com os valores de Nome_livro e ID_Autor da 
																			  --tbl_livro onde ID_livros é maior que 2

																			  --O select into é usado para fazer backup de tabelas
SELECT * FROM livroAutor











SELECT COUNT(*) AS quantidade_de_linha FROM tbl_autores		--Conte todas as linhas da tabela autores
SELECT MAX(Preco_livro) AS MAIOR_VALOR FROM tbl_livro		--Qual é o maior valor da coluna Preco_livro na tabela tbl_livro
SELECT MIN(Preco_livro) AS MENOR_VALOR FROM tbl_livro		--Qual é o menor valor da coluna Preco_livro na tabela tbl_livro
SELECT AVG(Preco_livro) AS MÉDIA_ARITMÉTICA FROM tbl_livro	--Qual é a média aritmética da coluna Preco_livro na tabela tbl_livro
SELECT SUM(Preco_livro) AS SOMA_TOTAL FROM tbl_livro		--Qual é a soma de todos os valores da coluna Preco_livro na tabela tbl_livro







SELECT * FROM tbl_livro WHERE Data_Pub BETWEEN '20040517' AND '20100217'
								--selecione todos os valores da tabela tbl_livros onde Data_Pub está entre os valores 
								--(nesse caso datas): 20040517 e 20100217







								--INNER JOIN: RETORNA VALORES QUE TENHAM REFERENCIA NA OUTRA TABELA

								/*OUTER JOIN: RETORNA VALORES MESMO QUE NÃO TENHAM REFERENCIA NA OUTRA TABELA,ELE SE DIVIDE EM:
								lEFT JOIN,RIGHT JOIN E FULL JOIN*/





--INNER JOIN

SELECT * FROM tbl_livro INNER JOIN tbl_autores ON tbl_livro.ID_AUTOR = tbl_autores.ID_Autor
--traga todos os valores das tabelas tbl_livro e tbl_Autores onde o campo ID_autor da tabela 
--tbl_autor for igual e não nulo ao campo ID_autores da tabela tbl_livros


SELECT tbl_livro.Nome_Livro, tbl_livro.ISBN, tbl_autores.Nome_Autor FROM tbl_livro INNER JOIN tbl_autores ON tbl_livro.ID_Autor = tbl_autores.ID_Autor;
--traga apenas os campos campos: tbl_livro.Nome_Livro, tbl_livro.ISBN, tbl_autores.Nome_Autor da 
--tabela da tabela: tbl_livro, onde tbl_livro.ID_Autor = tbl_autores.ID_Autor


	--usando aliases
-- eliases nada mais é que voçê dar nome a um nome a tabela para encurtar o tamanho do comando como pode ser vista na linha abaixo.

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
	/*isso que eu fiz de colocar a chave estrangeira como nula está errado, mas é apenas para 
	exemplificar o left e riht join*/


	SELECT * FROM tbl_livro
	SELECT * FROM tbl_autores LEFT JOIN tbl_livro ON tbl_livro.ID_AUTOR = tbl_autores.ID_Autor
	-- traga todos as informações da primeira tabela citada e tudo o que tiver da segunda tabela onde 
	--tbl_livro.ID_AUTOR = tbl_autores.ID_Autor

--RIGHT JOIN: TRAZ TODOS OS VALORES DA  SEGUNDA TABELA CITADA. 
	SELECT * FROM tbl_livro
	SELECT * FROM tbl_autores
	SELECT * FROM tbl_autores RIGHT JOIN tbl_livro ON tbl_livro.ID_AUTOR = tbl_autores.ID_Autor
	-- traga todos as informações da segunda tabela citada e tudo o que tiver da primeira tabela onde 
	--tbl_livro.ID_AUTOR = tbl_autores.ID_Autor
	
	SELECT * FROM tbl_autores RIGHT JOIN tbl_livro ON tbl_livro.ID_AUTOR = tbl_autores.ID_Autor 
	WHERE tbl_autores.ID_Autor IS NULL --O 'NULL' TRABALHA COM O 'IS'

	-- traga todos as informações da segunda tabela citada e tudo o que tiver da primeira tabela 
	--onde tbl_livro.ID_AUTOR = tbl_autores.ID_Autor E ONDE tbl_autores.ID_Autor IS NULL




--FULL JOIN: TRAZ TODOS OS VALORES DE AMBAS AS TABELAS CITADAS.

	select li.Nome_Livro,li.ID_Autor,au.Nome_Autor from tbl_livro as li full join tbl_autores as au 
	on li.ID_Autor = au.ID_Autor where li.ID_Autor is null or au.ID_Autor is null
	 /*traga os registros li.Nome_Livro,li.ID_Autor,au.Nome_Autor das tabelas tbl_autores e tbl_livros 
	 mesmo que não tenha referencia dos dados em ambas as tabelas e traga apenas os valores que são nulos 
	 ou na tabela tbl_autores ou tbl_livros*/








/* o operador'in' pode substituir o operador 'or',segue exemplo:*/

select  * from tbl_livro where ID_Autor in (1,2)
/* selecione tudo da tabla tbl_livros onde id_autor é igual a 1 ou 2*/

select  * from tbl_livro where ID_Autor not in (1,2)
/* selecione tudo da tabla tbl_livros onde id_autor não é igual a 1 ou 2*/




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
	 /*o index permite que as aplicações de banco de dados encontrem os dados mais rapidamente, 
	 sem ter de ler a tabela toda.
	 
	 vale salientar que é recomendado criar index em tabelas muito consultadas, em registros mais 
	 comuns de consulta, uma vez que tabelas indexadas levam mais tempo para serem atualizadas.*/

	 select * from tbl_autores
		
	create index indice_nome_livro on tbl_livro(Nome_Livro)

	--CRIAR REGRAS

	/*As regras são configurações que permitem especificar como 
	determinados parâmetros do banco de dados devem se comportar,por exemplo:
	limitar faixas de valores em colunas, ou 
	especificar valores inválidos para registros.
	*/



	-- o sp_bindrule vincula uma regra a um registro de uma tabela
	execute sp_bindrule rl_preco, 'tbl_livro.Preco_livro'

	--a regra que usaremos está localizada no inicio do arquivo

	-- caso tentemos inserir numeros menores que 0, não conseguiremos, pois a regra que criamos nós impere
	insert into tbl_livro values ('batatinha',123654987,'20221203',-15.20,4,2)


	insert into tbl_livro values ('batatinha',123654987,'20221203',15.20,4,2)



















-- Fazer um backup

backup database db_curso_sql to disk ='C:\SQL\backup.bak';

-- with format;
--o 'with format' formata o disco que será inserido o backup

--é importante espécificar o tipo do arquivo como bak
























--concatenação entre String's e colunas de tabelas

--é possível concaterar Strings usando o operador '+'
--exemplo: string | coluna +String2 | coluna

select 'Nilton comprou os livros:' + 'de nossa livraria'
select * from tbl_autores
select Nome_Autor from tbl_autores




select 'nome do autor: ' + Nome_Autor + ' ' + sobrenome_autor from tbl_autores

select 'eu gosto do livro' + Nome_Livro as 'meu livro' from tbl_livro where ID_Autor like 2

























--collation(colação/agrupamento)

/*
trata-se da codificação dos caracteres em uma ordem padrão

Muitos sistemas de colação são baseados em ordem numérica ou alfabética, 
a colação usada pelos bancos de dados é configurada durante a instalação do sistema.

collation-charts.org - site com cartas de agrupamento em vários alfabetos e idiomas
*/	


--traz as opções de colações contidas no sistema
	select * from fn_helpcollations()

-- O SERVERPROPERTY pode trazer um informação que está sendo usada pelo sistema,
--nesse caso como especificamos com ' collation' irá retornar qual é a colação usada pelo sistema
select SERVERPROPERTY('collation')	as colação_usada


--verificar o esquema de agrupamento(colação) de um banco de dados
select DATABASEPROPERTYEX('db_curso_sql','Collation') as colação
 
 --alterar o esquema de agrupamento(colação) de um banco de dados
 drop table produtos

 alter database db_curso_sql
	collate Greek_CI_AI

alter database db_curso_sql
	collate Latin1_General_CI_AS


 --alterar o esquema de agrupamento(colação) de um coluna específica
select * from tbl_livro order by Nome_Livro collate Icelandic_CI_AI













--cláusula With ties



create table tbl_times(
Nome_time varchar(20),
Pontos smallint,
)

insert into tbl_times values
('Atlético Goianiense', 3),
('Atlético Mineiro', 29),
('Atlético Paranaense', 30),
('Avaí', 15),
('Bahia', 40),
('Botafogo', 7),
('Chapecoense', 29),
('Corinthians', 9),
('Coritiba', 3),
('Cruzeiro', 2 );


  -- A claúsula with ties é usada como o top e é usada para evitar que se perca um valor repetido
 
 --com with ties:
	select top 3 with TIES Nome_time,Pontos from tbl_times order by Pontos desc

 --sem with ties:
	select top 3 Nome_time,Pontos from tbl_times order by Pontos desc



TRUNCATE TABLE tbl_times
 





















 --VIEWS
 /*
 O que é uma exibição(Visão) é uma tabela virtual baseada no conjunto de resultados de uma consulta SQL.
 
 Contém linhas e colunas como declarações JOIN, WHERE e funções como uma tabela normal.
 
 Mostra sempre resultados de dados atualizados, pois o motor do banco recria os dados toda vez que um
 usuário consulta a visão.
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

/*Uma subconsulta(subquery) é uma declaração sql embutida em uma consulta externa.
A subconsulta fornece uma resposta à consulta externa na forma de um valor escalar, 
lista de valores, ou conjunto de dados, equivalentes a uma expressão, lista ou tabela
para a consulta externa. 

exemplo simples: select(select 'Fábio') as Subconsulta;
*/

select * from tbl_autores
select * from tbl_livro
select * from tbl_livro as livro full join tbl_autores as autor on autor.ID_Autor = livro.ID_Autor


--exemplo de subconsulta
select Preco_livro from tbl_livro where ID_Autor = (select ID_Autor from tbl_autores where 
sobrenome_autor = 'Stanek')
	--selecione o registro Preco_livro da tabela tbl_livro, onde o ID_Autor é igual a seleção do 
	-- ID_Autor onde o registro sobrenome_autor é igual a Stanek


--outro exemplo de subconsulta(embora essa não vá funcionar por não existir as tabelas)
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


me recuso a escrever em linguagem natural esse código leia-o você mesmo, não é díficil!
*/

--CTE (Common table Expression)

/* 
O que é CTE (Common table Expression) ?

variação sentática de uma subconsulta, similar a uma exibição(view).
pode ser acessada múltiplas vezes dentro da consulta principal, como se fossse uma exibição ou tabela.
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

















--variáveis
  /*
  as variáveis podem ser declaradas no corpo de um batch ou procedimento.
  Pode-se atribuir-lhes valores usando-se declarações set ou select. 
  As variáveis são inicializadas por padrão com null.
  */


  --declara variável
DECLARE @valor int,  
		@texto varchar(40),
		@data_nasc date,
		@nada money


	--atribui valor a variável
set @valor = 50
set @texto = 'Nilton'
set @data_nasc = GETDATE()

--lê a variável
select  @valor as valor,
		@texto as nome,
		@data_nasc as data_de_nascimento, 
		@nada as salario 




--usando variável com o select

declare @livro varchar(30)
select @livro = nome_livro from tbl_livro where ID_livros = 101
select @livro as Nome_do_Livro

-- a variavel pode armazenar apenas uma informação por vez!

declare @preco money,@quantidade int,@nome varchar(30) set @quantidade = 5
select @preco=Preco_livro,@nome = Nome_Livro from tbl_livro where ID_livros = 101
select @nome as 'nome do livro', @preco*@quantidade as 'preço total dos livros'
select @preco as 'preço unitário'























--Converção de dados 

--Cast:
--um exemplo fala mais que mil palavras, exemplo:
select 'o preço do livro' + Nome_Livro + ' é de R$' + CAST(Preco_livro as varchar(6)) as Item from tbl_livro
where ID_autor = 2

--convert:
-- O operador 'convert' permite trabalhar com mais tipos de converção do que o operador 'cast'
--exemplo:
select 'o preço do livro ' + Nome_Livro + ' é de: R$' + CONVERT(varchar(6),Preco_livro) from tbl_livro


--edição de data com o convert:
--antes:
select 'A data de publicação ' + CONVERT(varchar(18),Data_Pub) from tbl_livro where ID_livros = 102
--depois:
select'A data de publicação ' + CONVERT(varchar(18),Data_Pub,103) from tbl_livro where ID_livros = 102




/* segue o link que contém informações do que pode ou não ser convertido e os estilos de edição de dado:
http://msdn.microsoft.com/pt-br/library/ms187928.aspx
*/

























-- if e else no sql server
--exemplo:
	declare @numero int,
	@texto varchar (10)

	set @numero = 20
	set @texto = 'Nilton'

if @numero = 20
	select 'número correto!'

	if @texto = 'Nilton'
		begin --começa o código
			set @numero = 30
			select @numero
	end;  --finaliza o código
else 
	begin 
		set @numero = 40
		select 'Número incorreto'
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

	  SELECT 'O PREÇO DO LIVRO ' + @NOMELIVRO  +char(13)+char(10)+ ' É ' + @STATUS + CAST(@VALOR AS VARCHAR ) AS VALOR;

	  -- o código: '+char(13)+char(10)+' quebra a linha de uma string em sql




--while no sql server





--exemplo(imprimir os numeros de 0 à 10):
declare @valor int
set @valor =  0
while @valor<= 10
	begin
		print'Número:'+cast(@valor as varchar(2))
		set @valor = @valor+1
	end;


--exemplo(imprimir livro e preço dos livros de IDs de 100 a 105):
declare @valor int
set @valor =  100
while @valor<= 105
	begin
		select ID_livros as ID,Nome_Livro as livro,Preco_livro as preço 
		from tbl_livro where ID_livros = @valor
		set @valor = @valor+1
	end;












-- Stored Proceures 

/*o que é:
	são lotes(batches) de declarações SQL que podem ser executadas como um subrotina.
	Permitem centralizar a lógica de acesso aos dados em um único local, facilitando 
	a manutenção e otimização de códigos.
	Também é possível ajustar permissões de acesso aos usuários, definindo quem pode 
	ou não executálas.
*/














--exemplo1:

--criando o procedimento(procedure)
CREATE PROCEDURE teste 
as 
select 'Bóson Treinamentos' as Nome

--executando a procedure
exec teste



--exemplo2:
create procedure p_LivroValor
as
select Nome_Livro,Preco_livro from tbl_livro


exec p_LivroValor















--traz informações da procedure
exec sp_helptext p_Livrovalor


--criar um procedure criptografado
create procedure p_LivroISBN
with encryption
as
select Nome_Livro,ISBN from tbl_livro

--não se pode ver a procedure com o sp_helptext, pois foi colocado o comando 'with encryption'.

exec sp_helptext p_LivroISBN















/*alterar um procedure,basicamente você vai re-escrever todo o código da procedure, entretanto isso permite
que você possa manter as permições já dadas a procedure*/

alter procedure teste(@parl as int)
as
select @parl as 'valor da variavel'

exec teste 22









alter procedure p_LivroValor(@ID smallint)
as
select Nome_Livro as Livro, Preco_Livro as Preço from tbl_livro where ID_livros = @ID

exec p_LivroValor 104



--o comando 'ctrl'+'K'+'C'  comenta um bloco de código
--o comando 'ctrl'+'K'+'U' descomenta um bloco de código










alter procedure teste(@par1 as int,@par2 as varchar(20))
as

select @par1 as 'valor da variavel 1'
select @par2 as 'valor da variavel 2'

--por posição:
exec teste 2, 'laranja'


--por chamada:
exec teste @par2 = 'laranja', @par1 = 2 







alter procedure p_LivroValor(@ID smallint,@Preco money)
as
select Nome_Livro as Livro, Preco_Livro as Preço from tbl_livro 
where ID_livros > @ID and Preco_livro > @Preco

exec p_LivroValor 103,60





alter procedure p_LivroValor(@ID smallint,@Quantidade smallint)
as
select Nome_Livro as Livro, Preco_Livro*@Quantidade as Preço from tbl_livro 
where ID_livros = @ID 


exec p_LivroValor 100,3













--inserção de valores com procedures
create procedure p_insere_editora(@nome varchar(50))
as
insert into tbl_editoras(Nome_editora) values(@nome)

exec p_insere_editora 'livrosfantasticos'


select * from tbl_editoras














--criação de procedures com valores padrão (ou pré estabelecidos, se preferir) 
create procedure p_teste_valor_padrão(@param1 int, @param2 varchar(20)='Valor Padrão!')
as
select 'valor do parâmetro 1:' + Cast(@param1 as varchar)
select 'valor do parãmetro 2:'+@param2

exec p_teste_valor_padrão 3

exec p_teste_valor_padrão 3,'arroz doce'














--parâmetro de saída no procedure
--criação
alter procedure teste(@parl as int output)
as
select @parl*2
return  
	--return termina a procedure incondicionalmente, é usado para retornar status de sucesso ou falha


--execução
declare @valor as int = 15
exec teste @valor output
print @valor













--criação:
alter procedure p_LivroValor(@Quantidade smallint, @ID smallint,@cod smallint = -10)
as
set nocount on --impede que conte as linhas
if @ID >=100
	begin
		select Nome_Livro as livros, Preco_livro*@Quantidade as preço from tbl_livro
		where ID_livros = @ID
		return 1 
	end
else
	return @cod


--execução:
declare @codigo int
exec @codigo = p_LivroValor @ID = 102, @Quantidade = 5
print @codigo




















--                                    Funções

--Funções escalares 
	/*
	o que fazem?
	Retornam um único valor específico
	*/ 

	--preparação
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
	(8,6,3,10,'andré Roaquina'),
	(4,7,3,8,'maicon Roaquina');


	--criação
	create function nota_media(@nome varchar(30))
	returns real
	as
		begin
		declare @media real 
		select @media=(nota1+nota2+nota3+nota4*2)/5.00 from tbl_alunos where nome_aluno = @nome
		return @media
		end

		select dbo.nota_media('maicon Roaquina') as media_do_aluno






		--função com valores de tabela  embutida(inline)
		/*
		o que faz? 
		São similares a uma exibição, porém permitem 
		 utilizar parâmetros. retornam um conjunto completo de dados
		*/



--criação
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


--execução:

--não especificando campos:
select * from retorna_itens(60)

-- especificando campos:
select Nome_Livro,Nome_Autor from retorna_itens(60)





--Funções com valor de tabela com várias intruções

/*
O que faz?

combina a habilidade da função escalar de conter códigos complexos com a habilidade da função com
valor de tabela de retornar um resultset.
O valor de função cria uma variável do tipo table e a popula a partir do código. Essa tabela é então 
passada de volta à função, de modo que possa ser usada em declarações select.
*/

--segue exemplo:


--você define quais são as tabelas que a função irá trazer


--criação:

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
	


--execução

select * from multi_tabela()

--criou uma nova tabela temporaria que contém os campos setados, nesse caso os campos:      (Nome_livro varchar(50),
																							--Data_Pub datetime,                    
																							--Nome_Editora varchar(50),
																							--Preco_Livro money)




























                         --Triggers

/*
O que é?


Um Trigger(Gatilho) é um tipo especial de Stored Procedure qe é executada automaticamente quando
um usuário realiza uma operação de modificação de dados em uma tabela especificada.

As operações que podem disparar um trigger são:
-INSERT
-UPDATE
-DELETE



Triggers DML:


Os triggers não são executados diretamente disparam apenas em resposta a enentos como insert, 
update ou delete em uma tabela.

**No SQL Server, os triggers disparam uma vez para cada operação de modificação -e não uma vez por linha 
afetada (no Oracle há as duas opções).**



Modo de disparo de um trigger:

Um trigger no SQL Server pode ser disparado de dois modos diferentes:

after - O código presente no trigger e executado após todas as ações terem sido completadas na tabela 
especificada

instead of- O código presente no trigger é executado no lugar da operação que causou seu disparo.

A imagem img_trigger1.png compara os dois tipos de triggers (ela está na mesma pasta que essa consulta)



Fluxo de transações:

Para desenvolver Triggers, é necessário conhecimento do fluxo geral da transação, para evitar conflitos 
entre os triggers e contraints.

As transações se movem através de verificações e códigos na ordem mostrada abaixo:

1.Verificação de IDentity Insert
2.Restrição (Constraint)  de Nulos(NULL)
3.Checagem de tipos de dados
4.Execução de trigger INSTEAD OF(a execução do DML pára aqui; esse trigger não é recursivo)
5.Restrição de Chave Primária
6.Restrição de "Check"
7.Restrição de chave Estrangeira
8.Execução do DML e atualização do log de tramsações
9.Execução do trigger after 
10.Commit da Transação (Confirmação)

*/








/*
sintaxe do trigger:

Create Trigger nome_trigger
on tabela | view
[with encryption]
	after|instead of
		[insert,update,delete]
as
código do trigger
*/



								--trigger after

--criação:

create trigger teste_trigger_after 
on tbl_editoras
after insert
as
print 'Olá mundo!';


--teste do trigger:
insert into tbl_editoras values ('editoras23')

select * from tbl_editoras



--criação:
create trigger trigger_after 
on tbl_editoras
after insert
as
insert into tbl_autores values(25,'José','da Silva');
insert into tbl_livro values('livro1','123456000','20001010',77,25,2);



--teste:
insert into tbl_editoras values ('editoras24')


select* from tbl_autores
select* from tbl_livro
select* from tbl_editoras







							--trigger instead of

--criação:
create trigger teste_trigger_insteadof
on tbl_autores
instead of insert
as
print'Olá de novo! não inseri o 
registro desta vez!'

--quando coloca na linha de baixo automaricamente quebra a linha.


--teste
insert into tbl_autores values(26,'joão','moura')

select * from tbl_autores


--exclui trigger

drop trigger teste_trigger_after 













--Habilitar e dasabilitar triggers

--alterar triggers

/*

sintaxe:

alter table nome_tabela
enable | Disable trigger nome trigger


obs: vale salientar que esse comando só desabilita o trigger, mas não o exclui!
*/

--criação:
alter table tbl_editoras
 Disable trigger trigger_after

 
--pesquisa de triggers

	--pesquisar as informações sobre um trigger em uma tabela:
 
		 --sintaxe: exec sp_helptrigger @tabname = nome da tabela
		 exec sp_helptrigger @tabname = tbl_editoras


	--pesquisar as informações sobre um trigger no banco de dados todo:

		--traz todos que estão ativados no banco de dados todo
		use db_curso_sql
			select * from sys.triggers where is_disabled=0

		--traz todos que estão desativados no banco de dados todo
		use db_curso_sql
			select * from sys.triggers where is_disabled=1




--triggers determinando as colunas atualizadas
	--A função Update() retorna True se uma coluna especfica dor afetada por uma transação DML 
		/*Podemos criar um gatinho que executa um código caso a colina especificada seja alterada
		por um comando DML usando essa função*/


		--criação de tabela
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
			print'nome não foi modificado'
		end
		--teste
		update tbl_autores set nome_autor = 'joão' where id_autor = 10




































--alinhamento de triggers DML
	/*
	o que é? 
		Resposta:É quando um trigger ao ser ativado leva ao ativamento de outros triggers.
	
	Para isso, a opção de servidor "Permitir que Gatilhos disparem outros gatilhos", em Propriedades do
	Servidor -> Avançado deve estar configurada como True (é o padrão)

	Para desabilitar/habilitar a opção de aninhamento de triggers, use o comando:
	
	exec sp_configure 'Nested Triggers', 0|1;
	reconfigure;


	imagem referencial no arquivo raiz com o nome de: img_trigger2
	*/

	
	exec sp_configure 'Nested Triggers', 1; 
	reconfigure;







	--Triggers Recursivos

	/*
	Um gatilho recursivo é um tipo especial de trigger after aninhado.
	O trigger recurivo ocorre quando um trigger executa uma declaração DML que o dispara novamente.
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

	--sintaxe:nome_coluna time[(frações de segundo)]


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


	--calcula a diferença de tempo entre duas datas

	select datediff(minute,hora_entr,hora_sai) as 'permanencia(em minutos)' from tbl_visitas

















