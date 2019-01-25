#!/usr/bin/env bash

echo ///////////////////////////////////////
echo //////////////////////////////////////
echo //  MacOS                          //
echo //     Command-Line               //
echo //           Setting 1.0v OBT    //
echo //                     Settings //
echo /////////////////////////////////
echo ////////////////////////////////
echo Check your CPU
sysctl -n machdep.cpu.brand_string #check-CPU
echo Ask for the administrator password #accpect osx administrator
sudo -v
echo Installing xcode-command-line... #Install command-line-tools
xcode-select --install
echo Accept xocde-command-line #At this point accept Xcode license
sudo xcodebuild -license
echo Installing Homebrew... #Install homebrew pacakages manager
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo Check Homebrew...
brew update
brew upgrade
brew doctor
echo ///////////////////////////////////////
echo //////////////////////////////////////
echo //  Set                KISSD3V.    //
echo //    System                      //
echo //       Details                 //
echo //           Settings           //
echo /////////////////////////////////
echo ////////////////////////////////
echo Set Dock preferences
defaults write com.apple.dock tilesize -int 34 # Set the icon size of Dock items to 34 pixels
defaults write com.apple.dock mineffect -string "scale" # Change minimize/maximize window effect to Scale effect
defaults write com.apple.dock autohide -bool false # Automatically hide and show the Dock
defaults write com.apple.dock showhidden -bool true # Make Dock icons of hidden applications translucent
defaults write com.apple.dock orientation -string bottom # Change dock position on the screen to left
defaults write com.apple.dock magnification -boolean NO # Turn off magnification
defaults write ~/Library/Preferences/.GlobalPreferences.plist AppleActionOnDoubleClick -string "Minimize" # Double-click a window's title bar to minimize
defaults write ~/Library/Preferences/.GlobalPreferences.plist AppleWindowTabbingMode -string "always" # Prefer tabs when opening documents always
defaults write com.apple.dock persistent-apps -array # remove all icons from the dock
# add my preferred icons to the dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Mail.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Calendar.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Notes.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Utilities/Terminal.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
echo Set Language and region preferences # System language set to English, region set to ES
defaults write ~/Library/Preferences/.GlobalPreferences.plist AppleLocale -string "en_US"
# Select default metrics
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true
defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"
echo Configuring security and privacy preferences # Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1 # Turn on firewall
echo Configuring energy saver preferences
defaults write com.apple.menuextra.battery ShowPercent -string "YES" # Show Battery Percentage on the meny bar
sudo pmset -b sleep 20 # Battery - Computer sleep: 20 min
sudo pmset -b displaysleep 5 # Battery - Turn display off after: 5 min
sudo pmset -c sleep 30 # Power Adapter - Computer sleep: 30 min
sudo pmset -c displaysleep 12 # Power Adapter - Turn display off after: 12 min
echo Configuring keyboard preferences
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3 # Enable full keyboard access for all controls
# Don't adjust keyboard brightness on low light
# defaults write com.apple.BezelServices kDim -bool true
defaults write com.apple.BezelServices kDimTime -int 30 # Turn keyboard backlight off after 30 secs of inactivity
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false # Disable auto-correct spelling automatically
defaults write NSGlobalDomain KeyRepeat -int 2 # Set a fast keyboard repeat rate
defaults write NSGlobalDomain InitialKeyRepeat -int 25
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false # Disable press-and-hold for keys in favor of key repeat
echo Configuring sound preferences
# Show volume in menu bar and hide clock/calendar (I use day-o)
defaults write com.apple.systemuiserver menuExtras -array \
	"/System/Library/CoreServices/Menu Extras/Volume.menu" \
	"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
	"/System/Library/CoreServices/Menu Extras/Battery.menu"
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -bool true
echo Configuring date and time preferences
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM  HH:mm" # Show date on the menu bar
echo Configuring time machine preferences
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool false # Prevent Time Machine from prompting to use new hard drives as backup volume
echo Configuring extra preferences
chflags nohidden ~/Library # Show the ~/Library folder
sudo chflags nohidden /Volumes # Show the /Volumes folder
echo Configuring desktop view options
# Show item info to the right of the icons on the desktop
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist
# Set desktop icons size to 20x20
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 20" ~/Library/Preferences/com.apple.finder.plist
# Set grid spacing for desktop icons to 50
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist
# Set text size to 10pt
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:textSize 10" ~/Library/Preferences/com.apple.finder.plist
echo Configuring finder options
# Set User home as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true # Show all filename extensions
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" # When performing a search, search the current folder by default
defaults write com.apple.finder _FXSortFoldersFirst -bool true # Keep folders on top when sorting by name
# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "icnv"
defaults write com.apple.finder ShowRecentTags -bool false
defaults write com.apple.finder ShowPathbar -bool true # Show path bar
# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
echo Configuring activity monitor options
defaults write com.apple.ActivityMonitor IconType -int 5 # Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor ShowCategory -int 0echo "Configuring activity monitor options" # Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor IconType -int 5 # Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor ShowCategory -int 0 # Show all processes in Activity Monitor
echo Configuring text edit options
defaults write com.apple.TextEdit RichText -int 0 # Plain text by default
# Turn off 'smart' editing
defaults write com.apple.TextEdit SmartDashes -int 0
defaults write com.apple.TextEdit SmartQuotes -int 0
defaults write com.apple.TextEdit TextReplacement -int 0
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
echo Configuring contacts options
defaults write com.apple.AddressBook ABDefaultAddressCountryCode -string "es" # Address format
defaults write com.apple.AddressBook NSPersonNameDefaultDisplayNameOrder -int 1 # Display format "First, Last"
defaults write com.apple.AddressBook ABNameSortingFormat -string "sortingFirstName sortingLastName" # Sort by first name
echo Configuring calendar options
defaults write com.apple.iCal "Show Week Numbers" -bool true # Show week numbers
defaults write com.apple.iCal "CalUICanvasOccurrenceFontSize" -int 10 # Make text smaller
echo Configuring safari options
defaults write com.apple.Safari 'ShowStatusBar' -bool true # show the status bar at the bottom (see URL on hover)
# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true # Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari HomePage -string "https://www.google.com" # Set Safari’s home page to google.com
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false # Prevent Safari from opening ‘safe’ files automatically after downloading
# Show Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool true
defaults write com.apple.Safari ShowFavoritesBar-v2 -bool true
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true # Enable Safari’s debug menu
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false # Make Safari’s search banners default to Contains instead of Starts With
# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true # Add a context menu item for showing the Web Inspector in web views
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true # Enable “Do Not Track”
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true # Update extensions automatically
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true # Warn about fraudulent websites
defaults write com.apple.Safari NewTabBehavior -int 1 # Open new tabs with an empty page
defaults write com.apple.Safari ShowFavoritesUnderSmartSearchField -bool false # don't show favorites on the smart search bar
defaults write com.apple.Safari CanPromptForPushNotifications -bool false # don't allow websites to ask for permission to send push notifications
defaults write com.apple.Safari SuppressSearchSuggestions -bool false # include search engine suggestions
# TODO install extensions: "Save to Pocket", "AdBlock", "SessionRestore
echo Installing MacOS System Lib... #Install System Lib
echo ///////////////////////////////////////
echo //////////////////////////////////////
echo //  Install                        //
echo //          Homebrew              //
echo //                    User Cask  //
echo //  kissd3v.                    //
echo /////////////////////////////////
echo ////////////////////////////////
brew install ossp-uuid
brew install zlib
brew install gcc
brew install pkg-config
brew install autoconf
brew install automake
brew install git
brew install curl
brew install python
brew install readline
brew install mas 
echo Installing MacOS User Cask... #Install UserCask Apps
echo ///////////////////////////////////////
echo //////////////////////////////////////
echo //  Install                        //
echo //          Homebrew              //
echo //                    User Cask  //
echo //  kissd3v.                    //
echo /////////////////////////////////
echo ////////////////////////////////
brew cask install gfxcardstatus
brew cask install appcleaner
brew cask install bettertouchtool
brew cask install caprine
brew cask install discord
brew cask install google-chrome
brew cask install java
brew cask install macs-fan-control
brew cask install transmission
brew cask install iterm2
brew cask install obs
brew cask install mysqlworkbench
brew cask install visual-studio-code
brew cask install vlc
brew upgrade
echo Login MacAppStore #Login AppStore Account
mas signin K1ssd3v@icloud.com
echo ///////////////////////////////////////
echo //////////////////////////////////////
echo //  Install                        //
echo //          Pacakages             //
echo //                    MacAppStore//
echo //  kissd3v.                    //
echo /////////////////////////////////
echo ////////////////////////////////
mas account
echo Xmind
mas install 1327661892
echo The Unarchiver
mas install 425424353
echo DrCleaner
mas install 921458519
echo 미세먼지코리아
mas install 1351084155
echo WakeUpTime
mas install 495945638
echo Telegram
mas install 747648890
echo LINE
mas install 539883307
echo NateON
mas install 501556811
echo Boom3D
mas install 1233048948
echo KakaoTalk
mas install 869223134
echo Xcode
mas install 497799835
echo Keynote
mas install 409183694
echo ///////////////////////////////////////
echo ///  MacOS AppStore Update Check   ///
echo /////////////////////////////////////
mas list
mas upgrade
echo Configuring App Store preferences
# Save password for free downloads # TODO
defaults write com.apple.appstore WebKitDeveloperExtras -bool true # Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true # Enable Debug Menu in the Mac App Store
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool true # Auto install app updates
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool FALSE # Don’t install automatically macOS updates
echo ///////////////////////////////////////
echo //////////////////////////////////////
echo //  Setting                        //
echo //           Develop              //
echo //                  WorkSpace    //
echo //  kissd3v.                    //
echo /////////////////////////////////
echo ////////////////////////////////
echo Git Setting
cd $HOME #move user home
mkdir workspace #make user home workspace folder
cd workspace # set git settings
git init
git config --global user.name "LeeNamYong"
git config --global user.email "kissd3v@gmail.com"
git config --global core.editor nano #set default texteditor nano
echo Check Git Setting #set check git settings
git config user.name
git config user.email
echo Ready to workspace #download workspace from github
git clone git@github.com:opentizen/macos_osx_restore_script.git
git clone git@github.com:opentizen/bettertouchtool_apple_script.git
git clone git@github.com:opentizen/homebrew-korea-fonts.git
ls
echo Set launchctl for MacOS
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist # Create local database to enable locate/find commands to search on the system
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist 
launchctl load ~/Library/LaunchAgents/com.apple.myservice.plist
echo Set Docker
brew install docker
echo Set boot2docker from docker
brew install boot2docker
echo Set Virtualbox
brew install virtualbox
echo Set virtualed docker engine
boot2docker init
echo Set MacOS SystemStatus netdata
echo Set Nignx WebServer
brew install nignx #install web_server_nginx
nignx #start web_server_nginx
#restart web_server_nginx => #nginx -s reload
brew install netdata #install netdata
cd $HOME #move user home
git clone https://github.com/netdata/netdata.git --depth=100 #netdata download from git
cd netdata
sudo ./netdata-installer.sh --install /usr/local #enter safari 127.0.x.x rootback check
ls
echo Set oh-my-zsh command-line
brew install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
alias osu='mv ~/Downloads/*.osz /Applications/osu!.app/drive_c/Program\ Files/osu!/songs' >> ~/.zshrc
export PATH=/usr/local/bin:/usr/local/sbin:$PATH >> ~/.zshrc
source ~/.zshrc
echo /////////////////////////////////
echo //  done! plz restart system  //
echo ////////////////////////////////
sudo shutdown -r now