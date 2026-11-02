### PQC with openssl

List KEM

```
openssl list -kem-algorithms
```

Generate PK / seperate

```
openssl genpkey -algorithm ML-KEM-768 -out key.pem -outpubkey pubkey.pem

# or

openssl genpkey -algorithm ML-KEM-768 -out key.pem
openssl pkey -in key.pem -pubout -out pubkey.pem
```

Encrypt file/message with KEM (Key Encapsulation Mechanism)

> [!NOTE]
>
> 1. Encapsulate → get a 32-byte shared secret (using the recipient's public key)
> 2. Encrypt the data with a symmetric cipher (AES-256-GCM) using that shared secret
> 3. Send the ML-KEM ciphertext + encrypted data to the recipient

```
# No integrity check
--------------------------

# Generate IV 16 bytes
openssl rand -hex 16

# Encapsulate
openssl pkeyutl -encap -pubin -inkey pubkey.pem \
  -out ciphertext.bin -secret shared_secret.bin

#Encrypt
openssl enc -aes-256-cbc -in plaintext.txt -out encrypted.bin \
  -K "$(xxd -p -c 64 shared_secret.bin | tr -d '\n')" \
  -iv "my-iv-hex-16-bytes"

```

Decrypt KEM

```
# No integrity check
--------------------------
# Decapsulate
openssl pkeyutl -decap -inkey key.pem -in ciphertext.bin -secret shared_secret.bin

#Decrypt
openssl enc -d -aes-256-cbc -in encrypted.bin -out plaintext.txt \
  -K "$(xxd -p -c 64 shared_secret.bin | tr -d '\n')" \
  -iv "my-iv-hex-16-bytes-that-generate"
```
