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

# NCAM Dust Devil Movie NCAM00596
msl_fetch_raw -c NAV_RIGHT -s $sol -S NCAM00596

# NCAM Cloud Shadow
msl_fetch_raw -c NAV_RIGHT -s $sol -S NCAM00556

# NCAM Zenith Movie
msl_fetch_raw -c NAV_RIGHT -s $sol -S NCAM00551
msl_fetch_raw -c NAV_RIGHT -s $sol -S NCAM00536

# NCAM Suprahorizon Movie
msl_fetch_raw -c NAV_RIGHT -s $sol -S NCAM00567

# NCAM Shunt Prevention Super SPENDI
msl_fetch_raw -c NAV_RIGHT -s $sol -S NCAM00597

msl_ecam_calibrate -i *JPG -v -t 2.0

if [ `ls *${seqid}*-rjcal.png 2> /dev/null | wc -l` -gt 0 ]; then
    diffgif -i *${seqid}*-rjcal.png -o DustDevil_${sol}_${seqid}_rjcal.gif -v -b 0 -w 2.0 -g 2.5 -l 5 -d 20 -p stacked
fi

if [ `ls *NCAM00556*-rjcal.png 2> /dev/null | wc -l` -gt 0 ]; then
    diffgif -i *NCAM00556*-rjcal.png -o CloudShadow_${sol}.gif -v -b 0 -w 1.0 -g 2.5 -l 5 -d 20
fi

if [ `ls *NCAM00551*-rjcal.png 2> /dev/null | wc -l` -gt 0 ]; then
    diffgif -i *NCAM00551*-rjcal.png -o ZenithMovie_${sol}.gif -v -b 0 -w 1.0 -g 2.5 -l 5 -d 20
fi

if [ `ls *NCAM00536*-rjcal.png 2> /dev/null | wc -l` -gt 0 ]; then
    diffgif -i *NCAM00536*-rjcal.png -o ZenithMovie_${sol}.gif -v -b 0 -w 1.0 -g 2.5 -l 5 -d 20
fi

if [ `ls *NCAM00567*-rjcal.png 2> /dev/null | wc -l` -gt 0 ]; then
    diffgif -i *NCAM00567*-rjcal.png -o SupraHorizonMovie_${sol}.gif -v -b 0 -w 1.0 -g 2.5 -l 5 -d 20
fi

if [ `ls *NCAM00596*-rjcal.png 2> /dev/null | wc -l` -gt 0 ]; then
    diffgif -i *_S*NCAM00596*rjcal.png -o DustDevil596_${sol}.gif -v -b 0 -w 5.0 -g 1.5 -l 5 -d 40
fi

if [ `ls *_F*NCAM00597*-rjcal.png 2> /dev/null | wc -l` -gt 0 ]; then
    diffgif -i *_F*NCAM00597*rjcal.png -o SuperSPENDFullFrameI597_${sol}.gif -v -b 0 -w 3.0 -g 1.5 -l 5 -d 40
fi

if [ `ls *_S*NCAM00597*-rjcal.png 2> /dev/null | wc -l` -gt 0 ]; then
    diffgif -i *_S*NCAM00597*rjcal.png -o SuperSPENDISubFrame597_${sol}.gif -v -b 0 -w 5.0 -g 1.5 -l 5 -d 40
fi
