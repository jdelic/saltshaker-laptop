import os
import re
import requests
import configparser


def _propagate_changes(myret, theirret):
    if theirret["result"] is False and myret["result"]:
        myret["result"] = False
        myret["comment"] = "Substate %s failed" % theirret["name"]

    if theirret.get("changes", {}):
        myret["changes"][theirret["name"]] = theirret["changes"]
    if theirret.get("pchanges", {}):
        myret["pchanges"][theirret["name"]] = theirret["pchanges"]


def _error(ret, err_msg):
    ret['result'] = False
    ret['comment'] = err_msg
    return ret


def installed(name, product=None, version="latest", lang="en-US", **kwargs):
    """
    Download the latest product (firefox or thunderbird) to /opt
    """

    ret = {
        "name": name,
        "changes": {},
        "pchanges": {},
        "result": True,
        "comment": "",
    }
    if not product:
        product = name

    require = kwargs.get("require", None)

    ver = version
    fn = f"{product}-{version}.tar.bz2"
    if version == "latest":
        resp = requests.head(
            f"https://download.mozilla.org/?product={product}-latest-ssl&os=linux64&lang=en-US",
            allow_redirects=False
        )

        if resp.status_code != 302:
            _error(ret,
                   f"Expected Mozilla download server to send a redirect ({resp.status_code})")
            return ret

        from urllib.parse import urlparse
        up = urlparse(resp.headers["location"])
        fn = __salt__['file.basename'](up.path)

        vr = re.match(rf'{product}-([0-9]+\.[0-9]+\.?[0-9]*)\.tar\.bz2', fn)
        if not vr:
            _error(ret, "Expected Mozilla download to contain a valid version %s = %s" %
                   (resp.url, fn))
            return ret

        ver = vr.group(1)

    # right now, we don't template the OS part, because download.mozilla.org uses
    # linux64 as an alias for linux-x86_64 and handling that would be complicated and
    # I wouldn't use this state on anything BUT linux64, so I didn't bother.
    fileurl = f"https://download-installer.cdn.mozilla.net/pub/{product}/releases/{ver}/linux-x86_64/{lang}/{fn}"
    hashurl = f"https://download-installer.cdn.mozilla.net/pub/{product}/releases/{ver}/SHA256SUMS"

    file_ret = __states__['archive.extracted'](
        name="/opt",
        source=fileurl,
        source_hash=hashurl,
        source_hash_name=f"linux-x86_64/{lang}/{fn}",
        if_missing=f"/opt/{product}",
        require=require,
        **kwargs
    )
    _propagate_changes(ret, file_ret)
    return ret


def desktop(name, user, group, gtk_theme_override=None, product=None, icon=None, **kwargs):
    """
    add a .desktop file in /home/{user}/.local/share/applications/{name}
    :param name:
    :param version:
    :param lang:
    :param icon:
    :param kwargs:
    :return:
    """

    ret = {
        "name": name,
        "changes": {},
        "pchanges": {},
        "result": True,
        "comment": "",
    }
    if not product:
        product = name

    require = kwargs.get("require", None)

    if not icon:
        if __salt__['file.file_exists'](
                f"/opt/{product}/browser/chrome/icons/default/default128.png"):
            icon = f"/opt/{product}/browser/chrome/icons/default/default128.png"
        elif __salt__['file.file_exists'](
                f"/opt/{product}/chrome/icons/default/default128.png"):
            icon = f"/opt/{product}/chrome/icons/default/default128.png"
        else:
            _error(ret, f"Can't find a valid icon for {product}")
            return ret

    info = __salt__['user.info'](user)
    if not info or "home" not in info:
        _error(ret, "User %s appears to not exist on this system or doesn't have a home" % user)
        return ret

    homedir = info["home"]

    product_cap = product.capitalize()
    cmdline = f"/opt/{product}/{product}-bin %u"
    if gtk_theme_override:
        cmdline = f"env GTK_THEME={gtk_theme_override} {cmdline}"
    desktop_ret = __states__['file.managed'](
        name=os.path.join(homedir, ".local", "share", "applications", f"{product}.desktop"),
        contents=f"""[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Exec={cmdline}
Icon={icon}
Name={product_cap}
""",
        user=user,
        group=group,
        mode="0600",
        require=require,
        **kwargs
    )
    _propagate_changes(ret, desktop_ret)

    return ret


def file(username, path, profile=None, **kwargs):
    """
    Allows you to drop a file into the user profile. Linux only!
    """

    ret = {
        "name": kwargs["name"] if "name" in kwargs else username,
        "changes": {},
        "pchanges": {},
        "result": True,
        "comment": "",
    }

    if path.startswith("/") or path.startswith("\\"):
        _error(ret, "Do not set absolute paths on mozilla.file. 'path' is relative to the "
                    "user's profile folder.")
        return ret

    info = __salt__['user.info'](username)
    if not info or "home" not in info:
        _error(ret, "User %s appears to not exist on this system or doesn't have a home" % username)
        return ret

    homedir = info["home"]
    firefoxdir = os.path.join(homedir, ".mozilla", "firefox")
    if not os.path.exists(os.path.join(firefoxdir, "profiles.ini")):
        _error(ret, "Can't find user's firefox profiles folder in %s" % 
                    os.path.join(firefoxdir, "profiles.ini"))
        return ret

    config = configparser.ConfigParser()
    config.read(os.path.join(firefoxdir, "profiles.ini"))
    
    profiledir = None
    userprofile = None

    if profile:
        if profile in config.sections():
            if not "path" in config[profile]:
                _error(ret, "Profile %s has no path" % profile)
                return ret
            userprofile = profile
            profiledir = os.path.join(firefoxdir, config[profile]["path"])
        else:
            for p in config.sections():
                if "path" in config[profile] and profile == config[profile]["path"]:
                    userprofile = p
                    profiledir = os.path.join(firefoxdir, profile)
                    break
    else:
        for s in config.sections():
            if s.startswith("profile") and profiledir and "path" in config[s]:
                _error(ret, "profiles.ini contains more than one profile. Please specify the profile "
                            "name in mozilla.file")
                return ret
            else:
                if "path" in config[s]:
                    userprofile = s
                    profiledir = os.path.join(firefoxdir, config[s]["path"])

    if not userprofile or not profiledir:
        _error(ret, "mozilla.file was unable to find a valid profile")
        return ret

    kwargs["name"] = os.path.join(profiledir, path)

    file_ret = __states__['file.managed'](
        **kwargs,
    )
    _propagate_changes(ret, file_ret)
    return ret
