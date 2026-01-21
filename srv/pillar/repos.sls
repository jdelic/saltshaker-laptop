repos:
    albert: deb http://download.opensuse.org/repositories/home:/manuelschneid3r/Debian_13/ /
    crush: deb https://repo.charm.sh/apt/ * *
    cuda: deb https://developer.download.nvidia.com/compute/cuda/repos/debian13/x86_64/ /
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
        url: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/DroidSansMono.zip
        hash: sha256=030229341907c833862f00682f0f4bce65d0dc8d281fc9a40d80b7ee9d306e88
    astral-uv-installer:
        url: https://astral.sh/uv/install.sh
        hash: sha256=09ace6a888bd5941b5d44f1177a9a8a6145552ec8aa81c51b1b57ff73e6b9e18

# vim: syntax=yaml
