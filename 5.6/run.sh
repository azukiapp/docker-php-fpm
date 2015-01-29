#!/bin/bash
if [[ "$APP_DIR" ]]; then
  rm -rf /app
  ln -s $APP_DIR /app
fi
service php5-fpm start && nginx
