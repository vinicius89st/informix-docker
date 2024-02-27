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
	
	echo "GRANT DBA TO informix;" | dbaccess "mediaxp" > /dev/null 2>&1

	echo "register ifxbuiltins.1.1 mediaxp"|blademgr
	echo "register LLD.1.20.FC2 mediaxp"|blademgr

	onmode -ky

	echo "Instalação concluida com sucesso"
	echo "iniciando criação de modelo"
	oninit -vy
	cd /home/informix/explorit
	
	dbaccess mediaxp  mediaxp_v8.0_base0_rev1.sql  1> a01.log 2>&1
	dbaccess mediaxp  mediaxp_v8.0_base2_rev1.sql   1> a02.log 2>&1
	dbaccess mediaxp  mediaxp_v8.0_funcoes_rev1.sql  1> a03.log 2>&1
	dbaccess mediaxp  mediaxp_v41.0_base3_rev1.sql 1> a04.log 2>&1
	onmode -ky
	oninit -vy
	dbaccess mediaxp  bmm_deletepalavra.sql 1> bmm_deletepalavra.log     2>&1
	dbaccess mediaxp  bmm_identificapalavra.sql     1> bmm_identificapalavra.log 2>&1
	dbaccess mediaxp  bmm_insertpalavra.sql         1> bmm_insertpalavra.log     2>&1
	dbaccess mediaxp  bmm_ins_proxy.sql             1> bmm_ins_proxy.log         2>&1
	dbaccess mediaxp  bmm_updatepalavra.sql         1> bmm_updatepalavra.log     2>&1
	dbaccess mediaxp  ca_getchild.sql               1> ca_getchild.log           2>&1
	dbaccess mediaxp  ca_gethistorico.sql           1> ca_gethistorico.log       2>&1
	dbaccess mediaxp  ca_getidx.sql                 1> ca_getidx.log             2>&1
	dbaccess mediaxp  ca_getparent.sql              1> ca_getparent.log          2>&1
	dbaccess mediaxp  ca_request.sql                1> ca_request.log            2>&1
	dbaccess mediaxp  mcadduser.sql                 1> mcadduser.log             2>&1
	dbaccess mediaxp  mclogerror.sql                1> mclogerror.log            2>&1
	dbaccess mediaxp  mc_addassettofolder.sql       1> mc_addassettofolder.log   2>&1
	dbaccess mediaxp  mc_authorize.sql              1> mc_authorize.log          2>&1
	dbaccess mediaxp  mc_authorizelevel.sql         1> mc_authorizelevel.log     2>&1
	dbaccess mediaxp  mc_authorizeupdate.sql        1> mc_authorizeupdate.log    2>&1
	dbaccess mediaxp  mc_undorequestgui.sql         1> mc_undorequestgui.log     2>&1
	dbaccess mediaxp  mv_requisitaclipe.sql         1> mv_requisitaclipe.log     2>&1
	dbaccess mediaxp  mx_collectionmember.sql       1> mx_collectionmember.log   2>&1
	dbaccess mediaxp  mx_createasset.sql            1> mx_createasset.log        2>&1
	dbaccess mediaxp  mx_createproxy.sql            1> mx_createproxy.log        2>&1
	dbaccess mediaxp  mx_marcador.sql               1> mx_marcador.log           2>&1
	dbaccess mediaxp  mx_status.sql                 1> mx_status.log             2>&1
	dbaccess mediaxp  mx_updateasset.sql            1> mx_updateasset.log        2>&1
	dbaccess mediaxp  vidptrparatc.sql              1> vidptrparatc.log          2>&1
	dbaccess mediaxp  vidtcparaptr.sql              1> vidtcparaptr.log          2>&1
	dbaccess mediaxp  vir_ins_img_track.sql         1> vir_ins_img_track.log     2>&1
	dbaccess mediaxp  vir_ins_vidmed.sql            1> vir_ins_vidmed.log        2>&1
	dbaccess mediaxp  mx_getvideos.sql              1> mx_getvideos.log          2>&1
	dbaccess mediaxp  mx_initlocation.sql           1> mx_initlocation.log       2>&1
	dbaccess mediaxp  lu_droptable.sql              1> lu_droptable.log          2>&1
	dbaccess mediaxp  lu_importresults.sql          1> lu_importresults.log      2>&1
	dbaccess mediaxp  mx_setstatus.sql              1> mx_setstatus.log          2>&1
	dbaccess mediaxp  cms_geststatus.sql            1> cms_geststatus.log        2>&1
	dbaccess mediaxp  seconds_to_HHMMSS.sql         1> seconds_to_HHMMSS.log     2>&1
	onmode -ky
	oninit -vy
	dbaccess mediaxp mxp00_spls_temp.sql 1> a00.log 2>&1
	dbaccess mediaxp mxp01_mc_assetformat.sql 1> a01.log 2>&1
	dbaccess mediaxp mxp02_mc_assetformat_icon.sql 1> a02.log 2>&1
	dbaccess mediaxp mxp03_mc_assettype.sql 1> a03.log 2>&1
	dbaccess mediaxp mxp04_mc_assettype_icon.sql 1> a04.log 2>&1
	dbaccess mediaxp mxp05_insert_tables.sql 1> a05.log 2>&1
	dbaccess mediaxp mxp07_virdbobjects.sql 1> a07.log 2>&1
	dbaccess mediaxp mxp08_vdf_model.sql 1> a08.log 2>&1
	dbaccess mediaxp mxp09_eventos.sql 1> a09.log 2>&1
	dbaccess mediaxp mxp10_triggers.sql 1> a10.log 2>&1
	dbaccess mediaxp mxp11_ca.sql 1> a11.log 2>&1
	dbaccess mediaxp mxp12_papeis_jn.sql 1> a12.log 2>&1
	dbaccess mediaxp mxp13_novo.sql 1> a13.log 2>&1
	dbaccess mediaxp mxp14_mp_project.sql 1> a14.log 2>&1
	onmode -ky
	oninit -vy
	dbaccess mediaxp 01projeto_tvnt_rev26.sql 1> a01.log 2>&1
	dbaccess mediaxp 02fpa_assetlocation.sql 1> a02.log 2>&1
	dbaccess mediaxp 03mc_gettapepool_novo.sql 1> a03.log 2>&1
	dbaccess mediaxp 04dados.sql 1> a04.log 2>&1
	dbaccess mediaxp 05papeis_tvnt.sql 1> a05.log 2>&1
	dbaccess mediaxp 06TVNT_menu.sql 1> a06.log 2>&1
	onmode -ky
	oninit -vy
	dbaccess mediaxp 00funcoes.sql 1>a00.log 2>&1
	dbaccess mediaxp 01busca.sql 1>a01.log 2>&1
	dbaccess mediaxp 02editAnd08pxy.sql 1>a02.log 2>&1
	dbaccess mediaxp 03view.sql 1>a03.log 2>&1
	dbaccess mediaxp 04mvw.sql 1>a041.log 2>&1
	dbaccess mediaxp 06pxy.sql 1>a06.log 2>&1
	dbaccess mediaxp 07pxy.sql 1>a07.log 2>&1
	dbaccess mediaxp 09wid1.sql 1>a09.log 2>&1
	dbaccess mediaxp 10cruza.sql 1>a10.log 2>&1
	dbaccess mediaxp 12brc.sql 1>a12.log 2>&1
	dbaccess mediaxp 13brc.sql 1>a13.log 2>&1
	dbaccess mediaxp 14list.sql 1>a14.log 2>&1
	dbaccess mediaxp 15list.sql 1>a15.log 2>&1
	dbaccess mediaxp 17js.sql 1>a17.log 2>&1
	dbaccess mediaxp 18js.sql 1>a18.log 2>&1
	dbaccess mediaxp 19rNew.sql 1>a19.log 2>&1
	dbaccess mediaxp carga_menu_local.sql 1> menu.log 2>&1
	onmode -ky
	
fi

oninit -vy