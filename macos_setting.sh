#!/usr/bin/env bash

echo  "custom_settings_macbook"  

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Updates                                                                     #
###############################################################################

# search for system updates and install them
# softwareupdate --install --all

###############################################################################
# General                                                                     #
###############################################################################

echo "Configuring general preferences"

# Use dark menu bar and dock
defaults write ~/Library/Preferences/.GlobalPreferences.plist AppleInterfaceTheme -string "Dark"
defaults write ~/Library/Preferences/.GlobalPreferences.plist AppleInterfaceStyle -string "Dark"

# Set sidebar icon size to small
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

###############################################################################
# Desktop & Screen Saver                                                      #
###############################################################################

echo "Configuring desktop and screen saver preferences"

# Change screensaver to random
# defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName Random path /System/Library/Screen\ Savers/Random.saver type 8

# Start screensaver after 10 minutes
defaults -currentHost write com.apple.screensaver idleTime 1800

# Show screensaver with Clock
defaults -currentHost write com.apple.screensaver showClock -bool t

# Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
# all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
# rm -rf ~/Library/Application Support/Dock/desktoppicture.db
# sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
# sudo ln -s /path/to/your/image /System/Library/CoreServices/DefaultDesktop.jpg

###############################################################################
# Dock                                                                        #
###############################################################################

echo "Configuring dock preferences"

# Set the icon size of Dock items to 34 pixels
defaults write com.apple.dock tilesize -int 34

# Change minimize/maximize window effect to Scale effect
defaults write com.apple.dock mineffect -string "scale"

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool false

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Change dock position on the screen to left
defaults write com.apple.dock orientation -string bottom

# Turn off magnification
defaults write com.apple.dock magnification -boolean NO

# Double-click a window's title bar to minimize
defaults write ~/Library/Preferences/.GlobalPreferences.plist AppleActionOnDoubleClick -string "Minimize"

# Prefer tabs when opening documents always
defaults write ~/Library/Preferences/.GlobalPreferences.plist AppleWindowTabbingMode -string "always"

# remove all icons from the dock
defaults write com.apple.dock persistent-apps -array

# add my preferred icons to the dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Mail.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Calendar.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Notes.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Utilities/Terminal.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

###############################################################################
# Mission Control                                                             #
###############################################################################

echo "Configuring mission control preferences"

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool true

# Don’t group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool false

# Disable Dashboard → disabled by default
# defaults write com.apple.dashboard mcx-disabled -bool true

# Hot Corners... Top left screen corner → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 1
defaults write com.apple.dock wvous-tl-modifier -int 0

###############################################################################
# Language & Region                                                           #
###############################################################################

echo "Configuring language and region preferences"

# System language set to English, region set to ES
defaults write ~/Library/Preferences/.GlobalPreferences.plist AppleLocale -string "en_US"

# Select default metrics
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true
defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"

###############################################################################
# Security & Privacy                                                          #
###############################################################################

echo "Configuring security and privacy preferences"

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Turn on firewall
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

###############################################################################
# Spotlight                                                                   #
###############################################################################

echo "Configuring spotlight preferences"

# Change default spotlight categories
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}' \
	'{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DOCUMENTS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 1;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "MESSAGES";}' \
	'{"enabled" = 1;"name" = "CONTACT";}' \
	'{"enabled" = 1;"name" = "EVENT_TODO";}' \
	'{"enabled" = 1;"name" = "IMAGES";}' \
	'{"enabled" = 1;"name" = "BOOKMARKS";}' \
	'{"enabled" = 1;"name" = "MUSIC";}' \
	'{"enabled" = 1;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "FONTS";}' \
	'{"enabled" = 1;"name" = "MENU_OTHER";}' \
	'{"enabled" = 1;"name" = "SOURCE";}'

###############################################################################
# Displays                      	                                      #
###############################################################################

echo "Configuring displays preferences"

# Don't show mirroring options in menu bar
defaults write com.apple.airplay showInMenuBarIfPresent -bool true

# TODO is it possible to change resolution with a command?

###############################################################################
# Energy Saver                  	                                      #
###############################################################################

echo "Configuring energy saver preferences"

# Show Battery Percentage on the meny bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Battery - Computer sleep: 20 min
sudo pmset -b sleep 20

# Battery - Turn display off after: 5 min
sudo pmset -b displaysleep 5

# Power Adapter - Computer sleep: 30 min
sudo pmset -c sleep 30

# Power Adapter - Turn display off after: 12 min
sudo pmset -c displaysleep 12

###############################################################################
# Keyboard                       	                                      #
###############################################################################

echo "Configuring keyboard preferences"

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Don't adjust keyboard brightness on low light
# defaults write com.apple.BezelServices kDim -bool true

