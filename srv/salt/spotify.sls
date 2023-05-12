spotify:
    aptrepo.managed:
        - name: {{pillar['repos']['spotify']}}
        - listfile_name: spotify.list
        - signed_by: /usr/share/keyrings/spotify-archive-keyring.gpg
        - signing_key_url: https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg
    pkg.installed:
        - name: spotify-client
        - require:
            - aptrepo: spotify
            - pkg: desktop-packages


{% for user in pillar['users'] %}
spotify-desktop-{{user}}:
    file.copy:
        - name: /home/{{user}}/.local/share/applications/spotify.desktop
        - source: /usr/share/spotify/spotify.desktop
        - user: {{user}}
        - group: {{user}}
        - mode: '0644'
        - require:
            - pkg: spotify
{% endfor %}



# vim: syntax=yaml
