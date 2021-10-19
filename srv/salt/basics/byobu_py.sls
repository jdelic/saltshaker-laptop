#!pydsl
# vim: syntax=python


def byobu(username, set_bashrc=True):
    st_byobu = state('byobu-%s' % username).cmd.run
    st_byobu.require(pkg='basesystem-packages')
    st_byobu(
        name='/usr/bin/byobu-launcher-install',
        runas=username,
        unless='grep -q byobu /home/%s/.profile' % username
    )

    st_byobu_tmux_config = state('byobu-%s-tmux-config' % username).file
    sbcm = st_byobu_tmux_config.managed(
        '/home/%s/.byobu/.tmux.conf' % username,
        source='salt://basics/tmux-user.conf',
        user=username,
        group=username,
        mode='644'
    )
    sbcm.require(cmd='byobu-%s' % username)

    st_byobu_status_config = state('byobu-%s-status-config' % username).file
    sbsc = st_byobu_status_config.managed(
        '/home/%s/.byobu/status' % username,
        source='salt://basics/status',
        user=username,
        group=username,
        mode='644'
    )
    sbsc.require(cmd='byobu-%s' % username)

    if set_bashrc:
        file_bashrc = state('/home/%s/.bashrc' % username).file
        file_bashrc.managed(
            source='salt://basics/bashrc',
            user=username,
            group=username,
            mode='640'
        )

for user in __pillar__['users']:
    if isinstance(user, str):
        byobu(user)
    else:
        raise ValueError("not a username string %s" % user)
