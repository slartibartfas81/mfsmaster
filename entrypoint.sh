chown mfs:mfs -R /usr/local/var/lib/mfs
if [ -f /usr/local/var/lib/mfs/metadata.mfs ]
then
	echo "mfsmetadata exists, start mfsmaster"
else
	echo "mfsmetadata does not exist, copy empty one"
	cp /usr/local/metadata.mfs.empty /usr/local/var/lib/mfs/metadata.mfs
	echo "start mfsmaster"
fi
if [ -f /usr/local/var/lib/mfs/metadata.mfs.lock ]
then
	echo "lockfile found, run mfsmetarestore"
	mfsmetarestore -a
	echo "metarestore Done"
fi
mfsmaster -d
