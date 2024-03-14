#!/bin/bash

cd
cat >/tmp/saltstack.list <<EOF
deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=amd64] https://repo.saltproject.io/salt/py3/debian/12/amd64/latest bookworm main
EOF
TMP1="$(mktemp)"
cat >$TMP1 <<EOF
mv /tmp/saltstack.list /etc/apt/sources.list.d/saltstack.list
apt install --no-install-recommends ca-certificates wget
wget -O /etc/apt/keyrings/salt-archive-keyring-2023.gpg https://repo.saltproject.io/salt/py3/debian/12/amd64/SALT-PROJECT-GPG-PUBKEY-2023.gpg
apt install --no-install-recommends git salt-minion
systemctl disable --now salt-minion
EOF
sudo bash $TMP1
mkdir -p ~/projects/maurus.net
git clone https://github.com/jdelic/saltshaker-laptop ~/projects/maurus.net/saltshaker-laptop
TMP2="$(mktemp)"
cat >$TMP2 <<EOF
mkdir -p /etc/salt/minion.d
cp ~/saltshaker-laptop/etc/salt-minion/minion.d/saltshaker.conf /etc/salt/minion.d/
ln -sv ~/saltshaker-laptop/srv/salt /etc/salt/salt
ln -sv ~/saltshaker-laptop/srv/pillar /etc/salt/pillar
salt-call --local state.highstate | less
EOF
sudo bash $TMP2
