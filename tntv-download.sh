#!/bin/bash

urlbase=https://s3.amazonaws.com/the-nexus-tv/podcasts/

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
    if [[ ! -e "$1$2.mp3" ]] ; then
        sleep 2  # just to be nice
        wget "$urlbase$1/$1$2.mp3"
    fi
}


getseries cs
getpodcast cs 0 # i'm special!

getseries eb

getseries tu
getpodcast tu 18x

getseries tf
getpodcast tf 1x

getseries ns
getpodcast ns 5x

getseries atn
getpodcast atn 20x
getpodcast atn 31x
getpodcast atn 50x
getpodcast atn 50_64
getpodcast atn 56x
