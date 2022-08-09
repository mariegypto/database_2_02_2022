SELECT 'Specific select on customer table' AS 'INFO';

SELECT customer.customer_id, customer.first_name, customer.last_name, customer.active FROM customer LIMIT 15; 

SELECT 'Select some specific people' AS 'INFO';

SELECT customer.customer_id, customer.first_name, customer.last_name, customer.active FROM customer WHERE customer.first_name = 'Mary' OR customer.first_name = 'Patricia' LIMIT 15; 

SELECT 'Select some specific people with and' AS 'INFO';

SELECT customer.customer_id, customer.first_name, customer.last_name, customer.active FROM customer WHERE customer.first_name = 'Mary' AND customer.first_name = 'Patricia' LIMIT 15; 

SELECT 'Select some specific people with and that works' AS 'INFO';

SELECT customer.customer_id, customer.first_name, customer.last_name, customer.active FROM customer WHERE customer.first_name = 'WADE' AND customer.email = 'WADE.DELVALLE@sakilacustomer.org' LIMIT 15; 

SELECT 'Specific selects of films' AS 'INFO';

SELECT film.title, film.rating, film.description, film.release_year, film.length, film.language_id FROM film WHERE (film.release_year > 2000 AND film.release_year < 2010) AND (film.length > 70 AND film.length < 80) AND (film.language_id = 1 OR film.language_id=5) AND (film.rating = 'G' OR film.rating = 'R' OR film.rating = 'NC-17') LIMIT 40; 

SELECT 'Use of IN' AS 'INFO';

SELECT film.title, film.rating, film.description, film.release_year, film.length, film.language_id FROM film WHERE (film.release_year > 2000 AND film.release_year < 2010) AND (film.length > 70 AND film.length < 80) AND (film.language_id IN (1,5)) AND (film.rating IN ('G','R','NC-17')) LIMIT 40; 

SELECT 'Use of BETWEEN' AS 'INFO';

SELECT film.title, film.rating, film.description, film.release_year, film.length, film.language_id FROM film WHERE (film.release_year BETWEEN 2000 AND 2010) AND (film.length BETWEEN 70 AND 80) AND (film.language_id IN (1,5)) AND (film.rating IN ('G','R','NC-17')) LIMIT 40; 

SELECT 'INTRODUCTION TO SUB QUERY' AS 'INFO';

SELECT film.title, film.rating, film.description, film.release_year, film.length, film.language_id FROM film WHERE (film.release_year BETWEEN 2000 AND 2010) AND (film.length BETWEEN 70 AND 80) AND (film.language_id IN ((SELECT language_id FROM language WHERE name='English'),(SELECT language_id FROM language WHERE name='French'),(SELECT language_id FROM language WHERE name='Italian'))) AND (film.rating IN ('G','R','NC-17')) ORDER BY film_languageid DESC LIMIT 40; 

SELECT 'INTRODUCTION TO SUB QUERY WITH VARIABLE' AS 'INFO';

SET @FRENCH_ID=(SELECT language_id FROM language WHERE name = 'French'); 
SET @ENGLISH_ID=(SELECT language_id FROM language WHERE name = 'English');
SET @ITALIAN_ID=(SELECT language_id FROM language WHERE name = 'Italian');

SELECT 'INTRODUCTION TO SUB QUERY USING VARIABLES' AS 'INFO';

SELECT film.title, film.rating, film.description, film.release_year, film.length, film.language_id FROM film WHERE (film.release_year BETWEEN 2000 AND 2010) AND (film.length BETWEEN 70 AND 80) AND (film.language_id IN (@FRENCH_ID, @ENGLISH_ID, @ITALIAN_ID)) AND (film.rating IN ('G','R','NC-17')) ORDER BY film_languageid DESC LIMIT 40; 
