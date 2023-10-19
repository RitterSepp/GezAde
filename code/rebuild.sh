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


