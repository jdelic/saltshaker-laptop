airtame-snap:
    cmd.run:
        - name: /usr/bin/snap install --color=never airtame-application
        - unless: /usr/bin/snap list --color=never | grep -q airtame-application 


# vim: syntax=yaml
