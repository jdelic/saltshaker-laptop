packer:
    pkg.installed:
        - require:
            - aptrepo: hashicorp-repo
