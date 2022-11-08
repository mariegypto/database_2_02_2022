DROP DATABASE IF EXISTS learn_procedures;

CREATE DATABASE learn_procedures;

USE learn_procedures;

CREATE TABLE country (
    id_country INTEGER AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(255),
    continent VARCHAR(255)
);

INSERT INTO 
    country(country_name, continent)
VALUES 
    ('Brasil','America do Sul'),
    ('Paraguai','America do Sul'),
    ('Uruguai','America do Sul'),
    ('Peru','America do Sul'),
    ('Libano','Asia'),
    ('Estados Unidos','America do Norte');


DELIMITER $$

DROP PROCEDURE IF EXISTS SelectCountry;

CREATE PROCEDURE SelectCountry()
BEGIN
    SELECT 
        * 
    FROM 
        country;
END $$

DELIMITER ;

call SelectCountry;

DELIMITER $$

DROP PROCEDURE IF EXISTS SelectCountryArgReceive;

CREATE PROCEDURE SelectCountryArgReceive(CountryName VARCHAR(255))
BEGIN
    SELECT 
        * 
    FROM 
        country 
    WHERE 
        country.country_name=CountryName; 
END $$

DELIMITER ;

call SelectCountryArgReceive('Brasil');



DELIMITER $$

DROP PROCEDURE IF EXISTS SelectCountryInternArg;

CREATE PROCEDURE SelectCountryInternArg()
BEGIN
    DECLARE CountryName VARCHAR(255);
    SET CountryName='Brasil';
    SELECT 
        * 
    FROM 
        country 
    WHERE 
        country.country_name=CountryName; 
END $$

DELIMITER ;

call SelectCountryInternArg;

DELIMITER $$

DROP PROCEDURE IF EXISTS SelectCountryUsingIf;

CREATE PROCEDURE SelectCountryUsingIf(InputNumber INTEGER)
BEGIN
    DECLARE CountryName VARCHAR(255);

    IF InputNumber = 1 THEN
        SET CountryName = 'Brasil';
    ELSEIF InputNumber = 2 THEN
        SET CountryName = 'Paraguai';
    ELSEIF InputNumber = 3 THEN
        SET CountryName = 'Uruguai';
    ELSEIF InputNumber = 4 THEN
        SET CountryName = 'Peru';
    ELSEIF InputNumber = 5 THEN
        SET CountryName = 'Libano';
    END IF;

    SELECT CountryName AS 'Pais Selecionado';
    
    SELECT 
        * 
    FROM 
        country 
    WHERE 
        country.country_name = CountryName;

END $$

DELIMITER ;

call SelectCountryUsingIf(4);

DELIMITER $$

DROP PROCEDURE IF EXISTS SelectCountryCase;

CREATE PROCEDURE SelectCountryCase(InputNumber INTEGER)
BEGIN
    DECLARE CountryName VARCHAR(255);
    CASE
    WHEN InputNumber = 1 THEN
        SET CountryName = 'Brasil';
    WHEN InputNumber = 2 THEN
        SET CountryName = 'Paraguai';
    WHEN InputNumber = 3 THEN
        SET CountryName = 'Uruguai';
    WHEN InputNumber = 4 THEN
        SET CountryName = 'Peru';
    WHEN InputNumber = 5 THEN
        SET CountryName = 'Libano';
    END CASE;

    SELECT CountryName AS 'Pais Selecionado';
    
    SELECT 
        * 
    FROM 
        country 
    WHERE 
        country.country_name = CountryName;

END $$

DELIMITER ;

call SelectCountryCase(2);

DELIMITER $$

CREATE PROCEDURE SelectLoopLabel()
BEGIN
    DECLARE ctr INT;
    SET ctr=0;

    loop_lable: LOOP
        IF ctr > 10 THEN
        LEAVE loop_lable;
        END IF;
        SELECT ctr AS 'CTR';
        SET ctr=ctr+1;
    END LOOP;
END $$

DELIMITER ;

call SelectLoopLabel();
