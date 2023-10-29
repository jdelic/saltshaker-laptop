thunderbird:
    mozilla.installed:
        - require:
            - pkg: desktop-packages


{% for user in pillar['users'] %}
thunderbird-desktop-{{user}}:
    mozilla.desktop:
        - product: thunderbird
        - user: {{user}}
        - group: {{user}}
        - gtk_theme_override: {{pillar.get("thunderbird", {}).get("gtk-theme-override", "")}}
        - require:
            - mozilla: thunderbird
{% endfor %}


thunderbird-policy:
    file.managed:
        - name: /etc/thunderbird/policies/policies.json
        - source: salt://thunderbird/policies.json
        - template: jinja
        - context:
            certificates:
{% for cert in pillar['ssl'].get('install-ca-certs', []) %}
                - {{salt['file.join'](pillar['ssl']['localca-location'], salt['file.basename'](cert))}}
{% endfor %}
        - user: root
        - group: root
        - mode: 0644
        - makedirs: True
        - require:
            - mozilla: thunderbird
{% for cert in pillar['ssl'].get('install-ca-certs', []) %}
            - file: install-certificates-{{salt['file.basename'](cert)}}
{% endfor %}
