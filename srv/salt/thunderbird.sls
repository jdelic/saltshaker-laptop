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
        - require:
            - mozilla: thunderbird
{% endfor %}
