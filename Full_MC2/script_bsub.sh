#!/bin/bash

scripts=*_script.sh

for f in $scripts
do
    echo "Processing $f script..."

    bsub -q 8nh $f

done

