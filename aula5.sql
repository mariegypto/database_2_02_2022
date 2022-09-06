CREATE DATABASE IF NOT EXISTS aprenderjoin CHARACTER SET utf8mb4; --cria a base de dados se ela nao existe

USE aprenderjoin;

DROP TABLE IF EXISTS garcom_restaurantes;
DROP TABLE IF EXISTS garcom;
DROP TABLE IF EXISTS restaurantes; 
DROP TABLE IF EXISTS cidade;--se já existirem deleta
DROP TABLE IF EXISTS estado;--se já existirem deleta


CREATE TABLE IF NOT EXISTS estado(
    id_estado INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    regiao ENUM('sul','sudeste','centro-oeste','nordeste','norte')
);

CREATE TABLE IF NOT EXISTS cidade(
    id_cidade INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    id_estado INTEGER NOT NULL,
    FOREIGN KEY (id_estado) REFERENCES estado(id_estado)

);

INSERT INTO 
    estado(nome, regiao)
VALUES
    ('Parana', 'sul'),
    ('Sao Paulo', 'sudeste'),
    ('Rio de Janeiro, PAH PAH TAH TAH', 'sudeste'),
    ('Bahia', 'nordeste'),
    ('Pernambuco', 'nordeste'),
    ('Para', 'norte'),
    ('Mato Grosso', 'centro-oeste');        

SET @idParana:=(SELECT id_estado FROM estado WHERE estado.nome = 'Parana');--set é criar uma variavel
SET @idSaoPaulo:=(SELECT id_estado FROM estado WHERE estado.nome = 'Sao Paulo');
SET @idRioDeJaneiro:=(SELECT id_estado FROM estado WHERE estado.nome = 'Rio de Janeiro, PAH PAH TAH TAH');
SET @idBahia:=(SELECT id_estado FROM estado WHERE estado.nome = 'Bahia');
SET @idPernambuco:=(SELECT id_estado FROM estado WHERE estado.nome = 'Pernambuco');
SET @idPara:=(SELECT id_estado FROM estado WHERE estado.nome = 'Para');
SET @idMatoGrosso:=(SELECT id_estado FROM estado WHERE estado.nome = 'Mato Grosso');

INSERT INTO cidade(nome, id_estado)VALUES
    ('Curitiba', @idParana),
    ('Londrina', @idParana),
    ('Paranagua', @idParana),
    ('Sao Paulo', @idSaoPaulo),
    ('Sorocaba', @idSaoPaulo),
    ('Rio de Janeiro', @idRioDeJaneiro),
    ('Niteroi', @idRioDeJaneiro),
    ('Mage', @idRioDeJaneiro),
    ('Porto Real', @idRioDeJaneiro),
    ('Petropolis', @idRioDeJaneiro),
    ('Salvador', @idBahia),
    ('Feira de Santana', @idBahia),
    ('Recife', @idPernambuco),
    ('Olinda', @idPernambuco),
    ('Petrolina', @idPernambuco),
    ('Belem', @idPara),
    ('Cuiaba', @idMatoGrosso);

/* 
SELECT
    estado.nome
FROM
    estado
WHERE
    estado.id_estado=(
        SELECT 
            cidade.id_estado
        FROM
            cidade
        WHERE
            cidade.nome = 'Petropolis'
    );
SELECT 
    *
FROM
    cidade
INNER JOIN /*quando vc usa o join entre duas tabelas o banco faz uma operação, pega as duas tabelas e junta elas, vira uma tabela só, esse operação melhora a performance da pesquisa. Pois usando subselect executa duas operações, pro primeiro e pro segundo select embutido.Trás tudo das duas tabelas
    estado ON cidade.id_estado = estado.id_estado
WHERE
    nome='Petropolis';*/


CREATE TABLE restaurantes (
    id_restaurante INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    descricao VARCHAR(255),
    id_cidade INTEGER,
    FOREIGN KEY(id_cidade) REFERENCES cidade(id_cidade)
    );

