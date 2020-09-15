# Show Missing Index Suggestions

```sql
SELECT db.[name] AS [DatabaseName]
    ,id.[object_id] AS [ObjectID]
    ,OBJECT_NAME(id.[object_id], db.[database_id]) AS [ObjectName]
    ,id.[statement] AS [FullyQualifiedObjectName]
    ,id.[equality_columns] AS [EqualityColumns]
    ,id.[inequality_columns] AS [InEqualityColumns]
    ,id.[included_columns] AS [IncludedColumns]
    ,gs.[unique_compiles] AS [UniqueCompiles]
    ,gs.[user_seeks] AS [UserSeeks]
    ,gs.[user_scans] AS [UserScans]
    ,gs.[last_user_seek] AS [LastUserSeekTime]
    ,gs.[last_user_scan] AS [LastUserScanTime]
    ,gs.[avg_total_user_cost] AS [AvgTotalUserCost]  -- Average cost of the user queries that could be reduced by the index in the group.
    ,gs.[avg_user_impact] AS [AvgUserImpact]  -- The value means that the query cost would on average drop by this percentage if this missing index group was implemented.
    ,gs.[system_seeks] AS [SystemSeeks]
    ,gs.[system_scans] AS [SystemScans]
    ,gs.[last_system_seek] AS [LastSystemSeekTime]
    ,gs.[last_system_scan] AS [LastSystemScanTime]
    ,gs.[avg_total_system_cost] AS [AvgTotalSystemCost]
    ,gs.[avg_system_impact] AS [AvgSystemImpact]  -- Average percentage benefit that system queries could experience if this missing index group was implemented.
    ,gs.[user_seeks] * gs.[avg_total_user_cost] * (gs.[avg_user_impact] * 0.01) AS [IndexAdvantage]
    ,'CREATE INDEX [IX_' + OBJECT_NAME(id.[object_id], db.[database_id]) + '_' + REPLACE(REPLACE(REPLACE(ISNULL(id.[equality_columns], ''), ', ', '_'), '[', ''), ']', '') + CASE
        WHEN id.[equality_columns] IS NOT NULL
            AND id.[inequality_columns] IS NOT NULL
            THEN '_'
        ELSE ''
        END + REPLACE(REPLACE(REPLACE(ISNULL(id.[inequality_columns], ''), ', ', '_'), '[', ''), ']', '') + '_' + LEFT(CAST(NEWID() AS [nvarchar](64)), 5) + ']' + ' ON ' + id.[statement] + ' (' + ISNULL(id.[equality_columns], '') + CASE
        WHEN id.[equality_columns] IS NOT NULL
            AND id.[inequality_columns] IS NOT NULL
            THEN ','
        ELSE ''
        END + ISNULL(id.[inequality_columns], '') + ')' + ISNULL(' INCLUDE (' + id.[included_columns] + ')', '') AS [ProposedIndex]
    ,CAST(CURRENT_TIMESTAMP AS [smalldatetime]) AS [CollectionDate]
FROM [sys].[dm_db_missing_index_group_stats] gs WITH (NOLOCK)
INNER JOIN [sys].[dm_db_missing_index_groups] ig WITH (NOLOCK) ON gs.[group_handle] = ig.[index_group_handle]
INNER JOIN [sys].[dm_db_missing_index_details] id WITH (NOLOCK) ON ig.[index_handle] = id.[index_handle]
INNER JOIN [sys].[databases] db WITH (NOLOCK) ON db.[database_id] = id.[database_id]
WHERE  db.[database_id] = DB_ID()
--AND OBJECT_NAME(id.[object_id], db.[database_id]) = 'YourTableName'
ORDER BY ObjectName, [IndexAdvantage] DESC
OPTION (RECOMPILE);
```
