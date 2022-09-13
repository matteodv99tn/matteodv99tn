# Repository Download
## Git account setup

If the SSH connection to the GitHub account isn't properly setup, follow this steps:

1. execute the command `ssh-keygen -t ed25519 -C "your_email@example.com"` to generate the SSH key; when prompted for file location just press _enter_ (sets default path) and then set the password;
2. start the SSH agent `eval "$(ssh-agent -s)"` and add the generated key to the agent with `ssh-add ~/.ssh/id_ed25519`;
3. to clip the public SSH key, first install _xclip_ with `sudo apt-get install xclip`, then perform `xclip ~/.ssh/id_ed25519.pub -sel clip` and paste it in the proper setting field of the GitHub account.

## Clone the repository
To update configuration files, firstly check to have git installed (`sudo apt install git -y`) and clone the current repository in the `.configfiles` folder as follows:
``` 
git clone git@github.com:matteodv99tn/matteodv99tn.git ~/.configfiles
```

# Bootstrap execution
Lunch the script `bootstrap.sh` within the terminal; pay attention that script requires administration rights (that will be prompted) and might require interaction with the user for continuing the installation.


