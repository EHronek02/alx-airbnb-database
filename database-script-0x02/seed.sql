-- 1. Insert sample users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
    ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'John', 'Smith', 'john.smith@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqAZsMjmceh7iJ6F1NAw7WY6DgqFq', '+15551234567', 'guest', '2023-01-15 09:30:00'),
    ('b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Sarah', 'Johnson', 'sarah.j@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqAZsMjmceh7iJ6F1NAw7WY6DgqFq', '+15552345678', 'host', '2023-02-20 14:15:00'),
    ('c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Michael', 'Williams', 'michael.w@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqAZsMjmceh7iJ6F1NAw7WY6DgqFq', '+15553456789', 'host', '2023-03-10 11:00:00'),
    ('d3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Emily', 'Brown', 'emily.b@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqAZsMjmceh7iJ6F1NAw7WY6DgqFq', '+15554567890', 'guest', '2023-04-05 16:45:00'),
    ('e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Admin', 'User', 'admin@airbnbclone.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqAZsMjmceh7iJ6F1NAw7WY6DgqFq', '+15550000000', 'admin', '2023-01-01 00:00:00');

-- 2. Insert amenities
INSERT INTO amenities (amenity_id, name, icon)
VALUES
    ('f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'WiFi', 'wifi'),
    ('f6eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'Pool', 'pool'),
    ('f7eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'Kitchen', 'kitchen'),
    ('f8eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'Parking', 'parking'),
    ('f9eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'Air Conditioning', 'snowflake');

-- 3. Insert properties with realistic locations (using JSONB)
INSERT INTO properties (property_id, host_id, title, description, location, price_per_night, max_guests, is_available, created_at)
VALUES
    ('0a1b2c3d-4e5f-6g7h-8i9j-0k1l2m3n4o5p', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 
     'Cozy Downtown Apartment', 'Modern 1-bedroom apartment in heart of the city', 
     '{"street": "123 Main St", "city": "New York", "state": "NY", "zip": "10001", "country": "USA", "lat": 40.7128, "lng": -74.0060}', 
     120.00, 2, TRUE, '2023-02-25 10:00:00'),
     
    ('1b2c3d4e-5f6g-7h8i-9j0k-1l2m3n4o5p6q', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 
     'Beachfront Villa', 'Luxury 3-bedroom villa with private beach access', 
     '{"street": "456 Ocean Dr", "city": "Miami", "state": "FL", "zip": "33139", "country": "USA", "lat": 25.7617, "lng": -80.1918}', 
     350.00, 6, TRUE, '2023-03-15 14:30:00'),
     
    ('2c3d4e5f-6g7h-8i9j-0k1l-2m3n4o5p6q7r', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 
     'Mountain Cabin Retreat', 'Rustic cabin with stunning mountain views', 
     '{"street": "789 Forest Rd", "city": "Denver", "state": "CO", "zip": "80202", "country": "USA", "lat": 39.7392, "lng": -104.9903}', 
     95.00, 4, TRUE, '2023-04-01 09:15:00');

-- 4. Link properties to amenities
INSERT INTO property_amenities (property_id, amenity_id)
VALUES
    ('0a1b2c3d-4e5f-6g7h-8i9j-0k1l2m3n4o5p', 'f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16'), -- WiFi
    ('0a1b2c3d-4e5f-6g7h-8i9j-0k1l2m3n4o5p', 'f7eebc99-9c0b-4ef8-bb6d-6bb9bd380a18'), -- Kitchen
    ('0a1b2c3d-4e5f-6g7h-8i9j-0k1l2m3n4o5p', 'f9eebc99-9c0b-4ef8-bb6d-6bb9bd380a20'), -- AC
    ('1b2c3d4e-5f6g-7h8i-9j0k-1l2m3n4o5p6q', 'f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16'), -- WiFi
    ('1b2c3d4e-5f6g-7h8i-9j0k-1l2m3n4o5p6q', 'f6eebc99-9c0b-4ef8-bb6d-6bb9bd380a17'), -- Pool
    ('1b2c3d4e-5f6g-7h8i-9j0k-1l2m3n4o5p6q', 'f8eebc99-9c0b-4ef8-bb6d-6bb9bd380a19'), -- Parking
    ('2c3d4e5f-6g7h-8i9j-0k1l-2m3n4o5p6q7r', 'f7eebc99-9c0b-4ef8-bb6d-6bb9bd380a18'); -- Kitchen

-- 5. Insert bookings with realistic date ranges
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
    ('3d4e5f6g-7h8i-9j0k-1l2m-3n4o5p6q7r8s', '0a1b2c3d-4e5f-6g7h-8i9j-0k1l2m3n4o5p', 
     'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', '2023-06-10', '2023-06-15', 600.00, 'confirmed', '2023-05-01 08:20:00'),
     
    ('4e5f6g7h-8i9j-0k1l-2m3n-4o5p6q7r8s9t', '1b2c3d4e-5f6g-7h8i-9j0k-1l2m3n4o5p6q', 
     'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', '2023-07-20', '2023-07-27', 2450.00, 'confirmed', '2023-06-15 14:45:00'),
     
    ('5f6g7h8i-9j0k-1l2m-3n4o-5p6q7r8s9t0u', '0a1b2c3d-4e5f-6g7h-8i9j-0k1l2m3n4o5p', 
     'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', '2023-08-05', '2023-08-08', 360.00, 'pending', '2023-07-20 11:30:00');

-- 6. Insert payments for confirmed bookings
INSERT INTO payments (payment_id, booking_id, amount, payment_method, transaction_id, status, created_at)
VALUES
    ('6g7h8i9j-0k1l-2m3n-4o5p-6q7r8s9t0u1v', '3d4e5f6g-7h8i-9j0k-1l2m-3n4o5p6q7r8s',
     600.00, 'credit_card', 'ch_1J4qRv2eZvKYlo2C0ZJZJZJZ', 'completed', '2023-05-01 08:25:00'),
     
    ('7h8i9j0k-1l2m-3n4o-5p6q-7r8s9t0u1v2w', '4e5f6g7h-8i9j-0k1l-2m3n-4o5p6q7r8s9t',
     2450.00, 'paypal', 'PAYID-MJ4RV2E5PV89612L12345678', 'completed', '2023-06-15 14:50:00');

-- 7. Insert reviews for completed stays
INSERT INTO reviews (review_id, property_id, user_id, booking_id, rating, comment, created_at)
VALUES
    ('8i9j0k1l-2m3n-4o5p-6q7r-8s9t0u1v2w3x', '0a1b2c3d-4e5f-6g7h-8i9j-0k1l2m3n4o5p',
     'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', '3d4e5f6g-7h8i-9j0k-1l2m-3n4o5p6q7r8s',
     5, 'Perfect location and amazing host!', '2023-06-16 09:00:00');

-- 8. Insert sample messages between users
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
    ('9j0k1l2m-3n4o-5p6q-7r8s-9t0u1v2w3x4y', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11',
     'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Hi! Is the apartment available June 10-15?', '2023-04-28 13:15:00'),
     
    ('0k1l2m3n-4o5p-6q7r-8s9t-0u1v2w3x4y5z', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12',
     'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Yes, those dates are open!', '2023-04-28 15:30:00');
     