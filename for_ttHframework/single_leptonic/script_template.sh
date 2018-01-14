#!/bin/bash

starting=put_starting_here
ending=put_ending_here

folder="${starting}_${ending}"

inputfile="ttbb_h_bbbbdue.lhe"
outdir="/afs/cern.ch/work/s/shtan/private/topreco_20161213/20180113/${folder}"

mkdir -p $outdir
mkdir -p "${outdir}/plots"

cd /eos/user/s/shtan/topreco/ttH_framework/

source setup.sh

./bin/test2 $starting $ending $inputfile $outdir fitplot

cd
