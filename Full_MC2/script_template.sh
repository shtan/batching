#!/bin/bash

starting=put_starting_here
ending=put_ending_here

#infilename="ttHbbNtuple_1.root"
infilename=put_infilename_here

outfilename=put_outfilename_here

#outfilename="${starting}_${ending}"

#outfile="/afs/cern.ch/work/s/shtan/private/stage3stuff/20171103/signal1_${outfilename}.root"
#outfile="/eos/user/s/shtan/stage3_out/"

cd /eos/user/s/shtan/stage3/CMSSW_8_0_24/src/ttH_Cornell/util/ntuple_st2/build

./ntuple_st2 $infilename $outfilename $starting $ending

cd
