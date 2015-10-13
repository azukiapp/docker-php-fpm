DOCUMENT_ROOT="/var/www"

if [ ! -z "$PUBLIC_DIR" ]; then
  rm -rf "${DOCUMENT_ROOT}"
  mkdir -p "${DOCUMENT_ROOT}"

  APP_DIR="${PUBLIC_DIR}"
  dir="${DOCUMENT_ROOT}/public"
elif [ ! -z "$APP_DIR" ]; then
  rm -rf "${DOCUMENT_ROOT}"

  if [ -d "${APP_DIR}/public" ]; then
      dir="${DOCUMENT_ROOT}"
  else
      dir="${DOCUMENT_ROOT}/public"
  fi

  mkdir -p "dirname ${dir}"
fi

if [ ! -z "$APP_DIR" ]; then
  echo "linking public folder: ${APP_DIR} -> ${dir}"
  ln -s $APP_DIR $dir
fi
