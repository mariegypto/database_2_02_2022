USE sakila;

SELECT
    distinct(actor.actor_id),
    actor.first_name,
    actor.last_name
FROM
    customer
INNER JOIN
    rental ON customer.customer_id = rental.customer_id
INNER JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN
    film ON inventory.film_id = film.film_id
INNER JOIN
    film_actor ON film.film_id = film_actor.film_id
INNER JOIN
    actor ON film_actor.actor_id = actor.actor_id
WHERE
    customer.email = 'DOROTHY.TAYLOR@sakilacustomer.org'
GROUP BY 
    actor.actor_id;