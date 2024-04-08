vagrant:
    pkg.installed:
        - pkgs:
            - vagrant
            - libffi-dev
            - libvirt-dev
            - rsync


vagrant-enable-nfs:
    file.append:
        - name: /etc/hosts.allow
        - text: |
            # allow 192.168.120-192.168.123 
            rpcbind mountd nfsd statd lockd rquotad : 127.0.0.1 192.168.120.1/255.255.252.0


{% for user in pillar['users'] %}
vagrant-libvirt:
    cmd.run:
        - name: vagrant plugin install vagrant-libvirt
        - unless: vagrant plugin list | grep -q libvirt
        - runas: {{user}}
        - require:
              - pkg: vagrant
              - pkg: ruby
{% endfor %}
