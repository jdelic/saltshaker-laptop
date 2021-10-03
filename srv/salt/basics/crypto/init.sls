#
# BASICS: crypto is included by basics (which are installed as a baseline everywhere)
# Usually, you won't need to assign this state manually. Assign "basics" instead.
#

include:
    - .ssl


crypto-packages:
    pkg.installed:
        - pkgs:
            - gnupg
            - gpgv
            - openssl
            - scdaemon
            - opensc
            - sbsigntool
            - dirmngr


# vim: syntax=yaml
