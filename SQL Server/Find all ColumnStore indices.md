# Find all ColumnStore indices

```sql
SELECT OBJECT_SCHEMA_NAME(OBJECT_ID) SchemaName,
       OBJECT_NAME(OBJECT_ID) TableName,
       i.name AS IndexName,
       i.type_desc IndexType
  FROM sys.indexes AS i
 WHERE is_hypothetical = 0
   AND i.index_id <> 0
   AND i.type_desc IN ('CLUSTERED COLUMNSTORE','NONCLUSTERED COLUMNSTORE')
```
