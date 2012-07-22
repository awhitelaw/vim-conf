#!/bin/bash

echo "Setting up Vim"

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

cwdir="`pwd`"

echo "Setting up symlinks to config"
source "${DIR}/install/symlinks.sh"


echo "Removing existing bundles (incase one is not needed anymore)"
source "${DIR}/install/bundle_clean.sh"


#Check that vundle is initialised
if [ ! -f "$DIR/vim/bundle/vundle/README.md" ];then
	echo "Vundle not found. Installing"
	
	cd "$DIR"
	git submodule init
	git submodule update
	cd "$cwdir"
fi


echo "Installing Bundles"
vim +BundleInstall +BundleClean +qall
