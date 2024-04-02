#!/usr/bin/bash
{% for script in accumulator["startup-scripts-%s" % user] %}
{{script}}
{% endfor %}

