# For HP cm1312nfi manual network connection use
# USB Vendor ID: 03f0
# USB Product ID: 4f17

vuescan:
    file.managed:
        - name: /var/cache/salt/vuescan/vuex6498.deb
        - source: 'https://www.hamrick.com/files/vuex6498.deb'
        - skip_verify: True
        - replace: False
        - makedirs: True
        - user: root
        - group: root
        - mode: '0644'
        - dir_mode: '0755'
    pkg.installed:
        - sources:
            - vuescan: https://www.hamrick.com/files/vuex6498.deb
        - onchanges:
            - file: vuescan
        - require:
            - pkg: desktop-packages
            - file: vuescan
