ruby:
    pkg.installed:
        - pkgs:
            - ruby
            - ruby-dev
        - install_recommends: False


fpm:
    gem.installed:
        - name: fpm
        - require:
            - pkg: ruby
