#!/usr/bin/perl -w

my $SONY_mf="0x00009470";  # 38k Hz
my $SONY_header="0x80000729 0x0000035d";
my $SONY_one="0x80000381 0x00000312";
my $SONY_zero="0x800001ad 0x00000312";
my $SONY_ptrail="0x800001ad";
my $SONY_pre_data ="";

my $mf=$SONY_mf;
my $header=$SONY_header;
my $ptrail=$SONY_ptrail;
my $pdata=$SONY_pre_data;
my $l=$SONY_one;
my $O=$SONY_zero;

system("ssh", "root\@192.168.0.249", '/usr/bin/testir',
    qw($mf $header $predata $l $O $l $O $l $O $O $l $O $O $O $ptrail) );

