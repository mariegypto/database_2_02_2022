USE sakila;

SET @ID_CUSTOMER_SELECTED = (SELECT customer.customer_id FROM customer WHERE customer.email = 'KIM.CRUZ@sakilacustomer.org');

SELECT @ID_CUSTOMER_SELECTED AS 'ID_CUSTOMER_SELECTED';

SELECT
    actor.first_name,
    actor.last_name
FROM
    actor
WHERE
    actor.actor_id IN(
        SELECT 
            film_actor.actor_id
        FROM
            film_actor
        WHERE  
            film_actor.film_id IN(
                SELECT 
                    film.film_id
                FROM
                    film
                WHERE
                    film.film_id IN(
                        SELECT 
                            inventory.film_id 
                        FROM 
                            inventory 
                        WHERE 
                            inventory.inventory_id IN (
                                SELECT 
                                    rental.inventory_id 
                                FROM 
                                    rental
                                WHERE
                                    rental.customer_id = (
                                        SELECT 
                                            customer.customer_id 
                                        FROM 
                                            customer 
                                        WHERE 
                                            customer.email = 'KIM.CRUZ@sakilacustomer.org'
                                        )
                            )
                    )
        )
    );

CREATE INDEX idx_film ON film(title);

EXPLAIN 
SELECT 
    film.title
FROM 
    customer 
INNER JOIN 
    rental ON customer.customer_id  = rental.customer_id
INNER JOIN
    inventory ON inventory.inventory_id = rental.inventory_id 
INNER JOIN 
    film ON film.film_id = inventory.film_id
WHERE 
    customer.email= 'JENNIFER.DAVIS@sakilacustomer.org';

SHOW INDEX FROM customer;
SHOW INDEX FROM inventory;
SHOW INDEX FROM film;
SHOW INDEX FROM rental;

