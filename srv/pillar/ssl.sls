# importable variables
{% set localca_links_location = '/etc/ssl/certs' %}
{% set localca_location = '/usr/share/ca-certificates/local' %}

# common ssl path config
# all certificate secrets are in the saltshaker-secrets git submodule
ssl:
    localca-links-location: {{localca_links_location}}
    localca-location: {{localca_location}}

    # certificates listed here will be installed and symlinked in the locations configured above
    install-ca-certs:
        - salt://basics/crypto/maurusnet-rootca.crt

