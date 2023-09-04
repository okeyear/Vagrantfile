#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export LANG=en

# exit shell when error
# set -e

# This script used for: 
# add all server IP Hostname in /etc/hosts

# delete old content, from line "# add by vagrant begin" to "# add by vagrant end"
sudo sed -i '/# add by vagrant begin/,/# add by vagrant end/d' /etc/hosts

serverip=$1
servercount=$2
nodeip=$3
nodecount=$4
clientip=$5
clientcount=$6

# server
echo '# add by vagrant begin' | sudo tee -a /etc/hosts
serverip_head=${serverip%.*}
serverip_tail=${serverip##*.}
for i in $( seq 0 $(($servercount-1)) )
do
    printf "%-16s    server-%02d\n" ${serverip_head}.$((${serverip_tail}+i)) $(($i+1)) | sudo tee -a /etc/hosts
done

# node
nodeip_head=${nodeip%.*}
nodeip_tail=${nodeip##*.}
for i in $( seq 0 $(($nodecount-1)) )
do
    printf "%-16s    node-%02d\n" ${nodeip_head}.$((${nodeip_tail}+i)) $(($i+1)) | sudo tee -a /etc/hosts
done

# client
clientip_head=${clientip%.*}
clientip_tail=${clientip##*.}
for i in $( seq 0 $(($clientcount-1)) )
do
    printf "%-16s    client-%02d\n" ${clientip_head}.$((${clientip_tail}+i)) $(($i+1)) | sudo tee -a /etc/hosts
done
echo '# add by vagrant end' | sudo tee -a /etc/hosts