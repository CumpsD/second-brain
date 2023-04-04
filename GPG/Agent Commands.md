# Agent Commands

## Starting

```bash
gpg-connect-agent /bye
```

## Enable SSH Support

`gpg-agent.conf`

```text
# To enable SSH support
enable-ssh-support

# To Enable support for PuTTY
enable-putty-support

# To Enable support for the native Microsoft OpenSSH binaries (requires gpg 2.4.0 / Gpg4win 4.1.0 or higher)
enable-win32-openssh-support

use-standard-socket

default-cache-ttl-ssh 21600
max-cache-ttl-ssh 86400
default-cache-ttl 21600
max-cache-ttl 86400
```

## Restarting

```bash
gpg-connect-agent killagent /bye
gpg-connect-agent /bye
```

## List Keys

```bash
gpg-connect-agent "KEYINFO --ssh-list --ssh-fpr" /bye
gpg-connect-agent "KEYINFO --ssh-list --ssh-fpr=sha1" /bye
```
