#!/bin/sh
MASTER_CFG=/usr/local/etc/mfs/mfsmaster.cfg

chown mfs:mfs -R /usr/local/var/lib/mfs
echo "Setup mfsmaster as $MFSM_PERSONALITY"
sed -i "s/# PERSONALITY = master/PERSONALITY = $MFSM_PERSONALITY/g" $MASTER_CFG
sed -i "s/# NO_ATIME = 0/NO_ATIME = 1/g" $MASTER_CFG
echo "Set master host as $MFSM_MASTERHOST"
sed -i "s/# MASTER_HOST = mfsmaster/MASTER_HOST = $MFSM_MASTERHOST/g" $MASTER_CFG
sed -i "s/# CHUNKS_REBALANCING_BETWEEN_LABELS = 0/CHUNKS_REBALANCING_BETWEEN_LABELS = $MFSM_REBAL_LABELS/g" $MASTER_CFG
echo "Set acceptable difference to $MFSM_ACCEPT_DIFF"
sed -i "s/# ACCEPTABLE_DIFFERENCE = 0.1/ACCEPTABLE_DIFFERENCE = $MFSM_ACCEPT_DIFF/g" $MASTER_CFG

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
echo ""
echo "here we go..."
mfsmaster -d
