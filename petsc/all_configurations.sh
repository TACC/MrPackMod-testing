#!/bin/bash

function usage () {
    echo "Usage: $1 [ -h ] [ -j 123 ] [ -l logprefix ]"
    echo "    [ -f : skip fortran ]"
}

fortran=ON
jcount=6
logprefix="all"
while [ $# -gt 0 ] ; do
    if [ $1 = "-h" ] ; then
	usage && exit
    elif [ "$1" = "-f" ] ; then
	fortran=OFF && shift
    elif [ "$1" = "-j" ] ; then
	shift && jcount=$1 && shift
    elif [ "$1" = "-l" ] ; then
	shift && logprefix="$1" && shift
    else
	echo "Unknown option <<$1>>" && usage && exit 1
    fi
done

#
# global log file
#
logfile=test_${logprefix}.log
rm -f ${logfile} && touch ${logfile}

baseversion=$( mpm.py version )
for i in 32 64 ; do
    export INTSIZE=$i
    for s in real complex ; do
	export SCALAR=$s
	for d in OFF ON ; do
	    export DEBUG=$d
	    extension=\
$( if [ $s = "complex" ] ; then echo "complex" ; fi )\
$( if [ $i = "64" ] ; then echo "i64" ; fi )\
$( if [ $d = "ON" ] ; then echo "debug" ; fi )
	    if [ -z "${extension}" ] ; then
		packageversion="${baseversion}"
	    else
		packageversion="${baseversion}-${extension}"
	    fi
	    SCRIPTSDIR=${PWD}/mpm_scripts_$s$i$d \
		  PACKAGEVERSION=${packageversion} \
		  HAS_FORTRAN=${fortran} \
		  mpm.py regression
	done
    done
done 2>&1 | tee -a ${logfile}
echo -e "\nSee ${logfile}\n"

