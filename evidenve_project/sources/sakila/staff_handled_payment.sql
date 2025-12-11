SELECT
    s.staff_id,
    s.first_name,
    s.last_name,
    p.amount
FROM
    staging.payment p
    INNER JOIN staging.staff s ON p.staff_id = s.staff_id;