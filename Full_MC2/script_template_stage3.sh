#!/bin/bash

#infilename="ttHbbNtuple_1.root"
infilename=put_infilename_here

outfilename=put_outfilename_here

#outfilename="${starting}_${ending}"

#outfile="/afs/cern.ch/work/s/shtan/private/stage3stuff/20171103/signal1_${outfilename}.root"
#outfile="/eos/user/s/shtan/stage3_out/"

cd /eos/user/s/shtan/stage3/CMSSW_8_0_24/src
#cmsenv
eval `scramv1 runtime -sh`

stage3 $infilename $outfilename

cd
