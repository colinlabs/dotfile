# install brew packages
###
 # @Author: your name
 # @Date: 2021-01-12 23:08:58
 # @LastEditTime: 2021-01-14 10:18:23
 # @LastEditors: Colin.Lee
 # @Description: In User Settings Edit
 # @FilePath: /.dotfile/bootstrap.sh
### 
BASEDIR=$(cd $(dirname $0);pwd)

pkgs() {
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

    ## Brew tap
    brew tap homebrew/cask-fonts

    ## Install command-line tools using Homebrew.
    # brew install emacs-mac --HEAD --with-official-icon --with-ctags  --with-gnutls

    # Essential tools
    brew install vim zsh
    # tools
    brew install findutils moreutils coreutils gnu-sed the_silver_searcher gnu-tar
    brew install tmux tree autojump htop iftop fzf wget iproute2mac

    # ascii graph
    brew install figlet
    # like curl
    brew install httpie
    # like cat
    brew install bat
    # like man
    brew install tldr
    # like ls
    brew install exa
    # font
    brew install font-fira-code
    ## Remove outdated versions from the cellar.
    brew cleanup

}

apps() {
    brew install --cask \
        iterm2 \
        visual-studio-code \
        qq wechat \
        wpsoffice \
        neteasemusic \
        dingtalk \
        yinxiangbiji \
        virtualbox \
        typora \
        bob 
}

tools() {
    zsh_completion_dir="/usr/local/share/zsh/site-functions"
    ## prezto
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    ## zplug
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    ## SpaceVim
    curl -sLf https://spacevim.org/install.sh | bash
    ## spacemacs
    # git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
    ## gem source
    gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
    ## colorls
    gem install colorls --user-install
    cp $HOME/.gem/ruby/*/gems/colorls*/zsh/_colorls $zsh_completion_dir/
}

links() {
    # ln -sf $BASEDIR/spacemacs.d/ ~/.spacemacs.d
    cp $BASEDIR/gitconfig ~/.gitconfig
    mkdir ~/.pip && cp $BASEDIR/python/pip.conf ~/.pip/
    ln -sf $BASEDIR/SpaceVim.d ~/.SpaceVim.d

    ln -sf $BASEDIR/zsh/zshrc ~/.zshrc
    ln -sf $BASEDIR/zsh/zlogin ~/.zlogin
    cp $BASEDIR/zsh/zprofile ~/.zprofile

    ln -sf ~/.dotfile/zsh/p10k.zsh ~/.p10k.zsh
}

after() {
    echo "$(brew --prefix)/opt/fzf/install"
}

install() {
    pkgs
    tools
    links
}

$@
