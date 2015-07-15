Save (Internet) TV Streams easy on HDD
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





