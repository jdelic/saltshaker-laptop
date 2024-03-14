
enpass-repo:
    aptrepo.managed:
        - name: {{pillar['repos']['enpass']}}
        - listfile_name: enpass.list
        - signed_by: /usr/share/keyrings/enpass-archive-keyring.gpg
        - signing_key_url: https://apt.enpass.io/keys/enpass-linux.key
        - require:
              - pkg: desktop-packages


enpass:
    pkg.installed


# vim: syntax=yaml

