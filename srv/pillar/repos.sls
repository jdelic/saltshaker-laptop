repos:
    albert: deb http://download.opensuse.org/repositories/home:/manuelschneid3r/Debian_12/ /
    trixie: deb http://ftp-stud.hs-esslingen.de/debian/ testing main contrib non-free non-free-firmware
    trixie-backports: deb http://ftp-stud.hs-esslingen.de/debian/ trixie-backports main contrib non-free non-free-firmware
    trixie-security: deb http://security.debian.org/debian-security testing-security main contrib non-free non-free-firmware
    trixie-updates: deb http://deb.debian.org/debian testing-updates main contrib non-free non-free-firmware
    cuda: deb https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/ /
    enpass: deb https://apt.enpass.io/ stable main
    hashicorp: deb https://apt.releases.hashicorp.com bookworm main
    nordvpn: deb https://repo.nordvpn.com/deb/nordvpn/debian stable main
    saltstack: deb https://packages.broadcom.com/artifactory/saltproject-deb/ stable main
    spotify: deb https://repository.spotify.com stable non-free


downloads:
    droidsans-nerdfont:
        url: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/DroidSansMono.zip
        hash: sha256=9fc4a511a9e8d3fa5062a2d94398e18898a0b45916ab42b6891307fcee493485

# vim: syntax=yaml
