nvidia-driver:
    pkg.installed:
        - pkgs:
            - nvidia-driver
            - nvidia-cuda-mps
            - vulkan-tools
