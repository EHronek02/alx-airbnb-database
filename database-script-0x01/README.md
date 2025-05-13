## Database Schema

###Key Features of This Schema:
1. Data Integrity:

- All foreign key relationships properly defined
- CHECK constraints enforce business rules (valid dates, rating ranges)
- UNIQUE constraints prevent duplicates

2. Performance Optimizations:
- Indexes on frequently queried columns
- GIN index for JSONB location searches
- Special message conversation index

3. Security:
- UUIDs instead of sequential IDs
- Proper data types for all fields

4. Extensibility:
- JSONB field for flexible location data
- Junction table for amenity management

5. Audit Trail:
- created_at/updated_at timestamps on all tables

