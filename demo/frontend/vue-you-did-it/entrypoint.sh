#!/bin/sh

# Reemplaza variables de entorno en los archivos JavaScript generados por Vue
for file in /usr/share/nginx/html/assets/*.js; do
  sed -i "s|VITE_API_HOST_PLACEHOLDER|$VITE_API_HOST|g" "$file"
done

exec "$@"
