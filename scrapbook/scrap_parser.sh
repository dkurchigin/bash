#!/bin/bash
scrap_files=/home/myasus/.mozilla/firefox/vaj0o9ye.default/ScrapBook/data/
#scrpt_dir=/usr/local/etc/scripts/scrapbook/

cd $scrap_files
for file in *
do
	if [[ -d $file ]] 
	then
		awk -F"<title>|</title>" '/<title>/ { print $2 }' "$file"/index.html > /tmp/scrap_tmp
		read dir_title < /tmp/scrap_tmp
		#echo "$file | $dir_title"
		if [[ -e $dir_title ]]
		then
			echo "Папка $dir_title уже существует"
		else
			mv  "$file" "$dir_title"	
		fi
	fi
done
rm /tmp/scrap_tmp
