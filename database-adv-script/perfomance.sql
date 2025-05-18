-- Initial inefficient query
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name AS guest_first_name,
    u.last_name AS guest_last_name,
    u.email AS guest_email,
    p.property_id,
    p.title AS property_title,
    p.location->>'city' AS property_city,
    p.price_per_night,
    h.first_name AS host_first_name,
    h.last_name AS host_last_name,
    py.payment_id,
    py.amount,
    py.payment_method,
    py.status AS payment_status,
    r.rating,
    r.comment
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
JOIN 
    users h ON p.host_id = h.user_id
LEFT JOIN 
    payments py ON b.booking_id = py.booking_id
LEFT JOIN 
    reviews r ON b.booking_id = r.booking_id
ORDER BY 
    b.start_date DESC;

-- Optimized booking details query
WITH booking_core AS (
    SELECT 
        b.booking_id,
        b.start_date,
        b.end_date,
        b.total_price,
        b.status,
        b.user_id,
        b.property_id,
        p.host_id,
        p.title AS property_title,
        p.location->>'city' AS property_city
    FROM 
        bookings b
    JOIN 
        properties p ON b.property_id = p.property_id
    WHERE
        b.start_date >= CURRENT_DATE - INTERVAL '6 months'
)
SELECT 
    bc.booking_id,
    bc.start_date,
    bc.end_date,
    bc.total_price,
    bc.status,
    bc.property_title,
    bc.property_city,
    -- Guest details
    gu.first_name AS guest_first_name,
    gu.last_name AS guest_last_name,
    gu.email AS guest_email,
    -- Host details
    ho.first_name AS host_first_name,
    ho.last_name AS host_last_name,
    -- Payment details (if exists)
    py.amount,
    py.payment_method,
    py.status AS payment_status
FROM 
    booking_core bc
JOIN 
    users gu ON bc.user_id = gu.user_id
JOIN 
    users ho ON bc.host_id = ho.user_id
LEFT JOIN 
    payments py ON bc.booking_id = py.booking_id
ORDER BY 
    bc.start_date DESC
LIMIT 1000;



-- Example: Find available properties in Paris
EXPLAIN ANALYZE
SELECT * FROM properties
WHERE location->>'city' = 'Paris'
AND is_available = TRUE
ORDER BY price_per_night;


-- Regularly analyze tables for query planner statistics
ANALYZE users;
ANALYZE properties;
ANALYZE bookings;
