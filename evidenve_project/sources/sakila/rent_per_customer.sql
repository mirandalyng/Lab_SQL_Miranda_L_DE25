SELECT
    c.first_name,
    c.last_name,
    i.film_id,
    r.customer_id,
    f.title
FROM
    staging.film f
    INNER JOIN staging.inventory i ON i.film_id = f.film_id
    INNER JOIN staging.rental r ON r.inventory_id = i.inventory_id
    INNER JOIN staging.customer c ON c.customer_id = r.customer_id;