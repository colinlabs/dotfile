# 
sudo spctl --master-disable

# font
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
defaults -currentHost write -globalDomain AppleFontSmoothing -int 3

# password lenght
 pwpolicy -clearaccountpolicies

