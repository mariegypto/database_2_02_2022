SELECT "USE MySQL database" AS "INFO";
USE mysql;
SELECT "Drop database aula 1 if exist" AS "INFO";
DROP DATABASE IF EXISTS aula1;
SELECT "The creation of database" AS "INFO";
CREATE DATABASE aula1;
SELECT "Use of database" AS "INFO";
USE aula1;

SELECT "Create table students" AS "INFO";

DROP TABLE IF EXISTS students;

CREATE TABLE students (
    id_student INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR (255),
    last_name VARCHAR (255),
    gender ENUM('MA', 'FE'),
    code_registration INTEGER UNIQUE,
    status  BOOLEAN,
    created_at DATETIME DEFAULT CURRENT_DATE(),
    deleted_at DATETIME
);

DESCRIBE students;

INSERT INTO students(
    first_name,
    last_name,
    gender,
    code_registration
)
    VALUES
(
    'Mariana',
    'Feigel',
    'FE',
    1
),
(
    'Ernani',
    'da Paz',
    'MA',
    2
);

SELECT * FROM students;