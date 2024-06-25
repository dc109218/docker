
nano /etc/hosts
10.122.0.2 role1
10.122.0.3 role2
10.122.0.4 role3
<!-- 10.0.102.211 role3 -->
<!-- 10.0.1.238 role4 -->
<!-- 10.0.2.93 role5 -->
<!-- 10.0.1.209 role6 -->
## apt-get remove glusterfs-server -y

===
# link
# https://www.digitalocean.com/community/tutorials/how-to-create-a-redundant-storage-pool-using-glusterfs-on-ubuntu-20-04

apt update -y; apt install glusterfs-server -y; apt install glusterfs-client -y
systemctl start glusterd.service; systemctl enable glusterd.service; systemctl status glusterd.service

sudo systemctl enable --now glusterd

## ec2 group add security group ##

gluster peer probe role2
gluster peer probe role3
<!-- gluster peer probe role3 -->
<!-- gluster peer probe role4 -->
<!-- gluster peer probe role5 -->
<!-- gluster peer probe role6 -->

gluster peer status

mkdir -p /mnt/role /rit

# storage-replica create
gluster volume create rit-prod-vol transport tcp replica 2 role1:/mnt/role role2:/mnt/role force

<!-- gluster volume add-brick rit-prod-vol replica 2 role2:/mnt/role force -->
<!-- gluster volume add-brick rit-prod-vol replica 3 role3:/mnt/role force -->

gluster volume start rit-prod-vol

sudo gluster volume set rit-prod-vol auth.allow 10.10.0.6
sudo gluster volume set rit-prod-vol auth.allow *

gluster volume status

gluster volume info rit-prod-vol

mkdir -p /rit
cd /rit

mount -t glusterfs role1:rit-prod-vol /rit
mount -t glusterfs role2:rit-prod-vol /rit
mount -t glusterfs role3:rit-prod-vol /rit
<!-- mount -t glusterfs role4:rit-prod-vol /rit -->
<!-- mount -t glusterfs role5:rit-prod-vol /rit -->
<!-- mount -t glusterfs role6:rit-prod-vol /rit -->

df -h

touch 1111_{0..6}.1

echo "role1:rit-prod-vol /rit glusterfs defaults,_netdev 0 0" >> /etc/fstab
echo "role2:rit-prod-vol /rit glusterfs defaults,_netdev 0 0" >> /etc/fstab
echo "role3:rit-prod-vol /rit glusterfs defaults,_netdev 0 0" >> /etc/fstab
<!-- echo "role4:rit-prod-vol /rit glusterfs defaults,_netdev 0 0" >> /etc/fstab -->
<!-- echo "role5:rit-prod-vol /rit glusterfs defaults,_netdev 0 0" >> /etc/fstab -->
<!-- echo "role6:rit-prod-vol /rit glusterfs defaults,_netdev 0 0" >> /etc/fstab -->

====
gluster volume list

mount | grep rit-prod-vol
du -sh /rit
umount -l /rit

gluster volume stop rit-prod-vol
gluster volume delete rit-prod-vol

<!-- sudo gluster volume remove-brick <volume_name> replica <desired_replica_count> <detached_node>:<brick_path> force -->
sudo gluster volume remove-brick rit-prod-vol replica 2 role1:/mnt/role force

gluster volume remove-brick rit-prod-vol replica 1 role2:/mnt/role force
gluster volume remove-brick rit-prod-vol replica 2 role3:/mnt/role force
gluster volume remove-brick rit-prod-vol replica 3 role4:/mnt/role force

gluster peer detach role2

===

Snapshort Management
# Snapshot creation
gluster snapshot create <snapname> <volname> [no-timestamp] [description <description>]
gluster snapshot create role1-bkp rit-prod-vol $(date +%d%m%Y-%H%M%S) role1-backup-for-manual

# Restoring snaps
gluster snapshot restore <snapname>

# Deleting snaps
gluster snapshot delete (all | <snapname> | volume <volname>)

# Listing of available snaps
gluster snapshot list [volname]

# Configuring the snapshot behavior
snapshot config [volname] ([snap-max-hard-limit <count>] [snap-max-soft-limit <percent>])
                            | ([auto-delete <enable|disable>])
                            | ([activate-on-create <enable|disable>])
gluster snapshot activate <snapname>
gluster snapshot deactivate <snapname>
