StartTime=$(date +%s)
mkdir -p  workdir_$1
mv $1 workdir_$1/
pushd workdir_$1
cmsRun $1 &> $1.log

        #cmsRun_jhchoi.sh ${JOBNAME}_${IJOB}_python.py &> ${JOBNAME}_${IJOB}.log & 


mkdir -p cmsrun_pythons
mv $1 cmsrun_pythons/

mkdir -p cmsrun_log
mv $1.log cmsrun_log/


EndTime=$(date +%s)
echo $EndTime
echo "runtime : $(($EndTime - $StartTime)) sec" >> $1_time.log
popd