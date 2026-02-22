cuda-repo:
    aptrepo.managed:
        - name: {{pillar['repos']['cuda']}}
        - listfile_name: cuda.list
        - signed_by: /etc/apt/keyrings/cuda-archive-keyring.gpg
        - signing_key_url: https://developer.download.nvidia.com/compute/cuda/repos/debian13/x86_64/8793F200.pub
        - dearmor: True
        - arch: amd64


nvidia-drivers:
    pkg.installed:
        - pkgs:
            - nvidia-driver
            - vulkan-tools
            - nvidia-persistenced
            - nvidia-settings
            - libgles-nvidia1
            - libnvidia-encode1
            - libnvidia-allocator1
            - nvidia-driver-libs:i386
            - libgles-nvidia2
            - nvidia-vulkan-icd
            - nvidia-suspend-common
            - nvidia-smi
            - nvtop
            - nvidia-kernel-dkms
        - fromrepo: trixie-backports
        - install_recommends: False
        - require:
            - pkg: desktop-packages


cuda:
    pkg.installed:
        - pkgs:
            - cuda-toolkit
        - install_recommends: False
        - require:
            - aptrepo: cuda-repo
            - pkg: nvidia-drivers
