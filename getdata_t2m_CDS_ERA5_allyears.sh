#!/bin/bash



syear=1999
eyear=2020
month='01 02 03 04 05 06 07 08 09 10 11 12'
script_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
var='sst'
run_dir='/cluster/work/users/sso102/ERA5/'
savedir='/cluster/work/users/sso102/ERA5/sfc/${var}'


if [ ! -d ${run_dir}/jobs ]
then
    mkdir ${run_dir}/jobs
else
    rm -r ${run_dir}/jobs
    mkdir ${run_dir}/jobs
fi


YYYY=${syear}

while [ ${YYYY} -le ${eyear} ]
do

for m in ${month}; do 

datein=$YYYY$m
echo ${savedir}ERA5_${datein}

cp $script_dir/getdata_${var}_CDS_ERA5.py $run_dir/jobs/getdata_${var}_CDS_ERA5_${datein}.py 
sed -i "s/2019/${YYYY}/g" $run_dir/jobs/getdata_${var}_CDS_ERA5_${datein}.py 
sed -i "s/'month': '01'/'month': ' $m '/g" $run_dir/jobs/getdata_${var}_CDS_ERA5_${datein}.py
#sed -i "s/DATA/${${savedir}ERA5_${datein}//\//\\/}/g" $run_dir/jobs/getdata_t2m_CDS_ERA5_${datein}.py
sed -i 's|DATA|'${savedir}ERA5_${var}_${datein}'|g' $run_dir/jobs/getdata_${var}_CDS_ERA5_${datein}.py

if [ ! -f ${savedir}ERA5_${var}_${datein}.grb ]
then
 echo "running python $run_dir/jobs/getdata_${var}_CDS_ERA5_${datein}.py"
  
 python  $run_dir/jobs/getdata_${var}_CDS_ERA5_${datein}.py
 wait
 echo "done..."
 else 
 echo " File already downloded "
fi  


done
YYYY=`expr ${YYYY} + 1`
done