SET @idCuritibaCidade := (SELECT id_cidade FROM cidade WHERE nome = 'Curitiba');
SET @idSaoPauloCidade := (SELECT id_cidade FROM cidade WHERE nome = 'Sao Paulo');
SET @idRiodeJaneiroCidade := (SELECT id_cidade FROM cidade WHERE nome = 'Rio de Janeiro');
SET @idPetropolisCidade := (SELECT id_cidade FROM cidade WHERE nome = 'Petropolis');
SET @idFeiradeSantanaCidade := (SELECT id_cidade FROM cidade WHERE nome = 'Feira de Santana');

SELECT @idFeiradeSantanaCidade as 'cidade';

INSERT INTO restaurantes (nome, descricao,id_cidade) VALUES
    ('Comida Mineira', 'comida tipica de minas, voce nao viu o nome?',@idCuritibaCidade),
    ('Fogo de chao', 'fogo... no chao?',@idSaoPauloCidade),
    ('Frangao','Uma homenagem a frangos sei la nao to enxergando',@idRiodeJaneiroCidade),
    ('Pizza Maromba','So pode comer aqui se voce usa bomba',@idPetropolisCidade),
    ('Pertuti', 'Deve ser italiano',@idFeiradeSantanaCidade);

SELECT 
    * 
FROM 
    restaurantes 
INNER JOIN
    cidade ON cidade.id_cidade = restaurantes.id_cidade
WHERE
    restaurantes.nome = 'Pizza Maromba'
;

SELECT 
    * 
FROM 
    cidade 
INNER JOIN
    restaurantes ON restaurantes.id_cidade=cidade.id_cidade 
WHERE
    restaurantes.nome = 'Pizza Maromba'
;

SELECT 
    cidade.nome as nome_da_cidade,
    restaurantes.nome as nome_do_restaurante,
    restaurantes.descricao as descricao_do_restaurante
FROM
    cidade
INNER JOIN
    restaurantes
        ON restaurantes.id_cidade = cidade.id_cidade
WHERE
    restaurantes.nome LIKE '%M%';

SELECT 'transformando em uma tabela ---------' as 'INFO';

SELECT
    t1.nome_da_cidade,
    t1.nome_do_restaurante
FROM
(
        SELECT
            cidade.nome as nome_da_cidade,
            restaurantes.nome as nome_do_restaurante,
            restaurantes.descricao as descricao_do_restaurante
        FROM
            cidade
        INNER JOIN
            restaurantes
                ON restaurantes.id_cidade = cidade.id_cidade
        WHERE
            restaurantes.nome LIKE '%M%'
) as t1

WHERE
    t1.nome_da_cidade = 'Curitiba'/*piora de performance, é usado para aplicar alguns switch cases, remoção de dados ou fazer joins com resultados de outros joins*/
;

SELECT 'com mais de um INNER JOIN --------' as 'INFO';

SELECT 
    cidade.nome as nome_da_cidade,
    estado.nome as nome_do_estado,
    restaurantes.nome as nome_do_restaurante
FROM   
    restaurantes
INNER JOIN
    cidade
        ON restaurantes.id_cidade = cidade.id_cidade
INNER JOIN
    estado  
        ON cidade.id_estado = estado.id_estado
WHERE 
    restaurantes.nome LIKE "Comida M%";

INSERT INTO restaurantes (nome, descricao) VALUES
('Restaurante que nao esta em cidade alguma','Descricao ja esta no nome');

SELECT "Fazendo busca com cidade na esquerda em registro sem relacao entre ambas tabelas" AS "LOG";

SELECT 
    *
FROM 
    cidade
INNER JOIN
    restaurantes
    ON
        cidade.id_cidade = restaurantes.id_cidade
WHERE
    restaurantes.nome = 'Restaurante que nao esta em cidade alguma';

SELECT "Fazendo busca com restaurante na esquerda em registro sem relacao entre ambas tabelas" AS "LOG";

SELECT 
    *
FROM 
    restaurantes
INNER JOIN
    cidade
    ON
        cidade.id_cidade = restaurantes.id_cidade
WHERE
    restaurantes.nome = 'Restaurante que nao esta em cidade alguma';

SELECT "Traga tudo" AS "LOG";

SELECT 
    cidade.nome,
    restaurantes.nome
