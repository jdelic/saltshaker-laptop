#
# BASICS: etc_mods is included by basics (which are installed as a baseline everywhere)
# Usually, you won't need to assign this state manually. Assign "basics" instead.
#

inputrc:
    file.managed:
        - name: /etc/inputrc
        - source: salt://etc_mods/inputrc


ensure-interfaces.d-works:
    file.append:
        - name: /etc/network/interfaces
        - text: source /etc/network/interfaces.d/*
        - order: 2
