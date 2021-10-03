#
# BASICS: crypto is included by basics (which are installed as a baseline everywhere)
# Usually, you won't need to assign this state manually. Assign "basics" instead.
#

ssl-cert:
    group.present


localca-location:
    file.directory:
        - name: {{pillar['ssl']['localca-location']}}
        - user: root
        - group: root
        - mode: '0755'
        - makedirs: True


{% for cert in pillar['ssl'].get('install-ca-certs', []) + pillar['ssl'].get('install-perenv-ca-certs', []) %}
install-certificates-{{salt['file.basename'](cert)}}:
    file.managed:
        - name: {{salt['file.join'](pillar['ssl']['localca-location'], salt['file.basename'](cert))}}
        - source: {{cert}}
        - user: root
        - group: root
        - mode: '0644'
        - require:
            - file: localca-location


add-certificate-{{salt['file.basename'](cert)}}:
    file.append:
        - name: /etc/ca-certificates.conf
        - text: {{salt['file.join'](
            salt['file.basename'](pillar['ssl']['localca-location']),
            salt['file.basename'](cert)
        )}}
        - require:
            - file: install-certificates-{{salt['file.basename'](cert)}}
        - onchanges_in:
            - cmd: require-ssl-certificates
{% endfor %}


require-ssl-certificates:
    cmd.run:
        - name: /usr/sbin/update-ca-certificates


# vim: syntax=yaml
