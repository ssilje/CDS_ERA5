#!/bin/bash

# get argument                                                                                                                                                                                                                                                                                                                                         
datein=${1}
year=$(echo ${datein} | cut -d'-' -f1)
month=$(echo ${datein} | cut -d'-' -f2)
echo ${datein}

run_dir='/cluster/home/sso102/ERA5'
savedir='/cluster/work/users/sso102/ERA5'


if [ ! -d ${run_dir}/jobs ]
then
    mkdir ${run_dir}/jobs
else
    rm -r ${run_dir}/jobs
    mkdir ${run_dir}/jobs
fi

if [ ! -d ${savedir} ]
then
    mkdir ${savedir}

fi

y=$(echo ${d} | cut -d'-' -f1)
m=$(echo ${d} | cut -d'-' -f2)
   
cp $run_dir/getdata_CDS_ERA5.py $run_dir/jobs/getdata_CDS_ERA5${d}.py 
sed -i "s/2019/$y/g" $run_dir/jobs/getdata_CDS_ERA5${d}.py 
sed -i "s/'month': '01'/'month': ' '$m' '/g" $run_dir/jobs/getdata_CDS_ERA5${d}.py 
  
