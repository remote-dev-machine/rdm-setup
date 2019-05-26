# Dev Machine
Steps to setup a remote dev environment to code on the go.

## Pre-requisites
- A remote server setup like AWS EC2 running on Linux. The following steps were created for a Ubuntu based system.

## Basic housekeeping
- Login as the root user
- Add a new user with sudo privileges
- Change hostname in remote machine to something easy to remember (e.g. DevMachine)
- Add the new hostname in local machine's `/etc/hosts` like `xx.xxx.xxx.xxx DevMachine`

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
git clone git@github.com:nishantdania/devmachine.git
```
- Replace existing vimrc with this custom one
```
cp ~/devmachine/.vimrc ~/.vimrc
source ~/.vimrc
rm -rf vimrc
```
- Make Vim the default editor
```
sudo update-alternatives --config editor
```
- Install new plugins >> Open vim using `vi`. It should start downloading the required packages. If it does not, using `:PlugInstall`

That's it !
