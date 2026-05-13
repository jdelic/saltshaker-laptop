nomad:
    pkg.installed:
        - require:
            - aptrepo: hashicorp-repo
    service.dead:
        - name: nomad
        - enable: False
        - require:
            - pkg: nomad

mask-nomad:
    service.masked:
        - name: nomad
        - require:
            - pkg: nomad