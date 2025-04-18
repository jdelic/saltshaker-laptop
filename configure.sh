#!/bin/bash

BASEDIR="$(readlink -f $(dirname $0))"
cat >/tmp/saltstack.list <<EOF
deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2024.gpg arch=amd64] https://packages.broadcom.com/artifactory/saltproject-deb/ stable main
EOF
TMP1="$(mktemp)"
cat >$TMP1 <<EOF
mv /tmp/saltstack.list /etc/apt/sources.list.d/saltstack.list
apt install --no-install-recommends ca-certificates wget
wget -O /etc/apt/keyrings/salt-archive-keyring-2024.gpg.tmp https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public
gpg --dearmor -o /etc/apt/keyrings/salt-archive-keyring-2024.gpg /etc/apt/keyrings/salt-archive-keyring-2024.gpg.tmp
rm /etc/apt/keyrings/salt-archive-keyring-2024.gpg.tmp
apt update
apt install --no-install-recommends git salt-minion
systemctl disable --now salt-minion
mkdir -p /etc/salt/minion.d
cp $BASEDIR/etc/salt-minion/minion.d/saltshaker.conf /etc/salt/minion.d/
ln -sv $BASEDIR/srv/salt /etc/salt/salt
ln -sv $BASEDIR/srv/pillar /etc/salt/pillar
salt-call --local state.highstate > >(tee -a /tmp/salt_first_run_stdout) 2> >(tee -a /tmp/salt_first_run_stderr >&2)
echo "************ Logs are in /tmp/salt_first_run_stdout and ..._stderr"
EOF
sudo bash $TMP1
