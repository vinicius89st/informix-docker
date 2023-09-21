#!/bin/bash

export INFORMIXSERVER="ol_database"
export INFORMIXDIR="/home/informix/data"
export INFORMIXTERM=terminfo
export ONCONFIG=onconfig.ol_database
export INFORMIXSQLHOSTS="/home/informix/data/etc/sqlhosts.ol_database"
export CLIENT_LOCALE="en_us.8859-1"
export DB_LANG="en_us.8859-1"
export DBDATE=Y4MD-
export DBDELIMITER='|';
export PATH="/data/lib:data/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/informix/data/bin:/home/informix/data/lib:/home/informix/data/lib/esql:/home/informix/data/"
export LD_LIBRARY_PATH=/home/informix/data/lib:/home/informix/data/lib/esql:/home/informix/data/lib/tools
export PS1="IDS-11:70 ol_database:"
export MSGPATH="/home/informix/data/logs/informix.log"
export INFORMIX_HOME="/home/informix"
export INFORMIX_DATA_DIR="/home/informix/data"
export MYINFORMIX_DBSPACE="dbs_root";


if [ ! -e "/home/informix/.initialized" ] ; then
	oninit -ivy
	touch /home/informix/.initialized

	onstat -

	onspaces -c -d dbspace -p /home/informix/spaces/dbspace_dat.000 -o 0 -s 2000000
	onspaces -c -S sbspace -p /home/informix/spaces/sbspace_dat.000 -o 0 -s 2000000
	onspaces -c -d logspace -p /home/informix/spaces/logspace_dat.000 -o 0 -s 1000000
	onspaces -c -t -d tmpspace -p /home/informix/spaces/tmpspace_dat.000 -o 0 -s 1000000

	echo "CREATE DATABASE mediaxp IN dbspace WITH BUFFERED LOG" | dbaccess

	echo "register ifxbuiltins.1.1 mediaxp"|blademgr
	echo "register LLD.1.20.FC2 mediaxp"|blademgr

	onmode -ky

	echo "Instalação concluida com sucesso"
	
fi

oninit -vy