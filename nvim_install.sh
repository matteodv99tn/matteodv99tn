SCRIPTDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

sudo apt-get install curl, ripgrep

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Download the latest executable from the GitHub repository
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage /usr/bin/nvim
sudo chmod +x /usr/bin/nvim

# Create symbolic link to configuration scripts
echo "Creating symbolic links"
sudo mkdir -p $HOME/.config/nvim 
sudo ln -s -f $SCRIPTDIR/nvim_files/* $HOME/.config/nvim/ -r
