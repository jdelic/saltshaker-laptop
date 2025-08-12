{% for user, kv in pillar["users"].items() %}
    {% if pillar["users"][user].get("install-uv", False) %}

{{user}}-uv-installer:
    file.managed:
        - name: /tmp/uv-installer.sh
        - source: {{pillar["downloads"]["astral-uv-installer"]["url"]}}
        - source_hash: {{pillar["downloads"]["astral-uv-installer"]["hash"]}}
        - mode: '0755'
        - user: root
        - group: root
        - unless: test -f /home/{{user}}/.local/bin/uv
    cmd.run:
        - name: /tmp/uv-installer.sh
        - unless: test -f /home/{{user}}/.local/bin/uv
        - runas: {{user}}
        - require:
            - file: /tmp/uv-installer.sh

    {% endif %}
{% endfor %}