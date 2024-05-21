# EVALUACIÓN MÓDULO 2

En este proyecto se resuelven 25 ejercicios relacionados con la BBDD Sakila 
Esta base de datos de ejemplo simula una tienda de alquiler de películas. 
Contiene tablas como film (películas), actor (actores), customer (clientes), rental (alquileres), category (categorías), entre otras. Estas tablas contienen información sobre películas, actores, clientes, alquileres y más, y se utilizan para realizar consultas y análisis de datos en el contexto de una tienda de alquiler de películas.

## Explicación de la resolución de los ejercicios

1. Seleccionar todos los nombres de las películas sin que aparezcan duplicados.

Descripción: Este ejercicio se centra en el uso de SELECT DISTINCT para eliminar duplicados en los resultados.

2. Mostrar los nombres de todas las películas que tengan una clasificación de "PG-13".

Descripción: Utilizamos la cláusula WHERE para filtrar las películas con clasificación "PG-13".

3. Encontrar el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

Descripción: Empleamos la cláusula LIKE para buscar la palabra "amazing" en la columna description.

4. Encontrar el título de todas las películas que tengan una duración mayor a 120 minutos.

Descripción: Utilizamos la cláusula WHERE para seleccionar películas con una duración (length) mayor a 120 minutos.

5. Recuperar los nombres de todos los actores.

Descripción: Realizamos una simple selección de las columnas first_name y last_name de la tabla actor.

6. Encontrar el nombre y apellido de los actores que tengan "Gibson" en su apellido.

Descripción: Usamos LIKE para buscar el apellido "Gibson" en la columna last_name.

7. Encontrar los nombres de los actores que tengan un actor_id entre 10 y 20.

Descripción: Utilizamos BETWEEN para filtrar los actor_id entre 10 y 20.

8. Encontrar el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

Descripción: Empleamos la cláusula NOT IN para excluir películas con clasificación "R" y "PG-13".

9. Encontrar la cantidad total de películas en cada clasificación de la tabla film y mostrar la clasificación junto con el recuento.

Descripción: Usamos GROUP BY junto con COUNT para agrupar las películas por su clasificación (rating).

10. Encontrar la cantidad total de películas alquiladas por cada cliente y mostrar el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

Descripción: Realizamos un JOIN entre las tablas customer y rental y utilizamos GROUP BY para contar las películas alquiladas por cada cliente.

11. Encontrar la cantidad total de películas alquiladas por categoría y mostrar el nombre de la categoría junto con el recuento de alquileres.

Descripción: Empleamos las cláusulas INNER JOIN, COUNT, GROUP BY y ORDER BY en una consulta SQL para contar los alquileres por categoría.

12. Encontrar el promedio de duración de las películas para cada clasificación de la tabla film y mostrar la clasificación junto con el promedio de duración.

Descripción:  Utilizamos AVG junto con GROUP BY para calcular el promedio de duración de las películas por clasificación.

13. Encontrar el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

Descripción: Realizamos un JOIN entre las tablas actor, film_actor, y film para encontrar los actores en la película "Indian Love".

14. Mostrar el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

Descripción: Usamos LIKE junto con OR para buscar las palabras "dog" o "cat" en la descripción.

15. Encontrar si hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.

Descripción: Utilizamos LEFT JOIN y WHERE para encontrar actores que no tienen registros en film_actor.

16. Encontrar el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

Descripción: Utilizamos BETWEEN para seleccionar películas lanzadas entre 2005 y 2010.

17. Encontrar el título de todas las películas que son de la misma categoría que "Family".

Descripción: Realizamos un JOIN entre film_category y category y una sencilla subconsulta dentro de WHERE para encontrar las películas de la categoría "Family".

18. Mostrar el nombre y apellido de los actores que aparecen en más de 10 películas.

Descripción: Utilizamos JOIN y GROUP BY junto con HAVING para encontrar actores que han aparecido en más de 10 películas.

19. Encontrar el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

Descripción:  Utilizamos WHERE para filtrar las películas con clasificación "R" y duración mayor a 120 minutos.

20. Encontrar las categorías de películas que tienen un promedio de duración superior a 120 minutos y mostrar el nombre de la categoría junto con el promedio de duración.

Descripción: Utilizamos una CTE (WITH) para calcular el promedio de duración por categoría y luego filtramos las categorías con un promedio superior a 120 minutos.

21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.

Descripción: se utiliza una combinación de INNER JOIN entre actor y film_actor para obtener los actores y las películas en las que han actuado. Luego, se agrupan por actor_id y se cuenta el número de películas por actor, filtrando los que han actuado en al menos 5 películas mediante HAVING.

22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.
Descripción: se usa una subconsulta para encontrar rental_id de las rentas con una duración superior a 5 días calculada con TIMESTAMPDIFF(DAY, rental_date, return_date) > 5. Luego, se hace un INNER JOIN entre film, inventory, y rental para obtener los títulos de las películas correspondientes.

23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.
Descripción: se realiza una subconsulta para obtener los actor_id de actores que han actuado en películas de la categoría "Horror". Luego, se usa NOT IN en la consulta principal para excluir estos actores, obteniendo así los actores que no han actuado en ninguna película de "Horror".

24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.
Descripción: se utiliza un INNER JOIN entre film, film_category, y category para encontrar las películas que son comedias (c.name = "Comedy") y tienen una duración mayor a 180 minutos (length > 180).

25. Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos. 
Descripción: se hace un SELF JOIN en la tabla film_actor para encontrar pares de actores que han actuado en la misma película (fa1.film_id = fa2.film_id). Se asegura que cada par se cuenta solo una vez usando la condición fa1.actor_id < fa2.actor_id. Se unen las tablas actor para obtener los nombres de los actores y se agrupan los resultados para contar el número de películas en las que han actuado juntos.

## Créditos

Marta García Palomo, alumna de la promo promo-a-da de Adalab# bda-modulo-2-evaluacion-final-martam3t3oro
