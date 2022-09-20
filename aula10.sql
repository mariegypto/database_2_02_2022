DROP DATABASE IF EXISTS aula10;
CREATE DATABASE aula10;

use aula10;

CREATE TABLE carros (
    id_carro INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    modelo VARCHAR(255),
    ano INTEGER
);

CREATE TABLE vendedores (
    id_vendedor INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    sobrenome VARCHAR(255),
    cpf BIGINT
);

CREATE TABLE compradores (
    id_comprador INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    sobrenome VARCHAR(255),
    cpf BIGINT,
    status_cpf ENUM('Negativado','Sem pendencias')
);

CREATE TABLE comp_vend_carro(
    id_comp_vend_carro INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_comprador INTEGER,
    id_vendedor INTEGER,
    id_carro INTEGER,
    FOREIGN KEY(id_comprador) REFERENCES compradores(id_comprador),
    FOREIGN KEY(id_vendedor) REFERENCES vendedores(id_vendedor),
    FOREIGN KEY(id_carro) REFERENCES carros(id_carro)
);

INSERT INTO
    carros(nome,modelo,ano)
VALUES
(
    'Chevette','Chevrolet', 1998
),
(
    'Gol','Volkswagen', 2005
),
(
    'Onix','Chevrolet', 2020
);

INSERT INTO
    vendedores(nome,sobrenome,cpf)
VALUES
(
    'Roberto','Carlos', 14578452033
),
(
    'Maria','Aparecida', 96302587465
),
(
    'Odair','Silveira', 30620510478
);

INSERT INTO
    compradores(nome,sobrenome,cpf,status_cpf)
VALUES
(
    'Jose','Silva', 55630948710, 'Sem pendencias'
),
(
    'Fabio','Lima', 96336985250,'Negativado'
),
(
    'Jeronimo','Madero', 22203050107,'Negativado'
),
(
    'Carolina','Vieira', 15963201400,'Sem pendencias'
);

INSERT INTO
    comp_vend_carro(id_comprador,id_vendedor,id_carro)
VALUES(
(SELECT id_comprador FROM compradores WHERE nome = 'Jose'),
(SELECT id_vendedor FROM vendedores WHERE nome = 'Odair'),
(SELECT id_carro FROM carros WHERE nome = 'Gol')
);

INSERT INTO
    comp_vend_carro(id_comprador,id_vendedor,id_carro)
VALUES(
(SELECT id_comprador FROM compradores WHERE nome = 'Jeronimo'),
(SELECT id_vendedor FROM vendedores WHERE nome = 'Odair'),
(SELECT id_carro FROM carros WHERE nome = 'Onix')
);


CREATE
    VIEW select_all_transacoes/*view é uma abstração, é como uma função, temos um código que vamos 
    usar várias vezes ao longo da estrututra do nosso código, para não ficar ctrl c ctrl v. 
    No caso o VIEW vc compacta a query, toda vez que chamar a view va estar chamando tal query*/
as (
    SELECT
    id_comp_vend_carro,
    carros.id_carro,
    compradores.id_comprador,
    vendedores.id_vendedor,
    compradores.nome as nome_comprador,
    compradores.status_cpf as status_docpf,
    compradores.cpf as cpf_comprador,
    vendedores.cpf as cpf_vendedor,
    vendedores.nome as nome_vendedor
FROM
    comp_vend_carro
INNER JOIN
    compradores
    ON comp_vend_carro.id_comprador=compradores.id_comprador
INNER JOIN
    vendedores
    ON comp_vend_carro.id_vendedor=vendedores.id_vendedor
INNER JOIN
    carros
    ON comp_vend_carro.id_carro=carros.id_carro
);