DROP DATABASE IF EXISTS transaction_rollback;
CREATE DATABASE transaction_rollback;

USE transaction_rollback;

CREATE TABLE musics (
    id_music INTEGER PRIMARY KEY AUTO_INCREMENT,
    name_of_music VARCHAR(255),
    band VARCHAR(255),
    created_at DATETIME DEFAULT NOW()
);

INSERT INTO musics(name_of_music, band)
VALUES('Nothing Else Matters','Metallica'),
('Enter Sandman','Metallica'),
('My Friend of Misery','Metallica'),
('Deutshchland','Rammstein'),
('Rosenrot','Rammstein'),
('Ohne dich','Rammstein');

SELECT "This scenario is with Rollback" AS 'LOG';

SELECT * FROM musics;

SET autocommit=0;/*commit em banco de dados é quando voce efetiva uma transacao. Ele =0 todas as operacoes feitas no banco garante que sejam sempre efetivas, sem precisar confirmar. Default dela é 1 e toda transicao é comitada*/

START TRANSACTION;

ALTER TABLE musics ADD good TINYINT;

UPDATE musics SET good = 1 WHERE band IN('Metallica','Rammstein');

UPDATE musics SET good = 0 WHERE name_of_music IN('Enter Sandman');

SELECT "AFTER DELETE ROW OF musics TABLE" AS 'LOG';

SELECT * FROM musics;

ROLLBACK;

SELECT "AFTER ROLLBACK OF musics TABLE" AS 'LOG';

SELECT * FROM musics;
/*
SET autocommit=1;*/