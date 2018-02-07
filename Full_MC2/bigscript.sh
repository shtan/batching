#!/bin/bash

current_dir=`pwd`
echo "current dir = ${current_dir}"

bigpath=/eos/cms/store/user/shtan/abhisek_ntuples/nov14/untarred        # Path to root MC folder
out_bigpath=/eos/cms/store/user/shtan/stage2stuff/feb8         # Path to root output folder
scripts_bigpath=/eos/user/s/shtan/batching/Full_MC2/scripts_stage2_feb8     # Path to root scripts folder

template_file=./script_template.sh
bsub_file=./script_bsub.sh

folders=${bigpath}/*/*/*/*  #Number of stars depends on folder structure
#folders=${bigpath}/TT_TuneCUETP8M2T4_13TeV-powheg-pythia8/*/*/*  #Number of stars depends on folder structure
batch_n=10000

for fol in $folders
do
    # Find directory structure within big MC folder
    bn1=$(basename "$fol")
    p1=$(dirname "$fol")
    bn2=$(basename "$p1")
    p2=$(dirname "$p1")
    bn3=$(basename "$p2")
    p3=$(dirname "$p2")
    bn4=$(basename "$p3")
    short_path=${bn4}/${bn3}/${bn2}/${bn1}  # Directory structure from MC folder
    #short_path_underscore=${bn4}_${bn3}_${bn2}_${bn1}

    echo "short path = ${short_path}"

    outpath=${out_bigpath}/${short_path}
    script_folder=${scripts_bigpath}/${short_path}
    #script_prefix=${scripts_bigpath}/${short_path_underscore}

    cd $out_bigpath
    mkdir $bn4
    cd $bn4
    mkdir $bn3
    cd $bn3
    mkdir $bn2
    cd $bn2
    mkdir $bn1

    cd $scripts_bigpath
    mkdir $bn4
    cd $bn4
    mkdir $bn3
    cd $bn3
    mkdir $bn2
    cd $bn2
    mkdir $bn1

    cd ${current_dir}

    files=${fol}/*.root
    for f in $files
    do
        filename=$(basename $f)
        filename_raw=$(echo $filename | cut -f 1 -d '.')  # Filename without extension
        outfile_raw=${outpath}/${filename_raw}_stage2        # Output filename without extension
        echo "filename = ${outfile_raw}"

        for i in {0..30}
        do
            echo "Processing ${i}th ${batch_n}..."
            starting=$(( $i * $batch_n ))       # Starting event number
            ending=$(( $starting + $batch_n ))  # Ending event number
            #if [ $i -eq $end_n ]
            #then
            #    ending=$n_entries           # If last batch
            #fi

            script_filename="${script_folder}/${filename_raw}_script_${starting}_${ending}.sh"
            #script_filename="${script_prefix}_${filename_raw}_script_${starting}_${ending}.sh"
            echo "script_filename = ${script_filename}"
            cp $template_file $script_filename

            outfilename=${outfile_raw}_${starting}_${ending}.root

            # Put values into template
            sed -i -e "s/put_starting_here/$starting/g" $script_filename
            sed -i -e "s/put_ending_here/$ending/g" $script_filename
            sed -i -e "s put_infilename_here $f g" $script_filename
            sed -i -e "s put_outfilename_here $outfilename g" $script_filename

            chmod 755 $script_filename
        done
    done
    
    cp $bsub_file ${script_folder}/   # bsub needs to be run from same folder as scripts

    cd $script_folder
    chmod 755 $bsub_file
    source $bsub_file

    cd $current_dir

done