starship-install:
    cmd.script:
        - name: install.sh -y
        - source: https://starship.rs/install.sh
        - runas: root
        - creates: /usr/local/bin/starship
        - require:
            - pkg: desktop-packages
