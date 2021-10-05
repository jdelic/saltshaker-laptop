pam-keyring-unlock:
    file.managed:
        - name: /etc/pam.d/common-password
        - source: salt://basics/common-password
        - require:
             - pkg: desktop-packages

# vim: syntax=yaml
