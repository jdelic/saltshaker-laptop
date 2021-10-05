slack-install:
    cmd.run:
        - name: /usr/bin/snap install slack
        - unless: test /usr/bin/snap list | grep -q slack


# vim: syntax=yaml
