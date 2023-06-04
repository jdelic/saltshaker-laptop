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
