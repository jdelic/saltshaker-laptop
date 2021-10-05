airtame-snap:
    cmd.run:
        - name: /usr/bin/snap install airtame-application
        - unless: /usr/bin/snap list | grep -q airtame-application 


# vim: syntax=yaml
