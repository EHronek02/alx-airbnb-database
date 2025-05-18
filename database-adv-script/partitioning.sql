-- 1. Create parent table with partitioning structure
CREATE TABLE bookings_partitioned (
    booking_id UUID,
    property_id UUID,
    user_id UUID,
    start_date DATE,
    end_date DATE,
    total_price DECIMAL(10,2),
    status VARCHAR(20),
    created_at TIMESTAMP
) PARTITION BY RANGE (start_date);

-- 2. Create monthly partitions for current and upcoming year
CREATE TABLE bookings_y2023m01 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2023-02-01');

CREATE TABLE bookings_y2023m02 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-02-01') TO ('2023-03-01');
    
-- [Continue for all months...]

CREATE TABLE bookings_y2024m01 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

-- 3. Create default partition for historical/future data
CREATE TABLE bookings_default PARTITION OF bookings_partitioned DEFAULT;

-- 4. Migrate data from original table
INSERT INTO bookings_partitioned 
SELECT * FROM bookings;

-- 5. Create indexes on each partition
CREATE INDEX idx_bookings_partitioned_property ON bookings_partitioned(property_id);
CREATE INDEX idx_bookings_partitioned_user ON bookings_partitioned(user_id);
CREATE INDEX idx_bookings_partitioned_dates ON bookings_partitioned(start_date, end_date);

-- 6. Replace original table (in production, you would use a transaction)
ALTER TABLE bookings RENAME TO bookings_old;
ALTER TABLE bookings_partitioned RENAME TO bookings;

EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2023-06-01' AND '2023-06-30';
