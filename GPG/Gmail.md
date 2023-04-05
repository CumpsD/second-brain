# Gmail

## Mailvelope

* Install the [Mailvelope](https://mailvelope.com/en/) browser extension.

## gpgme-json.exe

* Download [Gpg4win](https://www.gpg4win.org/get-gpg4win.html) and open the installer with 7-zip.
* In the `bin` directory is [`gpgme-json.exe`](ttps://github.com/CumpsD/second-brain/raw/main/assets/gpg/gpgme-json.exe)
* Copy it to the `bin` directory of your GnuPG installation.
* Run `gpgme-json.exe -i` to test it.
  * `{"op": "version"}` (followed by two returns) will give information on the backend used.
  * `{"op": "keylist"}` (followed by two returns) will get a simple key listing actually using the backend.

## gpgmejson.json

* Store the following file at `C:\Program Files (x86)\gnupg\gpgme.json`

```json
{
  "name": "gpgmejson",
  "description": "JavaScript binding for GnuPG",
  "path": "C:\\Program Files (x86)\\gnupg\\bin\\gpgme-json.exe",
  "type": "stdio",
  "allowed_origins": ["chrome-extension://kajibbejlbohfaggdiogboambcijhkke/"]
}
```

## Registry

* Key: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Google\Chrome\NativeMessagingHosts\gpgmejson`
* Value: `C:\Program Files (x86)\gnupg\gpgme.json`
