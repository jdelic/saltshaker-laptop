My laptop config
================

This is supposed to run from a local salt-minion install, using ``salt-call``
in a masterless setup. Based on a clean Debian Bookworm netinst installation,
I'm using this to get to my minimal laptop setup on a Dell XPS13. I am currently
running this on a 9310 model.

Among other things, this config will install:

* Gnome
* Most important apps:

  - Firefox
  - Thunderbird
  - Spotify
  - Slack
  - `Albert (my favorite launcher) <albert_>`__,
  - Enpass

* Most important Firefox extensions:

  - uBlock,
  - Enpass,
  - German dictionary,
  - Multi-account containers

* Enforces Firefox sanitization on closing the browser and other settings.

* Some other available applications include:

  - nordvpn
  - Discord
  - OBS
  - Airtame
  - `Starship prompt <starship_>`__


Getting to Netinst
------------------

Download the `Debian Netinst ISO <netinst_>`__. Then
install the minimal system. I like using the text mode installer and I
partition like this:

* 512MB EFI
* 512MB EXT4 /boot
* Remainder is dm-crypt encrypted volume with LVM (start by configuring the
  encrypted partition in the text mode installer, then add LVM and a volume
  group ``vg0``)

  - 90GB EXT4 vg0-root /root
  - 16GB SWAP vg0-swap ---
  - 256GB EXT4 vg0-home /home

After booting into the minimal system under bookwork, wifi will have been
configured in ``/etc/network/interfaces``. Gnome will later use NetworkManager,
which will not manage network adapters listed in ``/etc/network/interfaces``.
So after the first run of ``salt-call``, you'll have to remove the static
configuration.


.. code-block:: shell

    cd
    cat >/etc/apt/sources.list.d/saltstack.list
    deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=amd64] https://repo.saltproject.io/salt/py3/debian/12/amd64/latest bookworm main
    apt install --no-install-recommends ca-certificates wget
    wget -O /etc/apt/keyrings/salt-archive-keyring-2023.gpg https://repo.saltproject.io/salt/py3/debian/12/amd64/SALT-PROJECT-GPG-PUBKEY-2023.gpg
    apt install --no-install-recommends git salt-minion
    systemctl disable --now salt-minion
    git clone https://github.com/jdelic/saltshaker-laptop
    mkdir -p /etc/salt/minion.d
    cp ~/saltshaker-laptop/etc/salt-minion/minion.d/saltshaker.conf /etc/salt/minion.d/
    sudo ln -sv ~/saltshaker-laptop/srv/salt /etc/salt/salt
    sudo ln -sv ~/saltshaker-laptop/srv/pillar /etc/salt/pillar
    salt-call --local state.highstate | less


Important Gnome Extensions
--------------------------

These aren't installed automatically by this salt config, but I find them
useful and you can install them from ``Extension Manager``:

* `Frippery Move Clock <frippery_>`__ (moves the clock to the right where it 
  belongs)
* `Vertical overview <vertical_>`__ (because vertically stacked virtual 
  desktops are much more sensible)
* `Tray Icons <trayicons_>`__: Reloaded (no idea why Gnome tries to remove 
  them... so much software still uses them)

  - Make sure to change the settings to allow like 10 or so icons

* `No Overview At Start-up <nooverview_>`__ (with Albert as launcher the
  default is just annoying)


Important Gnome Settings to remember
------------------------------------

1. To get Albert to launch on ``META+X`` use Gnome settings and set a Keyboard
   shortcut for ``albert toggle``.
2. In the keyboard settings also change "Navigation"->"Switch Applications" to
   "disabled" and "Switch Windows" to "Alt+Tab"
3. On Gnome Tweaks set the clock to show calendar weeks and the date


Which Albert Plugins to Enable?
-------------------------------

I commonly use

* Applications
* Calculator
* Python
* System

  - I rename "Poweroff" to "Shutdown"

* Terminal

.. _netinst: https://www.debian.org/devel/debian-installer/
.. _starship: https://starship.rs
.. _albert: https://github.com/albertlauncher/albert
.. _frippery: https://extensions.gnome.org/extension/2/move-clock/
.. _vertical: https://extensions.gnome.org/extension/4144/vertical-overview/
.. _nooverview: https://extensions.gnome.org/extension/4099/no-overview/
.. _trayicons: https://extensions.gnome.org/extension/2890/tray-icons-reloaded/
.. # vim: wrap textwidth=80
