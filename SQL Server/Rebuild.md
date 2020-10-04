# Rebuild

## Get Index Statistics

```sql
SELECT
	'SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID(N''[' + s.name + '].[' + t.name + ']''), NULL, NULL, ''DETAILED'');'
FROM
     sys.tables t
INNER JOIN
	sys.schemas s ON t.schema_id = s.schema_id
ORDER BY
     t.name
```

## Find Heaps (Tables without clustered key)

```sql
SELECT
	t.name t,
	'ALTER TABLE [' + s.name + '].[' + t.name +'] REBUILD'
FROM
     sys.indexes ind
INNER JOIN
     sys.tables t ON ind.object_id = t.object_id
INNER JOIN
	sys.schemas s ON t.schema_id = s.schema_id
WHERE
	ind.type_desc = 'HEAP'
ORDER BY
	t
```

## Rebuild Indices

```sql
SELECT Command FROM
(SELECT
	'ALTER INDEX [' + ind.name + '] ON [' + s.name + '].[' + t.name + '] REBUILD;' AS Command,
	t.name t,
	ind.name ind,
	ind.index_id
FROM
     sys.indexes ind
INNER JOIN
     sys.tables t ON ind.object_id = t.object_id
INNER JOIN
	sys.schemas s ON t.schema_id = s.schema_id

) s
WHERE Command IS NOT NULL
ORDER BY s.t, s.ind, s.index_id
```

## Rebuild Indices and Heaps

```sql
SELECT Command FROM (
	SELECT '1' AS Priority, Command FROM (
		SELECT
			'ALTER INDEX ALL ON [' + s.name + '].[' + t.name + '] REBUILD;' AS Command,
			t.name t
		FROM
			 sys.tables t
		INNER JOIN
			sys.schemas s ON t.schema_id = s.schema_id) s
	WHERE Command IS NOT NULL

	UNION

	SELECT '2' AS Priority, '' AS Command

	UNION

	SELECT
		'3' AS Priority,
		'ALTER TABLE [' + s.name + '].[' + t.name +'] REBUILD;' AS Command
	FROM
		 sys.indexes ind
	INNER JOIN
		 sys.tables t ON ind.object_id = t.object_id
	INNER JOIN
		sys.schemas s ON t.schema_id = s.schema_id
	WHERE
		ind.type_desc = 'HEAP'

	UNION

	SELECT '4' AS Priority, '' AS Command

	UNION

	SELECT
		'5' AS Priority,
		'UPDATE STATISTICS [' + s.name + '].[' + t.name +'] WITH FULLSCAN;' AS Command
	FROM
		 sys.tables t
	INNER JOIN
		sys.schemas s ON t.schema_id = s.schema_id

	UNION

	SELECT '6' AS Priority, '' AS Command

	UNION

	SELECT
		'7' AS Priority,
		'SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID(N''[' + s.name + '].[' + t.name + ']''), NULL, NULL, ''DETAILED'');'
	FROM
		 sys.tables t
	INNER JOIN
		sys.schemas s ON t.schema_id = s.schema_id) s
ORDER BY Priority, Command
```

## Rebuild + Get Statistics

```sql
SELECT Command FROM
(SELECT
	'ALTER INDEX [' + ind.name + '] ON [' + s.name + '].[' + t.name + '] REBUILD;' + CHAR(13) + CHAR(10) +
	'GO' AS Command,
	t.name t,
	ind.name ind,
	ind.index_id
FROM
     sys.indexes ind
INNER JOIN
     sys.tables t ON ind.object_id = t.object_id
INNER JOIN
	sys.schemas s ON t.schema_id = s.schema_id

UNION

SELECT
	'SELECT * FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID(N''[' + s.name + '].[' + t.name + ']''), NULL, NULL, ''DETAILED'');' AS Command,
	t.name t,
	ind.name ind,
	ind.index_id
FROM
     sys.indexes ind
INNER JOIN
     sys.tables t ON ind.object_id = t.object_id
INNER JOIN
	sys.schemas s ON t.schema_id = s.schema_id
) s
WHERE Command IS NOT NULL
ORDER BY s.t, s.ind, s.index_id
```
