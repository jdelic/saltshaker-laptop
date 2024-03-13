albert-repo:
    aptrepo.managed:
        - name: {{pillar['repos']['albert']}}
        - listfile_name: albert.list
        - signed_by: /etc/apt/keyrings/albert-archive-keyring.gpg
        - signing_key_url: https://download.opensuse.org/repositories/home:manuelschneid3r/Debian_12/Release.key


albert:
    pkg.installed:
        - pkgs:
            - albert
        - require:
            - pkg: desktop-packages
            - aptrepo: albert-repo


{% for user in pillar['users'] %}
albert-autostart-{{user}}:
    file.symlink:
        - name: /home/{{user}}/.config/autostart/albert.desktop
        - target: /usr/share/applications/albert.desktop
        - user: {{user}}
        - group: {{user}}
        - makedirs: True
        - require:
            - pkg: albert
{% endfor %}
