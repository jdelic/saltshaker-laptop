grub-defaults:
    file.managed:
        - name: /etc/default/grub
        - backup: minion
        - source: salt://basics/grub.defaults.jinja
        - template: jinja
        - context:
            enable_osprober: {{pillar['grub']['enable_osprober']}}
    cmd.run:
        - name: update-grub
        - onchanges:
            - file: grub-defaults

# vim: syntax=yaml

