# install the element Matrix client
element:
    aptrepo.managed:
        - name: {{pillar['repos']['element']}}
        - listfile_name: element.list
        - signed_by: /etc/apt/keyrings/element-io-archive-keyring.gpg
        - signing_key_url: 'https://packages.element.io/debian/element-io-archive-keyring.gpg'
        - download_method: curl
        - require:
            - pkg: desktop-packages
    pkg.installed:
        - name: element-desktop
        - require:
            - aptrepo: element
