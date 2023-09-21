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


su informix -c "onmode -kuy"

echo "*** Shutdown of ${INFORMIXSERVER} SUCCESS ***"