# Query Optimization for Airbnb Clone Database

## Performance Analysis

After running EXPLAIN ANALYZE on the initial query, i identified several inefficiencies:

1. **Unnecessary Data Retrieval**:
	- Fetching all columns including unused ones like full review comments
	- Including LEFT JOINs for optional relationships when not always needed
2. **Missing Indexes**:
	- No indexes supporting the join operations
	- No indexes supporting the ORDER BY clause

3. **Inefficient Join Strategy:**
	- Mutliple many to many join in a single query
	- No indexes supporting the ORDER BY clause

4. **Execution Metrics**:
	- Planning time: 3.1 ms
	- Execution timee: 491.3 ms (for 10,000 records)
	- sequential scans on multiple tables
	- Heavy sorting operation in memory

### Optimization Techniques Applied
1. Query Structure Improvements:

- Used CTE to first narrow down the core booking data
- Added time-based filtering to reduce dataset size
- Removed unnecessary LEFT JOIN for reviews
- Limited results with pagination (LIMIT 1000)

2. Indexing Strategy:
3. Selective Column Selection:
- Only included essential columns in final output
- Removed large text fields (like review comments) unless needed
4. Performance Results After Optimization:
- Planning time: 1.2 ms (57% reduction)
- Execution time: 28.4 ms (94% reduction)
- Index scans used for all join operations
- Sorting eliminated by index-only scan

## Additional Recommendations

1. For Large Datasets:
```sql
-- Implement pagination
SELECT ...
ORDER BY bc.start_date DESC
LIMIT 50 OFFSET 0;

2. Application-Level Optimization:
	- Implement caching for frequently accessed booking data
	- Consider splitting into multiple focused queries if not all data is needed at once
```
