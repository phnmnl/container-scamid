#!/bin/bash

apt-get update -y && apt-get install -y --no-install-recommends wget ca-certificates

wget "https://drive.google.com/uc?export=donwload&id=1wg8GdYXZ1g1koo1nhF-5ahEaJ-ZmpZZ3" -O sw620 
wget "https://drive.google.com/uc?export=donwload&id=1v1mFJBsUfyXdqiqwfiwDOSEntxlAewnz" -O SW620.zip

mkdir -p files/SW620/
unzip SW620.zip

runscamid.R -i sw620 -z SW620/ -o out.csv
rc=$?; 
if [[ $rc != 0 ]]; then 
	echo "R process failed with error $rc"
	exit $rc; 
fi

if [ ! -f out.csv ]; then
   	echo "File out_exchanged.csv does not exist, failing test."
   	exit 1
fi

echo "scamid runs with test data without error codes, all expected files created."
