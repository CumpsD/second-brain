# Sign Commits

```bash
gpg --list-secret-keys --keyid-format LONG

git config --global user.signingkey 0123456789ABCDEF

git config --global gpg.program "C:\Program Files (x86)\gnupg\bin\gpg.exe"
git config --global gpg.minTrustLevel "ultimate"
git config --global gpg.format "openpgp"

git config --global commit.gpgsign true

git config --global push.gpgsign true

git config --global tag.gpgsign true
git config --global tag.forceSignAnnotated true
```
