#!/bin/bash

if [ ! -z "$APP_DIR" ]; then
	DOCUMENT_ROOT="/app"
	rm -rf ${DOCUMENT_ROOT}

	if [ -d "${APP_DIR}/public" ]; then
		dir="${DOCUMENT_ROOT}"
	else
		dir="${DOCUMENT_ROOT}/public"
	fi

	ln -s $APP_DIR $dir
fi

service php5-fpm start && nginx
