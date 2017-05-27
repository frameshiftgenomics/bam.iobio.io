#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
samtools=$DIR/samtools
bamstatsalive=$DIR/bamstatsalive

s=false

while getopts ":u:k:r:b:s" o; do
    case "${o}" in
    	b)  b=${OPTARG}
            ;;
        u)
            u=${OPTARG}
            ;;
        k)
            k=${OPTARG}
            ;;
        r)
            r=${OPTARG}
            ;;
        s)
            s=true
            ;;
    esac
done

shift $(($OPTIND - 1))

if ($s) ; then
	cat - | $samtools view -S -b -  | $bamstatsalive -u $u -k $k -r $r
else
	$samtools view -b $b $1 | $bamstatsalive -u $u -k $k -r $r
fi
