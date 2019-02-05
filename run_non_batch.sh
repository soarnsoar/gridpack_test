ARR_GRIDPACK=( /data7/Users/jhchoi/slow_mg261_test/test_gridpack_LHEGS/gridpack_test/gridpacks/modify_before_GPGEN/dyellell01234j_5f_LO_MLM_mg261_false_pdfwgt_slc6_amd64_gcc630_CMSSW_9_3_8_tarball.tar.xz /data7/Users/jhchoi/slow_mg261_test/test_gridpack_LHEGS/gridpack_test/gridpacks/modify_after_GPGEN/dyellell01234j_5f_LO_MLM_mg261_false_pdfwgt_slc6_amd64_gcc630_CMSSW_9_3_8_tarball.tar.xz  )

ARR_JOBNAME=( modify_before_GPGEN modify_after_GPGEN )

NEVENT=50000

NTAG=`echo "scale=0; ${#ARR_GRIDPACK[@]} -1 " | bc` 

NJOB=1

echo "NTAG="$NTAG
for ITAG in `seq 0 ${NTAG}`; do
    
    GRIDPACKPATH=${ARR_GRIDPACK[${ITAG}]}
    JOBNAME=${ARR_JOBNAME[${ITAG}]}

    echo "==========="
    echo $JOBNAME
    echo "NJOB="$NJOB
    for IJOB in `seq 1 ${NJOB}`; do
    ##Make python files
	python_maker.py --gridpack_path $GRIDPACKPATH  --jobname ${JOBNAME}_${IJOB} --nevent $NEVENT
    ##Run

	cmsRun_jhchoi.sh ${JOBNAME}_${IJOB}_python.py

	

    done
done