#!/bin/sh

# restore shell script for osx
# This script is .. brew setting + python django develop workspace
# if you start this script, you can enter command "sh restore_python.sh"

# user password
sudo -v

echo "Install Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# homebrew settings
echo "Setting Homebrew..."
brew update
brew upgrade
brew doctor

# install osx command-line-tools
echo "Install command-line"
brew tap caskroom/cask
xcode-select --install
brew install readline

# install develop packages
echo "Install develop brew packages..."
brew cask install java
brew install git 
brew install mas
brew install python3
brew cask install iterm2
brew install visual-studio-code

# install user packages
echo "Install utility packages..."
brew cask install appclaner
brew cask install bettertouchtool
brew cask install discord
brew cask install google-chrome
brew cask install macs-fan-control
brew cask install vlc
brew cask install obs

# instasll other appstore packages
echo "other apps for appstore"
#Xcode (10.1)
mas install 497799835 
#Keynote (8.3)
mas install 409183694 
#DrCleaner (3.3.7)
mas install 921458519 
#미세먼지코리아 (1.2)
mas install 1351084155 
#XMind ZEN (9.0.6)
mas install 1327661892 
#Pages (7.3)
mas install 409201541 
#Wake Up Time (1.4)
mas install 495945638 
#LINE (5.11.2)
mas install 539883307 
#Boom 3D (1.1.6) -> check buy log
mas install 1233048948 
#NateOn (1037.1)
mas install 501556811 
#Numbers (5.3)
mas install 409203825 
#Telegram (4.7.1)
mas install 747648890 
#KakaoTalk (2.5.4)
mas install 869223134 

# oh-my-zsh settings
echo "Setting zsh..."
# first, install "iterm2" terminal app
brew cask install iterm2
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# ~/.zshrc path settings
echo "Setting develop path..."
export PATH=/usr/local/bin:/usr/local/sbin:$PATH >> ~/.zshrc
alias osu='mv ~/Downloads/*.osz /Applications/osu!.app/drive_c/Program\ Files/osu!/songs' >> ~/.zshrc
source ~/.zshrc

# python django workspace setting 01
cd ~$HOME
cd ~/
mkdir workspace
cd workspace

# check python version
python --version
python3 --version

# python django workspace setting 02
python3 -m pip install --upgrade pip
# install virtualenv or pyenv, but im used virtualenv
pip install virtualenv
# make virtualenv --name
virtualenv workspace
# virturalenv activity
cd workspace/bin/activate
pip --version
# install django
pip install django
# deactivity -> deactivate
# done settings!
# shutdown -r now