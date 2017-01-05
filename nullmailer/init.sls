{% from 'nullmailer/map.jinja' import nullmailer_settings with context %}

/etc/nullmailer:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/etc/nullmailer/me:
  file.managed:
    - contents: {{ nullmailer_settings.me }}
    - user: root
    - group: root
    - mode: 644

/etc/nullmailer/adminaddr:
  file.managed:
    - contents: {{ nullmailer_settings.adminaddr }}
    - user: root
    - group: root
    - mode: 644

/etc/nullmailer/defaultdomain:
  file.managed:
    - contents: {{ nullmailer_settings.defaultdomain }}
    - user: root
    - group: root
    - mode: 644

/etc/nullmailer/remotes:
  file.managed:
    - source: salt://nullmailer/files/remotes
    - user: {{ nullmailer_settings.user }}
    - group: {{ nullmailer_settings.group }}
    - mode: 600
    - template: jinja

nullmailer:
  pkg.installed:
    - name: {{ nullmailer_settings.pkg }}
  service.running:
    - enable: True
    - name: {{ nullmailer_settings.service }}
    - require:
      - pkg: nullmailer

