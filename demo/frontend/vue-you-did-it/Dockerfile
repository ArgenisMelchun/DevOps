# Etapa 1: Construcción
FROM node:18-alpine AS build

# Crear y establecer el directorio de trabajo
WORKDIR /app

# Copiar archivos de configuración e instalar dependencias
COPY package*.json ./
RUN npm install

# Copiar el resto de los archivos y construir el proyecto
COPY . ./
RUN npm run build

# Etapa 2: Servir con Nginx
FROM nginx:alpine

# Copiar archivos generados al directorio de Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Copiar configuración personalizada de Nginx
COPY default.conf /etc/nginx/conf.d/default.conf

# Agregar un script para inyectar variables de entorno
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Exponer el puerto 80 para acceso HTTP
EXPOSE 80

# Configurar el script de entrada
ENTRYPOINT ["/entrypoint.sh"]

# Comando por defecto para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
