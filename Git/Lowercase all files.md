# Lowercase all files

To lowercase all files in a directory, being tracked by Git:

```bash
find . -depth -name '*[A-Z]*'|sed -n 's/\(.*\/\)\(.*\)/git mv -v \1\2 \1\L\2/p'|sh
```
