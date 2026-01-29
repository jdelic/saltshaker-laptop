My laptop config
================

This is supposed to run from a local salt-minion install, using ``salt-call``
in a masterless setup. Based on a clean Debian Bookworm netinst installation,
I'm using this to provision my work setup on a Dell XPS13 and my home PC. I
am currently running this on a 9310 model, unfortunately the newer XPSs are
terrible, and my custom-built Ryzen 9.

Among other things, this config will install:

* Gnome
* Most important apps:

  - Firefox
  - Thunderbird
  - Spotify
  - Slack
  - `Albert (my favorite launcher) <albert_>`__,
  - Enpass
  - Yubikey support
  - usbguard and usbguard-notifier

* Most important Firefox extensions (use ``about:debugging`` to find their IDs
  if you want to add more):

  - uBlock,
  - uMatrix,
  - Enpass,
  - German dictionary,
  - Multi-account containers
  - GDPR Content-O-Matic

* Enforces Firefox sanitization on closing the browser and other settings.

* Some other available applications include:

  - Discord
  - OBS
  - Airtame
  - `Starship prompt <starship_>`__
  - Steam
  - Inkscape
  - IntelliJ IDEA Ultimate
  - VSCode
  - Zoom
  - Xerox printer drivers
  - GIMP
  - VLC
  - Logitech camera controls for Brio webcams


Getting to Debian
-----------------

Download the `Debian Installer ISO <instiso_>`__. Then install the minimal
system. I like using the text mode installer and I partition like this:

* 512MB EFI
* 2048MB EXT4 /boot
* Remainder is dm-crypt encrypted volume with LVM (start by configuring the
  encrypted partition in the text mode installer, then add LVM and a volume
  group ``vg0``)

  - 90GB EXT4 vg0-root /root
  - 16GB SWAP vg0-swap ---
  - 256GB EXT4 vg0-home /home

After booting into the minimal system under Trixie, your wifi may have been
configured in ``/etc/network/interfaces``. Gnome will later use NetworkManager,
which will not manage network adapters listed in ``/etc/network/interfaces``.

Especially with Wifi-7 devices you still need to manually bring them up, as the
installer fails at it (at least on my Gigabyte x870e). So that's where it's
useful to have a full installation ISO and use nmcli to connect to wifi after
booting into the base system.

.. code-block:: shell

    apt install --no-install-recommends ca-certificates wget git
    git clone https://github.com/jdelic/saltshaker-laptop
    cd saltshaker-laptop
    ./configure.sh

    # remove static interface config so NetworkManager can take over, if necessary
    vi /etc/network/interfaces


Important Gnome Extensions
--------------------------

These are installed automatically by this salt config, but I find them
useful and you should know. You can install them from ``Extension Manager``:

* `Frippery Move Clock <frippery_>`__ (moves the clock to the right where it 
  belongs)
* `V-Shell Vertical Workspaces <vertical_>`__ (because vertically stacked
  virtual desktops are much more sensible)
* `AppIndicator and KStatusNotifier Support <trayicons_>`__: no idea why Gnome
  tries to remove tray icons... so much software still uses them)
* `No Overview At Start-up <nooverview_>`__ (with Albert as launcher the
  default is just annoying)
* `Better onscreen keyboard (GJS OSK) <gjsosk_>`__: Just an improved keyboard
  that's very useful for touchscreens or when you locked out your USB keyboard.
* `Tactile tiling <tactile_>`__: Gives keyboard shortcuts for tiling windows.
  Useful until niri or Hyprland make their way to Debian.


Important Gnome Settings changed by this config
-----------------------------------------------

This config installs a autostart script that changes the following Gnome
settings:

1. Add keyboard shortcut for Albert to launch ``albert toggle`` on ``META+X``.
2. Change "Navigation"->"Switch Applications" to "disabled" and "Switch
   Windows" to "Alt+Tab"
3. On Gnome Tweaks set the clock to show calendar weeks and the date
4. Configure the Gnome extensions, setting the keyboard shortcuts for vertical
   desktops and configuring the tray icons size and position
5. **Disable Gnome USB protection** in favor of usbguard and usbguard-notifier,
   changing the Kernel boot to disallow USB devices and adding udev rules for
   devices needed for boot (like the keyboard to unlock LUKS drives).


Which Albert Plugins to Enable?
-------------------------------

I commonly use

* Applications
* Calculator
* Python
* System

  - I rename "Poweroff" to "Shutdown"

* Terminal


Changes to be made to the system after ./configure.sh is complete
-----------------------------------------------------------------

These are changes that this salt configuration currently can't do for you. Here
is my personal "post-install todo list":

1. Zoom: Change ``enableMiniWindow`` to ``false`` in ``~/.config/zoomus.conf``.
2. Firefox: Enable the built-in dark theme in Firefox
3. Firefox: Enable ``devtools.netmonitor.persistlog`` in ``about:config``
4. Firefox: Import uMatrix config
5. Firefox: Remove spacers from Firefox toolbar config
6. Firefox: Enable extensions to run in private mode (this can't be automated)
7. Create Enpass service account and login
8. Activate IntelliJ IDEA, Slack, and Spotify
9. Projects: Install `ollama <ollama_>`__


Windows VM notes
----------------

Installing a Windows 10 or 11 VM with TPM:

.. code-block::

   virt-install -n "win-vm" \
       --memory=16384 --cpu=host -vcpus=6 --pm="suspend_to_mem=on,suspend_to_disk=on" \
       --disk="path=/dev/gen5/win-payoneer,device=disk,bus=virtio" \
       -c /tmp/win10_2023H2.iso --disk="path=/tmp/virtio-win.iso,device=cdrom" \
       --features kvm_hidden=on,smm=on \
       --tpm backend.type=emulator,backend.version=2.0,model=tpm-tis \
       --boot loader=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd,loader_ro=yes,loader_type=pflash,nvram_template=/usr/share/OVMF/OVMF_VARS_4M.ms.fd,loader_secure=yes \
       --graphics=spice \
       --video model.type=xml,model.vram=65536,model.vgamem=65536


Make sure to install the *latest* of these:

* `SPICE client for Windows VMs <spice_>`__
* `VirtIO drivers for Windows VMs <virtio_>`__


.. _instiso: https://www.debian.org/CD/http-ftp/
.. _starship: https://starship.rs
.. _albert: https://github.com/albertlauncher/albert
.. _frippery: https://extensions.gnome.org/extension/2/move-clock/
.. _vertical: https://extensions.gnome.org/extension/5177/vertical-workspaces/
.. _nooverview: https://extensions.gnome.org/extension/4099/no-overview/
.. _trayicons: https://extensions.gnome.org/extension/615/appindicator-support/
.. _gjsosk: https://extensions.gnome.org/extension/5949/gjs-osk/
.. _ollama: https://ollama.com/download
.. _spice: https://www.spice-space.org/download.html
.. _virtio: https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/
.. # vim: wrap textwidth=80
