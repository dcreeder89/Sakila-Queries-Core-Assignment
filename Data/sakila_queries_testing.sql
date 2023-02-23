USE sakila;

# 1. What query would you run to get all the customers inside city_id = 312? Your 
#query should return the customers' first name, last name, email, address, and city.
SELECT cu.first_name, cu.last_name, cu.email, a.address, ci.city
FROM customer AS cu
	JOIN address AS a
    ON cu.address_id = a.address_id
    JOIN city AS ci
    ON ci.city_id = a.city_id
WHERE ci.city_id = 312;


# 2. What query would you run to get all comedy films? Note that the genre is called 
#the category in this schema. Your query should return film title, description, 
#release year, rating, and special features.
SELECT * FROM category;
SELECT * FROM film;
SELECT * FROM film_category;

SELECT f.title, f.description, f.release_year, f.rating, f.special_features
FROM film as f
	JOIN film_category
    ON film_category.film_id = f.film_id
    JOIN category
    ON category.category_id = film_category.category_id
WHERE category.name = "Comedy";


# 3. What query would you run to get all the films that Johnny Lollobrigida was in? 
#Your query should return the actor's last name, film title, and release year.
SELECT * FROM film_actor;
SELECT * FROM actor;

SELECT a.last_name, f.title, f.release_year
FROM actor AS a
	JOIN film_actor
    ON film_actor.actor_id = a.actor_id
    JOIN film AS f
    ON f.film_id = film_actor.film_id
WHERE a.last_name = "Lollobrigida"
AND a.first_name = "Johnny";


# 4. What query would you run to get the first and last names of all the actors 
#in the movie titled "Bingo Talented"?
SELECT a.first_name, a.last_name, film.title
FROM actor AS a
	JOIN film_actor
    ON film_actor.actor_id = a.actor_id
    JOIN film
    ON film.film_id = film_actor.film_id
WHERE film.title = "BINGO TALENTED";


# 5. What query would you run to get the customer_id associated with all payments 
#greater than twice the average payment amount? (HINT: use 2* in your query to get 
#twice the amount). Your result should include the customer id and the amount.
SELECT customer_id, amount
FROM payment
HAVING amount > 2*(SELECT AVG(amount) FROM payment);



# 6. What query would you run to list the first and last names of the 5 customers 
#who have the highest number(count) of payments? You can title the number of 
#payments as num_payments.
SELECT * FROM payment;

SELECT customer_id, COUNT(*)
FROM payment
GROUP BY customer_id;

SELECT DISTINCT customer.first_name, customer.last_name, 
	(SELECT COUNT(*)
	FROM payment
    WHERE payment.customer_id = customer.customer_id
	GROUP BY customer_id) AS num_payments 
FROM customer 
JOIN payment ON payment.customer_id = customer.customer_id
ORDER BY num_payments DESC
LIMIT 5;