# some packages that appear needed for X11 with NVIDIA

dbus-x11:
    pkg.installed:
        - install_recommends: False
        - require_in:
            - pkg: desktop-packages

