#!/bin/sh
       SONY_mf="0x00009470"  # 38k Hz
   SONY_header="0x80000729 0x0000035d"
      SONY_one="0x80000381 0x00000312"
     SONY_zero="0x800001ad 0x00000312"
   SONY_ptrail="0x800001ad"
 SONY_pre_data

mf=$SONY_mf
header=$SONY_header
ptrail=$SONY_ptrail
pdata=$SONY_pre_data
l=$SONY_one
O=$SONY_zero

echo /usr/bin/testir $mf $header $predata $l $O $l $O $l $O $O $l $O $O $O $ptrail
