repos:
    albert: deb http://download.opensuse.org/repositories/home:/manuelschneid3r/Debian_13/ /
    crush: deb https://repo.charm.sh/apt/ * *
    cuda: deb https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/ /
    enpass: deb https://apt.enpass.io/ stable main
    hashicorp: deb https://apt.releases.hashicorp.com bookworm main
    nordvpn: deb https://repo.nordvpn.com/deb/nordvpn/debian stable main
    saltstack: deb https://packages.broadcom.com/artifactory/saltproject-deb/ stable main
    spotify: deb https://repository.spotify.com stable non-free
    trixie: deb [signed-by=/usr/share/keyrings/debian-archive-keyring.gpg arch=amd64] http://ftp-stud.hs-esslingen.de/debian/ trixie main contrib non-free non-free-firmware
    trixie-backports: deb [signed-by=/usr/share/keyrings/debian-archive-keyring.gpg arch=amd64] http://ftp-stud.hs-esslingen.de/debian/ trixie-backports main contrib non-free non-free-firmware
    trixie-security: deb [signed-by=/usr/share/keyrings/debian-archive-keyring.gpg arch=amd64] http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
    trixie-updates: deb [signed-by=/usr/share/keyrings/debian-archive-keyring.gpg arch=amd64] http://deb.debian.org/debian trixie-updates main contrib non-free non-free-firmware

downloads:
    droidsans-nerdfont:
        url: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/DroidSansMono.zip
        hash: sha256=9fc4a511a9e8d3fa5062a2d94398e18898a0b45916ab42b6891307fcee493485
    astral-uv-installer:
        url: https://astral.sh/uv/install.sh
        hash: sha256=fdc420c0f951e00148a77d5d4b22858bb3b0581ca50b2f62e09adc250104565c

# vim: syntax=yaml
