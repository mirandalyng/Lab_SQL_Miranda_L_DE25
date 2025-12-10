SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    fa.film_id
FROM
    staging.actor a
    INNER JOIN staging.film_actor fa ON fa.actor_id = a.actor_id;