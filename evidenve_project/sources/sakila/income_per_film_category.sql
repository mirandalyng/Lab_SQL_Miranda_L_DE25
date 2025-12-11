SELECT
    ca.name AS film_category_name,
    p.amount
FROM
    staging.category ca
    INNER JOIN staging.film_category fc ON fc.category_id = ca.category_id
    INNER JOIN staging.film f ON f.film_id = fc.film_id
    INNER JOIN staging.inventory i ON i.film_id = f.film_id
    INNER JOIN staging.rental r ON r.inventory_id = i.inventory_id
    INNER JOIN staging.payment p ON p.rental_id = r.rental_i;