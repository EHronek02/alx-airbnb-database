-- Count bookings per user with Group by
SELECT
    u.user_id,
	u.first_name,
	u.last_name,
	COUNT(b.booking_id) AS total_bookings,
	SUM(b.total_price) AS total_spent
FROM users u
LEFT JOIN bookings b on u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

-- WIndow functions to rank properties by booking count
SELECT
	property_id,
	title,
	COUNT(*) AS total_bookings,
	ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS row_number_rank,
	RANK() OVER (ORDER BY COUNT(*) DESC) AS property_rank
FROM bookings
GROUP BY property_id
ORDER BY total_bookings DESC;
