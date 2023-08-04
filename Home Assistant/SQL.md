# SQL

## Database Size

```sql
SELECT pg_size_pretty( pg_database_size('homeassistant_db') );
```

## Table Sizes

```sql
SELECT
  table_name,
  pg_size_pretty(pg_relation_size(quote_ident(table_name))),
  pg_relation_size(quote_ident(table_name))
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY 3 DESC;
```

## States Size

```sql
SELECT
  COUNT(*) as cnt,
  COUNT(*) * 100 / (SELECT COUNT(*) FROM events) AS cnt_pct,
  event_types.event_type
FROM events
INNER JOIN event_types ON events.event_type_id = event_types.event_type_id
GROUP BY event_types.event_type
ORDER BY cnt DESC
```

## Event Size

```sql
SELECT
  COUNT(*) AS cnt,
  COUNT(*) * 100 / (SELECT COUNT(*) FROM states) AS cnt_pct,
  states_meta.entity_id
FROM states
INNER JOIN states_meta ON states.metadata_id=states_meta.metadata_id
GROUP BY states_meta.entity_id
ORDER BY cnt DESC
```
