# Setup Software RAID

## Determine Harddisks

```bash
$ sudo fdisk -l
Disk /dev/sdb: 238.47 GiB, 256060514304 bytes, 500118192 sectors
Disk model: Samsung SSD 850
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

Disk /dev/sdc: 238.47 GiB, 256060514304 bytes, 500118192 sectors
Disk model: Samsung SSD 850
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

$ lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sdb      8:16   0 238.5G  0 disk
sdc      8:32   0 238.5G  0 disk
```

## Install Software

```bash
$ sudo apt install mdadm
```

## Setup RAID

```bash
$ sudo mdadm --create --verbose /dev/md0 --level=raid1 --raid-devices=2 /dev/sdb /dev/sdc
mdadm: /dev/sdb appears to contain an ext2fs file system
       size=250059096K  mtime=Thu Jan  1 00:00:00 1970
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: /dev/sdc appears to contain an ext2fs file system
       size=250059096K  mtime=Thu Jan  1 00:00:00 1970
mdadm: size set to 249926976K
mdadm: automatically enabling write-intent bitmap on large array
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.
```

## Check Status

```bash
$ cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
md0 : active raid1 sdc[1] sdb[0]
      249926976 blocks super 1.2 [2/2] [UU]
      [>....................]  resync =  1.4% (3601920/249926976) finish=20.5min speed=200106K/sec
      bitmap: 2/2 pages [8KB], 65536KB chunk

unused devices: <none>

$ cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
md0 : active raid1 sdc[1] sdb[0]
      249926976 blocks super 1.2 [2/2] [UU]
      bitmap: 0/2 pages [0KB], 65536KB chunk

unused devices: <none>
```

## Create Filesystem

```bash
$ sudo mkfs -t ext4 /dev/md0
mke2fs 1.46.5 (30-Dec-2021)
Discarding device blocks: done
Creating filesystem with 62481744 4k blocks and 15622144 inodes
Filesystem UUID: 7946ae6c-862b-4447-ac39-d6b1caed7420
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424, 20480000, 23887872

Allocating group tables: done
Writing inode tables: done
Creating journal (262144 blocks): done
Writing superblocks and filesystem accounting information: done
```

## Mounting RAID

```bash
$ sudo mkdir /data/

$ sudo blkid /dev/md0
/dev/md0: UUID="7946ae6c-862b-4447-ac39-d6b1caed7420" BLOCK_SIZE="4096" TYPE="ext4"

$ sudo ls -l /dev/disk/by-uuid
total 0
lrwxrwxrwx 1 root root  9 Apr  6 15:54 7946ae6c-862b-4447-ac39-d6b1caed7420 -> ../../md0

$ sudo nano /etc/fstab
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
UUID=AD6D-6C86                             /boot/efi vfat defaults 0 1
UUID=276778bc-e194-4863-a03a-0961258e4259  /         ext4 defaults 0 1
UUID=7946ae6c-862b-4447-ac39-d6b1caed7420  /data     ext4 defaults 0 2

$ sudo mount -a
$ sudo reboot

$ df -h
Filesystem      Size  Used Avail Use% Mounted on
tmpfs            13G  1.4M   13G   1% /run
/dev/sda2       218G   12G  196G   6% /
tmpfs            63G     0   63G   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/sda1       1.1G  6.1M  1.1G   1% /boot/efi
/dev/md127      234G   28K  222G   1% /data
tmpfs            13G  4.0K   13G   1% /run/user/1000

$ sudo touch /data/myfile.txt
$ ls -al /data
$ ls -al /data
total 24
drwxr-xr-x  3 root root  4096 Apr  6 16:19 .
drwxr-xr-x 20 root root  4096 Apr  6 15:55 ..
-rw-r--r--  1 root root     0 Apr  6 16:19 myfile.txt
```
