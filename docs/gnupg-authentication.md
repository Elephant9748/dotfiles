## SSH Auth
> !Need to disable pubkey auth & enable pass prompt on sshd_config
> so we can copy pubkey to ssh server
### Step1 create ssh config
add ``~/.ssh/config/``
```
Host SEVER_NAME
    HostName SERVER_NAME.domain.net
    User SERVER_NAME_USERNAME
```
### Step2 enable ssh support in gpg-agent
add ``~/.gnupg/gpg-agent.conf``
```
enable-ssh-support
```
### Step3 Init ``SSH_AUTH_SOCK`` and launch gpg-agent on login (depend what shell do you use)
BASH edit ``~/.bash_profile``
```bash
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
```
Source your ``~/.bash_profile``, restarting gpg-agent
```bash
gpgconf --kill gpg-agent  # (just in case it’s already running)
source ~/.bash_profile
```
FISH edit ``~/.config/fish/config.fish``
```fish
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
```
### Step4 Adding Keys
Tell gpg-agent which subkey to pass to ssh by adding its “keygrip” to ``~/gnupg/sshcontrol``
```bash
$ gpg -k --with-keygrip
/Users/you/.gnupg/pubring.kbx
------------------------------
pub   rsa2048/93BDD96B 2017-06-29 [SC]
      D03833D3D52F5FFCCC73452461671825E8DEC139
      Keygrip = 8A6CDC5FCE05A5B251BD8C397B269607534B4702
uid         [ultimate] John <john@example.com>
sub   rsa2048/0424163D 2017-06-29 [E]
      Keygrip = E110250E32B811D45879A66F487CE95BC1906D77
sub   rsa2048/8F228EDB 2017-06-29 [A]
      Keygrip = 32BC5688805A640D495E8A7B41EC78F74E77E098

$ echo 32BC5688805A640D495E8A7B41EC78F74E77E098 > ~/.gnupg/sshcontrol
```
Confirm key has been added:
```
$ ssh-add -l
2048 SHA256:zQ1wF6qOq8UNqcSRMYhDc+Cg3yM9lgp8dWvXwjnPcvU (none)
(RSA)
```
```
$ ssh-add -L
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDtCaocIjsx3OU3NnU6JG6GHcmG9rBwzwFWGlf7rpEhV (none)
```
Copy pubkey to Authrize key on remote server
```bash
$ ssh-copy-id SERVER_NAME
```
Log in!
```bash
ssh SERVER_NAME
```
> !For some reason ssh doesnt show password input
> try another pinentry
> list pinentry ls -al /usr/bin/ | grep -i "pinentry"
> edit ``~/.gnupg/gpg-agent.conf``
> ```pinentry-program /usr/bin/pinentry```
