# Database Indexing for Performance Optimizations

## Index Identification and Creation

1. High Usage Columns Analysis]

#### Users Table
- `user_id` - primary key, joins
- `email` - login lookups
- `role` - filtering hosts/guests

```sql
-- Users table indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
```

#### Proprties Table

- `property_id` - primary key, joins
- `host_id` joins for users
- `location->>'city'` - search filtering
- `price_per_night` - search/sorting
- `is_available` - filtering

```sql
-- Properties table indexes
CREATE INDEX idx_properties_host ON properties(host_id);
CREATE INDEX idx_properties_city ON properties((location->>'city'));
CREATE INDEX idx_properties_price ON properties(is_available) WHERE is_available = TRUE; -- Partial indx for active listing
```

#### Booking Table:

- `booking_id` - primary key
- `property_id` - joins to properties
- `user_id` - joins to users
- `start_date`/`end_date` - availability searches
- `status` - filtering


```sql
-- Booking table indexes
CREATE INDEX idx_bookings_property ON bookings(property_id);
CREATE INDEX idx_bookings_user ON bookings(user_id);
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);
CREATE INDEX idx_bookings_status ON bookings(status) WHERE status IN ('confirmed', 'pending');
```

```sql
-- Composite index for common search patterns
CREATE INDEX idx_property_search ON properties((location->>'city'), price_per_night, is_available);
```


## Performance Measurement

#### RUN Before and After indexing (sample queyr Analysis)

```sql
-- Example Find available properties in paris
EXPLAIN ANALYZE
SELECT * FROM properties
WHERE location->>'city' = 'Paris'
AND is_available = TRUE
ORDER BY price_per_night;
```
