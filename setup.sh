#!/bin/bash

##setup cmssw##
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc700
if [ -r CMSSW_10_2_6/src ] ; then 
 echo release CMSSW_10_2_6 already exists
else
scram p CMSSW CMSSW_10_2_6
fi
cd CMSSW_10_2_6/src
eval `scram runtime -sh`

scram b
cd ../../
seed=$(date +%s)

####declare binaries####

WORKDIR=`pwd`
MYBINS=$WORKDIR/bin
export PATH=${MYBINS}:${PATH}