# Backup to NAS

## Re-authenticating gphotos

SSH to the NAS and execute the following:

```bash
docker run --rm -ti --name gphotos-config -v /volume1/homes/cumpsd/Drive/Moments/Google:/storage -v /volume1/docker/gphotos-sync:/config gilesknap/gphotos-sync --new-token /storage
```
