vuescan:
    file.managed:
        - name: /var/cache/salt/vuescan/vuex6498.deb
        - source: 'https://www.hamrick.com/files/vuex6498.deb'
        - skip_verify: True
        - makedirs: True
        - user: root
        - group: root
        - mode: '0600'
    pkg.installed:
        - sources:
            - vuescan: https://www.hamrick.com/files/vuex6498.deb
        - require:
            - pkg: desktop-packages
            - file: vuescan
