#!/bin/bash
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:jonathonf/python-3.6
sudo apt-get update
sudo apt-get install python3.6
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
sudo update-alternatives --config python3

sudo apt-get install python3-pip
sudo pip3 install virtualenv
mkdir ~/.virtualenvs
sudo pip3 install virtualenvwrapper

cp .bashtc ~/,bashrc
source ~/.bashrc

