#!/bin/bash


#Grab the current script directory
SOURCE="${BASH_SOURCE[0]}"
DIR="$( dirname "$SOURCE" )"
while [ -h "$SOURCE" ]
do 
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
	DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# Create file array that we need
link[0]=".gvimrc"
link[1]=".vim"
link[2]=".vimrc"
link[3]=".vimrc.local"

# First check if files already exist
for i in "${link[@]}"; do
	
	if [[ -f "$HOME/$i" || -d "$HOME/$i" ]] 
	then
		echo "Existing vim files/directories detected."
		echo "Please make sure the following files are removed"
		for i in "${link[@]}"; do
			echo "~/$i"		
		done
		exit 1
	fi
done

# link
for i in "${link[@]}"; do
	isrc=`echo "${i}" | sed 's/^\.//'` 
	echo "Linking: $DIR/$isrc"
	
	ln -s "$DIR/$isrc" "$HOME/$i"
done
