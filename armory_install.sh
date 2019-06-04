sudo apt-get update
sudo apt-get install -y locales
sudo locale-gen en_US.UTF-8
sudo update-locale

sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:jonathonf/python-3.6
sudo apt-get update
sudo apt-get install -y python3.6
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1

sudo apt-get install -y python-dev python3-dev
sudo apt-get install -y python3-pyaudio
sudo apt-get install -y pulseaudio
sudo apt-get install -y portaudio19-dev

source ~/.bashrc
