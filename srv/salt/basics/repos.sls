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
    aptrepo.managed:
        - name: {{pillar['repos']['saltstack']}}
        - listfile_name: /etc/apt/sources.list.d/saltstack.list
        - signing_key_url: https://repo.saltproject.io/salt/py3/debian/11/amd64/SALT-PROJECT-GPG-PUBKEY-2023.gpg
        - signed_by: /etc/apt/keyrings/salt-archive-keyring-2023.gpg
        - dearmor: False
        - arch: amd64
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
        - source: salt://basics/etc_mods/bullseye-backports


hashicorp-repo:
    aptrepo.managed:
        - name: {{pillar['repos']['hashicorp']}}
        - listfile_name: hashicorp.list
        - signed_by: /usr/share/keyrings/hashicorp-archive-keyring.gpg
        - signing_key_url: https://apt.releases.hashicorp.com/gpg
