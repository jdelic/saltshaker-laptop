import re
import requests


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


def managed(name, version="latest", lang="en-US", icon=None, **kwargs):
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
        if_missing="/opt/{product}",
        require=require,
        **kwargs
    )
    _propagate_changes(ret, file_ret)

    if not icon:
        if __salt__['file.file_exists'](
                f"/opt/{product}/browser/chrome/icons/default/default128.png"):
            icon = "/opt/{product}/browser/chrome/icons/default/default128.png"
        elif __salt__['file.file_exists'](
                f"/opt/{product}/chrome/icons/default/default128.png"):
            icon = "/opt/{product}/chrome/icons/default/default128.png"
        else:
            _error(ret, f"Can't find a valid icon for {product}")
            return ret

    product_cap = product.capitalize()
    desktop_ret = __states__['file.managed'](
        name=f"/home/jonas/.local/share/applications/{product}.desktop",
        contents=f"""[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Exec=/opt/{product}/{product}-bin %u
Icon={icon}
Name={product_cap}
""",
        user="jonas",
        group="jonas",
        mode="0600",
    )
    _propagate_changes(ret, desktop_ret)

    return ret