# Turn keyboard backlight off after 30 secs of inactivity
defaults write com.apple.BezelServices kDimTime -int 30

# Disable auto-correct spelling automatically
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Set a fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

###############################################################################
# Trackpad                       	                                      #
###############################################################################

echo "Configuring trackpad preferences"

# enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# activate App Expose gesture
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

###############################################################################
# Printers                       	                                      #
###############################################################################

echo "Configuring printers preferences"

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

###############################################################################
# Sound                         	                                      #
###############################################################################

echo "Configuring sound preferences"

# Show volume in menu bar and hide clock/calendar (I use day-o)
defaults write com.apple.systemuiserver menuExtras -array \
	"/System/Library/CoreServices/Menu Extras/Volume.menu" \
	"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
	"/System/Library/CoreServices/Menu Extras/Battery.menu"

defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -bool true

###############################################################################
# App Store                      	                                      #
###############################################################################

echo "Configuring App Store preferences"

# Save password for free downloads
# TODO

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

# Auto install app updates
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool true

# Don’t install automatically macOS updates
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool FALSE

###############################################################################
# Bluethooth                     	                                      #
###############################################################################

echo "Configuring Bluetooth preferences"

# Turn bluethooth off
# TODO

###############################################################################
# Users & Groups                	                                      #
###############################################################################

echo "Configuring users and groups preferences"

# Don't allow guests to log in to this computer
# TODO
# sudo defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
# sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO
# sudo defaults write /Library/Preferences/com.apple.loginwindow.plist GuestEnabled -bool NO

###############################################################################
# Date & Time                   	                                      #
###############################################################################

echo "Configuring date and time preferences"

# Show date on the menu bar
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM  HH:mm"

###############################################################################
# Time Machine                   	                                      #
###############################################################################

echo "Configuring time machine preferences"

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool false

###############################################################################
# Accesibility                  	                                      #
###############################################################################

echo "Configuring accesibility preferences"

# Enable trackpad dragging without lock
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -int 1
defaults write com.apple.AppleMultitouchTrackpad Dragging -int 1

###############################################################################
# Extras                        	                                      #
###############################################################################

echo "Configuring extra preferences"

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Create Developer folder in home directory
if [ ! -d ~/Developer ]; then
	mkdir ~/Developer
fi;

# Create local database to enable locate/find commands to search on the system
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

###############################################################################
# Desktop                        	                                      #
###############################################################################

echo "Configuring desktop view options"

# Show item info to the right of the icons on the desktop
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

# Set desktop icons size to 20x20
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 20" ~/Library/Preferences/com.apple.finder.plist

# Set grid spacing for desktop icons to 50
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist

# Set text size to 10pt
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:textSize 10" ~/Library/Preferences/com.apple.finder.plist

###############################################################################
# Finder                         	                                      #
###############################################################################

echo "Configuring finder options"

# Set User home as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "icnv"

# Don't show tags on the sidebar
# TODO

# Don't show "All my files" and "Recent tags" on the sidebar
# TODO "all my files"
defaults write com.apple.finder ShowRecentTags -bool false

# Show "User" and "User Macbook Pro" on the sidebar
# TODO

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

###############################################################################
# Mail                          	                                      #
###############################################################################

echo "Configuring mail options"

# Show To/Cc label in the message list
defaults write com.apple.mail EnableToCcInMessageList -bool true

# Bold unread messages
defaults write com.apple.mail ShouldShowUnreadMessagesInBold -bool true

# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

# Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# Check for new messages automatically
defaults write com.apple.mail PollTime -int -1

# TODO add signature to gmail
# TODO select gmail as primary address
# TODO Enable junk mail filtering

###############################################################################
# Safari                         	                                      #
###############################################################################

echo "Configuring safari options"

# show the status bar at the bottom (see URL on hover)
defaults write com.apple.Safari 'ShowStatusBar' -bool true

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to google.com
defaults write com.apple.Safari HomePage -string "https://www.apple.com"

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Show Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool true
defaults write com.apple.Safari ShowFavoritesBar-v2 -bool true

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Open new tabs with an empty page
defaults write com.apple.Safari NewTabBehavior -int 1

# don't show favorites on the smart search bar
defaults write com.apple.Safari ShowFavoritesUnderSmartSearchField -bool false

# don't allow websites to ask for permission to send push notifications
defaults write com.apple.Safari CanPromptForPushNotifications -bool false

# include search engine suggestions
defaults write com.apple.Safari SuppressSearchSuggestions -bool false

# TODO install extensions: "Save to Pocket", "AdBlock", "SessionRestore"

###############################################################################
# Calendar                      	                                      #
###############################################################################

echo "Configuring calendar options"

# Don't show birthdays Calendar
defaults write com.apple.iCal "display birthdays calendar" -bool false

