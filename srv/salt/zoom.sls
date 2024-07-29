zoom:
    file.managed:
        - name: /var/cache/salt/zoom/zoom_amd64.deb
        - source: 'https://zoom.us/client/latest/zoom_amd64.deb'
        - skip_verify: True  # :-(. Zoom doesn't publish hashes.
        - replace: False
        - makedirs: True
        - user: root
        - group: root
        - mode: '0644'
        - dir_mode: '0755'
    pkg.installed:
        - sources:
            - zoom: /var/cache/salt/zoom/zoom_amd64.deb
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
