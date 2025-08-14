intellij-idea:
    intellij.installed:
        - user: {{list(pillar['users'].keys())[0]}}
        - group: {{list(pillar['users'].keys())[0]}}
