## Adding subkeys
List gpg keys with long format ``gpg -K --keyid-format 0xlong``
```
[keyboxd]
---------
sec   ed25519/0xB4606FF355E33A12 2025-11-23 [SC]
      7D23C4F1A73D2CFE1E9EBEB2B4606FF355E33A12
uid                   [ultimate] john <john@example.net>
ssb   cv25519/0x4D9CEF50A77F98ED 2025-11-23 [E]
      B3F1E8AF3951BF52A3E507824D9CEF50A77F98ED
```
#### Step1 Edit Keys
Edit keys ``gpg --expert --edit-key 0xB4606FF355E33A12``
```
gpg (GnuPG) 2.5.14; Copyright (C) 2025 g10 Code GmbH
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Secret key is available.

sec  ed25519/B4606FF355E33A12
     created: 2025-11-23  expires: never       usage: SC
     trust: ultimate      validity: ultimate
ssb  cv25519/4D9CEF50A77F98ED
     created: 2025-11-23  expires: never       usage: E
[ultimate] (1). john <john@example.net>

gpg>
```
Input: ``addkey``
```
Please select what kind of key you want:
   (3) DSA (sign only)
   (4) RSA (sign only)
   (5) Elgamal (encrypt only)
   (6) RSA (encrypt only)
   (7) DSA (set your own capabilities)
   (8) RSA (set your own capabilities)
  (10) ECC (sign only)
  (11) ECC (set your own capabilities)
  (12) ECC (encrypt only)
  (13) Existing key
  (14) Existing key from card
  (17) Kyber (encrypt only)
Your selection?
```
Input: ``17``
```
Please select the Kyber variant you want:
   (1) Kyber 768 *default*
   (2) Kyber 1024
   (3) Kyber 768 (X25519)
   (4) Kyber 1024 (X448)
Your selection?
```
Input: ``1``
```
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0)
```
Input: ``0`` you can adjust
```
Is this correct? (y/N) y
Really create? (y/N) y
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.

sec  ed25519/B4606FF355E33A12
     created: 2025-11-23  expires: never       usage: SC
     trust: ultimate      validity: ultimate
ssb  cv25519/4D9CEF50A77F98ED
     created: 2025-11-23  expires: never       usage: E
ssb  ky768_bp256/DA6EFC55A02F191A
     created: 2025-11-23  expires: never       usage: E
[ultimate] (1). john <john@example.net>
```
> Info:
> - E = encryption
> - S = signing
> - C = certification
> - A = authentication

To save changes

Input: ``save``

## Backup Keys & All Subkeys
> !Dont forgot to backup subkeys in case something happer
- Export secret keys ``gpg --export-secret-keys john > johnsecret.gpg``
- Export public keys ``gpg --export john > johnpublic.gpg``
- Export subkeys ``gpg --export-secret-subkeys john > johnsubkeys.gpg``

## Restore Keys 
- Restore Key ``gpg --import <Keys>.gpg``

## Revoke subkeys
Edit keys: ``gpg --expert --edit-key 0xB4606FF355E33A12``
```
gpg (GnuPG) 2.5.14; Copyright (C) 2025 g10 Code GmbH
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Secret key is available.

sec  ed25519/B4606FF355E33A12
     created: 2025-11-23  expires: never       usage: SC
     trust: ultimate      validity: ultimate
ssb  cv25519/4D9CEF50A77F98ED
     created: 2025-11-23  expires: never       usage: E
ssb  ky768_bp256/DA6EFC55A02F191A
     created: 2025-11-23  expires: never       usage: E
ssb  brainpoolP256r1/6EB78A532EEC9046
     created: 2025-11-23  expires: never       usage: S
[ultimate] (1). john <john@example.net>

gpg>
```
Input: ``key 2``
```
gpg> key 2

sec  ed25519/B4606FF355E33A12
     created: 2025-11-23  expires: never       usage: SC
     trust: ultimate      validity: ultimate
ssb  cv25519/4D9CEF50A77F98ED
     created: 2025-11-23  expires: never       usage: E
ssb* ky768_bp256/DA6EFC55A02F191A
     created: 2025-11-23  expires: never       usage: E
ssb  brainpoolP256r1/6EB78A532EEC9046
     created: 2025-11-23  expires: never       usage: S
[ultimate] (1). john <john@example.net>
```
Input: ``revkey``
```
gpg> revkey
Do you really want to revoke this subkey? (y/N) y
Please select the reason for the revocation:
  0 = No reason specified
  1 = Key has been compromised
  2 = Key is superseded
  3 = Key is no longer used
  Q = Cancel
Your decision? 3
Enter an optional description; end it with an empty line:
>
Reason for revocation: Key is no longer used
(No description given)
Is this okay? (y/N) y

sec  ed25519/B4606FF355E33A12
     created: 2025-11-23  expires: never       usage: SC
     trust: ultimate      validity: ultimate
ssb  cv25519/4D9CEF50A77F98ED
     created: 2025-11-23  expires: never       usage: E
The following key was revoked on 2025-11-23 by EDDSA key B4606FF355E33A12 john <john@example.net>
ssb  ky768_bp256/DA6EFC55A02F191A
     created: 2025-11-23  revoked: 2025-11-23  usage: E
ssb  brainpoolP256r1/6EB78A532EEC9046
     created: 2025-11-23  expires: never       usage: S
[ultimate] (1). john <john@example.net>
```
To save changes

Input: ``save``

## Delete subkeys
Edit keys: ``gpg --expert --edit-key 0xB4606FF355E33A12``
```
gpg (GnuPG) 2.5.14; Copyright (C) 2025 g10 Code GmbH
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Secret key is available.

sec  ed25519/B4606FF355E33A12
     created: 2025-11-23  expires: never       usage: SC
     trust: ultimate      validity: ultimate
ssb  cv25519/4D9CEF50A77F98ED
     created: 2025-11-23  expires: never       usage: E
ssb  ky768_bp256/DA6EFC55A02F191A
     created: 2025-11-23  expires: never       usage: E
ssb  brainpoolP256r1/6EB78A532EEC9046
     created: 2025-11-23  expires: never       usage: S
[ultimate] (1). john <john@example.net>

gpg>
```
Input: ``key 2``
```
gpg> key 2

sec  ed25519/B4606FF355E33A12
     created: 2025-11-23  expires: never       usage: SC
     trust: ultimate      validity: ultimate
ssb  cv25519/4D9CEF50A77F98ED
     created: 2025-11-23  expires: never       usage: E
ssb* ky768_bp256/DA6EFC55A02F191A
     created: 2025-11-23  expires: never       usage: E
ssb  brainpoolP256r1/6EB78A532EEC9046
     created: 2025-11-23  expires: never       usage: S
[ultimate] (1). john <john@example.net>
```
Input: ``delkey``
```
gpg> delkey
Do you really want to delete this key? (y/N) y

sec  ed25519/B4606FF355E33A12
     created: 2025-11-23  expires: never       usage: SC
     trust: ultimate      validity: ultimate
ssb  cv25519/4D9CEF50A77F98ED
     created: 2025-11-23  expires: never       usage: E
ssb  brainpoolP256r1/6EB78A532EEC9046
     created: 2025-11-23  expires: never       usage: S
[ultimate] (1). john <john@example.net>
```
To save changes

Input: ``save``
