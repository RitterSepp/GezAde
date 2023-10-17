#!/bin/bash

FUTURE_HOMELESS_SHELTER="https://www.rundfunkbeitrag.de/der_rundfunkbeitrag/senderfamilie/"
WHITELIST="instagram|facebook|twitter|youtube|wikipedia|google|spotify|amazon|snapchat|whatsapp|windows|\.com|\.org|\.net|\.eu"

# wget $FUTURE_HOMELESS_SHELTER
# cat *.htm* | sed 's/></>\n</g'| grep 'href\="http' | sed 's/href=/$/g' | cut -d'$' -f2 | cut -d'"' -f2 > urls.tmp
# find . -type f -name '*.htm*' -exec rm {} \;
# 
# echo searching redirects
# while IFS= read -r URL; do
#     echo -n "."
#     LOCATION=$(curl -I -s "$URL" | grep "Location" | cut -d: -f2-3 | sed 's/ //g')
#     if [[ -n "$LOCATION" ]]; then
#         # echo "$LOCATION"
#         echo "$LOCATION" >> urls_redirect.tmp
#     fi
# done < urls.tmp
# echo
# 
# echo following urls
# grep '/$\|\.html$\|\.de$' urls.tmp | sort | uniq > to_follow.tmp
# while IFS= read -r MORE_HOMELESS_SHELTER; do
#     wget $MORE_HOMELESS_SHELTER
#     WHITELINKS=$(cat *.htm* | sed 's/></>\n</g' | grep 'href\="http' | sed 's/href=/$/g' | cut -d'$' -f2 | cut -d'"' -f2 | grep -E $WHITELIST)
#     if [ -z "$WHITELINKS" ]; then
#         cat *.htm* | grep 'href\="http' | sed 's/href=/$/g' | cut -d'$' -f2 | cut -d'"' -f2 | grep http >> urls_link.tmp
#     fi
#     find . -type f -name '*.htm*' -exec rm {} \; 
# done < to_follow.tmp
# 
# echo searching more redirects
# while IFS= read -r URL; do
#     echo -n "."
#     LOCATION=$(curl -I -s "$URL" | grep "Location" | cut -d: -f2-3 | sed 's/ //g')
#     if [[ -n "$LOCATION" ]]; then
#         echo "$LOCATION" >> urls_redirect.tmp
#     fi
# done < urls_link.tmp
# echo
# 
# cat urls* | cut -d/ -f3 | grep -v '#' >> domains.tmp
# grep '\..*\..*' domains.tmp | rev | cut -d. -f1,2 | rev >> domains_shortend.tmp
# mv ../blacklist.txt ../blacklist.$(date +%Y%m%d_%H%M).txt
# cat domains* | grep '.' | sed 's/www\.//g' | sort  | uniq > ../blacklist.txt

# echo searching trends
# while IFS= read -r TRENDING; do
#     echo search $TRENDING
#     lynx --accept_all_cookies --source https://www.bing.com/search?q=$TRENDING > index.html
# 	lynx --accept_all_cookies --source https://www.bing.com/news/search?q=$TRENDING >> index.html
# 	while IFS= read -r PROPAGANDA_PROVIDER; do
# 	    if grep -q $PROPAGANDA_PROVIDER index.html; then
# 		    echo "        found $PROPAGANDA_PROVIDER"
#             echo "$PROPAGANDA_PROVIDER" >> query.tmp
#         fi
#     done < ../blacklist.txt
#     find . -type f -name '*.htm*' -exec rm {} \;
# done < trends.txt
# 
# echo creating output
# cat query.tmp | sort | uniq >> query_sorted.tmp
BLACKLIST=$(cat ../blacklist.txt)
QUERY=$(cat ../query.txt)
# while IFS= read -r URL; do
#     QUERY="$QUERY -site:$URL"
# done < query_sorted.tmp
# echo $QUERY > ../query.txt
# 
# FOUND=$(wc -l ../blacklist.txt)
# echo "found $FOUND domains"

README_MD="$(cat readme.tpl)"
README_MD="${README_MD/BLACKLIST/$BLACKLIST}"
README_MD="${README_MD/QUERY/$QUERY}"
echo "$README_MD" > ../ReadMe.md

# rm *.tmp
