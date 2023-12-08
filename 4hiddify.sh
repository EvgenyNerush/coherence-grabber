#!/usr/bin/env bash

if [ -v $1 ]
then
    echo -e "To convert geodata from domain-list-community format (as data/coherence-extra)
to text format of Hiddify or V2Ray, try:
    ./4hiddify.sh file-with-domain-list"
    exit 1
fi

input_file=$1
domains=$(cat $input_file | grep -v "#" | cut -d " " -f 1)
for d in ${domains[@]}
do
    echo "domain:${d},"
done

