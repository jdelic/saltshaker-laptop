#
# BASICS: etc_mods is included by basics (which are installed as a baseline everywhere)
# Usually, you won't need to assign this state manually. Assign "basics" instead.
#

inputrc:
    file.managed:
        - name: /etc/inputrc
        - source: salt://etc_mods/inputrc


hosts-deny:
    file.managed:
        - name: /etc/hosts.deny
        - contents: |
            ALL: ALL
        - user: root
        - group: root
        - mode: '0644'
