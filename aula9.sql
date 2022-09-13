use sakila;

SELECT 'creating a view' as 'log';

CREATE
    VIEW select_all_actors/*view é uma abstração, é como uma função, temos um código que vamos 
    usar várias vezes ao longo da estrututra do nosso código, para não ficar ctrl c ctrl v. 
    No caso o VIEW vc compacta a query, toda vez que chamar a view va estar chamando tal query*/
as (
    SELECT actor.first_name FROM actor
);

SELECT 'using' as 'log';

SELECT * FROM select_all_actors;