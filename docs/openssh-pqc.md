## Test validate connection if using pqc
```bash
# ssh -v brnrd.eu
...
debug1: kex: algorithm: mlkem768x25519-sha256
...
debug1: Offering public key: /home/testuser/.ssh/id_ed25519_sk ED25519-SK SHA256:... authenticator agent
...
```
## config ssh client
``~/.ssh/config``
```
Host hostname
        ...
        KexAlgorithms mlkem768x25519-sha256
        ...
```
## To show available KexAlgorithms
```bash
ssh -Q kex
```
