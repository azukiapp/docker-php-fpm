#!/bin/bash

if [ ! -z "$APP_DIR" ]; then
	DOCUMENT_ROOT="/var/www"
	rm -rf ${DOCUMENT_ROOT}

	if [ -d "${APP_DIR}/public" ]; then
		dir="${DOCUMENT_ROOT}"
	else
		dir="${DOCUMENT_ROOT}/public"
	fi

	mkdir -p `dirname ${dir}`
	ln -s $APP_DIR $dir
fi

# Tweak nginx to match the workers to cpu's
procs=$(cat /proc/cpuinfo |grep processor | wc -l)
sed -i -e "s/worker_processes 5/worker_processes $procs/" /etc/nginx/nginx.conf

service php5-fpm start && nginx
