#!/usr/bin/perl -w
use warnings;
die ("Usage: $ARGV[0] TV-Channel TIMEOUT-IN-MIN <FTP-SERVER/OUTPUTFILE>\n\n\tStreams:tagesschau_1,ntv_1,n24_1,daserste_1,zdf_1,rtl_1,sat1_1,prosieben_1,rtl2_1,vox_1,kabeleins_1,superrtl_1,eurosportde_1,sport1_1,disney_channel_de_1,pro7maxx_1,rtlnitro_1,sixx_1,kika_1,nickcc_1,viva_1,dmax_1,artede_1,3sat_1,phoenix_1,swr_1,wdr_1,br3_1,servus_1,orf1_1,orf2_1,sf1_1,sf2_1,3plus_1,atv_1,daserste_de,de14_v1,de13_v1,tagesschau_1,de12_v1,de11_v1,dach10_v1,servustvhd_1,livetvmdrsachsenanhalt_de,ndrfs_nds,wdrfs_geogeblockt,bfssued_germany,bralpha_germany,rbb_berlin,live_1\n") if (scalar (@ARGV) < 3);

print scalar(@urls)."\n";
my $time_to_die=0;
my $tvchan = $ARGV[0];
my $val = scalar($ARGV[1]);
my $timeout=$val*60; #in seconds 
my $file = $ARGV[2] || 'ftp://foilo:yeah12ha!!@nated.at:21/outtest.avi';
$file=~s/\.([a-z]+)$//;
my $filter = "";

$filter = '-vf "delogo=x=874:y=24:w=125:h=35:band=10"' if ($tvchan =~/pro7maxx/i);

print "TV:$tvchan\t$val\t$file\n";
exit;
if (-f '/tmp/ip.pls') {

}else{
 system("curl https://gist.githubusercontent.com/dbiesecke/c15243da0e8c17067c73/raw/gistfile1.txt > /tmp/ip.pls");
};
my ($url,$forward);

if(-f '/tmp/ip.pls') {
  $url = `cat /tmp/ip.pls | grep $tvchan`;
  $forward = $2 if ( $url=~/(.*)\|X-Forwarded-For=([\d\.]+)/) || die("ERROR! - $url\n");
  $url = $1;
  $url =~ s/i(\/$tvchan\@\d+).*/z$1\/manifest\.f4m/ig;
}
die("ERROR - cant find TV-Channel") if not ($url=~/http/);

print "$url\t$forward\n";
#exit;
$SIG{ALRM} = sub { $time_to_die=1; 
        system("killall livestreamer");
        system("killall ffmpeg");
        system("sleep 2 && clear && ls -lah outtest.avi");
        exit;


};

alarm($timeout);
while(!$time_to_die){
my $cmd =  'livestreamer --yes-run-as-root  -O --http-header "X-Forwarded-For='.$forward.'" "hds://'.$url.'" best | ffmpeg -i - -vcodec copy -c:v libx264 -c:a copy  '.$filter.' '.$file;
system($cmd);
print "[ERROR]\t Something went wrong!\n";
exit -1;
}

#will allow while loop to complete 
#after $SIG{ALRM} is received 
