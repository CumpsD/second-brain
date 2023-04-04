# Verify SHA Checksums

## Method 1 - Powershell

```bash
Get-FileHash -Path GnuPG\gnupg-w32-2.4.0_20221216.exe
Get-FileHash -Path GnuPG\gpg4win-4.1.0.exe
```

## Method 2 - Certutil

```bash
certutil -hashfile GnuPG\gnupg-w32-2.4.0_20221216.exe sha256
certutil -hashfile GnuPG\gpg4win-4.1.0.exe sha256
```
