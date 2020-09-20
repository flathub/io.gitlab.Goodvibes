# Flatpak packaging for Goodvibes

Add the Flathub repository and install the necessary SDK:

    $ make setup

To build the package, run:

    $ make

This builds both the Flatpak repo (in `repo`) and the bundle as
`<app-id>.flatpak`. To install the bundle:

    $ make install

Then run the application:

    $ make run

If things go wrong:

    $ make debug
    [📦] $ alias ls='ls --color'
    [📦] $ alias ll='ls -l'
    [📦] $ cat /etc/os-release
    [📦] $ ...

When done, don't forget to cleanup:

    $ make uninstall
