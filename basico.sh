#!/usr/bin/env bash
echo "Instalando estructura basica para clase virtualhost y proxy reverso"

# Habilitando la memoria de intercambio.
sudo dd if=/dev/zero of=/swapfile count=2048 bs=1MiB
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Subiendo el servicio de Apache.
sudo service apache2 start

# Copiando los archivos de configuración en la ruta indicada.
sudo cp ~/practica-4-script/seguro.conf/etc/apache2/sites-available/

#Moviendo a la carpeta app1
cd app1

# Ejecutando la creación de fatjar
chmod +x gradlew
./gradlew shadowjar

# Subiendo la aplicación 1 puerto por defecto.
java -jar ~/practica-4-script/app1/build/libs/app.jar > ~/practica-4-script/app1/build/libs/salida.txt 2> ~/practica-4-script/app1/build/libs/error.txt &

#Moviendo a la carpeta app2
cd ../app2

# Ejecutando la creación de fatjar
chmod +x gradlew
./gradlew shadowjar

# Subiendo la aplicación 2 puerto por defecto.
java -jar ~/practica-4-script/app2/build/libs/app.jar > ~/practica-4-script/app2/build/libs/salida.txt 2> ~/practica-4-script/app2/build/libs/error.txt &
