#!/usr/bin/env bash
echo "Instalando estructura basica para clase virtualhost y proxy reverso"

# Habilitando la memoria de intercambio.
sudo dd if=/dev/zero of=/swapfile count=2048 bs=1MiB
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Instando los software necesarios para probar el concepto.
sudo apt update && sudo apt -y install zip unzip nmap apache2 certbot tree

# Instalando la versión sdkman y java
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Utilizando la versión de java 17 como base.
sdk install java 17.0.9-tem

# Subiendo el servicio de Apache.
sudo service apache2 start

# Clonando el repositorio.
git clone https://github.com/Natashalopez05/practica-4-script.git

#Moviendo a la carpeta app1
cd ~/practica-4-script/app1

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
