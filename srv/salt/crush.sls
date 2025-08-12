crush:
    aptrepo.managed:
        - name: {{pillar['repos']['crush']}}
        - listfile_name: crush.list
        - signed_by: /etc/apt/keyrings/crush-archive-keyring.gpg
        - signing_key_url: https://repo.charm.sh/apt/gpg.key
        - dearmor: True
        - require:
            - pkg: desktop-packages
    pkg.installed:
        - name: crush
        - require:
            - aptrepo: crush
