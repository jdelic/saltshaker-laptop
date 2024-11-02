bookworm:
    pkgrepo.managed:
        - name: {{pillar['repos']['bookworm']}}
        - file: /etc/apt/sources.list
      {% if pillar['repos'].get('pgpkey', None) %}
        - key_url: {{pillar['repos']['pgpkey']}}
      {% endif %}
        - consolidate: False
        - order: 1  # execute this state early!


saltstack-repo:
    aptrepo.managed:
        - name: {{pillar['repos']['saltstack']}}
        - listfile_name: /etc/apt/sources.list.d/saltstack.list
        - signing_key_url: https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public
        - signed_by: /etc/apt/keyrings/salt-archive-keyring-2024.gpg
        - dearmor: False
        - arch: amd64
        - order: 2  # execute this state early!


updates-bookworm:
    pkgrepo.managed:
        - name: {{pillar['repos']['bookworm-updates']}}
        - file: /etc/apt/sources.list
        - order: 2  # execute this state early!


security-updates-bookworm:
    pkgrepo.managed:
        - name: {{pillar['repos']['bookworm-security']}}
        - file: /etc/apt/sources.list
        - order: 2  # execute this state early!


backports-org-bookworm:
    pkgrepo.managed:
        - name: {{pillar['repos']['bookworm-backports']}}
        - file: /etc/apt/sources.list
        - order: 2  # execute this state early!
    file.managed:
        - name: /etc/apt/preferences.d/bookworm-backports
        - source: salt://basics/etc_mods/bookworm-backports


hashicorp-repo:
    aptrepo.managed:
        - name: {{pillar['repos']['hashicorp']}}
        - listfile_name: hashicorp.list
        - signed_by: /usr/share/keyrings/hashicorp-archive-keyring.gpg
        - signing_key_url: https://apt.releases.hashicorp.com/gpg
