# Dev Machine
Steps to setup a remote dev environment to code on the go.

## Pre-requisites
- A remote server setup like AWS EC2 running on Linux
- For Mac, install brew via 
  `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`
- For Mac, instal wget by `brew install wget`

## Basic housekeeping (Linux)
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
- Update firewall on remote server to accept UDP connection from Mosh (Linux)
```
sudo ufw allow 60000:61000/udp
```
- If there is a locale error, use this on remote server (Linux)
```
sudo apt-get update
sudo apt-get install -y locales
sudo locale-gen "en_US.UTF-8"
sudo update-locale LC_ALL="en_US.UTF-8"
```

## Setup ZSH shell
- Install ZSH (Linux)
```
sudo apt-get install zsh
# brew install zsh
```
- Copy the path to the installation. The path can be found using:
```
which zsh
```
- Make ZSH the default shell
```
chsh -s /usr/local/bin/zsh
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

### Screenshot
![Vim](https://user-images.githubusercontent.com/1717441/96362662-748f9980-1161-11eb-9c01-aceedec23065.png)

### Setup Fugitive Browse handler to open github files/commits in browser from vim
- [Generate access token](https://github.com/settings/tokens/new)
- Setup login credentials
```
echo 'machine api.github.com login <user> password <token>' >> ~/.netrc
```

### Setup solargraph for ruby intellisense
```
gem install solargraph
```

### Setup Rg for search
- Install Ripgrep (Linux)
```
sudo apt-get install ripgrep
# brew install ripgrep
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
ln -s ~/rdm-setup/.vimrc ~/.vimrc
cp ~/rdm-setup/coc-settings.json ~/.vim/coc-settings.json
```
- Make Vim the default editor (Linux)
```
sudo update-alternatives --config editor
```
- Install new plugins >> Open vim using `vi`. It should start downloading the required packages. If it does not, using `:PlugInstall`

### Setup coc.nvim extensions for intellisense
- Run the following command in vim
```
:CocInstall coc-json coc-css coc-elixir coc-ember coc-eslint coc-html coc-stylelint coc-solargraph coc-tsserver coc-yaml coc-vimlsp coc-kotlin coc-java coc-xml coc-sql coc-sh coc-graphql
```

## Setup tmux
- Install tmux
```
sudo apt-get install tmux
# brew install tmux
```
- Add tmux config symlink
```
ln -s ~/rdm-setup/.tmux.conf ~/.tmux.conf
```
- Install tmuxinator
```
sudo apt-get install -y tmuxinator
# brew install tmuxinator
```

**That's it !**
