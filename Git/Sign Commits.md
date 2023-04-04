# Sign Commits

```bash
gpg --list-secret-keys --keyid-format LONG
git config --global user.signingkey 0123456789ABCDEF
git config --global gpg.program "C:\Program Files (x86)\gnupg\bin\gpg.exe"
git config --global commit.gpgsign true
```
