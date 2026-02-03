awscli:
    cmd.run:
        - name: snap install --classic --color=never aws-cli
        - unless: snap list --color=never | grep -q aws-cli
        - require:
            - pkg: desktop-packages
