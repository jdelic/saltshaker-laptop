# enable WCN785x bluetooth. We don't want to add this to udev, so it's not enabled during boot.
# So we add a usbguard rule for it here. This only exists on my Gigabyte Aorus x870e.
cmd.run:
    - name: >
        usbguard append-rule 'allow id 0489:e10d serial "" name ""'
    - onlyif: >
        usbguard list-devices | grep -q 'block id 0489:e10d'
    - require:
        - service: usbguard
