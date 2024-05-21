USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
#Uso SELECT DISTINCT para eliminar duplicados en los resultados.

SELECT DISTINCT title
FROM sakila.film;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
# Utilizo WHERE para filtrar las películas con clasificación "PG-13"

SELECT 
	title, 
    rating 
FROM film
WHERE rating = "PG-13";

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
# Empleo de LIKE para buscar la palabra "amazing" en la columna description.

SELECT 
	title, 
	description
FROM film 
WHERE description LIKE "%amazing%";

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
# Uso de la cláusula WHERE para seleccionar películas con una duración (length) mayor a 120 minutos.

SELECT title
FROM film
WHERE length > 120;

-- 5. Recupera los nombres de todos los actores.
# Selección simple de las columnas first_name y last_name de la tabla actor.

SELECT first_name, last_name
FROM actor
ORDER BY first_name;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
# Empleo de LIKE para buscar el apellido "Gibson" en la columna last_name.

SELECT 
	first_name, 
    last_name 
FROM actor
WHERE last_name LIKE "Gibson"
ORDER BY first_name;

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
# Utilización de BETWEEN para filtrar los actor_id entre 10 y 20.
SELECT 
	first_name, 
    last_name 
FROM actor
WHERE actor_id BETWEEN 10 and 20
ORDER BY first_name;

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
# Uso de la láusula NOT IN para excluir películas con clasificación "R" y "PG-13".

SELECT title
FROM film
WHERE rating NOT IN ("R", "PG-13");

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
# Empleo de GROUP BY junto con COUNT para agrupar las películas por su clasificación (rating).

SELECT 
	rating, 
	COUNT(*) AS total_films
FROM film
GROUP BY rating
ORDER BY rating;

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
# Realización de un JOIN entre las tablas customer y rental y uso de GROUP BY para contar las películas alquiladas por cada cliente.

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
# Empleo de las cláusulas INNER JOIN, COUNT, GROUP BY y ORDER BY en una consulta SQL para contar los alquileres por categoría.

SELECT 
    c.name AS category_name,
    COUNT(r.rental_id) AS total_rents
FROM 
    category c
    INNER JOIN film_category fc ON c.category_id = fc.category_id
    INNER JOIN film f ON fc.film_id = f.film_id
    INNER JOIN inventory i ON f.film_id = i.film_id
    INNER JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    c.name
ORDER BY 
    total_rents DESC;

-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
# Utilización de AVG junto con GROUP BY para calcular el promedio de duración de las películas por clasificación.

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
# Realización de un JOIN entre las tablas actor, film_actor, y film para encontrar los actores en la película "Indian Love".

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
# Utilización de LIKE junto con OR para buscar las palabras "dog" o "cat" en la descripción.

SELECT 
    title, description
FROM 
    film
WHERE 
    UPPER(description) LIKE "%DOG%" OR UPPER(description) LIKE "%CAT%";

-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor. 
# Empleo de LEFT JOIN y WHERE para encontrar actores que no tienen registros en film_actor.

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
# Empleo de BETWEEN para seleccionar películas lanzadas entre 2005 y 2010.

SELECT 
    title, release_year
FROM 
    film
WHERE 
    release_year BETWEEN 2005 AND 2010;
    
-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
# Realización de un JOIN entre film_category y category y una subconsulta dentro de WHERE para encontrar las películas de la categoría "Family".

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
        WHERE name = "Family"
    );

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
# Empleo de JOIN y GROUP BY junto con HAVING para encontrar actores que han aparecido en más de 10 películas.

SELECT 
	a.first_name, 
    a.last_name 
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING 
    COUNT(fa.film_id) > 10;

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
# Uso de WHERE para filtrar las películas con clasificación "R" y duración mayor a 120 minutos.

SELECT 
    title
FROM 
    film
WHERE 
    rating = "R"
    AND length > 120;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
# Uso de una CTE (WITH) para calcular el promedio de duración por categoría y luego filtramos las categorías con un promedio superior a 120 minutos.

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
# Se hace INNER JOIN entre actor y film_actor para obtener los actores y las películas en las que han actuado. Luego, se agrupan por actor_id y se cuenta el número de películas por actor, filtrando los que han actuado en al menos 5 películas mediante HAVING.

SELECT 
	a.first_name, 
    a.last_name,
    COUNT(fa.film_id) AS film_count
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY 
	a.actor_id, 
    a.first_name, 
    a.last_name
HAVING 
    COUNT(fa.film_id) >= 5
ORDER BY 
	film_count DESC;
    
-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.
# Uso de una subconsulta para encontrar rental_id de las rentas con una duración superior a 5 días calculada con TIMESTAMPDIFF(DAY, rental_date, return_date) > 5. Después empleo de INNER JOIN entre film, inventory, y rental para obtener los títulos de las películas correspondientes.

SELECT DISTINCT f.title 
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
WHERE 
	r.rental_id IN (
    SELECT rental_id
    FROM rental r
	WHERE TIMESTAMPDIFF(DAY, rental_date, return_date) > 5
); 

-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.
# Realización de una subconsulta para obtener los actor_id de actores que han actuado en películas de la categoría "Horror". Luego, uso de NOT IN en la consulta principal para excluir estos actores, obteniendo así los actores que no han actuado en ninguna película de "Horror".

SELECT
    a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT fa.actor_id
    FROM film_actor fa
    INNER JOIN film_category fc ON fa.film_id = fc.film_id
    INNER JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = "Horror"
)
ORDER BY a.first_name;

-- BONUS
-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.
# Empleo de un INNER JOIN entre film, film_category, y category para encontrar las películas que son comedias (c.name = "Comedy") y tienen una duración mayor a 180 minutos (length > 180).

SELECT title
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
WHERE c.name = "Comedy" AND length > 180;
	
-- 25. Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos. 
# Se hace un SELF JOIN en la tabla film_actor para encontrar pares de actores que han actuado en la misma película (fa1.film_id = fa2.film_id). Se asegura que cada par se cuenta solo una vez usando la condición fa1.actor_id < fa2.actor_id. Se unen las tablas actor para obtener los nombres de los actores y se agrupan los resultados para contar el número de películas en las que han actuado juntos.

SELECT 
    a1.first_name AS actor1_first_name,
    a1.last_name AS actor1_last_name,
    a2.first_name AS actor2_first_name,
    a2.last_name AS actor2_last_name,
    COUNT(*) AS number_of_movies_together
FROM 
    film_actor fa1
JOIN 
    film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN 
    actor a1 ON fa1.actor_id = a1.actor_id
JOIN 
    actor a2 ON fa2.actor_id = a2.actor_id
GROUP BY 
    a1.actor_id, a1.first_name, a1.last_name, 
    a2.actor_id, a2.first_name, a2.last_name
ORDER BY 
	number_of_movies_together DESC;