SELECT
    c.first_name,
    c.last_name,
    i.film_id,
    r.customer_id
FROM
    staging.inventory i
    INNER JOIN staging.rental r ON r.inventory_id = i.inventory_id
    INNER JOIN staging.customer c ON c.customer_id = r.customer_id;