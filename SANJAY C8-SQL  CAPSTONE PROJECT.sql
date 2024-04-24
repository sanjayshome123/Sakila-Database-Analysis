use sakila;

-- Task1 Display the full names of all actors available in the database.
select concat(first_name,' ',last_name) as 'Full Name' from actor;
-- Full name of actors are shown 200 rows in the output by the concat function.

-- Task2.1 Display the number of times each first name appears in the database
select first_name,count(first_name) from actor group by first_name;
-- The first name of actors along with the count of repeated first names are 128 rows are shown in the output.

-- Task2.2 count of actors that have unique first names in the database.
select distinct first_name from actor;
-- The unique first names of the actors are shown in the output.

-- Task3.1 Display the number of times each last names appears in the database.
select last_name,count(last_name) from actor group by last_name;
-- The last name of actors along with the count of repeated last names are shown in the output.

-- Task3.2 Display all unique last names in the database.
select distinct last_name from actor;

-- The unique last names of the actors are shown in the output.

-- Task 4.1 Display the list of records for the movies with the Rating "R".
select film_id,title,rating from film where rating = 'R';
-- Their are 195 movie title which are coming under "R" category.

-- Task 4.2 Display the list of records for the movies that are not Rated "R".
select film_id,title,rating from film where rating != 'R';
-- Their are 805  movie title which are other than  "R" category.

-- Task 4.3  Display the list of records for the movies that are suitable for audience below 13 years of age.
select film_id,title,rating from film where rating = 'G';
-- Their are 178  movie title which can be watch by the audience below 13 years of age.alter

-- Task 5.1 Display the list of records for the movies where the replacement cost is up to $11.
select title,replacement_cost from film where replacement_cost <=11;
-- There are 90 movie title where the replacement cost is up to $11.

-- Task 5.2 Display the list of records for the movies where the replacement cost is between $11 and $20.
select title,replacement_cost from film where replacement_cost between 11 and 20;
-- There are 424 rows movie title where the replacement cost is between $11 and $20.

-- Task 5.3 Display the list of records for all the movies in descending orders of their replacement costs.
select title,replacement_cost from film order by replacement_cost desc;
-- The list of records for all the movies in descending order are shown in the figure.

-- Task 6 Display the names of the TOP 3 movies with the greatest number of actors.
SELECT 
    film.title,
    COUNT(actor.actor_id) AS actor_count
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY film.film_id, film.title
ORDER BY actor_count DESC
LIMIT 3;
-- There are 

-- Task 7 Display the titles of the movies starting with the letters 'K' and 'Q'.
SELECT title
FROM film
WHERE title LIKE 'K%' OR title LIKE 'Q%'
ORDER BY title;
-- There are 15 rows movies titles are shown in the figure.

-- Task 8 The fim 'Agent Truman' has been a  great sucess,Display the name of all actors who  appeared in this film.

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Agent Truman';
-- There are 7 actors who appered in the film.

-- Task 9 Sales have  been lagging among young families,so the mangement wants to promote family movies.identify all the movies categorized as family films.

SELECT f.film_id, f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Family';


-- Task 10.1 Display the max,min,and average rental rate of  movies based on their ratings.the output must be sorted in the descending order of the verage rental rates. 

SELECT f.rating,
       MAX(f.rental_rate) AS max_rental_rate,
       MIN(f.rental_rate) AS min_rental_rate,
       AVG(f.rental_rate) AS avg_rental_rate
FROM film f
GROUP BY f.rating
ORDER BY avg_rental_rate DESC;


-- Task10.2 Display the movies in the descending order of their frequencies,so the mangement can maintain more copies of those movies.

SELECT f.title, COUNT(r.rental_id) AS rental_frequency
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY rental_frequency DESC;

 -- TASK 11 Display in how many category the differencec between the average film replacement cost and the average rent in more than 15
  
SELECT 
    Name,
    ROUND(AVG(replacement_cost), 2) AS AverageReplacementCost,
    ROUND(AVG(rental_rate), 2) AS AverageRentalRate,
    AVG(replacement_cost) - AVG(rental_rate) AS Difference
FROM
    category c
        INNER JOIN
    film_category fc ON fc.category_id = c.category_id
        INNER JOIN
    film f ON f.film_id = fc.film_id
GROUP BY Name
HAVING Difference > 15
ORDER BY Difference DESC;	  
            
  -- TASK 12 Display the film category where the number of movies is greater than 70

SELECT 
    Name, COUNT(title) AS Num_Of_Movies
FROM
    film f
        INNER JOIN
    film_category fc ON f.film_id = fc.film_id
        INNER JOIN
    category c ON c.category_id = fc.category_id
GROUP BY Name
HAVING Num_Of_Movies > 70
ORDER BY Num_Of_Movies DESC;





