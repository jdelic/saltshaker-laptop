
nordvpn-repo:
  aptrepo.managed:
    - name: {{pillar['repos']['nordvpn']}}
    - listfile_name: nordvpn.list
    - signed_by: /usr/share/keyrings/nordvpn-archive-keyring.gpg
    - signing_key_url: salt://apt.enpass.io/keys/enpass-linux.key
    - dearmor: False


nordvpn:
  pkg.installed:
    - require:
        - pkg: desktop-packages


# vim: syntax=yaml

