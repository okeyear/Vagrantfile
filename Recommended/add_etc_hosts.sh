#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export LANG=en

# exit shell when error
# set -e

# This script used for: 
# add all server IP Hostname in /etc/hosts

# delete old content, from line "# add by vagrant begin" to "# add by vagrant end"
sudo sed -i '/# add by vagrant begin/,/# add by vagrant end/d' /etc/hosts

domain=$1
serverip=$2
servercount=$3
nodeip=$4
nodecount=$5
clientip=$6
clientcount=$7

# domain
sudo sed -i '/^search/d' /etc/resolv.conf
echo "search $domain" | sudo tee -a /etc/resolv.conf

# server
echo '# add by vagrant begin' | sudo tee -a /etc/hosts
serverip_head=${serverip%.*}
serverip_tail=${serverip##*.}
for i in $( seq 0 $(($servercount-1)) )
do
    printf "%-16s    server-%02d.${domain}    server-%02d\n" ${serverip_head}.$((${serverip_tail}+i)) $(($i+1)) $(($i+1)) | sudo tee -a /etc/hosts
done

# node
nodeip_head=${nodeip%.*}
nodeip_tail=${nodeip##*.}
for i in $( seq 0 $(($nodecount-1)) )
do
    printf "%-16s    node-%02d.${domain}    node-%02d\n" ${nodeip_head}.$((${nodeip_tail}+i)) $(($i+1)) $(($i+1)) | sudo tee -a /etc/hosts
done

# client
clientip_head=${clientip%.*}
clientip_tail=${clientip##*.}
for i in $( seq 0 $(($clientcount-1)) )
do
    printf "%-16s    client-%02d.${domain}    client-%02d\n" ${clientip_head}.$((${clientip_tail}+i)) $(($i+1)) $(($i+1)) | sudo tee -a /etc/hosts
done
echo '# add by vagrant end' | sudo tee -a /etc/hosts
