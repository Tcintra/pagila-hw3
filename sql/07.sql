/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

SELECT first_name || ' ' || last_name as "Actor Name"
FROM actor
JOIN film_actor USING (actor_id)
WHERE
    film_id IN (
        SELECT DISTINCT film_id
        FROM actor
        JOIN film_actor USING (actor_id)
        WHERE
            actor_id IN (
                SELECT DISTINCT actor_id
                FROM actor
                JOIN film_actor USING (actor_id)
                WHERE 
                    film_id IN (
                        SELECT DISTINCT film_id
                        FROM film_actor
                        JOIN actor USING (actor_id)
                        WHERE first_name = 'RUSSELL'
                          AND last_name = 'BACALL'
                    )   
            )
        )
    AND actor_id NOT IN (
                SELECT DISTINCT actor_id
                FROM actor
                JOIN film_actor USING (actor_id)
                WHERE
                    film_id IN (
                        SELECT DISTINCT film_id
                        FROM film_actor
                        JOIN actor USING (actor_id)
                        WHERE first_name = 'RUSSELL'
                          AND last_name = 'BACALL'
                    )
                )
    AND NOT (first_name = 'RUSSELL' AND  last_name = 'BACALL')
GROUP BY "Actor Name"
ORDER BY "Actor Name";
