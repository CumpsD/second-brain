# Restart repository

If you ever face a situation where you want to blow away all your Git history and start over, this can help.

```bash
git checkout --orphan new-main main
git commit -m "Enter commit message for your new initial commit" 

# Overwrite the old master branch reference with the new one 
git branch -M new-main main 
git push origin main --force
```
