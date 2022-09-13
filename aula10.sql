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
    cpf BIGINT
);

CREATE TABLE comp_vend_carro(
    id_comp_vend_carro INTEGER
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
    compradores(nome,sobrenome,cpf)
VALUES
(
    'Jose','Silva', 55630948710
),
(
    'Fabio','Lima', 96336985250
),
(
    'Carolina','Vieira', 15963201400
);

CREATE
    VIEW select_all_transacoes/*view é uma abstração, é como uma função, temos um código que vamos 
    usar várias vezes ao longo da estrututra do nosso código, para não ficar ctrl c ctrl v. 
    No caso o VIEW vc compacta a query, toda vez que chamar a view va estar chamando tal query*/
as (
    SELECT nome.carros, modelo.carros, ano.carros, nome.vendedores, nome.compradores FROM carros INNER JOIN vendedores ON 
);