firefox:
    mozilla.managed:
        - require:
            - pkg: desktop-packages


firefox-policy:
    file.managed:
        - name: /opt/firefox/distribution/policies.json
        - source: salt://firefox/policies.json
        - makedirs: True
        - require:
            - mozilla: firefox



# vim: syntax=yaml 
