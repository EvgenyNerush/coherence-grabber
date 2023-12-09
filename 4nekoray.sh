#!/usr/bin/env bash

if [ -v $1 ]
then
    echo -e "To convert geodata from v2fly's domain-list-community format (as data/coherence-extra)
to text format of Nekoray, try:
    ./4nekoray.sh file-with-domain-list"
    exit 1
fi

input_file=$1
domains=$(cat $input_file | grep -v "#" | cut -d " " -f 1)
for d in ${domains[@]}
do
    echo "domain:${d}"
done

