# Kill unattended upgrades, just in case something enabled that BS

unattended-upgrades:
    service.dead:
        - enable: False
    pkg.purged:
        - require:
            - service: unattended-upgrades
