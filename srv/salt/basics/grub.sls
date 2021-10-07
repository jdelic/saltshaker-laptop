grub-defaults:
    file.managed:
        - name: /etc/default/grub
        - source: salt://basics/grub.defaults
    cmd.run:
        - name: update-grub
        - onchanges:
            - file: grub-defaults

# vim: syntax=yaml

