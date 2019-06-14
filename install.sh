#!/bin/bash
sudo apt-get update
sudo apt-get install git
sudo apt-get install wget
sudo apt-get install unzip
sudo apt-get install xdg-utils 
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:jonathonf/python-3.6
#if above show apt_pkg not found, use below commands
#cd /usr/lib/python3/dist-packages
#cp apt_pkg.cpython-35m-x86_64-linux-gnu.so apt_pkg.so
sudo apt-get update
sudo apt-get install python3.6
#sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
#sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
#sudo update-alternatives --config python3
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1

#sudo add-apt-repository ppa:jonathonf/vim
#sudo apt update
#sudo apt install vim


sudo apt-get install locales
sudo locale-gen en_US.UTF-8
sudo update-locale

sudo apt-get install python3-pip
python3 -m pip install --user --upgrade pip
pip3 install virtualenv
mkdir ~/.virtualenvs
pip3 install virtualenvwrapper

pip3 install flake8
pip3 install autopep8

#pip mismatch version
#curl https://bootstrap.pypa.io/get-pip.py | sudo -H python3

# install Vundle and install all the specified plugins
echo "Installing Vundle" 
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
cp .vimrc ~/.vimrc
#install ctags
echo "Installing ctags"
sudo apt-get install exuberant-ctags
echo "Installing taglist"
#install taglist
wget -O /usr/src/taglist.zip http://www.vim.org/scripts/download_script.php?src_id=7701
unzip /usr/src/taglist.zip -d $HOME/.vim # with 'filetype plugin on' in ~/.vimrc
#install YCM, not sure whether Vundle install only will work
echo "Installing YCM"
sudo apt-get install build-essential cmake
sudo apt-get install python-dev python3-dev
sudo apt-get install python3.6-dev
git clone https://github.com/Valloric/YouCompleteMe.git $HOME/.vim/bundle/YouCompleteMe
sudo apt-get install -y cmake
(cd $HOME/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && ./install.py --clang-completer)
(cd $HOME/.vim/bundle/jedi-vim/ && git submodule update --init)
#install ConqueGDB

sudo apt-get install python3-pyaudio
sudo apt-get install pulseaudio
sudo apt-get install portaudio19-dev

vim +PluginInstall +qall

cp .bashrc ~/.bashrc
source ~/.bashrc

sudo apt install -y imagemagick
git clone https://github.com/stefanhaustein/TerminalImageViewer.git
(cd TerminalImageViewer/src/main/cpp && make && sudo make install)
rm -rf TerminalImageViewer
