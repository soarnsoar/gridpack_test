


ARR_GRIDPACK=( /cms/ldap_home/jhchoi/generator_group/slow_mg261/gridpacks/modify_before_GPGEN/dyellell01234j_5f_LO_MLM_mg261_false_pdfwgt_slc6_amd64_gcc630_CMSSW_9_3_8_tarball.tar.xz /cms/ldap_home/jhchoi/generator_group/slow_mg261/gridpacks/modify_after_GPGEN/dyellell01234j_5f_LO_MLM_mg261_false_pdfwgt_slc6_amd64_gcc630_CMSSW_9_3_8_tarball.tar.xz  )

ARR_JOBNAME=( modify_before_GPGEN modify_after_GPGEN )

#NEVENT=10000
NEVENT=10000

NTAG=`echo "scale=0; ${#ARR_GRIDPACK[@]} -1 " | bc` 

NJOB=50

echo "NTAG="$NTAG
for ITAG in `seq 0 ${NTAG}`; do

    GRIDPACKPATH=${ARR_GRIDPACK[${ITAG}]}
    JOBNAME=${ARR_JOBNAME[${ITAG}]}_10k_50j


    JOBDIR=$PWD/../JOBS/JOBDIR_$JOBNAME ##Must be matched to one in create_ajob.py
#(0) cmsRun shell
    echo "cmsRun shell  "

    echo "#!/bin/bash" > $JOBNAME.sh
    echo "StartTime=\$(date +\%s)" >> $JOBNAME.sh
    echo "tar -xf INPUT.tar" >> $JOBNAME.sh
#    echo "cd "$PWD >> $JOBNAME.sh
#    echo "ls" >> $JOBNAME.sh
    echo "source setup.sh" >> $JOBNAME.sh
#    echo "cd CMSSW_10_2_6/src"  >> $JOBNAME.sh
#    echo "cmsenv" >> $JOBNAME.sh
#    echo "scram b -j 10" >> $JOBNAME.sh
#    echo "cd -" >> $JOBNAME.sh
    echo "cmsRun ${JOBNAME}_python.py" >> $JOBNAME.sh 
    echo "EndTime=\$(date +\%s)" >> $JOBNAME.sh
    echo "echo \$EndTime" >> $JOBNAME.sh
    echo "echo \"runtime : \$((\$EndTime - \$StartTime)) sec\" " >> $JOBNAME.sh
    
   
#(1) create job
    echo "create job"
    create_ajob.py --runshell $JOBNAME.sh --jobname $JOBNAME --njob $NJOB --nosubmit --inputtar INPUT.tar
    
#(2)make python
    echo "make python"
    python_maker.py --gridpack_path $GRIDPACKPATH  --jobname ${JOBNAME} --nevent $NEVENT
    #mv ${JOBNAME}_python.py $JOBDIR
#(3) tar input & move each scripts
    tar -cf INPUT.tar *
    mv INPUT.tar $JOBDIR
    mv ${JOBNAME}_python.py $JOBDIR
    mv $JOBNAME.sh $JOBDIR
#(4)submit
    echo "submit"
    cd $JOBDIR
    condor_submit submit.jds
    cd -
done