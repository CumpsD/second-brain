# Delete all tables and sequences

```sql
SELECT ' DROP TABLE ' + QUOTENAME(DB_NAME()) + '.' + QUOTENAME(s.NAME) + '.' + QUOTENAME(t.NAME) + '; '
  FROM sys.tables t
  JOIN sys.schemas s
    ON t.[schema_id] = s.[schema_id]
 WHERE t.type = 'U'
 UNION
SELECT ' DROP VIEW ' + QUOTENAME(s.NAME) + '.' + QUOTENAME(v.NAME) + '; '
  FROM sys.views v
  JOIN sys.schemas s
    ON v.[schema_id] = s.[schema_id]
 UNION
SELECT ' DROP SEQUENCE ' + QUOTENAME(s.NAME) + '.' + QUOTENAME(t.NAME) + '; '
  FROM sys.sequences t
  JOIN sys.schemas s
    ON t.[schema_id] = s.[schema_id]
```
