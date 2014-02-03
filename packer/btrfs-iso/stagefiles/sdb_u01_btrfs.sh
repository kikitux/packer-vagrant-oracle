#initialize and mount the 2nd disk only if there is no partitions

# Author    :   Alvaro Miranda
# Email     :   kikitux@gmail.com
# Web       :   http://kikitux.net


blkid /dev/sdb*
if [ $? -ne 0 ]; then
  mkfs.btrfs /dev/sdb
  blkid /dev/sdb 2>&1>/dev/null && echo $(blkid /dev/sdb -o export | head -n1) /u01 btrfs defaults 0 0 >> /etc/fstab
  mkdir -p /u01
  mount /u01
  mkdir -p /u01/stage
else
  echo "filesystem metadata found on sdb, ignoring"
fi
