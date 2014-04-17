#!/bin/bash

export NEET=/opt/neet
export CONFIDR="${NEET}/etc"
export VERSION=`cat VERSION`
export INST="${PWD}"

if [ ! -d "$NEET" ]; then
	echo "Couldn't find neet installation. Exiting."
	exit 1
fi

. ${NEET}/core/installsupport

if [ ! -z $INVOKEDBYNEETUPDATE ] && [ $INVOKEDBYNEETUPDATE -eq 1 ]; then
	echo -n "   + Installing neet shell updates..."
	FILESTOREMOVE=""
	for file in $FILESTOREMOVE; do
		rm -f "$file"
	done
	#######################################################

	[ ! -d "${NEET}/neetsh" ] && mkdir -p "${NEET}/neetsh"
	cp -R content/* "${NEET}/neetsh/"
	chown -R root.root "${NEET}/neetsh/"
	chmod -R go-w "${NEET}/neetsh/"

	# Link the neetsh to the system
	for file in neetsh gethash mimikatz; do
		rm -f /usr/bin/$file
		chmod +x ${NEET}/neetsh/$file
		ln -s ${NEET}/neetsh/$file /usr/bin/$file
	done

	#######################################################
	newVersion neet-shell $VERSION
	echo "done"
else
	echo "This package is for the neet-update script and should not be installed manually."
	exit 1
fi

exit 0



