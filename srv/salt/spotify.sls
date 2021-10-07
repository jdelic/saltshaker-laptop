spotify:
    aptrepo.managed:
        - name: {{pillar['repos']['spotify']}}
        - listfile_name: spotify.list
        - signed_by: /usr/share/keyrings/spotify-archive-keyring.gpg
        - signing_key_url: https://download.spotify.com/debian/pubkey_0D811D58.gpg
    pkg.installed:
        - name: spotify-client
        - require:
            - aptrepo: spotify
            - pkg: desktop-packages

# vim: syntax=yaml
