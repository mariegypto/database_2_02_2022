DROP DATABASE IF EXISTS aprendendoleft;
CREATE DATABASE aprendendoleft;
USE aprendendoleft;

DROP TABLE IF EXISTS alunos;
DROP TABLE IF EXISTS classe;
DROP TABLE IF EXISTS professores;

CREATE TABLE classe (
    id_classe INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_classe VARCHAR(100) NOT NULL,
    descricao TEXT,
    ano VARCHAR(4) NOT NULL    
);

CREATE TABLE alunos (
    id_aluno INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    documento VARCHAR(20) NOT NULL,
    id_classe INTEGER,
    FOREIGN KEY (id_classe) REFERENCES classe(id_classe)
);

CREATE TABLE professores (
    id_professor INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    documento VARCHAR(20) NOT NULL,
    id_classe INTEGER,
    FOREIGN KEY (id_classe) REFERENCES classe(id_classe)
);


INSERT INTO classe (nome_classe, descricao, ano) VALUES
('A', 'turma que entrou no inicio do ano', '2021'),
('B', 'turma que entrou no meio do ano', '2021');


INSERT INTO alunos (nome, sobrenome, documento, id_classe) VALUES
('Brunno', 'Sobrenome do Brunno', 'XX.XXX.XXX.X',1),
('Bryan', 'Sobrenome do Bryan', 'XX.XXX.XXX.X',1),
('Leandro', 'Sobrenome do Leandro', 'XX.XXX.XXX.X',1),
('Luan', 'Sobrenome do Luan', 'XX.XXX.XXX.X',1),
('Lucas', 'Sobrenome do Lucas', 'XX.XXX.XXX.X',2),
('Aryon', 'Sobrenome do Aryon', 'XX.XXX.XXX.X',2),
('Raphael', 'Sobrenome do Raphael', 'XX.XXX.XXX.X',2),
('Leticia', 'Sobrenome do Leticia', 'XX.XXX.XXX.X',2),
('Pedro', 'Sobrenome do Pedro', 'XX.XXX.XXX.X',2),
('Guilherme', 'Sobrenome do Guilherme', 'XX.XXX.XXX.X',2);


INSERT INTO alunos (nome, sobrenome, documento) VALUES
('Ernani', 'Sobrenome do Ernani', 'XX.XXX.XXX.X');

SELECT 'ALUNOS - INNER JOIN' AS 'LOG';
SELECT * FROM alunos INNER JOIN classe ON alunos.id_classe = classe.id_classe;

SELECT 'ALUNOS - LEFT JOIN' AS 'INLOGFO';
SELECT alunos.nome FROM alunos LEFT JOIN classe ON alunos.id_classe = classe.id_classe;

SELECT 'PROFESSORES - LEFT JOIN' AS 'LOG';
SELECT professores.nome FROM professores LEFT JOIN classe ON professores.id_classe = classe.id_classe;

SELECT 'PROFESSORES - RIGHT JOIN' AS 'LOG';
SELECT professores.nome FROM professores RIGHT JOIN classe ON professores.id_classe = classe.id_classe;

SELECT 'PROFESSORES - INNER JOIN' AS 'LOG';
SELECT professores.nome FROM professores INNER JOIN classe ON professores.id_classe = classe.id_classe;

SELECT 'PROFESSORES NA DIREITA- LEFT JOIN' AS 'LOG';
SELECT professores.nome FROM classe LEFT JOIN professores ON professores.id_classe = classe.id_classe;

SELECT 'PROFESSORES NA DIREITA- RIGHT JOIN' AS 'LOG';
SELECT professores.nome FROM classe LEFT JOIN professores ON professores.id_classe = classe.id_classe;

SELECT 'PROFESSORES NA DIREITA- INNER JOIN' AS 'LOG';
SELECT professores.nome FROM classe LEFT JOIN professores ON professores.id_classe = classe.id_classe;