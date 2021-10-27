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

if [ ! -d pngs ]; then
    mkdir pngs
else
    rm pngs/*
fi

/usr/bin/convert *${seqid}*JPG -verbose  -define png:bit-depth=16 "pngs/image_%04d.png"

python /data/MSL/process_dd_movie.py -i pngs/ima*png -o DustDevil_${sol}_${seqid}_rjcal.gif -b 0 -w 2.0 -g 2.5 -a 10 -m 15 -M 255 -v -e 20 -n -B 21 -N -d 5 -D .45

