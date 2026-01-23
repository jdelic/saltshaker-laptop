cyberjack-driver:
    file.managed:
        - name: /var/cache/salt/cyberjack/libifd-cyberjack6_3.99.5final.sp17_amd64_d13.deb
        - source: 'https://support.reiner-sct.de/downloads/LINUX/V3.99.5_SP17/libifd-cyberjack6_3.99.5final.sp17_amd64_d13.deb'
        - skip_verify: True
        - replace: False
        - makedirs: True
        - user: root
        - group: root
        - mode: '0644'
        - dir_mode: '0755'
    pkg.installed:
        - sources:
            - code: /var/cache/salt/cyberjack/libifd-cyberjack6_3.99.5final.sp17_amd64_d13.deb
        - onchanges:
            - file: cyberjack-driver
        - require:
            - pkg: desktop-packages
            - file: cyberjack-driver
