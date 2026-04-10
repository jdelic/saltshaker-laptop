hosts-deny:
    file.managed:
        - name: /etc/hosts.deny
        - contents: |
            ALL: ALL
        - user: root
        - group: root
        - mode: '0644'
