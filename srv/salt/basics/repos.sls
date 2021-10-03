bullseye:
    pkgrepo.managed:
        - name: {{pillar['repos']['bullseye']}}
        - file: /etc/apt/sources.list
      {% if pillar['repos'].get('pgpkey', None) %}
        - key_url: {{pillar['repos']['pgpkey']}}
      {% endif %}
        - consolidate: True
        - order: 1  # execute this state early!


saltstack-repo:
    pkgrepo.managed:
        - name: {{pillar['repos']['saltstack']}}
        - file: /etc/apt/sources.list.d/saltstack.list
        - key_url: salt://saltstack_0E08A149DE57BFBE.pgp.key
        - order: 2  # execute this state early!


updates-bullseye:
    pkgrepo.managed:
        - name: {{pillar['repos']['bullseye-updates']}}
        - file: /etc/apt/sources.list.d/bullseye-updates.list
        - order: 2  # execute this state early!


security-updates-bullseye:
    pkgrepo.managed:
        - name: {{pillar['repos']['bullseye-security']}}
        - file: /etc/apt/sources.list.d/bullseye-security.list
        - order: 2  # execute this state early!


backports-org-bullseye:
    pkgrepo.managed:
        - name: {{pillar['repos']['bullseye-backports']}}
        - file: /etc/apt/sources.list.d/bullseye-backports.list
        - order: 2  # execute this state early!
    file.managed:
        - name: /etc/apt/preferences.d/bullseye-backports
        - source: salt://etc_mods/bullseye-backports


hashicorp-repo:
    aptrepo.managed:
        - name: {{pillar['repos']['hashicorp']}}
        - listfile_name: hashicorp.list
        - signed_by: /usr/share/keyrings/hashicorp-archive-keyring.gpg
        - signing_key_url: https://apt.releases.hashicorp.com/gpg
