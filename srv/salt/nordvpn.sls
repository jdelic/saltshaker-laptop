
nordvpn-repo:
    aptrepo.managed:
        - name: {{pillar['repos']['nordvpn']}}
        - listfile_name: nordvpn.list
        - signed_by: /usr/share/keyrings/nordvpn-archive-keyring.gpg
        - signing_key_url: salt://nordvpn_6B219E535C964CA1.pgp.key
        - dearmor: False


nordvpn:
    pkg.installed:
        - require:
            - pkg: desktop-packages


{% for user in pillars['users'] %}
group-nordvpn-{{user}}:
    user.present:
        - name: {{user}}
        - optional_groups:
            - nordvpn
{% endfor %}

# vim: syntax=yaml

