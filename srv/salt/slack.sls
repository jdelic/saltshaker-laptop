slack-install:
    cmd.run:
        - name: /usr/bin/snap install --classic --color=never slack
        - unless: /usr/bin/snap list --color=never | grep -q slack


# vim: syntax=yaml