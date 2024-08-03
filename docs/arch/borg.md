### borg 

#### initialize borg repo

Remote
<br>
set env (fish command)
<br>
manual
```
set BORG_RSH "ssh -i $HOME/.ssh/rigel_ed25519"

set -x BORG_RSH
```
or set in config.fish
```
export BORG_RSH="ssh -i $HOME/.ssh/rigel_ed25519"
```

borg init repo
```
borg init --encryption=repokey-blake2 ssh://[USER]@[HOST]:[PORT]/[LOCATED BACKUP DIRECTORY]
```

borg create backup
```
borg create --stats --progress --compression zlib,7 ssh://[USER]@[HOST]:[PORT]/[LOCATED BACKUP DIRECTORY]::[BACKUP NAME] [DIRECTORY to BACKUP]
```

borg list
```
borg list ssh://[USER]@[HOST]:[PORT]/[LOCATED BACKUP DIRECTORY]
```

<br>
Local
<br>

borg init repo
```
borg init --encryption=repokey-blake2 [LOCATED BACKUP DIRECTORY]
```

borg create backup 

```
# Super fast, low compression (lz4, default)
$ borg create /path/to/repo::arch ~
# Less fast, higher compression (zlib, N = 0..9)
$ borg create --compression zlib,N /path/to/repo::arch ~
# Even slower, even higher compression (lzma, N = 0..9)
$ borg create --compression lzma,N /path/to/repo::arch ~
# Only compress compressible data with lzma,N (N = 0..9)
$ borg create --compression auto,lzma,N /path/to/repo::arch


borg create --stats --progress --compression lz4 [LOCATED BACKUP DIRECTORY]::[BACKUP NAME] [DIRECTORY To BACKUP]
```

borg list
<br>
to eq ls file: [LOCATED BACKUP DIRECTORY]::[BACKUP NAME]
```
borg list [LOCATED BACKUP DIRECTORY]
```

borg delete archive
```
borg delete --glob-archives '*contain_name_of_file*' [LOCATED BACKUP DIRECTORY]::[BACKUP NAME] [DIRECTORY To BACKUP]
```
