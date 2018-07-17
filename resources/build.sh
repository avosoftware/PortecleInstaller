#!/bin/sh

VERSION=$1

if [ -z "$VERSION" ]; then
	echo 1>&2
	echo "--------------------------------" 1>&2
    echo ERROR: No version supplied 1>&2
	echo 1>&2
    exit 1 # terminate and indicate error
fi

rm -f /portecle-installer/portecle/Portecle.exe
rm -f /portecle-installer/portecle/Portecle-Installer-$VERSION.exe

/portecle-installer/launch4j/launch4j /portecle-installer/resources/launch4j/config.xml

if [ ! -f /portecle-installer/portecle/Portecle.exe ]; then
	echo 1>&2
	echo "--------------------------------" 1>&2
	echo ERROR: Failed to generate Portecle.exe file 1>&2
	echo 1>&2
    exit 1 # terminate and indicate error
fi

makensis -DFILE_VERSION=1.0.0.0 -DPRODUCT_VERSION=$VERSION.0.0 -DVERSION=$VERSION /portecle-installer/resources/nsis/installer.nsi
     
if [ -f /portecle-installer/portecle/Portecle-Installer-$VERSION.exe ]; then
	echo
	echo "--------------------------------"
	echo "Installer succesfully generated!"
	echo
else
	echo 1>&2
	echo "--------------------------------" 1>&2
	echo ERROR: Failed to generate Portecle-Installer-$VERSION.exe installer file 1>&2
	echo 1>&2
    exit 1 # terminate and indicate error
fi