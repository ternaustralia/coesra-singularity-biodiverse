#!/bin/bash
container_name=$1
tag=$(git name-rev --name-only --tags HEAD)
if [[ $tag != "undefined" ]]; then
	/bin/bash .travis/build.sh -u "coesra/$container_name" -t $tag -c registry "Singularity.$container_name" 
else
	echo "Not in tag. Not build attempted!"
fi

