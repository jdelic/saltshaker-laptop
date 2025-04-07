include:
    - .golang
    - .nfs
    - .python
    - .ruby
    #- .fpm
    - .vagrant

dev-essentials:
    pkg.installed:
        - pkgs:
            - binutils 
            - binutils-common 
            - binutils-x86-64-linux-gnu 
            - build-essential 
            - dpkg-dev 
            - fakeroot 
            - g++ 
            - gcc
            - libalgorithm-diff-perl
            - libalgorithm-diff-xs-perl 
            - libalgorithm-merge-perl 
            - libasan8
            - libbinutils
            - libc-dev-bin 
            - libc-devtools 
            - libc6-dev 
            - libcc1-0 
            - libcrypt-dev 
            - libctf-nobfd0 
            - libctf0 
            - libdpkg-perl
            - libexpat1-dev 
            - libfakeroot 
            - libfile-fcntllock-perl 
            - libgcc-12-dev
            - libitm1 
            - liblsan0 
            - libnsl-dev
            - libstdc++-12-dev
            - libtirpc-dev 
            - libtsan2
            - libubsan1 
            - linux-libc-dev
            - linux-headers-amd64
            - netcat-openbsd
        - install_recommends: False

# vim: syntax=yaml
