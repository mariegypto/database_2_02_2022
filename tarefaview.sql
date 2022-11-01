DROP DATABASE IF EXISTS tarefaview;
CREATE DATABASE tarefaview;

USE tarefaview;

CREATE TABLE IF NOT EXISTS pais (
    pais_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome_pais VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS cidade (
    cidade_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    pais_id INTEGER,
    nome_cidade VARCHAR(20) NOT NULL,
    FOREIGN KEY(pais_id) REFERENCES pais(pais_id)
);

INSERT INTO
    pais(nome_pais)
VALUES
    ('Marrocos'),
    ('Egito'),
    ('Brasil'),
    ('Inglaterra');

SET @idPaisMarrocos:=(SELECT pais_id FROM pais WHERE nome_pais = 'Marrocos');
SET @idPaisEgito:=(SELECT pais_id FROM pais WHERE nome_pais = 'Egito');
SET @idPaisBrasil:=(SELECT pais_id FROM pais WHERE nome_pais = 'Brasil');
SET @idPaisInglaterra:=(SELECT pais_id FROM pais WHERE nome_pais = 'Inglaterra');

INSERT INTO
    cidade(nome_cidade, pais_id)
VALUES
    ('Marrakech',@idPaisMarrocos),
    ('Fez',@idPaisMarrocos),
    ('Casablanca',@idPaisMarrocos),
    ('Cairo',@idPaisEgito),
    ('Luxor',@idPaisEgito),
    ('Alexandria',@idPaisEgito),
    ('Rio de Janeiro',@idPaisBrasil),
    ('Sao Paulo',@idPaisBrasil),
    ('Curitiba',@idPaisBrasil),
    ('Londres',@idPaisInglaterra),
    ('Liverpool',@idPaisInglaterra),
    ('Cambridge',@idPaisInglaterra);

CREATE
    VIEW select_all_countries_cities
as (
    SELECT 
        pais.nome_pais as nome_do_pais,
        cidade.nome_cidade as nome_da_cidade
    FROM 
        cidade
    INNER JOIN 
        pais ON cidade.pais_id = pais.pais_id
);

SELECT * FROM select_all_countries_cities;
