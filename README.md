iptv-rec
------------
Nutzt öffentliche IP-TV Server um Sendungen zu Speichern & ggfls. Sender Logo zu entfernen.

* Speichert ab diesem Zeitpunkt 60 Minuten von RTL2 & bennennt es als output-<date>-<channel>.avi

  `$ docker run -it dbiesecke/docker-iptv-rec rtl2 60 output.avi`


* Zeichnet  30 Minuten von pro7maxx auf &  speichert die datei direkt auf einem FTP ( mit schreibrechten). Es wird automatisch das Logo Entfernt, Filter ist hinterlegt

  `$ docker run -it dbiesecke/docker-iptv-rec pro7maxx_1 30 'ftp://username:password@server:21/public/output.avi'`


Usage
---------------------


      $ docker run -it docker-iptv-rec 
      Usage:  TV-Channel TIMEOUT-IN-MIN <FTP-SERVER/OUTPUTFILE>
      
              Streams: tagesschau_1,ntv_1,n24_1,daserste_1,zdf_1,rtl_1,sat1_1,prosieben_1,rtl2_1,vox_1,kabeleins_1,superrtl_1,eurosportde_1,
              sport1_1,disney_channel_de_1,pro7maxx_1,rtlnitro_1,sixx_1,kika_1,nickcc_1,viva_1,dmax_1,artede_1,3sat_1,phoenix_1,swr_1,wdr_1,
              br3_1,servus_1,orf1_1,orf2_1,sf1_1,sf2_1,3plus_1,atv_1,daserste_de,de14_v1,de13_v1,tagesschau_1,de12_v1,de11_v1,dach10_v1,servustvhd_1,
              livetvmdrsachsenanhalt_de,ndrfs_nds,wdrfs_geogeblockt,bfssued_germany,bralpha_germany,rbb_berlin,live_1



Save (Internet) TV Streams easy on HDD - "manualy"
-------------------------------------------
* Use your fav. TV Stream from list like my [iptv.m3u8](https://gist.githubusercontent.com/dbiesecke/c15243da0e8c17067c73/raw/gistfile1.txt)
* install livestreamer 


    `livestreamer -O --yes-run-as-root  --http-header "X-Forwarded-For=195.186.136.21" "hds://http://pebbles107-lh.akamaihd.net/z/pro7maxx_1@97522//manifest.f4m" best | ffmpeg  -i - -c:v copy   -vcodec copy -c:a copy   /video/outfile.mkv`



Manifest for best selection
--------------------------------------
* You can transform url's to  files like this: `http://pebbles107-lh.akamaihd.net/i/pro7maxx_1@97522/master.m3u8` to
    `http://pebbles107-lh.akamaihd.net/z/pro7maxx_1@97522/manifest.f4m`


        % livestreamer  --http-header "X-Forwarded-For=195.186.136.21" "hds://http://pebbles107-lh.akamaihd.net/z/rtl2_1@97460/manifest.f4m" best                                                                        :(
        [cli][info] Found matching plugin stream for URL hds://http://pebbles107-lh.akamaihd.net/z/rtl2_1@97460/manifest.f4m
        [cli][info] Available streams: 1428k (best), 908k (worst)
        [cli][info] Opening stream: 1428k (hds)
        [....]

