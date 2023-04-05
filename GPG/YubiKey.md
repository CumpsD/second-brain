# YubiKey

# Configure Smartcard

Plug in a YubiKey and use GPG to configure it as a smartcard:

```console
$ gpg --card-edit

Reader ...........: Yubico Yubikey 4 OTP U2F CCID
Application ID ...: D2760001240102010006055532110000
Application type .: OpenPGP
Version ..........: 3.4
Manufacturer .....: Yubico
Serial number ....: 05553211
Name of cardholder: [not set]
Language prefs ...: [not set]
Salutation .......:
URL of public key : [not set]
Login data .......: [not set]
Signature PIN ....: not forced
Key attributes ...: rsa2048 rsa2048 rsa2048
Max. PIN lengths .: 127 127 127
PIN retry counter : 3 0 3
Signature counter : 0
KDF setting ......: off
Signature key ....: [none]
Encryption key....: [none]
Authentication key: [none]
General key info..: [none]
```

Enter administrative mode:

```console
gpg/card> admin
Admin commands are allowed
```

**Note** If the card is locked, see [Reset](#reset).

## Enable KDF

Key Derived Function (KDF) enables YubiKey to store the hash of PIN, preventing the PIN from being passed as plain text. Note that this requires a relatively new version of GnuPG to work, and may not be compatible with other GPG clients (notably mobile clients). These incompatible clients will be unable to use the YubiKey GPG functions as the PIN will always be rejected. If you are not sure you will only be using your YubiKey on supported platforms, it may be better to skip this step.

```console
gpg/card> kdf-setup
```

## Change PIN

The [GPG interface](https://developers.yubico.com/PGP/) is separate from other modules on a Yubikey such as the [PIV interface](https://developers.yubico.com/PIV/Introduction/YubiKey_and_PIV.html). The GPG interface has its own *PIN*, *Admin PIN*, and *Reset Code* - these should be changed from default values!

Entering the user *PIN* incorrectly three times will cause the PIN to become blocked; it can be unblocked with either the *Admin PIN* or *Reset Code*.

Entering the *Admin PIN* or *Reset Code* incorrectly three times destroys all GPG data on the card. The Yubikey will have to be reconfigured.

Name       | Default Value | Use
-----------|---------------|-------------------------------------------------------------
PIN        | `123456`      | decrypt and authenticate (SSH)
Admin PIN  | `12345678`    | reset *PIN*, change *Reset Code*, add keys and owner information
Reset code | _**None**_      | reset *PIN* ([more information](https://forum.yubico.com/viewtopicd01c.html?p=9055#p9055))

Values are valid up to 127 ASCII characters and must be at least 6 (*PIN*) or 8 (*Admin PIN*, *Reset Code*) characters. See the GnuPG documentation on [Managing PINs](https://www.gnupg.org/howtos/card-howto/en/ch03s02.html) for details.

To update the GPG PINs on the Yubikey:

```console
gpg/card> passwd
gpg: OpenPGP card no. D2760001240102010006055532110000 detected

1 - change PIN
2 - unblock PIN
3 - change Admin PIN
4 - set the Reset Code
Q - quit

Your selection? 3
PIN changed.

1 - change PIN
2 - unblock PIN
3 - change Admin PIN
4 - set the Reset Code
Q - quit

Your selection? 1
PIN changed.

1 - change PIN
2 - unblock PIN
3 - change Admin PIN
4 - set the Reset Code
Q - quit

Your selection? q
```

**Note** The number of retry attempts can be changed later with the following command, documented [here](https://docs.yubico.com/software/yubikey/tools/ykman/OpenPGP_Commands.html#ykman-openpgp-access-set-retries-options-pin-retries-reset-code-retries-admin-pin-retries):

```bash
$ ykman openpgp access set-retries 5 5 5 -f -a YOUR_ADMIN_PIN
```

## Set information

Some fields are optional.

```console
gpg/card> name
Cardholder's surname: Duh
Cardholder's given name: Dr

gpg/card> lang
Language preferences: en

gpg/card> login
Login data (account name): doc@duh.to

gpg/card> salutation
gpg/card> url
gpg/card> fetch

gpg/card> list

Application ID ...: D2760001240102010006055532110000
Version ..........: 3.4
Manufacturer .....: unknown
Serial number ....: 05553211
Name of cardholder: Dr Duh
Language prefs ...: en
Sex ..............: unspecified
URL of public key : [not set]
Login data .......: doc@duh.to
Private DO 4 .....: [not set]
Signature PIN ....: not forced
Key attributes ...: rsa2048 rsa2048 rsa2048
Max. PIN lengths .: 127 127 127
PIN retry counter : 3 0 3
Signature counter : 0
KDF setting ......: on
Signature key ....: [none]
Encryption key....: [none]
Authentication key: [none]
General key info..: [none]

gpg/card> quit
```

# Transfer keys

**Important** Transferring keys to YubiKey using `keytocard` is a destructive, one-way operation only. Make sure you've made a backup before proceeding: `keytocard` converts the local, on-disk key into a stub, which means the on-disk copy is no longer usable to transfer to subsequent security key devices or mint additional keys.

Previous GPG versions required the `toggle` command before selecting keys. The currently selected key(s) are indicated with an `*`. When moving keys only one key should be selected at a time.

```console
$ gpg --edit-key $KEYID

Secret key is available.

sec  rsa4096/0xFF3E7D88647EBCDB
    created: 2017-10-09  expires: never       usage: C
    trust: ultimate      validity: ultimate
ssb  rsa4096/0xBECFA3C1AE191D15
    created: 2017-10-09  expires: 2018-10-09  usage: S
ssb  rsa4096/0x5912A795E90DD2CF
    created: 2017-10-09  expires: 2018-10-09  usage: E
ssb  rsa4096/0x3F29127E79649A3D
    created: 2017-10-09  expires: 2018-10-09  usage: A
[ultimate] (1). Dr Duh <doc@duh.to>
```

## Signing

You will be prompted for the master key passphrase and Admin PIN.

Select and transfer the signature key.

```console
gpg> key 1

sec  rsa4096/0xFF3E7D88647EBCDB
    created: 2017-10-09  expires: never       usage: C
    trust: ultimate      validity: ultimate
ssb* rsa4096/0xBECFA3C1AE191D15
    created: 2017-10-09  expires: 2018-10-09  usage: S
ssb  rsa4096/0x5912A795E90DD2CF
    created: 2017-10-09  expires: 2018-10-09  usage: E
ssb  rsa4096/0x3F29127E79649A3D
    created: 2017-10-09  expires: 2018-10-09  usage: A
[ultimate] (1). Dr Duh <doc@duh.to>

gpg> keytocard
Please select where to store the key:
   (1) Signature key
   (3) Authentication key
Your selection? 1

You need a passphrase to unlock the secret key for
user: "Dr Duh <doc@duh.to>"
4096-bit RSA key, ID 0xBECFA3C1AE191D15, created 2016-05-24
```

## Encryption

Type `key 1` again to de-select and `key 2` to select the next key:

```console
gpg> key 1

gpg> key 2

sec  rsa4096/0xFF3E7D88647EBCDB
    created: 2017-10-09  expires: never       usage: C
    trust: ultimate      validity: ultimate
ssb  rsa4096/0xBECFA3C1AE191D15
    created: 2017-10-09  expires: 2018-10-09  usage: S
ssb* rsa4096/0x5912A795E90DD2CF
    created: 2017-10-09  expires: 2018-10-09  usage: E
ssb  rsa4096/0x3F29127E79649A3D
    created: 2017-10-09  expires: 2018-10-09  usage: A
[ultimate] (1). Dr Duh <doc@duh.to>

gpg> keytocard
Please select where to store the key:
   (2) Encryption key
Your selection? 2

[...]
```

## Authentication

Type `key 2` again to deselect and `key 3` to select the last key:

```console
gpg> key 2

gpg> key 3

sec  rsa4096/0xFF3E7D88647EBCDB
    created: 2017-10-09  expires: never       usage: C
    trust: ultimate      validity: ultimate
ssb  rsa4096/0xBECFA3C1AE191D15
    created: 2017-10-09  expires: 2018-10-09  usage: S
ssb  rsa4096/0x5912A795E90DD2CF
    created: 2017-10-09  expires: 2018-10-09  usage: E
ssb* rsa4096/0x3F29127E79649A3D
    created: 2017-10-09  expires: 2018-10-09  usage: A
[ultimate] (1). Dr Duh <doc@duh.to>

gpg> keytocard
Please select where to store the key:
   (3) Authentication key
Your selection? 3
```

Save and quit:

```console
gpg> save
```

# Verify card

Verify the sub-keys have been moved to YubiKey as indicated by `ssb>`:

```console
$ gpg -K
/tmp.FLZC0xcM/pubring.kbx
-------------------------------------------------------------------------
sec   rsa4096/0xFF3E7D88647EBCDB 2017-10-09 [C]
      Key fingerprint = 011C E16B D45B 27A5 5BA8  776D FF3E 7D88 647E BCDB
uid                            Dr Duh <doc@duh.to>
ssb>  rsa4096/0xBECFA3C1AE191D15 2017-10-09 [S] [expires: 2018-10-09]
ssb>  rsa4096/0x5912A795E90DD2CF 2017-10-09 [E] [expires: 2018-10-09]
ssb>  rsa4096/0x3F29127E79649A3D 2017-10-09 [A] [expires: 2018-10-09]
```

# Multiple YubiKeys

To provision additional security keys, restore the master key backup and repeat the [Configure Smartcard](#configure-smartcard) procedure.

```console
$ mv -vi $GNUPGHOME $GNUPGHOME.1
renamed '/tmp.FLZC0xcM' -> '/tmp.FLZC0xcM.1'

$ cp -avi /mnt/encrypted-storage/tmp.XXX $GNUPGHOME
'/mnt/encrypted-storage/tmp.FLZC0xcM' -> '/tmp.FLZC0xcM'

$ cd $GNUPGHOME
```

Another way to provision additional security keys:

* Insert Yubikey 1
* Create keys/subkeys
* Run `keytocard` to transfer keys to Yubikey 1
* **QUIT WITHOUT SAVING!!!!!**

This will leave the keys on the Yubikey but NOT change the
GPG keyring to point to the Yubikey1 with a stub

* Insert Yubikey 2
* Run `keytocard` to transfer keys to Yubikey 2
* QUIT and SAVE to make GPG point it's stubs to Yubikey 2

## Switching between two or more Yubikeys

When you add a GPG key to a Yubikey using the *keytocard* command, GPG deletes the key from your keyring and adds a *stub* pointing to that exact Yubikey (the stub identifies the GPG KeyID and the Yubikey's serial number).

However, when you do this same operation for a second Yubikey, the stub in your keyring is overwritten by the *keytocard* operation and now the stub points to your second Yubikey. Adding more repeats this overwriting operation.

In other words, the stub will point ONLY to the LAST Yubikey written to.

When using GPG key operations with the GPG key you placed onto the Yubikeys, GPG will request a specific Yubikey asking that you insert a Yubikey with a given serial number (referenced by the stub). GPG will not recognise another Yubikey with a different serial number without manual intervention.

You can force GPG to scan the card and re-create the stubs to point to another Yubikey.

Having created two (or more Yubikeys) with the same GPG key (as described above) where the stubs are pointing to the second Yubikey:

Insert the first Yubikey (which has a different serial number) and run the following command:

```console
$  gpg-connect-agent "scd serialno" "learn --force" /bye
```
GPG will then scan your first Yubikey for GPG keys and recreate the stubs to point to the GPG keyID and Yubikey Serial number of this first Yubikey.

To return to using the second Yubikey just repeat (insert other Yubikey and re-run command).

Obviously this command is not easy to remember so it is recommended to either create a script or a shell alias to make this more user friendly.

# Using keys

Remove and re-insert YubiKey and verify the status:

```console
$ gpg --card-status
Reader ...........: Yubico YubiKey OTP FIDO CCID 00 00
Application ID ...: D2760001240102010006055532110000
Version ..........: 3.4
Manufacturer .....: Yubico
Serial number ....: 05553211
Name of cardholder: Dr Duh
Language prefs ...: en
Sex ..............: unspecified
URL of public key : [not set]
Login data .......: doc@duh.to
Signature PIN ....: not forced
Key attributes ...: rsa4096 rsa4096 rsa4096
Max. PIN lengths .: 127 127 127
PIN retry counter : 3 3 3
Signature counter : 0
KDF setting ......: on
Signature key ....: 07AA 7735 E502 C5EB E09E  B8B0 BECF A3C1 AE19 1D15
      created ....: 2016-05-24 23:22:01
Encryption key....: 6F26 6F46 845B BEB8 BDF3  7E9B 5912 A795 E90D D2CF
      created ....: 2016-05-24 23:29:03
Authentication key: 82BE 7837 6A3F 2E7B E556  5E35 3F29 127E 7964 9A3D
      created ....: 2016-05-24 23:36:40
General key info..: pub  4096R/0xBECFA3C1AE191D15 2016-05-24 Dr Duh <doc@duh.to>
sec#  4096R/0xFF3E7D88647EBCDB  created: 2016-05-24  expires: never
ssb>  4096R/0xBECFA3C1AE191D15  created: 2017-10-09  expires: 2018-10-09
                      card-no: 0006 05553211
ssb>  4096R/0x5912A795E90DD2CF  created: 2017-10-09  expires: 2018-10-09
                      card-no: 0006 05553211
ssb>  4096R/0x3F29127E79649A3D  created: 2017-10-09  expires: 2018-10-09
                      card-no: 0006 05553211
```

`sec#` indicates the master key is not available (as it should be stored encrypted offline).

**Note** If you see `General key info..: [none]` in the output instead - go back and import the public key using the previous step.

Encrypt a message to your own key (useful for storing password credentials and other data):

```console
$ echo "test message string" | gpg --encrypt --armor --recipient $KEYID -o encrypted.txt
```

To encrypt to multiple recipients (or to multiple keys):

```console
$ echo "test message string" | gpg --encrypt --armor --recipient $KEYID_0 --recipient $KEYID_1 --recipient $KEYID_2 -o encrypted.txt
```

Decrypt the message:

```console
$ gpg --decrypt --armor encrypted.txt
gpg: anonymous recipient; trying secret key 0x0000000000000000 ...
gpg: okay, we are the anonymous recipient.
gpg: encrypted with RSA key, ID 0x0000000000000000
test message string
```

Sign a message:

```console
$ echo "test message string" | gpg --armor --clearsign > signed.txt
```

Verify the signature:

```console
$ gpg --verify signed.txt
gpg: Signature made Wed 25 May 2016 00:00:00 AM UTC
gpg:                using RSA key 0xBECFA3C1AE191D15
gpg: Good signature from "Dr Duh <doc@duh.to>" [ultimate]
Primary key fingerprint: 011C E16B D45B 27A5 5BA8  776D FF3E 7D88 647E BCDB
     Subkey fingerprint: 07AA 7735 E502 C5EB E09E  B8B0 BECF A3C1 AE19 1D15
```

# Require touch

**Note** This is not possible on YubiKey NEO.

By default, YubiKey will perform encryption, signing and authentication operations without requiring any action from the user, after the key is plugged in and first unlocked with the PIN.

To require a touch for each key operation, install [YubiKey Manager](https://developers.yubico.com/yubikey-manager/) and recall the Admin PIN:

**Note** Older versions of YubiKey Manager use `touch` instead of `set-touch` in the following commands.

Authentication:

```console
$ ykman openpgp keys set-touch aut on
```

Signing:

```console
$ ykman openpgp keys set-touch sig on
```

Encryption:

```console
$ ykman openpgp keys set-touch enc on
```

Depending on how the YubiKey is going to be used, you may want to look at the policy options for each of these and adjust the above commands accordingly. They can be viewed with the following command:

```console
$ ykman openpgp keys set-touch -h
Usage: ykman openpgp keys set-touch [OPTIONS] KEY POLICY

  Set touch policy for OpenPGP keys.

  KEY     Key slot to set (sig, enc, aut or att).
  POLICY  Touch policy to set (on, off, fixed, cached or cached-fixed).

  The touch policy is used to require user interaction for all operations using the private key on the YubiKey. The touch policy is set individually for each key slot. To see the current touch policy, run

      $ ykman openpgp info

  Touch policies:

  Off (default)   No touch required
  On              Touch required
  Fixed           Touch required, can't be disabled without a full reset
  Cached          Touch required, cached for 15s after use
  Cached-Fixed    Touch required, cached for 15s after use, can't be disabled
                  without a full reset

Options:
  -a, --admin-pin TEXT  Admin PIN for OpenPGP.
  -f, --force           Confirm the action without prompting.
  -h, --help            Show this message and exit.
```

If the YubiKey is going to be used within an email client that opens and verifies encrypted mail, `Cached` or `Cached-Fixed` may be desirable.

```console
ykman openpgp keys set-touch enc cached
Enter Admin PIN:
Set touch policy of ENC key to cached? [y/N]: y

ykman openpgp keys set-touch aut cached
Enter Admin PIN:
Set touch policy of AUT key to cached? [y/N]: y

ykman openpgp keys set-touch sig cached
Enter Admin PIN:
Set touch policy of SIG key to cached? [y/N]: y
```

YubiKey will blink when it is waiting for a touch. On Linux you can also use [yubikey-touch-detector](https://github.com/maximbaz/yubikey-touch-detector) to have an indicator or notification that YubiKey is waiting for a touch.

# Reset

If PIN attempts are exceeded, the card is locked and must be [reset](https://developers.yubico.com/ykneo-openpgp/ResetApplet.html) and set up again using the encrypted backup.

Copy the following script to a file and run `gpg-connect-agent -r $file` to lock and terminate the card. Then re-insert YubiKey to reset.

```console
/hex
scd serialno
scd apdu 00 20 00 81 08 40 40 40 40 40 40 40 40
scd apdu 00 20 00 81 08 40 40 40 40 40 40 40 40
scd apdu 00 20 00 81 08 40 40 40 40 40 40 40 40
scd apdu 00 20 00 81 08 40 40 40 40 40 40 40 40
scd apdu 00 20 00 83 08 40 40 40 40 40 40 40 40
scd apdu 00 20 00 83 08 40 40 40 40 40 40 40 40
scd apdu 00 20 00 83 08 40 40 40 40 40 40 40 40
scd apdu 00 20 00 83 08 40 40 40 40 40 40 40 40
scd apdu 00 e6 00 00
scd apdu 00 44 00 00
/echo Card has been successfully reset.
```

Or use `ykman` (sometimes in `~/.local/bin/`):

```console
$ ykman openpgp reset
WARNING! This will delete all stored OpenPGP keys and data and restore factory settings? [y/N]: y
Resetting OpenPGP data, don't remove your YubiKey...
Success! All data has been cleared and default PINs are set.
PIN:         123456
Reset code:  NOT SET
Admin PIN:   12345678
```

## Recovery after reset

If for whatever reason you need to reinstate your YubiKey from your master key backup (such as the one stored on an encrypted USB described in [Backup](#backup)), follow the following steps in [Rotating keys](#rotating-keys) to setup your environment, and then follow the steps of again [Configure Smartcard](#configure-smartcard).

Before you unmount your backup, ask yourself if you should make another one just in case.
