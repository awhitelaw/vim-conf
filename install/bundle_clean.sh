#!/bin/bash

bundle_dir="$DIR/vim/bundle/"
for file in ${bundle_dir}*; do
	base=`basename "$file"`
	
	if [ "$base" == "vundle" ];then
		continue
	fi
	
	if [ -d "$file" ];then
		echo "Removing '$file'"
		rm -rf $file
	fi
done
