spotify:
    aptrepo.managed:
        - name: {{pillar['repos']['spotify']}}
        - listfile_name: spotify.list
        - signed_by: /usr/share/keyrings/spotify-archive-keyring.gpg
        - signing_key_url: https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg
        - require:
            - pkg: desktop-packages
    pkg.installed:
        - name: spotify-client
        - require:
            - aptrepo: spotify


{% for user in pillar['users'] %}
spotify-desktop-{{user}}:
    file.copy:
        - name: /home/{{user}}/.local/share/applications/spotify.desktop
        - source: /usr/share/spotify/spotify.desktop
        - user: {{user}}
        - group: {{user}}
        - makedirs: True
        - mode: '0644'
        - require:
            - pkg: spotify
{% endfor %}



# vim: syntax=yaml
