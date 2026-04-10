
users:
{% if salt['user.info']('vagrant') %}
    vagrant:
        gnupghome: /home/vagrant/.gnupg
{% else %}
    jonas:
        gnupghome: /home/jonas/jm/gpg
        install-uv: True

        # the following are only used for headless installs
        groups:
            - jonas
            - sudo
            - gpg-access
        password: '$6$tYAeNeVWVCfZUfEw$cf8uCuhYJWy2S.6LeJzMlNQU86UV9.DwlmNmNKbv2fXyo78kItXw03DZAT3mmBVJDTnEeydJJqdawiAVS1hh6.'
        ssh_keys:
            - 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHS6w4Jzel7ef0jxiLG7s+8hvOaDx0SLWXr9PhC3ZnIb jonas@hades'
            - 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINuRkuMdRdZ8aNZu6X8qlAfrVWbRP2Bi9M96I2zdZ31O jonas@parasite'
            - 'sk-ecdsa-sha2-nistp256@openssh.com AAAAInNrLWVjZHNhLXNoYTItbmlzdHAyNTZAb3BlbnNzaC5jb20AAAAIbmlzdHAyNTYAAABBBKvJ8nPel1Lojsdpv0eTxQHyXok2KnRRmmAuzZxmBtcK9WAhTMoDRkXJ01ZE6pOGVfVQIPjmpqqp+RxVYtM1cmsAAAALdGVybWl1cy5jb20= jm cardno:23497472'
        enable_byobu: True
  {% endif %}

sudoers:
{% if salt['user.info']('vagrant') %}
    - vagrant
{% else %}
    - jonas
{% endif %}
