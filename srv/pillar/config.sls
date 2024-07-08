
wayland:
    enabled: true


public-interfaces:
    - wlp0s20f3


starship:
    enabled: true


zoom:
    enable-mini-window: false


grub:
    enable_osprober: {{grains['id'] == 'hades'}}

#firefox:
#    gtk-theme-override: "Adwaita:light"

#thunderbird:
#    gtk-theme-override: "Adwaita:light"