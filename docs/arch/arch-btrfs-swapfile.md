## Swap file
### Step1 create subvolume
```bash
sudo btrfs subvolume create /swap
```
### Step2 create swap file
```bash
btrfs filesystem mkswapfile --size 4g --uuid clear /swap/swapfile
```
> ``--size`` swap file size
### Step3 Activate swap file
```bash
sudo swapon /swap/swapfile
```
### Step4 edit ``/etc/fstab``
```
/swap/swapfile none swap defaults 0 0
```
### Step5 COW must be disables  (i.e., swap files must have the NOCOW attribute)
```bash
sudo chattr -C /swap/swapfile
```
