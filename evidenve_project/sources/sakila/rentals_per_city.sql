SELECT
    ci.city,
    r.rental_id AS rental_count
FROM
    staging.city ci
    INNER JOIN staging.address ad ON ad.city_id = ci.city_id
    INNER JOIN staging.customer c ON c.address_id = ad.address_id
    INNER JOIN staging.rental r ON r.customer_id = c.customer_id