#!/bin/bash

template_file=./script_template.sh

for i in {0..39}
do
    echo "Processing ${i}th 500..."
    starting=$(($i*500))
    ending=$(($starting+499))

    script_filename="./scripts_folder/script_${starting}_${ending}.sh"
    cp $template_file $script_filename

    sed -i -e "s/put_starting_here/$starting/g" $script_filename
    sed -i -e "s/put_ending_here/$ending/g" $script_filename

    chmod 755 $script_filename

done

