# crouton-init

Setting up a new chroot with crouton can be a pain.

Instead of manually installing and reconfiguring packages, I am aiming to make some scripts that will automate the process.

I'm writing these with myself in mind, but am trying to write them in a way that may be beneficial for others as well.

## Install Process

If you don't know what crouton is, refer to [the repository here](https://github.com/dnschneid/crouton). No really, check it out. It's awesome.

Open the terminal and run `sudo sh ~/Downloads/crouton -t xfce-desktop`

Once installation is complete enter the new chroot with `sudo startxfce4`

Run `package-install.sh` - `wget https://raw.githubusercontent.com/mzrimsek/crouton-init/master/package-install.sh -O - | sudo sh`

Run `git-init.sh` - `wget https://raw.githubusercontent.com/mzrimsek/crouton-init/master/git-init.sh && ./git-init <github_user> <github_token> <email> <full name> && rm git-init.sh`

## Start Clean!

Go full scorched earth, delete everything, and start from scratch! That's what these scripts were made for!

`cd /usr/local/chroots && sudo delete-chroot -y * && sudo rm -rf /usr/local/bin`
