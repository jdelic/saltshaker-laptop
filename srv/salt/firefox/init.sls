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
    mozilla.file:
        - username: {{user}}
        - path: user.js
        - source: salt://firefox/user.js
        - require:
            - mozilla: firefox
{% endfor %}


firefox-policy:
    file.managed:
        - name: /etc/firefox/policies/policies.json
        - source: salt://firefox/policies.json
        - user: root
        - group: root
        - mode: 0644
        - makedirs: True
        - require:
            - mozilla: firefox


# vim: syntax=yaml 
