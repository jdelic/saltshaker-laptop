albert-repo:
    aptrepo.managed:
        - name: {{pillar['repos']['albert']}}
        - listfile_name: albert.list
        - signed_by: /usr/share/keyrings/albert-archive-keyring.gpg
        - signing_key_url: https://download.opensuse.org/repositories/home:manuelschneid3r/Debian_11/Release.key


albert:
    pkg.installed:
        - require:
            - pkg: desktop-packages

