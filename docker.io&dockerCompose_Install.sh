#!/bin/bash

# Entfernen von Docker-bezogenen Paketen
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    sudo apt-get remove -y $pkg
done

# Aktualisieren der Paketlisten
sudo apt-get update

# Installation von erforderlichen Paketen
sudo apt-get install -y ca-certificates curl

# Erstellen eines Verzeichnisses für apt-Schlüssel
sudo install -m 0755 -d /etc/apt/keyrings

# Herunterladen des Docker-GPG-Schlüssels
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Ändern der Berechtigungen für den heruntergeladenen GPG-Schlüssel
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Hinzufügen des Docker-Repositorys zur sources.list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Aktualisieren der Paketlisten nach Hinzufügen des Repositorys
sudo apt-get update

# Installation von Docker und zugehörigen Paketen
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Ausführen des Befehls "docker run hello-world", um sicherzustellen, dass Docker ordnungsgemäß installiert wurde
sudo docker run hello-world
