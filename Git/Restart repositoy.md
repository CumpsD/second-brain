# Restart repository

If you ever face a situation where you want to blow away all your Git history and start over, this can help.

```bash
git checkout --orphan new-main main
git commit -m "Enter commit message for your new initial commit" 
git branch -M new-main main 
git push origin main --force
```

If you want to clean up afterwards:

```bash
git checkout main
git ls-files > keep-these.txt
git filter-branch --force --index-filter \
  "git rm  --ignore-unmatch --cached -qr . ; \
  cat $PWD/keep-these.txt | tr '\n' '\0' | xargs -0 git reset -q \$GIT_COMMIT --" \
  --prune-empty --tag-name-filter cat -- --all
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now
git gc --aggressive --prune=now
git push origin main --force
```