FROM 
    restaurantes
INNER JOIN
    cidade
    ON
        cidade.id_cidade = restaurantes.id_cidade;


INSERT INTO restaurantes (nome, descricao,id_cidade) VALUES
    ('Comida Mineira', '2 pães de queijo',@idCuritibaCidade),
    ('Fogo de chao', 'Uma costela',@idCuritibaCidade),
    ('Frangao','4 pastéis de frango',@idCuritibaCidade),
    ('Pizza Maromba','Uma pizza com ovo frango e whey',@idCuritibaCidade),
    ('Pertuti', 'Duas macarronadas',@idCuritibaCidade);


SELECT  
    *
FROM
    restaurantes
INNER JOIN
    cidade ON restaurantes.id_cidade = cidade.id_cidade
WHERE
    cidade.nome = 'Curitiba';

INSERT INTO restaurantes(nome, descricao, id_cidade)VALUES
    ('Comida Mineira','Comida tipica de minas, voce nao viu o nome?',@idSaoPauloCidade);

SELECT
    *
FROM
    restaurantes
INNER JOIN
    cidade ON restaurantes.id_cidade=cidade.id_cidade
WHERE
    cidade.nome IN ('Curitiba','Sao Paulo');

CREATE TABLE garcom(
    id_garcom INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    experiencia ENUM('junior','pleno','senior'),
    tipo_documento ENUM('cpf','rg'),
    documento BIGINT
);

INSERT INTO 
    garcom(nome, experiencia, tipo_documento, documento)
VALUES
    ('Jorge','junior','cpf',86000009432),
    ('Maria','pleno','cpf',58700000208),
    ('Jhenifer','pleno','rg',880000010),
    ('Carolina','pleno','rg',890000078),
    ('Mirela','pleno','rg',900000075),
    ('Pedro','pleno','rg',910000065),
    ('Plinio','senior','cpf',92000004569),
    ('Matheus','senior','cpf',59300000159),
    ('Samuel','senior','cpf',94000000274);

SELECT * FROM garcom;

CREATE TABLE garcom_restaurantes (
    id_restaurante INTEGER NOT NULL,
    id_garcom INTEGER NOT NULL,
    dia_semana ENUM('segunda', 'terca', 'quarta', 'quinta', 'sexta', 'sabado', 'domingo'),
    FOREIGN KEY (id_restaurante) REFERENCES restaurantes(id_restaurante),
    FOREIGN KEY (id_garcom) REFERENCES garcom(id_garcom)        
);

INSERT INTO
    garcom_restaurantes(id_restaurante, id_garcom, dia_semana)
VALUES (
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Pizza Maromba' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
    'segunda'
),
(
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Pertuti' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
    'terca'
),
(
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Restaurante que nao esta em cidade alguma' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
    'quarta'
),
(
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Frangao' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
    'quinta'
),
(
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Fogo de chao' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
    'sexta'
),
(
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Pizza Maromba' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Maria'),
    'segunda'
),
(
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Pertuti' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Maria'),
    'terca'
),
(
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Restaurante que nao esta em cidade alguma' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Maria'),
    'quarta'
),
(
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Frangao' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Maria'),
    'quinta'
),
(
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Fogo de chao' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Maria'),
    'sexta'
),
(
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Pizza Maromba' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Samuel'),
    'segunda'
),
(
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Pertuti' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Samuel'),
    'terca'
),
(
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Restaurante que nao esta em cidade alguma' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Samuel'),
    'quarta'
),
(
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Frangao' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Samuel'),
    'quinta'
),
(
    (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome ='Fogo de chao' LIMIT 1),
    (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Samuel'),
    'sexta'
);

SELECT 
    garcom.nome as nome_garcom,
    restaurantes.nome as nome_restaurante,
    garcom_restaurantes.dia_semana as dia_semana
FROM 
    garcom
INNER JOIN 
     garcom_restaurantes ON garcom.id_garcom = garcom_restaurantes.id_garcom
INNER JOIN
    restaurantes ON garcom_restaurantes.id_restaurante=restaurantes.id_restaurante
WHERE
    garcom.nome IN('Jorge','Samuel','Maria');


