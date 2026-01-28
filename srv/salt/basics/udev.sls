generate-udev-rules-for-usbguard:
    cmd.run:
        - name: >
              for id in $(usbguard list-devices | grep -E "xHCI|Keyboard|Mouse|Hub" | cut -d' ' -f4 | sort | uniq); do 
                  V="$(echo $id | cut -d':' -f1)"; 
                  P="$(echo $id | cut -d':' -f2)"; 
                  C="$(usbguard list-devices | grep "$id" | cut -d'"' -f4 | sort | uniq)"; 
                  printf "# $C\nACTION==\"add\", SUBSYSTEM==\"usb\", ATTR{idVendor}==\"$V\", ATTR{idProduct}==\"$P\", ATTR{authorized}=\"1\"\n" >> /etc/udev/rules.d/99-enabled-usb-devices-at-boot.rules; 
              done
        - creates: /etc/udev/rules.d/99-enabled-usb-devices-at-boot.rules
        - require:
            - pkg: basesystem-packages
            - file: grub-defaults
