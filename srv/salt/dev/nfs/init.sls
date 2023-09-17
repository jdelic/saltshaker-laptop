nfs-kernel-server:
    pkg.installed:
        - install_recommends: False


nfs-kernel-server-defaults:
    file.managed:
        - name: /etc/default/nfs-kernel-server
        - source: salt://dev/nfs/nfs-kernel-server.defaults
        - user: root
        - group: root
        - mode: '0644'
        - require:
            - pkg: nfs-kernel-server


nfs-libvirt-access:
    firewalld.present:
        - name: libvirt
        - services:
            - nfs
            - rpc-bind
            - mountd
