firefox:
    mozilla.installed:
        - require:
            - pkg: desktop-packages


firefox-policy:
    file.managed:
        - name: /etc/firefox/policies/policies.json
        - source: salt://firefox/policies.json
        - user: root
        - group: root
        - mode: 0644
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
