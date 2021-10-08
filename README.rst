My laptop config
================

This is supposed to run from a local salt-minion install, using ``salt-call``
in a masterless setup. Based on a clean Debian Bullseye netinst installation,
I'm using this to get to my minimal laptop setup on a Dell XPS13. I am currently
running this on a 9310 model.

Among other things, this config will install:
  
* Gnome
* Most important apps: 

  - Firefox, 
  - Thunderbird, 
  - Spotify, 
  - Albert (my favorite launcher), 
  - Enpass
  
* Most important Firefox extensions: 

  - uBlock, 
  - Enpass, 
  - German dictionary, 
  - Multi-account containers, 
  - Gnome Extension Manager
  
* Enforces Firefox sanitization on closing the browser and other settings.


Getting to Netinst
------------------

Download the `Debian Netinst ISO with non-free firmware <_netinst>`. Then
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

After booting into the minimal system, bring up wifi. We're going to use
wpa_supplicant and systemd-networkd to establish a network connection. Later
when Gnome is installed, Gnome will use NetworkManager and we'll have to remove
the wifi settings we're adding here.

.. code-block:: shell
    
    mount /dev/sda1 /mnt/usb
    echo "deb [trusted=yes] file:/mnt/usb bullseye main contrib non-free" >> /etc/apt/sources.list 
    apt update 
    apt -o Acquire::Check-Valid-Until=false install firmware-iwlwifi vim wpasupplicant wireless-tools firmware-linux-nonfree 
    modprobe ath11k
    wpa_passphrase [YOUR SSID] > /etc/wpa_supplicant/wpa_supplicant-wlp0s20f3.conf
    vi /etc/wpa_supplicant/wpa_supplicant-wlp0s20f3.conf 

    ### contents of /etc/wpa_supplicant/wpa_supplicant-wlp0s20f3.conf
    ctrl_interface=DIR=/run/wpa_supplicant
    country=DE
    network={
        ssid="[YOUR SSID]"
        psk=...  # filled by wpa_passphrase 
        priority=10
    }
    # just for the record, free wifi access points without wpa work like this
    network={
         ssid="starbucks"
         key_mgmt=NONE
         priority=20
    }
    ### EOF

    vi /etc/systemd/network/10-[YOUR SSID].network

    ### contents of /etc/systemd/network/10-[YOUR SSID].network
    [Match]
    Name=wlp0s20f3
    SSID=maurus.net

    [Network]
    DHCP=ipv4
    ### EOF

    systemctl start wpa_supplicant@wlp0s20f3
    systemctl enable systemd-networkd --now


You might have to set up a ``resolv.conf`` and there are other useful commands
to debug wifi:

.. code-block:: shell

    ln -sv /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
    # other useful commands are:
    networkctl
    iwlist scan


Once you have a network connection, edit ``/etc/apt/sources.list`` and enable
the bullseye sources. Then you can install ``git``, grab this repo, install salt
and get going.


.. code-block:: shell

    cd
    apt install --no-install-recommends git salt-minion
    systemctl disable --now salt-minion
    git clone https://github.com/jdelic/saltshaker-laptop
    mkdir -p /etc/salt/minion.d
    cp ~/saltshaker-laptop/etc/salt-minion/minion.d/saltshaker.conf /etc/salt/minion.d/ 
    sudo ln -sv ~/saltshaker-laptop/srv/salt /etc/salt/salt
    sudo ln -sv ~/saltshaker-laptop/srv/pillar /etc/salt/pillar
    salt-call --local state.highstate


.. _netinst: https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/11.0.0+nonfree/amd64/iso-cd/ 
.. # vim: wrap textwidth=80 
