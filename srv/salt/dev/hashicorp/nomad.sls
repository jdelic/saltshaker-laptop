nomad:
    pkg.installed:
        - require:
            - aptrepo: hashicorp-repo
    service.dead:
        - name: nomad
        - disable: True
        - require:
            - pkg: nomad
