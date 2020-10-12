#!/bin/bash

vgchange -ay

DEVICE_FS=$(blkid -o value -s TYPE ${DEVICE})

if [ "`echo -n $DEVICE_FS`" == "" ]; then
        # 3 commands of lvm2 to create a volume
        pvcreate ${DEVICE} 
        vgcreate data ${DEVICE}
        lvcreate --name volume1 -l 100%FREE data

        # using /dev/data/volume1 instead & file system type : ext4
        mkfs.ext4 /dev/data/volume1
fi

mkdir -p /data

# add the newly created volume to file systems table;
# 0 0 -> indicates dump & pass 
# dump is set to 0 meaning "do not automatically backup". 
# pass is set to 0 meaning "do not check" for any errors at boot time
echo '/dev/data/volume1 /data ext4 defaults 0 0' >> /etc/fstab

# reads the fstab and mounts /data
mount /data 