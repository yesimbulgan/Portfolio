SELECT * FROM film
SELECT * FROM payment


-- Total Number of Films
SELECT COUNT(*) AS Total_Films FROM film



-- Number of Films by Rating
SELECT "rating", COUNT(*) AS Count FROM film
GROUP BY "rating"



-- Average Amount by Customer_id
SELECT "customer_id", AVG("amount") AS "Avg_Selling_Price"
FROM payment
GROUP BY "customer_id"
ORDER BY "customer_id"



-- Top 5 Most Films by rental rate
SELECT "title", "rental_rate" FROM film
ORDER BY "rental_rate" DESC



-- Films with over 10.00 Replacement Cost
SELECT "title", "replacement_cost", "release_year"
FROM film
WHERE "replacement_cost" > 10.00  
ORDER BY "replacement_cost" DESC



-- Payment Details with Customer First Names
SELECT payment_id, payment.customer_id, first_name
FROM customer
INNER JOIN payment ON
payment.customer_id = customer.customer_id



-- City Details with Country Info
SELECT  city_id, city.country_id, city.country_id city
FROM city
INNER JOIN country ON 
city.country_id = country.country_id



-- Null Inventory and Store ID
SELECT film.film_id, title, inventory_id, store_id
FROM film
LEFT JOIN inventory ON
inventory.film_id = film.film_id
WHERE inventory.film_id IS NULL



-- Payment Date
SELECT payment.rental_id, payment_date
FROM payment
LEFT JOIN rental ON
rental.rental_id = payment.rental_id
GROUP BY
payment.rental_id,
payment_date


-- Rental Date
SELECT rental.rental_id, rental_date
FROM rental
RIGHT JOIN payment ON
payment.rental_id = rental.rental_id
GROUP BY
rental.rental_id,
rental_date



-- Rental Date Rankings per Customer
SELECT 
    rental_id, 
	customer_id,
    rental_date,
    ROW_NUMBER() OVER (ORDER BY rental_date) AS RentDate_ROW,
    RANK() OVER (ORDER BY rental_date) AS RentDate_RANK,
    DENSE_RANK() OVER (ORDER BY rental_date) AS RentDate_DENSE_RANK
FROM rental