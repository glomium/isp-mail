exim4:

    pkg.installed:
        - pkgs:
            - exim4-daemon-heavy
            - postgresql-client
            - sa-exim
        - require:
            - sls: spamassassin
            - sls: clamav
    
    service.running:
        - enable: True
        - reload: True
        - require:
            - pkg: exim4
