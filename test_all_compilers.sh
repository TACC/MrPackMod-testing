#!/bin/bash

pkgversion=$( mpm.py version )
while [ $# -gt 0 ] ; do
    if [ "$1" = "-v" ] ; then
	shift && pkgversion=$1 && shift
    else
	echo "Error: unrecognized option <<$1>>" && exit 1
    fi
done

package=$( mpm.py package | tail -n 1 )
echo "================================================================"
echo "    Testing package=${package}/${pkgversion}"
echo "================================================================"
echo

modulereset ()
{
    module purge;
    module reset;
    if [ $( echo $MODULEPATH | grep $( whoami ) | wc -l ) -gt 0 ]; then
        echo "ERROR still private modules left:";
        echo ${MODULEPATH} | tr ':' '\n';
        exit 1;
    fi
}

host=$(hostname)
host=${host%%.tacc.utexas.edu}
host=${host##*.}
for compiler in $( cat ../compilers_${host}.sh ) ; do
    echo -e "================\nTesting: $compiler\n================"
    modulereset 2>/dev/null
    path=${compiler%%:*}
    if [ ! -z "${path}" ] ; then module use $path 2>/dev/null ; fi
    compiler=${compiler##*:}
    module -t load $compiler 2>/dev/null
    if [ $? -gt 0 ] ; then
	echo "Could not load compiler=${compiler}"
	continue
    else
	module -t try-load ${package}/${pkgversion} 2>/dev/null
	if [ $? -gt 0 ] ; then
	    echo "Could not load package=${package}"
	    continue
	fi
	compilermodule=$( module -t show ${compiler} 2>&1 )
	SYSTEMMODULES=cmake \
	     PACKAGEVERSION=${pkgversion} \
	     REGRESSIONHEADEREXTRA=", compiler=${compilermodule}" \
	     mpm.py regression
    fi
done
