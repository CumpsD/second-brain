# Filtered sp_who

When you run `sp_who` it is often a lot of output, we can filter this output to reduce the clutter:

```sql
CREATE TABLE #sp_who2 (SPID INT,Status VARCHAR(255),
      Login  VARCHAR(255),HostName  VARCHAR(255),
      BlkBy  VARCHAR(255),DBName  VARCHAR(255),
      Command VARCHAR(255),CPUTime INT,
      DiskIO INT,LastBatch VARCHAR(255),
      ProgramName VARCHAR(255),SPID2 INT,
      REQUESTID INT)

INSERT INTO #sp_who2 EXEC sp_who2
SELECT      *
FROM        #sp_who2
WHERE       DBName <> 'master' AND DBName IS NOT NULL AND Command <> 'AWAITING COMMAND' AND COMMAND <> 'SELECT'
ORDER BY    DBName ASC

DROP TABLE #sp_who2
```
