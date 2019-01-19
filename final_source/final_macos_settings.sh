#!/usr/bin/env bash
#accpect osx administrator
sudo -v
#install web_server_nginx
brew install nignx
#start web_server_nginx
nignx
#restart web_server_nginx
#nginx -s reload

#set default --global core.editor nano
git config --global core.editor nano
echo //////////////////////////////////////
#check-CPU
sysctl -n machdep.cpu.brand_string
#install command-line for macos
sudo xcode-select --install
#At this point accept Xcode license
sudo xcodebuild -license
#install netdata from homebrew
brew install netdata
#install lib
brew install ossp-uuid
brew install zlib
brew install gcc
brew install pkg-config
brew install autoconf
brew install automake
brew install git
brew install curl
#netdata download from git
git clone https://github.com/netdata/netdata.git --depth=100
cd netdata
sudo ./netdata-installer.sh --install /usr/local