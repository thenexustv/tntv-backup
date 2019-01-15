#!/bin/bash

# this script is OSX compatiable
# CURL is required since OSX does not have wget

ryanStyle=$1
ryanDirectory="podcasts"
urlbase=https://s3.amazonaws.com/the-nexus-tv/podcasts/
scriptPath="`dirname \"$0\"`"
cd $scriptPath

if [[ -z $ryanStyle ]] ; then
	ryanStyle=true;
fi

function getseries(){
    local i=1
    while [[ true ]] ; do
        getpodcast $1 $i
        if [[ $? -ne 0 ]] ; then
            break;
        fi
        let i++
    done
    return 0
}

function getpodcast(){
	if $ryanStyle ; then
		podcasts="$scriptPath/$ryanDirectory/$1"
	else
		podcasts="$scriptPath"
	fi
    
    # just in case the directory does not exist
    mkdir -p "$podcasts"

    echo "$podcasts/$1$2.mp3"
    if [[ ! -e "$podcasts/$1$2.mp3" ]] ; then
        sleep 2  # just to be nice
		if $ryanStyle ; then
            curl -L -k -o "$podcasts/$1$2.mp3" "$urlbase$1/$1$2.mp3"
		else
			curl -L -k -o "$podcasts/$1$2.mp3" "$urlbase$1/$1$2.mp3"
		fi
        echo "\n\n"
    fi
}

# Each series is downloaded below
# After each series is downloaded,
# exceptions to the series conventions are downloaded
# ---

# At The Nexus
getseries atn
getpodcast atn 20x
getpodcast atn 31x
getpodcast atn 50x
getpodcast atn 50_64
getpodcast atn 56x
getpodcast atn 61x

# # Control Structure
getseries cs
getpodcast cs 0 # i'm special!

# # Eight Bit
getseries eb

# # In Bootcamp
getseries ib

# # Nexus Special
getseries ns
getpodcast ns 5x

# # Podkit
getseries pk

# # Robots Will Steal Your Job
getseries rsj
getpodcast rsj 0 # intro

# # Second Opinion
getseries so

# # The Extra Dimension
getseries ted

# # The Fringe
getseries tf
getpodcast tf 1x

# # The Universe
getseries tu
getpodcast tu 18x

