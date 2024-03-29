#!/bin/bash
#apt-get install -y software-properties-common
#add-apt-repository ppa:jonathonf/vim
sudo apt-get update
sudo apt-get install -y git
#sudo apt-get install -y vim
sudo apt-get install -y gdb
sudo apt-get install -y wget
sudo apt-get install -y unzip
#sudo apt-get install -y xdg-utils 
git config --global user.email "zhangzn710@gmail.com"
git config --global user.name "deciding"
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

sudo apt-get install -y software-properties-common
#sudo add-apt-repository ppa:deadsnakes/ppa
#sudo add-apt-repository ppa:jonathonf/vim
#sudo add-apt-repository ppa:ubuntu-toolchain-r/test
# sudo add-apt-repository --remove ppa:deadsnakes/ppa
##if above show apt_pkg not found, use below commands
##cd /usr/lib/python3/dist-packages
##cp apt_pkg.cpython-35m-x86_64-linux-gnu.so apt_pkg.so
sudo apt-get update
#sudo apt-get install -y python3.6

#sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1
#sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.5 1

#sudo apt-get install -y gcc-8 g++-8

#sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 500 --slave /usr/bin/g++ g++ /usr/bin/g++-5
#sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8

#sudo update-alternatives --config python3
#sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1

#sudo apt install -y vim

sudo apt-get install -y locales
sudo locale-gen en_US.UTF-8
sudo update-locale

#curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
#python3 get-pip.py --force-reinstall
sudo apt-get install -y python3-pip
#python3 -m pip install --user --upgrade pip
pip3 install --upgrade pip

pip3 install --user virtualenv
mkdir ~/.virtualenvs
pip3 install --user virtualenvwrapper

pip3 install --user flake8
pip3 install --user autopep8

#pip mismatch version
#curl https://bootstrap.pypa.io/get-pip.py | sudo -H python3

# install Vundle and install all the specified plugins

echo "Installing Vundle" 
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
cp .vimrc ~/.vimrc
#install ctags
echo "Installing ctags"
sudo apt-get install -y exuberant-ctags
echo "Installing taglist"
#install taglist
wget -O /usr/src/taglist.zip http://www.vim.org/scripts/download_script.php?src_id=7701
unzip /usr/src/taglist.zip -d $HOME/.vim # with 'filetype plugin on' in ~/.vimrc
#install YCM, not sure whether Vundle install only will work
echo "Installing YCM"
#sudo apt-get install -y build-essential cmake
#sudo apt-get install -y python-dev python3-dev
#sudo apt-get install python3.6-dev
#sudo apt-get install libpython3.6-dev
#git clone https://github.com/Valloric/YouCompleteMe.git $HOME/.vim/bundle/YouCompleteMe
git clone https://github.com.cnpmjs.org/Valloric/YouCompleteMe.git $HOME/.vim/bundle/YouCompleteMe
sudo apt-get install -y cmake
(cd $HOME/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && ./install.py --clang-completer)
#wget https://nchc.dl.sourceforge.net/project/vim-taglist/vim-taglist/4.6/taglist_46.zip
#unzip -d $HOME/.vim/ taglist_46.zip
#(cd $HOME/.vim/bundle/jedi-vim/ && git submodule update --init)
#install ConqueGDB

#sudo apt-get install -y python3-pyaudio
#sudo apt-get install -y pulseaudio
#sudo apt-get install -y portaudio19-dev

vim +PluginInstall +qall

cp .bashrc ~/.bashrc
cp .tmux.conf ~/.tmux.conf
source ~/.bashrc

#cp .gdbinit ~/.gdbinit

##mpi
#wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.2.tar.gz
#gunzip -c openmpi-4.0.2.tar.gz | tar xf -
#cd openmpi-4.0.2
#./configure --prefix=/usr/local
#sudo make all install
#cd -
#rm -rf openmpi-4.0.2
#rm openmpi-4.0.2.tar.gz
##horovod
#sudo apt-get install -y g++-4.8
#sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 1
#HOROVOD_WITH_MPI=1 HOROVOD_CUDA_INCLUDE=/usr/local/cuda-9.0/targets/x86_64-linux/include/ HOROVOD_CUDA_LIB=/usr/local/cuda-9.0/targets/x86_64-linux/lib/ HOROVOD_CUDA_HOME=/usr/local/cuda-9.0/bin/ HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_WITH_TENSORFLOW=1 pip install --no-cache-dir horovod
##CUDA_VISIBLE_DEVICES=2,3 mpirun -np 2     -bind-to none -map-by slot     -x LD_LIBRARY_PATH     -x LIBRARY_PATH     -x PYTHONPATH     -x PATH     -x NCCL_DEBUG=INFO     -x NCCL_SOCKET_IFNAME=eth0     -x NCCL_P2P_DISABLE=1     --mca btl_tcp_if_include eth0 --mca oob_tcp_if_include eth0     -mca pml ob1 -mca btl ^openib hostname

#sudo apt install -y imagemagick
#git clone https://github.com/stefanhaustein/TerminalImageViewer.git
#(cd TerminalImageViewer/src/main/cpp && make && sudo make install)
#rm -rf TerminalImageViewer


#Problems
# 1. apt_pkg not found:
#    /usr/lib/python3/dist-packages# ln -s apt_pkg.cpython-35m-x86_64-linux-gnu.so apt_pkg.so
# 2. g++ not support ++17
#    sudo add-apt-repository ppa:ubuntu-toolchain-r/test
#    sudo apt-get update
#    sudo apt-get install gcc-8 g++-8
#    gcc-8 --version
#    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 500 --slave /usr/bin/g++ g++ /usr/bin/g++-5
#    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8
# 3. remove ppa
#    1. sudo add-apt-repository --remove ppa:whatever/ppa
#    2. rm /etc/apt/sources.list.d *.list
#    3. sudo apt-get install ppa-purge
#       sudo ppa-purge ppa:whatever/ppa 
# 4. compile vim with python3.6
#    check with :py3 print( __import__( 'sys' ).version )
#    sudo apt-get install -y python3-distutils python3-dev
#    git clone https://github.com/vim/vim.git
#    cd vim
#    ./configure --prefix=/usr/local \
#        --enable-python3interp \
#        --with-python3-config-dir=/usr/lib/python3.6/config-*
#    make
#    sudo make install
# 5. cmake latest
#    sudo apt purge --auto-remove cmake
#    wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
#    sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main'     #focal 20.04, bionic 18.04, xenial 16.04
#    sudo apt update
#    sudo apt install cmake
