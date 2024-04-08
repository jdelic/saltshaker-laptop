zoom:
    file.managed:
        - name: /var/cache/zoom_amd64.deb
        - source: https://zoom.us/client/latest/zoom_amd64.deb
        - skip_verify: True  # :-(. Zoom doesn't publish hashes.
    pkg.installed:
        - sources:
            - zoom: /var/cache/zoom_amd64.deb
        - onchanges:
            - file: zoom
        - require:
            - pkg: desktop-packages
            - file: zoom


{% for user in pillar['users'] %}
zoom-disable-miniwindow:
    ini.options_present:
        - name: {{salt['file.join'](salt['user.info'](user).home, '.config', 'zoomus.conf')}}
        - strict: False
        - sections:
              General:
                  enableMiniWindow: {{pillar['zoom']['enable-mini-window']}}
{% endfor %}
