
# Extract environment variables
SCRIPTDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
CURRENTDIR=$PWD

cd ~/.config/nvim
# Install required packages
echo "INSTALLING PACKAGES AND PROGRAMS"
sudo apt-get install neovim curl nodejs npm python3 exuberant-ctags clangd -y
sudo add-apt-repository ppa:jonathonf/vim
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
sudo npm install -g yarn -y
sudo apt update
sudo apt install vim

# Creating folders
echo "CREATING FOLDERS"
mkdir -p ~/.config
mkdir -p ~/.config/nvim

# Symbolic links creation
echo "CREATING SYMBOLIC LINKS"
ln -s -f $SCRIPTDIR/cfg_files/.bashrc ~
ln -s -f $SCRIPTDIR/cfg_files/.gitconfig ~
ln -s -f $SCRIPTDIR/cfg_files/.vimrc ~
ln -s -f $SCRIPTDIR/cfg_files/nvim/init.vim ~/.config/nvim/
echo "$SCRIPTDIR"

# Neovim setups
echo "NEOVIM SETUP"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim ~/.neovim_setup.txt -c ":PlugInstall" -c ":q" -c ":q"
cd ~/.config/nvim/plugged/coc.nvim
yarn install
yarn build
pip3 install jedi
nvim ~/.neovim_setup.txt -c ":CocInstall coc-pyright" -c ":q" -c ":q"
nvim ~/.neovim_setup.txt -c ":CocInstall coc-clangd" -c ":q" -c ":q"

cd $CURRENTDIR
