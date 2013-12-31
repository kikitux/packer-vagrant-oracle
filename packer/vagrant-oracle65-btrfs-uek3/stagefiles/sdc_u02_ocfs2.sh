#initialize and mount the 3rd disk only if there is no partitions

rpm -q ocfs2-tools > /dev/null
if [ $? -ne 0 ];then
  yum -y install ocfs2-tools > /dev/null
fi

blkid /dev/sdc*
if [ $? -ne 0 ]; then
  mkfs.ocfs2 -M local -T mail /dev/sdc
  blkid /dev/sdc 2>&1>/dev/null && echo $(blkid /dev/sdc -o export | head -n1) /u02 ocfs2 defaults 0 0 >> /etc/fstab
  mkdir -p /u02
  mount /u02
else
  echo "filesystem metadata found on sdc, ignoring"
fi

