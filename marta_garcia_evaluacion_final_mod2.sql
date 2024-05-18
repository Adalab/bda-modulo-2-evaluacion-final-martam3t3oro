USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
SELECT DISTINCT title
FROM sakila.film;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT 
	title, 
    rating 
FROM film
WHERE rating = "PG-13";

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
SELECT 
	title, 
	description
FROM film 
WHERE description LIKE "%amazing%";

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
SELECT title
FROM film
WHERE length > 120;

-- 5. Recupera los nombres de todos los actores.
SELECT first_name, last_name
FROM actor
ORDER BY first_name;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT 
	first_name, 
    last_name 
FROM actor
WHERE last_name LIKE "Gibson"
ORDER BY first_name;

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT 
	first_name, 
    last_name 
FROM actor
WHERE actor_id BETWEEN 10 and 20
ORDER BY first_name;

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
SELECT title
FROM film
WHERE rating NOT IN ('R', 'PG-13');

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
SELECT 
	rating, 
	COUNT(*) AS total_films
FROM film
GROUP BY rating
ORDER BY rating;

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
SELECT 
    c.customer_id, 
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_rents
FROM 
    customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
GROUP BY 
    c.customer_id, 
    c.first_name, 
    c.last_name
ORDER BY 
   total_rents DESC;

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
SELECT 
    c.name AS category_name,
    (
        SELECT COUNT(*)
        FROM film f
        WHERE f.film_id IN (
            SELECT film_id
            FROM film_category
            WHERE category_id = c.category_id
        )
    ) AS total_rents
FROM 
    category c
ORDER BY 
    total_rents DESC;

-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
SELECT 
    f.rating,
    ROUND(AVG(f.length),2) AS AVG_length
FROM 
    film f
GROUP BY 
    f.rating
ORDER BY 
    f.rating;

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
SELECT 
    a.first_name,
    a.last_name
FROM 
    actor a
INNER JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN 
    film f ON fa.film_id = f.film_id
WHERE 
    f.title = "Indian Love";

-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
SELECT 
    title, description
FROM 
    film
WHERE 
    UPPER(description) LIKE '%DOG%' OR UPPER(description) LIKE '%CAT%';

-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.
SELECT 
    a.actor_id,
    a.first_name,
    a.last_name
FROM 
    actor a
LEFT JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
WHERE 
    fa.actor_id IS NULL;
    
-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
SELECT 
    title, release_year
FROM 
    film
WHERE 
    release_year BETWEEN 2005 AND 2010;
    
-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
SELECT 
    f.title
FROM 
    film f
INNER JOIN 
    film_category fc ON f.film_id = fc.film_id
WHERE 
    fc.category_id = (
        SELECT category_id
        FROM category
        WHERE name = 'Family'
    );

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
SELECT 
	a.first_name, 
    a.last_name 
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING 
    COUNT(fa.film_id) > 10;

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
SELECT 
    title
FROM 
    film
WHERE 
    rating = 'R'
    AND length > 120;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
WITH Category_AVG_Duration AS (
    SELECT 
        c.name AS category_name,
        AVG(f.length) AS AVG_duration
    FROM 
        category c
    JOIN 
        film_category fc ON c.category_id = fc.category_id
    JOIN 
        film f ON fc.film_id = f.film_id
    GROUP BY 
        c.name
)
SELECT 
    category_name,
    AVG_duration
FROM 
    Category_AVG_Duration
WHERE 
    AVG_duration > 120;

-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.
-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.
-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.

-- BONUS
-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.
-- 25. Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos. 

SELECT *
FROM category;
