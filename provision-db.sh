#!/usr/bin/env bash

# Actualizar paquetes
sudo apt-get update -y

# Instalar PostgreSQL
sudo apt-get install -y postgresql postgresql-contrib

# Crear base de datos, usuario y tabla con datos de ejemplo
sudo -u postgres psql -c "CREATE DATABASE productos;"
sudo -u postgres psql -c "CREATE USER vagrant WITH ENCRYPTED PASSWORD 'vagrant';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE productos TO vagrant;"

# Crear tabla y datos dentro de la base de datos
sudo -u postgres psql -d productos -c "CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL
);"

sudo -u postgres psql -d productos -c "INSERT INTO productos (nombre, precio) VALUES
('Teclado mecánico', 150.00),
('Mouse gamer', 80.00),
('Monitor 24 pulgadas', 600.00);"

# Configurar PostgreSQL para aceptar conexiones externas
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/*/main/postgresql.conf

# Permitir conexiones desde la VM web (192.168.56.50)
echo "host all all 192.168.56.50/32 md5" | sudo tee -a /etc/postgresql/*/main/pg_hba.conf

# Reiniciar PostgreSQL para aplicar los cambios
sudo systemctl restart postgresql

# Habilitar PostgreSQL al inicio del sistema
sudo systemctl enable postgresql

echo "PostgreSQL instalado y configurado correctamente."
echo "   Base de datos: productos"
echo "   Usuario: vagrant"
echo "   Contraseña: vagrant"
echo "   Tabla: productos"
