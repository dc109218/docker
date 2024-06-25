#!/bin/bash

set-e

ROLE1pIP="10.0.101.155"
ROLE2pIP="10.0.102.150"
ROLE3pIP="10.0.102.211"

nm1="role1"
nm2="role2"
nm3="role3"

hsnm="$(hostname)"

volnm="volume1"

# machine_1
if [[ $hsnm == $nm1 ]]; then
    echo this is hostmachine
    echo

    # host name added
    echo "$ROLE1pIP $nm1" >> /etc/hosts
    echo "$ROLE2pIP $nm2" >> /etc/hosts
    echo "$ROLE3pIP $nm3" >> /etc/hosts

    # glusterfs install packages
    apt update -y 
    apt install glusterfs-server -y
    apt install glusterfs-client -y
    systemctl start glusterd.service
    systemctl enable glusterd.service
    # echo "exit" | systemctl status glusterd.service

    # cluster peer probe
    gluster peer probe $nm1
    gluster peer probe $nm2
    gluster peer probe $nm3

    # Volume1 create folder
    mkdir -p /mnt/role
    gluster volume create $volnm transport tcp replica 3 $nm1:/mnt/role $nm2:/mnt/role $nm3:/mnt/role force

    gluster volume start $volnm

    mkdir -p /rolemount
    mount -t glusterfs $nm1:$volnm /rolemount
    # mount -t glusterfs $nm2:$volnm /rolemount
    # mount -t glusterfs $nm3:$volnm /rolemount


    # Adde restart machine
    echo "$nm1:$volnm /rolemount glusterfs defaults,_netdev 0 0" >> /etc/fstab
    # echo "$nm2:$volnm /rolemount glusterfs defaults,_netdev 0 0" >> /etc/fstab
    # echo "$nm3:$volnm /rolemount glusterfs defaults,_netdev 0 0" >> /etc/fstab
else
    echo "this is not a hostmachin $nm1"
fi

# machine_2
if [[ $hsnm == $nm2 ]]; then
    echo this is hostmachine
    echo

    # host name added
    echo "$ROLE1pIP" >> /etc/hosts
    echo "$ROLE2pIP" >> /etc/hosts
    echo "$ROLE3pIP" >> /etc/hosts

    # glusterfs install packages
    apt update -y 
    apt install glusterfs-server -y
    apt install glusterfs-client -y
    systemctl start glusterd.service
    systemctl enable glusterd.service
    # systemctl status glusterd.service

    # cluster peer probe
    # gluster peer probe $nm1
    # gluster peer probe $nm2
    # gluster peer probe $nm3

    # Volume1 create folder
    mkdir -p /mnt/role
    # gluster volume create $volnm transport tcp replica 3 $nm1:/mnt/role $nm2:/mnt/role $nm3:/mnt/role force

    # gluster volume start $volnm

    mkdir -p /rolemount
    # mount -t glusterfs $nm1:$volnm /rolemount
    mount -t glusterfs $nm2:$volnm /rolemount
    # mount -t glusterfs $nm3:$volnm /rolemount


    # Adde restart machine
    # echo "$nm1:$volnm /rolemount glusterfs defaults,_netdev 0 0" >> /etc/fstab
    echo "$nm2:$volnm /rolemount glusterfs defaults,_netdev 0 0" >> /etc/fstab
    # echo "$nm3:$volnm /rolemount glusterfs defaults,_netdev 0 0" >> /etc/fstab
else
    echo "this is not a hostmachin $nm1"
fi

# machine_3
if [[ $hsnm == $nm3 ]]; then
    echo this is hostmachine
    echo

    # host name added
    echo "$ROLE1pIP" >> /etc/hosts
    echo "$ROLE2pIP" >> /etc/hosts
    echo "$ROLE3pIP" >> /etc/hosts

    # glusterfs install packages
    apt update -y 
    apt install glusterfs-server -y
    apt install glusterfs-client -y
    systemctl start glusterd.service
    systemctl enable glusterd.service
    # systemctl status glusterd.service

    # cluster peer probe
    # gluster peer probe $nm1
    # gluster peer probe $nm2
    # gluster peer probe $nm3

    # Volume1 create folder
    mkdir -p /mnt/role
    # gluster volume create $volnm transport tcp replica 3 $nm1:/mnt/role $nm2:/mnt/role $nm3:/mnt/role force

    # gluster volume start $volnm

    mkdir -p /rolemount
    # mount -t glusterfs $nm1:$volnm /rolemount
    # mount -t glusterfs $nm2:$volnm /rolemount
    mount -t glusterfs $nm3:$volnm /rolemount


    # Adde restart machine
    # echo "$nm1:$volnm /rolemount glusterfs defaults,_netdev 0 0" >> /etc/fstab
    # echo "$nm2:$volnm /rolemount glusterfs defaults,_netdev 0 0" >> /etc/fstab
    echo "$nm3:$volnm /rolemount glusterfs defaults,_netdev 0 0" >> /etc/fstab
else
    echo "this is not a hostmachin $nm1"
fi

echo "script run done.................."
echo
echo "script run done.................."