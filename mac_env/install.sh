#!/bin/bash
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
git clone https://github.com/Valloric/YouCompleteMe.git $HOME/.vim/bundle/YouCompleteMe
(cd $HOME/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && ./install.py --clang-completer)
#install ConqueGDB

vim +PluginInstall +qall

cp .bashrc ~/.bashrc
source ~/.bashrc

# https://github.com/zegervdv/homebrew-zathura
brew tap zegervdv/zathura
brew install zathura --with-synctex
brew install zathura-pdf-poppler
mkdir -p $(brew --prefix zathura)/lib/zathura
ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib
cat 'set selection-clipboard clipboard' >> ~/.config/zathura/zathurarc
