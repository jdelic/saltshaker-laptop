
v4l2loopback:
    pkg.installed:
        - pkgs:
            - v4l2loopback-dkms         # for virtual camera support
            - v4l2loopback-dkms-utils
        - install_recommends: False
    file.managed:
        - name: /etc/modules-load.d/v4l2loopback.conf
        - contents: |
              v4l2loopback


obs-virtual-camera-source:
    file.managed:
        - name: /etc/modprobe.d/v4l2loopback.conf
        - contents: |
            options v4l2loopback video_nr=10 card_label="OBS Virtual Camera" exclusive_caps=1
        - requires:
            - file: v4l2loopback

obs:
    cmd.run:
        - name: flatpak install -y --or-update flathub com.obsproject.Studio
        - require:
            - file: obs-virtual-camera-source
            - cmd: flatpak-flathub
