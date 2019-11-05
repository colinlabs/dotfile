# install brew packages
BASEDIR=$(cd `dirname $0`; pwd)

pkgs(){
    ## homebrew
    export HOMEBREW_NO_AUTO_UPDATE=1
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    cd "$(brew --repo)"
    git remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git
    cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
    git remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git
    ## Make sure we’re using the latest Homebrew.
    brew update

    ## Upgrade any already-installed formulae.
    brew upgrade

    brew tap caskroom/fonts
    ## Install command-line tools using Homebrew.
    # brew install emacs-mac --HEAD --with-official-icon --with-ctags  --with-gnutls
    brew install vim zsh
    brew install findutils moreutils coreutils gnu-sed the_silver_searcher 
    brew install tmux tree autojump htop iftop fzf wget iproute2mac
    brew install figlet httpie bat
    ## Remove outdated versions from the cellar.
    brew cleanup

}

apps() {

    brew cask install \
        font-fira-code \
        iterm2 \
        visual-studio-code \
        qq wechat \
        shadowsocksx-ng \
        wpsoffice \
        neteasemusic \
        dingtalk \
        yinxiangbiji \
        virtualbox \
        eudic
}

tools(){
    ## prezto
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    ## zplug
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
    ## SpaceVim
    curl -sLf https://spacevim.org/install.sh | bash
    ## spacemacs
    # git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

}

links(){
    
    # ln -sf $BASEDIR/spacemacs.d/ ~/.spacemacs.d
    cp $BASEDIR/gitconfig ~/.gitconfig
    mkdir ~/.pip && cp $BASEDIR/python/pip.conf ~/.pip/
    ln -sf $BASEDIR/SpaceVim.d ~/.SpaceVim.d

    ln -sf $BASEDIR/zsh/zshrc ~/.zshrc
    ln -sf $BASEDIR/zsh/zlogin ~/.zlogin
    ln -sf $BASEDIR/zsh/zpreztorc ~/.zpreztorc
    cp $BASEDIR/zsh/zprofile ~/.zprofile

}


install(){

    pkgs
    tools
    links
}

$@