
{% for user in piller["users"] %}
add-{{user}}-into-scanner:
    user.present:
        - name: {{user}}
        - optional_groups:
            - scanner
        - remove_groups: False
        - require:
            - pkg: desktop-packages
{% endfor %}
