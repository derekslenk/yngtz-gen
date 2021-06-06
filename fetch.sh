#!/bin/sh

while true; do

FN=$(TZ=America/New_York date +%Y-%m-%d-%H%M%S-%s)

curl 'http://www.cjh.com.cn/sqindex.html' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Referer: http://www.cjh.com.cn/swyb_sssq.html' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  --compressed \
  --insecure \
  -o out/$FN.html

touch updated

sleep 300

done
