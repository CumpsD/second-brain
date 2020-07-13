# Key Commands

## Listing

```bash
$ gpg2 --list-keys
 /root/.gnupg/pubring.gpg
 ------------------------
 pub   4096R/D37A732F 2019-08-22 [expires: 2020-08-21]
 uid                  terminaltwister (test user for demo) <email@address.com>
 sub   4096R/7C7D2187 2019-08-22 [expires: 2020-08-21]

$ gpg2 --list-secret-keys
 /root/.gnupg/secring.gpg
 ------------------------
 sec   4096R/D37A732F 2019-08-22 [expires: 2020-08-21]
 uid                  terminaltwister (test user for demo) <email@address.com>
 ssb   4096R/7C7D2187 2019-08-22
```

## Revoking

### Creating the revoke key

```bash
$ gpg2 --armour --output revoke-key.asc --gen-revoke <key_id>
 sec  4096R/D37A732F 2019-08-22 terminaltwister (test user for demo) <email@address.com>
 
 Create a revocation certificate for this key? (y/N) y
 Please select the reason for the revocation:
   0 = No reason specified
   1 = Key has been compromised
   2 = Key is superseded
   3 = Key is no longer used
   Q = Cancel
 (Probably you want to select 1 here)
 Your decision? 1
 Enter an optional description; end it with an empty line:
 > compromised! oh no!
 > 
 Reason for revocation: Key has been compromised
 compromised! oh no!
 Is this okay? (y/N) y
 
 You need a passphrase to unlock the secret key for
 user: "terminaltwister (test user for demo) <email@address.com>"
 4096-bit RSA key, ID D37A732F, created 2019-08-22
 
 Revocation certificate created.
 
 Please move it to a medium which you can hide away; if Mallory gets
 access to this certificate he can use it to make your key unusable.
 It is smart to print this certificate and store it away, just in case
 your media become unreadable.  But have some caution:  The print system of
 your machine might store the data and make it available to others!
```

### Using the revoke key in the future

```bash
$ gpg2 --list-keys
 /root/.gnupg/pubring.gpg
 ------------------------
 pub   4096R/D37A732F 2019-08-22 [expires: 2020-08-21]
 uid                  terminaltwister (test user for demo) <email@address.com>
 sub   4096R/7C7D2187 2019-08-22 [expires: 2020-08-21]
 
$ gpg2 --import revoke-key.asc
 gpg: key D37A732F: "terminaltwister (test user for demo) <email@address.com>" revocation certificate imported
 gpg: Total number processed: 1
 gpg:    new key revocations: 1
 gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
 gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
 gpg: next trustdb check due at 2020-08-21
 
$ gpg2 --list-keys
 /root/.gnupg/pubring.gpg
 ------------------------
 pub   4096R/D37A732F 2019-08-22 [revoked: 2019-08-23]
 uid                  terminaltwister (test user for demo) <email@address.com>
 
$ gpg2 --delete-secret-and-public-key <key_id>
 gpg (GnuPG) 2.0.22; Copyright (C) 2013 Free Software Foundation, Inc.
 This is free software: you are free to change and redistribute it.
 There is NO WARRANTY, to the extent permitted by law.

 sec  4096R/D37A732F 2019-08-22 terminaltwister (test user for demo) <email@address.com>
 
 Delete this key from the keyring? (y/N) y
 This is a secret key! - really delete? (y/N) y
 
 pub  4096R/D37A732F 2019-08-22 terminaltwister (test user for demo) <email@address.com>
 
 Delete this key from the keyring? (y/N) y
```

## Exporting

```bash
$ gpg2 --export --armor --output public-key.asc <key_id>
 -rw-r--r-- 1 root root 3.1K Aug 23 06:33 public-key.asc
 
$ gpg2 --export-secret-keys --armor --output private-key.asc <key_id>
 -rw-r--r-- 1 root root 6.6K Aug 23 07:28 private-key.asc
```

## Importing

```bash
$ gpg2 --import private-key.asc
 gpg: key D37A732F: secret key imported
 gpg: key D37A732F: public key "terminaltwister (test user for demo) <email@address.com>" imported
 gpg: Total number processed: 1
 gpg:               imported: 1  (RSA: 1)
 gpg:       secret keys read: 1
 gpg:   secret keys imported: 1
 
$ gpg2 --import public-key.asc 
 gpg: key D37A732F: "terminaltwister (test user for demo) <email@address.com>" not changed
 gpg: Total number processed: 1
 gpg:              unchanged: 1
```

## Trusting

