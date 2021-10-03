My laptop config
================

This is supposed to run from a local salt-minion install, using ``salt-call``
in a masterless setup. Based on a clean Debian Bullseye netinst installation,
I'm using this to get to my minimal laptop setup.

.. code-block:: shell

    cd
    apt install --no-install-recommends git
    git clone https://github.com/jdelic/saltshaker-laptop
    sudo ln -sv ~/saltshaker-laptop/srv/salt /etc/salt/salt
    sudo ln -sv ~/saltshaker-laptop/srv/pillar /etc/salt/pillar
    apt install --no-install-recommends salt-minion
    systemctl disbale --now salt-minion
    mkdir -p /etc/salt/minion.d
    cp ~/saltshaker-laptop/etc/salt-minion/minion.d/saltshaker.conf /etc/salt/minion.d/
    salt-call --local state.highstate
