#!/bin/bash
  
IN=/usr/local/etc  #папка которая бекапится
OUT=/var/backups/  #куда упадет
PREFIX=bckp
flag=0

for file in "$OUT"*tar.gz*
do
	if [[ $file = *bckp* && $file != *old && $file != *temp ]]
	then
		echo "Нашел актуальный бекап: $file"
		echo "Создаю его временную копию"
		mv $file "$file".temp
		flag=1
	fi
	if [[ $file = *bckp* && $file = *old ]]
	then
	echo "Нашел старую версию бекапа: $file"
		if [[ $flag != 1 ]]
		then
			echo "Она не актульна, удаляю"			
			rm $file	
		fi
	fi
done

if [[ $flag = 1 ]]
then
	echo "Переименовываю временную копию как старую"
	mv "$file".temp "$file".old
fi

date +%d_%m_%Y > tempfile
read str < tempfile
rm tempfile

arch="$OUT""$PREFIX"'_'"$str"'_'"$HOSTNAME"".tar.gz"
tar -cvzf $arch "$IN"

