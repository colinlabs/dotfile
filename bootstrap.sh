#!/usr/bin/env bash

BASEDIR=$(cd $(dirname $0);pwd)
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
export HOMEBREW_NO_AUTO_UPDATE=1

# install brew packages
pkgs() {
    ## homebrew
    # curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

    # cd "$(brew --repo)"
    # git remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git
    # cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
    # git remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git

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
    # tssh like ssh
    brew install trzsz-ssh
    # kubecolor
    brew install kubecolor
    # amazon-q
    brew install amazon-q
    ## Remove outdated versions from the cellar.
    brew cleanup

}

apps() {
    brew install --cask \
        iterm2 \
        alfred 
}

tools() {
    zsh_completion_dir="/opt/homebrew/share/zsh/site-functions"

    ## prezto
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

    ## SpaceVim
    curl -sLf https://spacevim.org/install.sh | bash

    # Download zimfw plugin manager if missing.
    ZIM_HOME=~/.zim
    if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    fi

    ## spacemacs
    # git clone https://github.com/syl20bnr/spacemacs $HOME/emacs.d

    ## colorls, like ls
    PATH=/opt/homebrew/opt/ruby/bin:$PATH
    gem install colorls
    cp $HOME/.gem/ruby/*/gems/colorls*/zsh/_colorls $zsh_completion_dir/
}

links() {
    # ln -sf $BASEDIR/spacemacs.d/ $HOME/spacemacs.d

    [ ! -f "$HOME/.gitconfig" ] && cp $BASEDIR/gitconfig $HOME/.gitconfig
    ln -sf $BASEDIR/SpaceVim.d $HOME/.SpaceVim.d
    ln -sf $BASEDIR/zsh/zshrc $HOME/.zshrc
    ln -sf $BASEDIR/zsh/zlogin $HOME/.zlogin

    cp $BASEDIR/zsh/zprofile $HOME/.zprofile

    ln -sf $BASEDIR/zsh/p10k.zsh $HOME/.p10k.zsh
    ln -sf $BASEDIR/jetbrans/ideavimrc $HOME/.ideavimrc
    ln -sf $BASEDIR/config/zimrc $HOME/.config/zimrc
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
