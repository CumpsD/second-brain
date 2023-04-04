# Export GPG to SSH

```bash
gpg --export-ssh-key <authentication-key-id> > ssh_auth_key.pub
gpg -o gpg_auth_key.pub --armor --export <authentication-key-id>
```
