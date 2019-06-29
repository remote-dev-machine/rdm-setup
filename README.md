# Dev Machine
Steps to setup a remote dev environment to code on the go.

## Pre-requisites
- A remote server setup like AWS EC2 running on Linux. The following steps were created for a Ubuntu based system.

## Basic housekeeping
- Login as the root user
- Add a new user with sudo privileges
- Change hostname in remote machine to something easy to remember (e.g. DevMachine)
- Add the new hostname in local machine's `/etc/hosts` like `xx.xxx.xxx.xxx DevMachine`

## Setup Mosh (used instead of SSH)
- Install Mosh on both client and remote
```
sudo apt-get install mosh
# brew install mosh
```
- Update firewall on remote server to accept UDP connection from Mosh
```
sudo ufw allow 60000:61000/udp
```
- If there is a locale error, use this on remote server
```
sudo apt-get update
sudo apt-get install -y locales
sudo locale-gen "en_US.UTF-8"
sudo update-locale LC_ALL="en_US.UTF-8"
```

## Setup ZSH shell
- Install ZSH
```
sudo apt-get install zsh
```
- Copy the path to the installation. The path can be found using:
```
which zsh
```
- Make ZSH the default shell
```
chsh -s path/to/zsh/installation
```

## Setup Oh-my-ZSH
- Install Oh-my-ZSH
```
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
```
- Add a .zshrc file and source it
```
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
source ~/.zshrc
```

## Setup Github
- Setup user config
```
git config --global user.email "nishantdania@gmail.com"
git config --global user.name "nishantdania"
```
- Setup SSH keys on Github - [Guide](https://help.github.com/en/articles/connecting-to-github-with-ssh)

## Setup Vim Editor

### Setup Ack for search
- Install Ack-grep
```
sudo apt-get install ack-grep
```
- Rename ack-grep to ack
```
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
```

### Setup fzf for fuzzy find
- Install fzf
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```
### Setup vimrc
- Fetch the latest vimrc from devmachine repo
```
git clone git@github.com:remote-dev-machine/rdm-setup.git
```
- Setup symbolic links to the new vimrc and vim plugins
```
mkdir ~/.vim
ln -s ~/rdm-setup/vim/.vimrc ~/.vimrc
ln -s ~/rdm-setup/vim/pluginConfigs ~/.vim/pluginConfigs
ln -s ~/rdm-setup/vim/vimNativeConfigs ~/.vim/vimNativeConfigs
```
- Make Vim the default editor
```
sudo update-alternatives --config editor
```
- Install new plugins >> Open vim using `vi`. It should start downloading the required packages. If it does not, using `:PlugInstall`

## Setup tmux
- Install tmux
```
sudo apt-get install tmux
```
- Add tmux config
```
cp ~/devmachine/.tmux.conf ~/.tmux.conf
source ~/.tmux.conf
```

**That's it !**
