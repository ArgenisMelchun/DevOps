# Usa una imagen base con Python
FROM python:3.9-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos necesarios
COPY requirements.txt requirements.txt
COPY app.py app.py

# Instala las dependencias del sistema necesarias para psycopg2
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && pip install --no-cache-dir -r requirements.txt psycopg2-binary \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Expone el puerto 5000
EXPOSE 5000

# Define el comando de inicio
CMD ["python", "app.py"]