```bash
$ gpg2 --edit-key <key_id>
 gpg (GnuPG) 2.0.22; Copyright (C) 2013 Free Software Foundation, Inc.
 This is free software: you are free to change and redistribute it.
 There is NO WARRANTY, to the extent permitted by law.
 
 Secret key is available.
 
 pub  4096R/D37A732F  created: 2019-08-22  expires: 2020-08-21  usage: SC  
                      trust: unknown       validity: ultimate
 sub  4096R/7C7D2187  created: 2019-08-22  expires: 2020-08-21  usage: E   
 [ultimate] (1). terminaltwister (test user for demo) <email@address.com>
 
 gpg> trust
 pub  4096R/D37A732F  created: 2019-08-22  expires: 2020-08-21  usage: SC  
                      trust: unknown       validity: ultimate
 sub  4096R/7C7D2187  created: 2019-08-22  expires: 2020-08-21  usage: E   
 [ultimate] (1)* terminaltwister (test user for demo) <email@address.com>
 
 Please decide how far you trust this user to correctly verify other users' keys
 (by looking at passports, checking fingerprints from different sources, etc.)
 
   1 = I don't know or won't say
   2 = I do NOT trust
   3 = I trust marginally
   4 = I trust fully
   5 = I trust ultimately
   m = back to the main menu
 
 Your decision? 5
 Do you really want to set this key to ultimate trust? (y/N) y
 

 pub  4096R/D37A732F  created: 2019-08-22  expires: 2020-08-21  usage: SC  
                      trust: ultimate      validity: ultimate
 sub  4096R/7C7D2187  created: 2019-08-22  expires: 2020-08-21  usage: E   
 [ultimate] (1)* terminaltwister (test user for demo) <email@address.com>
 Please note that the shown key validity is not necessarily correct
 unless you restart the program.
 
 gpg> quit
```

## Keyserver

```bash
$ gpg2 --refresh-keys
 gpg: refreshing 4 keys from hkps://keys.openpgp.org
 gpg: key 0x9D771C7A03413FB3: "David Cumps <david@exira.com>" not changed
 gpg: Total number processed: 2
 gpg:              unchanged: 2

$ gpg2 --send-keys <key_id>
 gpg: sending key 0x9D771C7A03413FB3 to hkps://keys.openpgp.org
```

At this point you can find your key online too: [keys.openpgp.org/search?q=0x9D771C7A03413FB3](https://keys.openpgp.org/search?q=0x9D771C7A03413FB3)

```bash
$ gpg2 --refresh-keys
 gpg: connecting dirmngr at '/run/user/1000/gnupg/S.dirmngr' failed: IPC connect call failed
 gpg: keyserver refresh failed: No dirmngr

$ gpg2 --send-keys <key_id>
 gpg: connecting dirmngr at '/run/user/1000/gnupg/S.dirmngr' failed: IPC connect call failed
 gpg: no keyserver known
 gpg: keyserver send failed: No keyserver available

$ dirmngr < /dev/null
 dirmngr[172698]: No ldapserver file at: '/home/cumpsd/.gnupg/dirmngr_ldapservers.conf'
 dirmngr[172698.0]: permanently loaded certificates: 128
 dirmngr[172698.0]:     runtime cached certificates: 0
 dirmngr[172698.0]:            trusted certificates: 128 (127,0,0,1)
 dirmngr[172698.0]: failed to open cache dir file '/home/cumpsd/.gnupg/crls.d/DIR.txt': Permission denied
 dirmngr[172698.0]: error creating new cache dir file '/home/cumpsd/.gnupg/crls.d/DIR.txt': Permission denied
 dirmngr[172698.0]: Fatal: failed to create a new cache object: Configuration error

$ touch $HOME/.gnupg/dirmngr_ldapservers.conf
$ chmod 700 /home/$USER/.gnupg/crls.d/
$ sudo killall dirmngr

$ dirmngr < /dev/null
 dirmngr[173733.0]: permanently loaded certificates: 128
 dirmngr[173733.0]:     runtime cached certificates: 0
 dirmngr[173733.0]:            trusted certificates: 128 (127,0,0,1)
 # Home: /home/cumpsd/.gnupg
 # Config: [none]
 OK Dirmngr 2.2.19 at your service
```

## Backup

```bash
$ gpg2 --export --armor > all-public-keys.asc
 -rw-rw-r-- 1 cumpsd cumpsd 27K Jul 13 19:39 all-public-keys.asc

$ gpg2 --export-secret-keys --armor > all-secret-keys.asc
 -rw-rw-r-- 1 cumpsd cumpsd 29K Jul 13 19:41 all-secret-keys.asc
 
$ gpg2 --export-ownertrust > ownertrust.txt
 -rw-rw-r-- 1 cumpsd cumpsd 164 Jul 13 19:42 ownertrust.txt
 
$ gpg2 --import all-public-keys.asc
$ gpg2 --import all-secret-keys.asc
$ gpg2 --import-ownertrust otrust.txt
```
