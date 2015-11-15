# The below was adapted from the following link. I have not actually checked
# what features grub supports or not, but this was updated as of Oct 4:
# https://github.com/zfsonlinux/pkg-zfs/wiki/HOWTO-install-EL7-(CentOS-RHEL)-to-a-Native-ZFS-Root-Filesystem#step-3-create-the-root-pool

# I don't set ashift because these are native 4kn drives

# We use names like sda here, but immediately export and then use serial-number
# based ids
# We use -d to disable all features by default to ensure GRUB will be able to
# handle both the pool and the root partition
# -f makes this pretty dangerous, I think, but is needed to overcome the lack
# of an EFI label
zpool create -f -d \
    -o feature@async_destroy=enabled \
    -o feature@empty_bpobj=enabled \
    -o feature@lz4_compress=enabled \
    -O compression=lz4 \
    bigdisks0 raidz sda sdb sdc sdd sde
 
zpool export rpool
zpool import -d /dev/disk/by-id rpool
