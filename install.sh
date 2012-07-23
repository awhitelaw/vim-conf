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
# Create file array that we need
linksrc=()
linkdst=()

linksrc[${#linksrc[@]}]=".gvimrc"
linkdst[${#linkdst[@]}]="gvimrc"

linksrc[${#linksrc[@]}]=".vim"
linkdst[${#linkdst[@]}]="vim"

linksrc[${#linksrc[@]}]=".vimrc"
linkdst[${#linkdst[@]}]="vimrc"

linksrc[${#linksrc[@]}]=".vimrc.local"
linkdst[${#linkdst[@]}]="vimrc.local"


for (( i=0; i<${#linkdst[@]}; i++ ));
do
	p1="$HOME/${linksrc[$i]}"
	p2="$DIR/${linkdst[$i]}"

	if [[ -e "$p1" ]];then
		if [[ -h "$p1" ]];then
			chkpath=`readlink "$p1"`
			if [ "$chkpath" = "$p2" ];then
				#It's a link we've set previously so it's fine
				rm -f "$p1"
				continue;
			fi
		fi
		if [[ -e "$p1"   ]];then
			#it's a link we don't know so error out
			echo "We have detected previous files that were not set by this script."
			echo "To continue, please manually remove the following files"
			
			for (( y=0; y<${#linkdst[@]}; y++ ));
			do
				py1="$HOME/${linksrc[$y]}"
				py2="$DIR/${linkdst[$y]}"

				if [[ -e "$py1" ]];then
					if [[ -h "$py1" ]];then
						chkpath=`readlink "$py1"`

						if [ "$chkpath" = "$py2" ];then
							continue;
						else
							echo "$py1"
						fi
					else
						#it's a link we don't know so error out
						echo "$py1";
					fi
				fi
			done
			exit 0
		fi
	fi
done


# All good so now set our links
for (( i=0; i<${#linkdst[@]}; i++ ));
do
	p1="$HOME/${linksrc[$i]}"
	p2="$DIR/${linkdst[$i]}"

	#if we detected anything earlier, it would have been our own symlink so ignore
	if [[ -e "$p1" ]];then
		continue
	fi

	echo "Linking: $p2"

	ln -s "$p2" "$p1"

done


echo "Removing existing bundles (incase one is not needed anymore)"
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
