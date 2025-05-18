-- Non-correlated subquery to find all properties where the average is
-- greater than 4.0
SELECT
    p.property_id,
	p.title,
	p.price_per_night,
	p.location->>'city' AS city
FROM properties p
WHERE
    p.property_id IN (
	    -- subquery runs first and returns a list
		SELECT r.property_id
		FROM reviews r
		GROUP BY r.property_id
		HAVING AVG(r.rating) > 4.0
	)
ORDER BY p.price_per_night;

-- Correlated subquery to find frequent bookers
SELECT
    u.user_id,
	u.first_name,
	u.last_name,
	u.email,
	(
		-- corelated subquery that counts bookings per user
		SELECT COUNT(*)
		FROM bookings b
		WHERE b.user_id = u.user_id
	) AS booking_count
FROM users u
WHERE
	(
		-- the same subquey used in where clause
		SELECT COUNT(*)
		FROM booking b
		WHERE b.user_id = u.user_id
	) > 3
ORDER BY booking_count DESC;
