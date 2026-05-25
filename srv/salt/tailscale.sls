tailscale:
    aptrepo.managed:
        - name: {{pillar['repos']['tailscale']}}
        - listfile_name: tailscale.list
        - signed_by: /etc/apt/keyrings/tailscale-archive-keyring.gpg
        - signing_key_url: 'https://pkgs.tailscale.com/stable/debian/trixie.noarmor.gpg'
        - download_method: curl
        - require:
            - pkg: basesystem-packages
    pkg.installed:
        - name: tailscale
        - require:
            - aptrepo: tailscale
