#!/bin/bash

scripts=script_*_*.sh

for f in $scripts
do
    echo "Processing $f script..."

    bsub -q 8nh $f

done

