SELECT * FROM film;

-- 1. How many actors are there with the last name ‘Wahlberg’?

-- Answer: 2

SELECT COUNT(last_name)
FROM actor
WHERE last_name = 'Wahlberg';



-- 2. How many payments were made between $3.99 and $5.99?

-- Answer: 1

SELECT COUNT(payment_id)
FROM payment
WHERE amount > 3.99 and amount < 5.99;



-- 3. What film does the store have the most of? (search in inventory)

-- Answer: there are 2 stores, and each store has a large number of movies whose inventory equals to 4 (please see code below for list of movies)

SELECT film.title, inventory.store_id, COUNT(inventory.film_id)
FROM inventory
LEFT OUTER JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title, inventory.store_id
ORDER BY COUNT(inventory.film_id) DESC, inventory.store_id DESC, title ASC;



-- 4. How many customers have the last name ‘William’?

-- Answer: 0

SELECT COUNT(last_name)
FROM customer
WHERE last_name = 'William';



-- 5. What store employee (get the id) sold the most rentals?

-- Answer: id 1 (Mike Hillyer) with 8040 rentals

SELECT rental.staff_id, CONCAT(staff.first_name,' ',staff.last_name), COUNT(rental_id)
FROM rental
LEFT OUTER JOIN staff ON rental.staff_id = staff.staff_id
GROUP BY rental.staff_id, staff.first_name, staff.last_name
ORDER BY COUNT(rental_id) DESC;



-- 6. How many different district names are there?

-- Answer: 378

SELECT COUNT(DISTINCT district)
FROM address;



-- 7. What film has the most actors in it? (use film_actor table and get film_id)

-- Answer: film with id 508 (Lambs Cincinatti)

SELECT film_actor.film_id, film.title, COUNT(film_actor.actor_id)
FROM film_actor
LEFT OUTER JOIN film ON film_actor.film_id = film.film_id
GROUP BY film_actor.film_id, film.title
ORDER BY COUNT(film_actor.actor_id) DESC;

-- Note that I don't use LIMIT 1 here because it is possible that more than 1 film will have the most actors in it (in which case SQL will only return the top row of the query, leaving the other option(s) out)



-- 8. From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)

-- Answer: 13

SELECT COUNT(last_name)
FROM customer
WHERE last_name LIKE '%es' AND store_id = 1



-- 9. How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers
-- with ids between 380 and 430? (use group by and having > 250)

-- Answer: 3 (but the amounts are all negative); otherwise, 0 (if only considering positive amounts)

SELECT amount, COUNT(rental_id)
FROM payment
WHERE customer_id >= 380 and customer_id <= 430
GROUP BY amount
HAVING COUNT(rental_id) > 250;

SELECT amount, COUNT(rental_id)
FROM payment
WHERE customer_id >= 380 AND customer_id <= 430 AND amount > 0
GROUP BY amount
HAVING COUNT(rental_id) > 250;



-- 10. Within the film table, how many rating categories are there? And what rating has the most
-- movies total?

-- Answer: 5 rating categories, PG-13 has the most films (223)

SELECT COUNT(DISTINCT rating)
FROM film;

SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;

-- Note that I don't use LIMIT 1 here because it is possible that more than 1 rating will have the most films (in which case SQL will only return the top row of the query, leaving the other option(s) out)