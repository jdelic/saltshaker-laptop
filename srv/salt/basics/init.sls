include:
    - .vim
    - .etc_mods
    - .crypto
    - .repos
    - .base
    - .desktop
    - .noexim
    - .nounup
    - .byobu_py
    - .grub
    - .pam
    - .bluetooth
    - .firewalld


# enforce that Debian packages can't launch daemons while salt runs
# see http://people.debian.org/~hmh/invokerc.d-policyrc.d-specification.txt
policy-deny:
    file.managed:
        - name: /usr/sbin/policy-rc.d
        - source: salt://basics/policy-rc.d
        - mode: 0755
        - user: root
        - group: root
        - order: 1  # execute super-early before we install most packages


# at the end we remove the policy-rc.d file again to restore default behavior...
# it might be worthwhile to switch all Debian boxes to a default policy of "deny"
# and remove this state.
policy-allow:
    file.absent:
        - name: /usr/sbin/policy-rc.d
        - order: last  # remove the file when we're basically done


dbus:
    service.running:
        - require:
            - pkg: basesystem-packages


sudo:
    pkg.installed


root:
    user.present:
        - uid: 0
        - gid: 0
        - home: /root
        - password:
        - remove_groups: False
        - createhome: False


root-bashrc:
    file.managed:
        - name: /root/.bashrc
        - source: salt://basics/bashrc.root
        - user: root
        - group: root
        - mode: 640


timezone-germany:
    cmd.run:
        - name: timedatectl set-timezone Europe/Berlin
        - unless: test "$(readlink /etc/localtime)" = "/usr/share/zoneinfo/Europe/Berlin"
        - require:
            - service: dbus


empty-crontab:
    file.managed:
        - name: /etc/cron.d/00-ignore
        - contents: |
              # nothing to see here, this is just for salt


cron:
    service.running:
        - sig: /usr/sbin/cron
        - watch:
            - file: /etc/cron.d*
        - require:
            - pkg: basesystem-packages


# enforce en_us.UTF8
default-locale-gen:
    locale.present:
        - name: en_US.UTF-8


default-locale-set:
    locale.system:
        - name: en_US.UTF-8
        - require:
            - locale: default-locale-gen
        - order: 2


# vim: syntax=yaml
