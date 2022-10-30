# Revert Migration

```bash
dotnet ef database update NAME_OF_MIGRATION_TO_REVERT_TO --project Immovlan.SqlServer --context ImmovlanContext --connection "Server=.;Database=Immo;Trusted_Connection=True;"
```

```bash
dotnet ef database update 20220630084400_RemoveIsPriceDisplayedDefaultConstraint --project Immovlan.SqlServer --context ImmovlanContext --connection "Server=xxx;Database=xxx;User Id=xxx;Password=xxx;TrustServerCertificate=true;"
```
