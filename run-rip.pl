#!/usr/bin/perl -w
use warnings;

die ("Usage: $ARGV[0] TIMEOUT-IN-MIN <FTP-SERVER/OUTPUTFILE>\n") if (scalar (@ARGV) != 2);


my $time_to_die=0;
my $val = scalar($ARGV[0]);
my $timeout=$val*60; #in seconds 
my $file = $ARGV[0] || 'ftp://ftpuser:pass@deinserver.at:21/outtest.avi';

$SIG{ALRM} = sub { $time_to_die=1; 
        system("killall livestreamer");
        system("killall ffmpeg");
        system("sleep 2 && clear && ls -lah outtest.avi");
        exit;


};

alarm($timeout);
while(!$time_to_die){
system('livestreamer --yes-run-as-root  -O --http-header "X-Forwarded-For=195.186.136.21" "hds://http://pebbles107-lh.akamaihd.net/z/pro7maxx_1@97522//manifest.f4m" best | ffmpeg -i - -vcodec copy -c:v libx264 -c:a copy  -vf "delogo=x=874:y=24:w=125:h=35:band=10" '.$file);
print time,"\n";
}


