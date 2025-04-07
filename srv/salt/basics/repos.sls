trixie:
    pkgrepo.managed:
        - name: {{pillar['repos']['trixie']}}
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
        - dearmor: True
        - arch: amd64
        - order: 2  # execute this state early!


#trixie-updates:
#    pkgrepo.managed:
#        - name: {{pillar['repos']['trixie-updates']}}
#        - file: /etc/apt/sources.list
#        - order: 2  # execute this state early!


#trixie-security-updates:
#    pkgrepo.managed:
#        - name: {{pillar['repos']['trixie-security']}}
#        - file: /etc/apt/sources.list
#        - order: 2  # execute this state early!


#trixie-backports:
#    pkgrepo.managed:
#        - name: {{pillar['repos']['trixie-backports']}}
#        - file: /etc/apt/sources.list
#        - order: 2  # execute this state early!
#    file.managed:
#        - name: /etc/apt/preferences.d/trixie-backports
#        - source: salt://basics/etc_mods/trixie-backports


hashicorp-repo:
    aptrepo.managed:
        - name: {{pillar['repos']['hashicorp']}}
        - listfile_name: hashicorp.list
        - signed_by: /usr/share/keyrings/hashicorp-archive-keyring.gpg
        - signing_key_url: https://apt.releases.hashicorp.com/gpg
