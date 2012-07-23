#!/bin/bash

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
				continue;
			else
				rm -f "$p1"
			fi
		fi
		if [[ -e "$p1" ]];then
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

