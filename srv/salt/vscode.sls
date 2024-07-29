vscode:
    file.managed:
        - name: /var/cache/salt/vscode/vscode.deb
        - source: 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
        - skip_verify: True
        - makedirs: True
        - user: root
        - group: root
        - mode: '0600'
    pkg.installed:
        - sources:
            - vscode: /var/cache/salt/vscode/vscode.deb
        - require:
            - pkg: desktop-packages
            - file: vscode
