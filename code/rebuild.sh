#!/bin/bash

echo ...read list

BLOCKLIST=$(cat ../blocklist.txt)
QUERY=$(cat ../query.txt)

echo ...clac fees

period1_start="2013-01-01"
period2_start="2015-04-01"
period3_start="2021-08-01"
end_date=$(date +%F)

function calculate() {
  local start="$1"
  local end="$2"
  local fee="$3"
  local months=$(datediff -i "%Y-%m-%d" -f "%m" "$start" "$end")
  let "total=fee*months"
  echo "$total"
}

period1=$(calculate "$period1_start" "$period2_start" 1798)
period2=$(calculate "$period2_start" "$period3_start" 1750)
period3=$(calculate "$period3_start" "$end_date" 1836)
total=$((period1 + period2 + period3))
let "ABZOCKSUMME = total / 100"
echo $ABZOCKSUMME €

echo ...write read me

README_MD="$(cat readme.tpl)"
README_MD="${README_MD/BLOCKLIST/$BLOCKLIST}"
README_MD="${README_MD/QUERY/$QUERY}"
README_MD="${README_MD/ABZOCKSUMME/$ABZOCKSUMME}"
echo "$README_MD" > ../ReadMe.md

echo ...update seo
wget https://rittersepp.github.io/GezAde/

sed '7i <meta name="google-site-verification" content="n0BqjWHUaEKAYcmD4Mv5MiB28rXXha6C76vKWGPUz8g" />' index.html > tmp1.html
sed '7i <meta name="msvalidate.01" content="B5BE1DBEFB1EEC8E97269DC72CD5261D" />' tmp1.html > tmp2.html
sed '42i <a href="https://github.com/RitterSepp/GezAde/"><img decoding="async" width="149" height="149" src="https://github.blog/wp-content/uploads/2008/12/forkme_left_green_007200.png?resize=149%2C149" class="attachment-full size-full" alt="Fork me on GitHub" loading="lazy" data-recalc-dims="1"></a>' tmp2.html > tmp3.html

cat tmp3.html | sed 's#<h1><a href="https://rittersepp.github.io/GezAde/">GezAde</a></h1>##g' > ../seo/index.html

rm *.html