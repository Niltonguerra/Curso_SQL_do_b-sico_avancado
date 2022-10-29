
--Caso queira ver algum assunto em específico use o comando: 'ctrl'+'F' para pesquisar pelo arquivo.

--Não delecione os comentários caso queira textar o código por partes, pois isso irá gerar erro!



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
	ID_Clientes varchar(10),
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











TRUNCATE TABLE tbl_livro							-- Exclua todos os registros contidos na tabela tbl_livro
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
SELECT AVG(Preco_livro) AS MÉDIA_ARITMÉTICA FROM tbl_livro		--Qual é a média aritmética da coluna Preco_livro na tabela tbl_livro
SELECT SUM(Preco_livro) AS SOMA_TOTAL FROM tbl_livro		--Qual é a soma de todos os valores da coluna Preco_livro na tabela tbl_livro







SELECT * FROM tbl_livro WHERE Data_Pub BETWEEN '20040517' AND '20100217'
								--selecione todos os valores da tabela tbl_livros onde Data_Pub está entre os valores (nesse caso datas): 20040517 e 20100217







								--INNER JOIN: RETORNA VALORES QUE TENHAM REFERENCIA NA OUTRA TABELA

								/*OUTER JOIN: RETORNA VALORES MESMO QUE NÃO TENHAM REFERENCIA NA OUTRA TABELA,ELE SE DIVIDE EM:
								lEFT JOIN,RIGHT JOIN E FULL JOIN*/





--INNER JOIN

SELECT * FROM tbl_livro INNER JOIN tbl_autores ON tbl_livro.ID_AUTOR = tbl_autores.ID_Autor
--traga todos os valores das tabelas tbl_livro e tbl_Autores onde o campo ID_autor da tabela tbl_autor for igual e não nulo ao campo ID_autores da tabela tbl_livros


SELECT tbl_livro.Nome_Livro, tbl_livro.ISBN, tbl_autores.Nome_Autor FROM tbl_livro INNER JOIN tbl_autores ON tbl_livro.ID_Autor = tbl_autores.ID_Autor;
--traga apenas os campos campos: tbl_livro.Nome_Livro, tbl_livro.ISBN, tbl_autores.Nome_Autor da tabela da tabela: tbl_livro, onde tbl_livro.ID_Autor = tbl_autores.ID_Autor


	--usando aliases
-- eliases nada mais é que voçê dar nome a um nome a tabela para encurtar o tamanho do comando como pode ser vista na linha abaixo.

SELECT L.Nome_Livro AS Livros, E.Nome_editora AS Editoras FROM tbl_livro AS L INNER JOIN tbl_editoras AS E ON L.ID_editora = E.ID_editora WHERE E.Nome_Editora LIKE 'M%';

--nesse caso chamei a tabela 'tbl_livro' de 'L' 
--e a tabela 'tbl_editoras' de 'E'






--LEFT JOIN:TRAZ TODOS OS VALORES DA TABELA CITADA PRIMEIRO.

	SELECT * FROM tbl_livro
	SELECT * FROM tbl_autores LEFT JOIN tbl_livro ON tbl_livro.ID_AUTOR = tbl_autores.ID_Autor
	-- traga todos as informações da primeira tabela citada e tudo o que tiver da segunda tabela onde tbl_livro.ID_AUTOR = tbl_autores.ID_Autor

--RIGHT JOIN: TRAZ TODOS OS VALORES DA  SEGUNDA TABELA CITADA. 
	SELECT * FROM tbl_livro
	SELECT * FROM tbl_autores
	SELECT * FROM tbl_autores RIGHT JOIN tbl_livro ON tbl_livro.ID_AUTOR = tbl_autores.ID_Autor
	-- traga todos as informações da segunda tabela citada e tudo o que tiver da primeira tabela onde tbl_livro.ID_AUTOR = tbl_autores.ID_Autor
	
	SELECT * FROM tbl_autores RIGHT JOIN tbl_livro ON tbl_livro.ID_AUTOR = tbl_autores.ID_Autor WHERE tbl_autores.ID_Autor IS NULL --O 'NULL' TRABALHA COM O 'IS'

	-- traga todos as informações da segunda tabela citada e tudo o que tiver da primeira tabela onde tbl_livro.ID_AUTOR = tbl_autores.ID_Autor E ONDE tbl_autores.ID_Autor IS NULL




--FULL JOIN: TRAZ TODOS OS VALORES DE AMBAS AS TABELAS CITADAS.

 









