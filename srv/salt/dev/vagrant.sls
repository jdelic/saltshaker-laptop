vagrant:
    pkg.installed:
        - pkgs:
            - vagrant
            - libffi-dev
            - libvirt-dev


{% for user in pillar['users'] %}
vagrant-libvirt-{{user}}:
    cmd.run:
        - name: vagrant plugin install vagrant-libvirt
        - unless: vagrant plugin list | grep -q libvirt
        - runas: {{user}}
        - require:
            - pkg: vagrant
{% endfor %}
