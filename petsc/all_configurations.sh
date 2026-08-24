#!/bin/bash

function usage () {
    echo "Usage: $1 [ -h ] [ -j 123 ]"
    echo "    [ -f : skip fortran ]"
    # echo "    [ --install big/small]"
}

## export INSTALLATION=big
fortran=ON
jcount=6
while [ $# -gt 0 ] ; do
    if [ $1 = "-h" ] ; then
	usage && exit
    # elif [ $1 == "--install" ] ; then
    # 	shift && INSTALLATION=$1 && shift
    elif [ "$1" = "-f" ] ; then
	fortran=OFF && shift
    elif [ "$1" = "-j" ] ; then
	shift && jcount=$1 && shift
    else
	echo "Unknown option <<$1>>" && usage && exit 1
    fi
done

for i in 32 64 ; do
    export INTSIZE=$i
    for s in real complex ; do
	export SCALAR=$s
	for d in OFF ON ; do
	    export DEBUG=$d
	    SCRIPTSDIR=${PWD}/mpm_scripts_$s$i$d \
	    HAS_FORTRAN=${fortran} \
		      mpm.py regression
	done
    done
done
