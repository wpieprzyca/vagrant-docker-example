#!/bin/bash

export PROJECT_FOLDER="javaee7-simple-sample"
export GIT_PROJECT_URL="https://github.com/javaee-samples/javaee7-simple-sample"

echo -n "Adding repositories for Java 8 and Notepadqq"
add-apt-repository -y ppa:webupd8team/java
add-apt-repository -y ppa:notepadqq-team/notepadqq

echo -n "Updating the package list"
apt-get update -y 

echo -n "Installing Xubuntu and Ubuntu session"
apt-get install -y xubuntu-desktop
apt-get install -y ubuntu-session

echo -n "Installing virtualbox guest additions"
apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11 linux-headers-$(uname -r)

echo -n "Installing Java 8"
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get install -y oracle-java8-installer

echo -n "Installing Eclipse"
wget -q http://ftp-stud.fht-esslingen.de/pub/Mirrors/eclipse/technology/epp/downloads/release/neon/3/eclipse-jee-neon-3-linux-gtk-x86_64.tar.gz
tar -xvf /home/vagrant/eclipse-jee-neon-3-linux-gtk-x86_64.tar.gz --directory /opt

echo -n "Making an eclipse desktop link executable"
chmod +x /home/vagrant/Desktop/eclipse.desktop

echo -n "Installing JBoss Tools Plugin" 
/opt/eclipse/eclipse -clean -purgeHistory -application org.eclipse.equinox.p2.director -noSplash -repository http://download.jboss.org/jbosstools/neon/stable/updates/ -installIUs org.jboss.ide.eclipse.as.feature.feature.group

echo -n "Installing Maven"
apt-get install -y maven

echo -n "Installing Docker"
curl -fsSL https://get.docker.com/ | sh

echo -n "Adding vagrant user to docker group"
gpasswd -a vagrant docker

echo -n "Creating a folder for deployments"
mkdir /home/vagrant/deployments
chown vagrant:vagrant /home/vagrant/deployments

echo -n "Installing Notepadqq"
apt-get install -y notepadqq

echo -n "Building Docker Wildfly container"
docker build --tag=wildfly --file=Dockerfile4Wildfly /home/vagrant

echo -n "Autostart Docker Wildfly container"
cp /home/vagrant/docker-wildfly.service /etc/systemd/system/docker-wildfly.service
systemctl enable docker-wildfly.service

echo -n "Cloning Git Project"
git clone $GIT_PROJECT_URL $PROJECT_FOLDER
chown -R vagrant:vagrant $PROJECT_FOLDER