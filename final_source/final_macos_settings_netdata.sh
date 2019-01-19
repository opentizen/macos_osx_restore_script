#!/usr/bin/env bash

echo ///////////////////////////////////////
echo //////////////////////////////////////
echo //  Install                        //
echo //       Netdata                  //
echo //             Installing        //
echo //  kissd3v.           Script   //
echo /////////////////////////////////
echo ////////////////////////////////
#accpect osx administrator
echo ask for the administrator password!
sudo -v
echo install command-line for osx.
#install command-line for macos
sudo xcode-select --install
echo accept xocde license.
#At this point accept Xcode license
sudo xcodebuild -license
echo Install homebrew
#install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#check_homebrew
brew doctor
echo other lib install now.
#install macosx lib
brew install ossp-uuid
brew install zlib
brew install gcc
brew install pkg-config
brew install autoconf
brew install automake
brew install git
brew install curl
echo download and settings netdata
#netdata download from git
cd $HOME
pwd
git clone https://github.com/netdata/netdata.git --depth=100
cd netdata
sudo ./netdata-installer.sh --install /usr/local
# done! you can enter browser, address type 127.0.0.1:19999 or 192.0.x.x:19999
# use netdata port, :1999