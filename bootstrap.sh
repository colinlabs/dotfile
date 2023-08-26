#!/usr/bin/env bash
set -xe

BASEDIR=$(cd $(dirname $0);pwd)
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
export HOMEBREW_NO_AUTO_UPDATE=1

# install brew packages
pkgs() {
    ## homebrew
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

    cd "$(brew --repo)"
    git remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git
    cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
    git remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git

    ## Load brew command
    eval "$(/opt/homebrew/bin/brew shellenv)"

    ## Make sure we’re using the latest Homebrew.
    brew update

    ## Upgrade any already-installed formulae.
    brew upgrade

    ## Brew tap
    brew tap homebrew/cask-fonts

    ## Install command-line tools using Homebrew.
    # brew install emacs-mac --HEAD --with-official-icon --with-ctags  --with-gnutls

    # Disable build-in command
    brew reinstall zsh ruby
    sudo chsh -s /opt/homebrew/bin/zsh $(whoami)

    # Essential tools
    brew reinstall vim

    # tools
    brew install findutils moreutils coreutils gnu-sed the_silver_searcher gnu-tar trash
    brew install tmux tree autojump htop iftop fzf wget iproute2mac lrzsz

    # ascii graph
    brew install figlet
    # like curl
    brew install httpie
    # like cat
    brew install bat
    # like man
    brew install tldr
    # like df
    brew install duf
    # font
    brew install font-fira-code font-hack-nerd-font
    # zplug
    brew install zplug
    # starship promt
    brew install starship
    # exa like ls
    brew install exa nnn
    ## Remove outdated versions from the cellar.
    brew cleanup

}

apps() {
    brew install --cask \
        iterm2 \
        alfred \
        bartender \

        wechat \
        # terminal auto completion
        fig
}

tools() {
    zsh_completion_dir="/opt/homebrew/share/zsh/site-functions"

    ## prezto
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

    ## SpaceVim
    curl -sLf https://spacevim.org/install.sh | bash

    ## spacemacs
    # git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

    ## colorls, like ls
    PATH=/opt/homebrew/opt/ruby/bin:$PATH
    gem install colorls
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

    ln -sf $BASEDIR/zsh/p10k.zsh ~/.p10k.zsh
    ln -sf $BASEDIR/jetbrans/ideavimrc ~/.ideavimrc
}

after() {
    yes | $(brew --prefix)/opt/fzf/install
}

install() {
    pkgs
    tools
    links
}

$@
