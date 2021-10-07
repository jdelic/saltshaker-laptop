firefox:
    mozilla.install:
        - require:
            - pkg: desktop-packages


firefox-policy:
    file.managed:
        - name: /opt/firefox/distribution/policies.json
        - source: salt://firefox/policies.json
        - makedirs: True
        - require:
            - mozilla: firefox


firefox-userprefs:
    mozilla.file:
        - username: jonas
        - path: user.js
        - source: salt://firefox/user.js
        - require:
            - mozilla: firefox


# vim: syntax=yaml 
