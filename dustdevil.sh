#!/bin/bash


sol=$1
seqid=NCAM00595

if [ "x$2" != "x" ];then
    seqid=$2
fi

cd /data/MSL

if [ ! -d $sol/NCAM ]; then
    mkdir -p $sol/NCAM
fi

cd $sol/NCAM 

msl_fetch_raw -c NAV_RIGHT HAZ_FRONT HAZ_REAR -s $sol -S ${seqid}

msl_ecam_calibrate -i *JPG -v -t 2.0

diffgif -i *${seqid}*-rjcal.png -o DustDevil_${sol}_${seqid}_rjcal.gif -v -b 0 -w 2.0 -g 2.5 -B 1.5 -d 20
