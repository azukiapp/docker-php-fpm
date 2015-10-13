#!/usr/bin/env sh

cd $(dirname $0)

procs=$(cat /proc/cpuinfo |grep processor | wc -l)
sed -i -e "s/worker_processes 5/worker_processes $procs/" '../configuration/supervisord/nginx.conf'

./run.sh

if [ "$1" = 'nginx-php-fpm' ]; then
  # If we have a custom confiuration we should use it when starting nginx, otherwise use the default one. Here
  # we update the supervisord configuration with the custom parameter.

  if [ -f '../configuration/nginx.conf' ]; then
      sed -i -e 's~\(command=nginx\).*$~\1 -c '"'"$(pwd)'/../configuration/nginx.conf'"'"'~g' '../configuration/supervisord/nginx.conf'
  else
      sed -i -e 's/\(command=nginx\).*$/\1/g' '../configuration/supervisord/nginx.conf'
  fi

  supervisord --nodaemon --configuration="../configuration/supervisord.conf"
else
  exec "$@"
fi
