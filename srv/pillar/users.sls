
users:
{% if salt['user.info']('vagrant') %}
    vagrant:
        gnupghome: /home/vagrant/.gnupg
{% else %}
    jonas:
        gnupghome: /home/jonas/jm/gpg
        install-uv: True
{% endif %}

sudoers:
{% if salt['user.info']('vagrant') %}
    - vagrant
{% else %}
    - jonas
{% endif %}
