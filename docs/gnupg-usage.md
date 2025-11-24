## Generate Key
```
gpg --expert --full-generate-key
```
## List Key
> ``-k`` -> pub key, ``-K`` -> secret key
### With fingerprint
```
gpg -k --with-fingerprint [pub key uuid/name]
```
### With keygrip
```
gpg -k --with-keyrip [pub key uuid/name]
```
### With format
```
gpg -k --keyid-format 0xlong
```
## Encrypt key
### With Key
```
gpg -a -o users.txt.asc -u [secret key specific] -r john -r john --sign --encrypt users.txt

#encrypt with armor
gpg --encrypt --sign -a -o [namefile.asc] -r [recipient] -r [recipient]
```
### With only symmetric
```
#encrypt with cipher
gpg -o filename --symmetric --cipher-algo AES256 file.txt
```
## Decrypt Key
```
gpg -o outputfile [-u uuid(optional)] --decrypt filename

gpg -d filename
```
## Detach Sign
```
gpg -o outputfile[filename.sig] -u uuid --detach-sig filetarget
```
## Verify Key
```
gpg --verify [filename.sig] [realfile]
```
## Export Key
```
#export-key
gpg --output public.pgp --armor --export username@email
gpg --output private.pgp --armor --export-secret-key username@email

#export keys with armor
gpg --export [uuid] -a > pub.pgp
gpg --export-secret-key [uuid] -a > pub.pgp

#backupkey with chiper
gpg --export [uuid] > pub && gpg -o [filename] --symmetric --cipher-algo AES256 pub
gpg --export-secret-key [uuid] > pk && gpg -o [filename] --symmetric --cipher-algo AES256 pk

gpg --export [multiple key name] > masterPub.pgp
gpg --export-secret-keys [multiple key name] > masterPK.pgp

```
## Import Key
```
gpg --import filename
```
## Clear Passphrase GpgCache
```
#clear passphrase gnupgCache
gpg-connect-agent reloadagent /bye
```
## import key from keyserver
```
gpg --keyserver [server-name with https://] --recv-keys [uuid from server]
```
