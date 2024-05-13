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


vagrant-sudoer-rules:
    file.managed:
        - name: /etc/sudoers.d/vagrant
        - user: root
        - group: root
        - mode: 0440
        - contents: |
            Cmnd_Alias VAGRANT_EXPORTS_CHOWN = /bin/chown 0\:0 /tmp/vagrant-exports
            Cmnd_Alias VAGRANT_EXPORTS_MV = /bin/mv -f /tmp/vagrant-exports /etc/exports
            Cmnd_Alias VAGRANT_NFSD_CHECK = /usr/bin/systemctl status --no-pager nfs-server.service
            Cmnd_Alias VAGRANT_NFSD_START = /usr/bin/systemctl start nfs-server.service
            Cmnd_Alias VAGRANT_NFSD_APPLY = /usr/sbin/exportfs -ar
            %libvirt ALL=(root) NOPASSWD: VAGRANT_EXPORTS_CHOWN, VAGRANT_EXPORTS_MV, VAGRANT_NFSD_CHECK, VAGRANT_NFSD_START, VAGRANT_NFSD_APPLY


{% for user in pillar['users'] %}
vagrant-libvirt:
    cmd.run:
        - name: vagrant plugin install vagrant-libvirt
        - unless: vagrant plugin list | grep -q libvirt
        - runas: {{user}}
        - require:
              - pkg: vagrant
              - pkg: ruby


add-{{user}}-into-libvirt:
    user.present:
        - name: {{user}}
        - optional_groups:
            - libvirt
        - remove_groups: False
        - require:
            - pkg: desktop-packages
{% endfor %}
