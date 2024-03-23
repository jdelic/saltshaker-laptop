import os
import re
import requests
import configparser


def _propagate_changes(myret, theirret):
    if theirret["result"] is False and myret["result"]:
        myret["result"] = False
        myret["comment"] = "Substate %s failed with %s" % (theirret["name"], theirret['comment'])

    if theirret.get("changes", {}):
        myret["changes"][theirret["name"]] = theirret["changes"]
    if theirret.get("pchanges", {}):
        myret["pchanges"][theirret["name"]] = theirret["pchanges"]


def _error(ret, err_msg):
    ret['result'] = False
    ret['comment'] = err_msg
    return ret


def installed(name, target="/opt/idea", platform="linux", **kwargs):
    """
    Download the latest IntelliJ IDEA to /opt
    """

    ret = {
        "name": name,
        "changes": {},
        "pchanges": {},
        "result": True,
        "comment": "",
    }

    require = kwargs.get("require", None)

    resp = requests.get(
        f"https://data.services.jetbrains.com/products/releases?code=IIU&latest=true&type=release&build=",
        allow_redirects=False,
    )
    r = resp.json()['IIU'][0]['downloads'][platform]

    file_ret = __states__['archive.extracted'](
        name=target,
        source=r['link'],
        source_hash=r['checksumLink'],
        if_missing=target,
        enforce_toplevel=False,
        options="--strip-components=1",
        require=require,
        **kwargs
    )
    _propagate_changes(ret, file_ret)

    return ret

