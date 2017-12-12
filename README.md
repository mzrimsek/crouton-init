# crouton-init

Setting up a new chroot with crouton can be a pain.

Instead of manually installing and reconfiguring packages, I am aiming to make some scripts that will automate the process.

I'm writing these with myself in mind, but am trying to write them in a way that may be beneficial for others as well.

## Install Process

Open the terminal and run `sudo sh ~/Downloads/crouton -t xfce-desktop`

Once installation is complete enter the new chroot with `sudo startxfce4`

Run `package-install.sh` - `<COMMAND>`

Run `git-init.sh` - `<COMMAND>`
