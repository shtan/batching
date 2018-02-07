#!/bin/bash

current_dir=`pwd`
echo "current dir = ${current_dir}"

bigpath=/eos/cms/store/user/shtan/stage2stuff/feb6                      # Path to big MC folder

#folders=${bigpath}/*/*/*/*  #Number of stars depends on folder structure
folders=${bigpath}/TT_TuneCUETP8M2T4_13TeV-powheg-pythia8/*/*/*  #Number of stars depends on folder structure

for fol in $folders
do
    # Find directory structure within big MC folder
    bn1=$(basename "$fol")
    p1=$(dirname "$fol")
    bn2=$(basename "$p1")
    p2=$(dirname "$p1")
    bn3=$(basename "$p2")
    p3=$(dirname "$p2")
    bn4=$(basename "$p3")  #repeat as many times as necessary
    short_path=${bn4}/${bn3}/${bn2}/${bn1}  #change as necessary # Directory structure from MC folder

    echo "short path = ${short_path}"

    cd $bigpath/$short_path

    files=${fol}/*.root
    for f in $files
    do
        filename=$(basename $f)
        filename_raw=$(echo $filename | cut -f 1 -d '.')  # Filename without extension
        #echo $filename_raw

        OIFS=$IFS
        IFS='_' read -ra filename_raw_list <<< $filename_raw
        #filename_raw_list=$(echo $filename_raw | tr "_" "\n")
        #filename_raw_list=$filename_raw
        filenum=${filename_raw_list[1]}
        fileprefix=${filename_raw_list[0]}
        filepostfix=${filename_raw_list[2]}
        IFS=$OIFS
        #echo $filenum

        combined_file="${bigpath}/${short_path}/${fileprefix}_${filenum}_${filepostfix}_combined.root"
        #echo $combined_file
        if [ ! -f $combined_file ]; then
            echo "hadding file ${combined_file}"
            hadd $combined_file ${fileprefix}_${filenum}_${filepostfix}_*_*.root
        fi

    done

    cd $current_dir

done