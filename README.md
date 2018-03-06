# crouton-init

Setting up a new chroot with crouton can be a pain.

Instead of manually installing and reconfiguring packages, I am aiming to make some scripts that will automate the process.

I'm writing these with myself in mind, but am trying to write them in a way that may be beneficial for others as well.

With that in mind most of these scripts will be very opinionated toward my own usage.

## Install Process

1. If you don't know what crouton is, refer to [the repository here](https://github.com/dnschneid/crouton). No really, check it out. It's awesome.

2. Open the terminal and run `sudo sh ~/Downloads/crouton -t xfce-desktop`

3. Once installation is complete enter the new chroot with `sudo startxfce4`

4. Run `package-install.sh` - `wget https://raw.githubusercontent.com/mzrimsek/crouton-init/master/package-install.sh -O - | sudo -E env "PATH=$PATH" sh`

## Additional Configuration

### Git

* Run `git-init.sh` - `wget https://raw.githubusercontent.com/mzrimsek/crouton-init/master/git-init.sh -O - | sh -s <github_user> <github_token> <email> <full name>`

### Visual Studio Code

* Run `vscode-init.sh` - `wget https://raw.githubusercontent.com/mzrimsek/crouton-init/master/vscode-init.sh -O - | sh`

#### Backup Settings

* Run `vscode-init.sh` - `wget https://raw.githubusercontent.com/mzrimsek/crouton-init/master/vscode-init.sh -O - | sh -s b`

## Start Clean!

Go full scorched earth, delete everything, and start from scratch! That's what these scripts were made for!

`cd /usr/local/chroots && sudo delete-chroot -y * && sudo rm -rf /usr/local/bin`
