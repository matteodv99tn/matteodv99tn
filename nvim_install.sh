SCRIPTDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Download the latest executable from the GitHub repository
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage /usr/bin/nvim

# Create symbolic link to configuration scripts
mkdir -p $HOME/.config/nvim 
ln -s -f $SCRIPTDIR/nvim_files/* $HOME/.config/nvim/ -r
