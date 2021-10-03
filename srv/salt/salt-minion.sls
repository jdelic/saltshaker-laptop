salt-minion:
    pkg:
        - installed

    service.dead:
        - enable: False
        - require:
            - pkg: salt-minion
