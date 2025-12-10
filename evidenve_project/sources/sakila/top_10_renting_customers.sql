SELECT
    c.first_name,
    c.last_name,
    p.customer_id,
    p.amount
FROM
    staging.payment p
    INNER JOIN staging.customer c ON c.customer_id = p.customer_id;