cuda-repo:
    aptrepo.managed:
        - name: {{pillar['repos']['cuda']}}
        - listfile_name: cuda.list
        - signed_by: /etc/apt/keyrings/cuda-archive-keyring.gpg
        - signing_key_url: https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/3bf863cc.pub
        - dearmor: True
        - arch: amd64


cuda:
    pkg.installed:
        - pkgs:
            - cuda-toolkit
            - nvidia-kernel-open-dkms
            - nvidia-open
            - nvtop
        - install_recommends: False
        - require:
            - aptrepo: cuda-repo
