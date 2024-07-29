vscode:
    file.managed:
        - name: /var/cache/salt/vscode/vscode.deb
        - source: 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
        - skip_verify: True
        - replace: False
        - makedirs: True
        - user: root
        - group: root
        - mode: '0644'
        - dir_mode: '0755'
    pkg.installed:
        - sources:
            - vscode: /var/cache/salt/vscode/vscode.deb
        - onchanges:
            - file: vscode
        - require:
            - pkg: desktop-packages
            - file: vscode
