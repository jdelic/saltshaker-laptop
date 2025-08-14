intellij-idea:
    intellij.installed:
        - user: {{(pillar['users'].keys()|list)[0]}}
        - group: {{(pillar['users'].keys()|list)[0]}}
