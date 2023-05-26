My laptop config
================

This is supposed to run from a local salt-minion install, using ``salt-call``
in a masterless setup. Based on a clean Debian Bookworm netinst installation,
I'm using this to get to my minimal laptop setup on a Dell XPS13. I am currently
running this on a 9310 model.

Among other things, this config will install:

* Gnome
* Most important apps:

  - Firefox,
  - Thunderbird,
  - Spotify,
  - Slack
  - Albert (my favorite launcher),
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
    deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=amd64] https://repo.saltproject.io/salt/py3/debian/11/amd64/latest bullseye main
    apt install --no-install-recommends ca-certificates wget
    wget -O /etc/apt/keyrings/salt-archive-keyring-2023.gpg https://repo.saltproject.io/salt/py3/debian/11/amd64/SALT-PROJECT-GPG-PUBKEY-2023.gpg
    apt install --no-install-recommends git salt-minion
    systemctl disable --now salt-minion
    git clone https://github.com/jdelic/saltshaker-laptop
    mkdir -p /etc/salt/minion.d
    cp ~/saltshaker-laptop/etc/salt-minion/minion.d/saltshaker.conf /etc/salt/minion.d/
    sudo ln -sv ~/saltshaker-laptop/srv/salt /etc/salt/salt
    sudo ln -sv ~/saltshaker-laptop/srv/pillar /etc/salt/pillar
    salt-call --local state.highstate


.. _netinst: https://www.debian.org/devel/debian-installer/
.. # vim: wrap textwidth=80
