#!/usr/bin/env bash

if [ -v $1 ]
then
    echo -e "To convert geodata from v2fly's domain-list-community format (as data/coherence-extra)
to text format of Nekoray, try:
    ./4nekoray.sh file-with-domain-list another-file etc"
    exit 1
fi

domains=$(cat $@ | grep -v "#" | cut -d " " -f 1)
for d in ${domains[@]}
do
    echo "domain:${d}"
done

