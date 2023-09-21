#!/bin/bash


if [ ! -e "/home/informix/.initialized" ] ; then

	echo "Iniciando instalação, aguarde..."
	
	dos2unix /home/informix/onconfig.ol_database
	dos2unix /home/informix/.bashrc
	dos2unix /home/informix/install.sh
	dos2unix /home/informix/start.sh
	dos2unix /home/informix/stop.sh
	
	mkdir /home/informix/data
	mkdir /home/informix/logs
	mkdir /home/informix/spaces
	mkdir /home/informix/spaces/dbs_root/
	mkdir /home/informix/data/logs
	
	cd /home/informix/spaces/dbs_root/
	
	touch dbs_root.000
	chmod 660 dbs_root.000
	chown informix.informix dbs_root.000
	
	cd /home/informix/spaces
	touch dbspace_dat.000 sbspace_dat.000 logspace_dat.000 tmpspace_dat.000 tmpsbspace_dat.000
	chmod 660 /home/informix/spaces/*
	chown informix.informix /home/informix/spaces/*
	
	cd /home/informix/data
	mv /home/informix/iif.11.70.FC8IE.linux-x86_64.tar .
	tar -xf iif.11.70.FC8IE.linux-x86_64.tar
	mv /home/informix/bundle.properties .
	dos2unix bundle.properties
	echo "Realizando a instalação, isso pode levar alguns minutos..."
	
	/home/informix/data/ids_install -i silent -f /home/informix/data/bundle.properties -DLICENSE_ACCEPTED=TRUE
	
	cd /home/informix/data/etc
	cp sqlhosts.std sqlhosts.ol_database
	echo "ol_database      onsoctcp        *${HOSTNAME}   9088" >> /home/informix/data/etc/sqlhosts.ol_database
	echo "ol_database_dr   drsoctcp        *${HOSTNAME}   9089" >> /home/informix/data/etc/sqlhosts.ol_database
	cp /home/informix/onconfig.ol_database /home/informix/data/etc/onconfig.ol_database
	chown informix.informix /home/informix/data/etc/*
	chmod 770 /home/informix/data/etc/*
	
fi

