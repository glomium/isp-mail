{% from 'emailhosting/map.jinja' import hosting with context %}
{% from 'exim/map.jinja' import config with context %}

/etc/exim4/sa-exim.conf:
  file.managed:
    - source:
      - salt://exim/files/sa-exim.conf
    - require:
      - pkg: exim4
    - watch_in:
      - service: exim4

{% if not config.root_alias %}
/etc/aliases:
  file.line:
    - content: root
    - match: "root:"
    - mode: delete
    - backup: False
    - show_changes: True
{% endif %}

{% if config.primary_hostname %}
/etc/mailname:
  file.managed:
    - require:
      - pkg: exim4
    - watch_in:
      - service: exim4
    - contents:
      - {{ config.primary_hostname }}
{% elif 'fqdn' in grains and grains['fqdn'] %}
/etc/mailname:
  file.managed:
    - require:
      - pkg: exim4
    - watch_in:
      - service: exim4
    - contents:
      - {{ grains['fqdn'] }}
{% endif%}

/etc/exim4/update-exim4.conf.conf:
  file.managed:
    - source:
      - salt://exim/files/update-exim4.conf.conf
    - template: jinja
    - defaults:
      config: {{ config }}
    - require:
      - pkg: exim4
    - watch_in:
      - service: exim4


/etc/exim4/conf.d:
  file.recurse:
    - source:
      - salt://exim/files/conf.d
    - clean: True
    - template: jinja
    - defaults:
      config: {{ config }}
      hosting: {{ hosting }}
    - require:
      - pkg: exim4
    - watch_in:
      - service: exim4


update-exim4.conf:
  cmd.wait:
    - name: "update-exim4.conf"
    - watch:
      - file: /etc/exim4/update-exim4.conf.conf
      - file: /etc/exim4/conf.d
    - watch_in:
      - service: exim4
