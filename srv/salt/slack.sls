slack-install:
    cmd.run:
        - name: /usr/bin/snap install slack
        - unless: /usr/bin/snap list | grep -q slack


# vim: syntax=yaml
