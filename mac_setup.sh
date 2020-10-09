# 
sudo spctl --master-disable

# font
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
defaults -currentHost write -globalDomain AppleFontSmoothing -int 3

# password lenght
pwpolicy -clearaccountpolicies

# Application Language 
defaults write com.apple.Maps AppleLanguages '(zh-CN)'
defaults write com.apple.iCal AppleLanguages '(zh-CN)'

# Show Pathbar
defaults write com.apple.finder ShowPathbar -bool true

# Jetbrains
# defaults write com.jetbrains.goland CGFontRenderingFontSmoothingDisabled -bool YES
