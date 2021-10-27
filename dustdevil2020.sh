#!/bin/bash


sol=$1
seqid=NCAM00525

if [ "x$2" != "x" ];then
    seqid=$2
fi

cd /data/M20

soldir=$sol
if [ $soldir -lt 1000 ]; then
    soldir=0${soldir}
fi

echo Processing in directory ${soldir}/NCAM

if [ ! -d 0${soldir}/NCAM ]; then
    mkdir -p ${soldir}/NCAM
fi

cd ${soldir}/NCAM 

m20_fetch_raw -c NAVCAM_LEFT -s $sol -S ${seqid}

if [ ! -d pngs ]; then
    mkdir pngs
else
    rm pngs/*
fi

/usr/bin/convert *${seqid}*J0?.png -verbose  -define png:bit-depth=16 "pngs/image_%04d.png"

python /data/MSL/process_dd_movie.py -i pngs/ima*png -o DustDevil_${sol}_${seqid}_rjcal.gif -b 0 -w 5.0 -g 2.5 -a 10 -m 15 -M 255 -v -e 20 -n -B 21 -N -d 5 -D .45

