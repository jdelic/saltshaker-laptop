signal:
    aptrepo.managed:
        - name: {{pillar['repos']['signal']}}
        - listfile_name: signal.list
        - signed_by: /etc/apt/keyrings/signal-archive-keyring.gpg
        - signing_key_url: https://updates.signal.org/desktop/apt/keys.asc
        - dearmor: True
        - arch: amd64
    pkg.installed:
        - name: signal-desktop
        - install_recommends: False
        - require:
            - aptrepo: signal
