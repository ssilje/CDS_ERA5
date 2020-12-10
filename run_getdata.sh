#!/bin/bash

# get argument                                                                                                                                                                                                                                                                                                                                         
datein=${1}
year=$(echo ${datein} | cut -d'-' -f1)
month=$(echo ${datein} | cut -d'-' -f2)
echo ${datein}

run_dir='/cluster/home/sso102/ERA5/CDS_ERA5'
savedata='/cluster/work/users/sso102/ERA5/ERA5'


if [ ! -d ${run_dir}/jobs ]
then
    mkdir ${run_dir}/jobs
else
    rm -r ${run_dir}/jobs
    mkdir ${run_dir}/jobs
fi

   
cp $run_dir/getdata_CDS_ERA5.py $run_dir/jobs/getdata_CDS_ERA5${datein}.py 
sed -i "s/2019/$year/g" $run_dir/jobs/getdata_CDS_ERA5${datein}.py 
sed -i "s/'month': '01'/'month': ' $month '/g" $run_dir/jobs/getdata_CDS_ERA5${datein}.py
sed -i "s/DATA/$savedata_$datein/g" $run_dir/jobs/getdata_CDS_ERA5${datein}.py

  