# Show week numbers
defaults write com.apple.iCal "Show Week Numbers" -bool true

# Make text smaller
defaults write com.apple.iCal "CalUICanvasOccurrenceFontSize" -int 10

###############################################################################
# Contacts                       	                                      #
###############################################################################

echo "Configuring contacts options"

# Address format
defaults write com.apple.AddressBook ABDefaultAddressCountryCode -string "es"

# Display format "First, Last"
defaults write com.apple.AddressBook NSPersonNameDefaultDisplayNameOrder -int 1

# Sort by first name
defaults write com.apple.AddressBook ABNameSortingFormat -string "sortingFirstName sortingLastName"

###############################################################################
# Terminal                       	                                      #
###############################################################################

echo "Configuring terminal options"

# default theme to Basic
defaults write com.apple.Terminal "Default Window Settings" -string "Basic"
defaults write com.apple.Terminal "Startup Window Settings" -string "Basic"

# configure the basic theme
# /usr/libexec/PlistBuddy -c "Set \"Window Settings\":Basic:FontAntialias 1" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:rowCount integer 30" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:UseBoldFonts bool 1" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:ShowActiveProcessArgumentsInTitle bool 1" ~/Library/Preferences/com.apple.Terminal.plist

# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:ShowRepresentedURLPathInTitle bool 0" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:ShowTTYNameInTitle bool 0" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:BackgroundSettingsForInactiveWindows bool 0" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:UseBrightBold bool 0" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:ShowWindowSettingsNameInTitle bool 0" ~/Library/Preferences/com.apple.Terminal.plist

# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:ShowCommandKeyInTitle bool 0" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:BackgroundBlur real 0,296188586795261" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:CursorType bool 0" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:columnCount integer 90" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:ShowDimensionsInTitle bool 0" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:CursorBlink bool 0" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:ShowActiveProcessInTitle bool 1" ~/Library/Preferences/com.apple.Terminal.plist

# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:ShowShellCommandInTitle bool 0" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:ShowRepresentedURLInTitle bool 1" ~/Library/Preferences/com.apple.Terminal.plist

# /usr/libexec/PlistBuddy -c "Add \"Window Settings\":Basic:BackgroundColor data \"<62706c69 73743030 d4010203 04050615 16582476 65727369 6f6e5824 6f626a65 63747359 24617263 68697665 72542474 6f701200 0186a0a3 07080f55 246e756c 6cd3090a 0b0c0d0e 554e5352 47425c4e 53436f6c 6f725370 61636556 24636c61 73734631 20312031 00100180 02d21011 12135a24 636c6173 736e616d 65582463 6c617373 6573574e 53436f6c 6f72a212 14584e53 4f626a65 63745f10 0f4e534b 65796564 41726368 69766572 d1171854 726f6f74 80010811 1a232d32 373b4148 4e5b6269 6b6d727d 868e919a acafb400 00000000 00010100 00000000 00001900 00000000 00000000 00000000 0000b6>\"" ~/Library/Preferences/com.apple.Terminal.plist
# /usr/libexec/PlistBuddy -c "Set \"Window Settings\":Basic:Font data \"<62706c69 73743030 d4010203 04050618 19582476 65727369 6f6e5824 6f626a65 63747359 24617263 68697665 72542474 6f701200 0186a0a4 07081112 55246e75 6c6cd409 0a0b0c0d 0e0f1056 4e535369 7a65584e 5366466c 61677356 4e534e61 6d655624 636c6173 73234026 00000000 00001010 80028003 5e53464d 6f6e6f2d 52656775 6c6172d2 13141516 5a24636c 6173736e 616d6558 24636c61 73736573 564e5346 6f6e74a2 1517584e 534f626a 6563745f 100f4e53 4b657965 64417263 68697665 72d11a1b 54726f6f 74800108 111a232d 32373c42 4b525b62 69727476 78878c97 a0a7aab3 c5c8cd00 00000000 00010100 00000000 00001c00 00000000 00000000 00000000 0000cf>\"" ~/Library/Preferences/com.apple.Terminal.plist

###############################################################################
# Text Edit                                                                   #
###############################################################################

echo "Configuring text edit options"

# Plain text by default
defaults write com.apple.TextEdit RichText -int 0

# Turn off 'smart' editing
defaults write com.apple.TextEdit SmartDashes -int 0
defaults write com.apple.TextEdit SmartQuotes -int 0
defaults write com.apple.TextEdit TextReplacement -int 0

# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

###############################################################################
# Activity Monitor                                                            #
###############################################################################

echo "Configuring activity monitor options"

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

###############################################################################

echo "Done. Note that some of these changes require a logout/restart to take effect."

# Restart computer now!
sudo shutdown -r now