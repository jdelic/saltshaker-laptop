firefox:
    mozilla.installed:
        - require:
            - pkg: desktop-packages


{% for user in pillar['users'] %}
firefox-desktop-{{user}}:
    mozilla.desktop:
        - product: firefox
        - user: {{user}}
        - group: {{user}}
        - gtk_theme_override: {{pillar.get("firefox", {}).get("gtk-theme-override", "")}}
        - require:
            - mozilla: firefox


firefox-userprefs-{{user}}:
    mozilla.firefox_file:
        - username: {{user}}
        - initialize_profile: True
        - path: user.js
        - source: salt://firefox/user.js
        - require:
            - mozilla: firefox
{% endfor %}


firefox-policy:
    file.managed:
        - name: /etc/firefox/policies/policies.json
        - source: salt://firefox/policies.json
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
            - mozilla: firefox
{% for cert in pillar['ssl'].get('install-ca-certs', []) %}
            - file: install-certificates-{{salt['file.basename'](cert)}}
{% endfor %}

# vim: syntax=yaml
