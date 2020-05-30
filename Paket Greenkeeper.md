# Paket Greenkeeper

Update every repository, run `dotnet paket outdated` and parse the results.

```bash
rm -f /tmp/repos-outdated.txt; forrepos "git pull; sleep 5; echo 'Pulled '(pwd); echo (pwd) >> /tmp/repos-outdated.txt; dotnet paket outdated --ignore-constraints | awk '/Outdated packages found:/,/Performance:/' >> /tmp/repos-outdated.txt; sleep 5; echo >> /tmp/repos-outdated.txt; echo 'Outdated '(pwd);"; echo 'Outdated check done!!'
```