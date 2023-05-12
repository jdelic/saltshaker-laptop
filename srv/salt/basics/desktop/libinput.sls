libinput-gestures-git:
    git.latest:
        - name: https://github.com/bulletmark/libinput-gestures
        - target: /var/cache/salt/libinput-gestures
        - branch: master
        - require:
            - pkg: desktop-packages


{% for user in pillar['users'] %}
libinput-gestures-install:
    cmd.run:
        - name: /var/cache/salt/libinput-gestures/libinput-gestures-setup install
        - cwd: /var/cache/salt/libintput-gestures
        - unless: /var/cache/salt/libinput/gestures/libinput-gestures-setup status | grep -q "libinput-gestures is installed"
        - runas: {{user}}
        - watch:
              - git: libinput-gestures-git

libinput-gestures-desktop:
    cmd.run:
        - name: /var/cache/salt/libinput-gestures/libinput-gestures-setup desktop
        - cwd: /var/cache/salt/libintput-gestures
        - unless: /var/cache/salt/libinput/gestures/libinput-gestures-setup status | grep -q "libinput-gestures is set up as a desktop application"
        - runas: {{user}}
        - watch:
            - git: libinput-gestures-git

libinput-gestures-start:
    cmd.run:
        - name: /var/cache/salt/libinput-gestures/libinput-gestures-setup autostart start
        - cwd: /var/cache/salt/libinput-gestures
        - unless: /var/cache/salt/libinput-gestures/libinput-gestures-setup status | grep -q "libinput-gestures is set to autostart"
        - runas: {{user}}
        - require:
            - cmd: libinput-gestures-install
            - cmd: libinput-gestures-desktop

group-input-{{user}}:
    user.present:
        - name: {{user}}
        - optional_groups:
            - input
            - libvirt
        - remove_groups: False
        - createhome: False
{% endfor %}