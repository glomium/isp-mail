#!/usr/bin/python
# ex:set fileencoding=utf-8:

import getpass
import os
import socket

from fabric import task


DIR = os.path.dirname(__file__)
PYTHON = ".venv/bin/python3"

INSTALL = [
    "docker.io",
    "nmap",
    "ntp",
    "vim",
    "zip",
    "zram-config",
    "zsh",
]
PURGE = [
    "ceph",
    "cryptsetup",
    "lxcfs",
    "lxd",
    "lxd-client",
    "mdadm",
    "mlocate",
]


@task()
def deploy(c):
    # c.config["sudo"]["password"] = getpass.getpass()

    data = c.local("grep image: docker-compose.yaml | awk '{print $2}'").stdout.strip().splitlines()

    int_images = []
    ext_images = []
    for image in data:
        if image.endswith(":local"):
            int_images.append(image)
        else:
            ext_images.append(image)

    install = list(set(INSTALL))
    purge = list(set(PURGE))
    print(int_images)
    exit()

    c.sudo('DEBIAN_FRONTEND=noninteractive apt-get update -qq -y')
    c.sudo('DEBIAN_FRONTEND=noninteractive apt-get purge -qq -y %s' % ' '.join(purge))
    c.sudo('DEBIAN_FRONTEND=noninteractive apt-get upgrade -qq -y')
    c.sudo('DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -qq -y')
    c.sudo('DEBIAN_FRONTEND=noninteractive apt-get install -qq --no-install-recommends -y %s' % ' '.join(install))
    c.sudo('DEBIAN_FRONTEND=noninteractive apt-get autoremove --purge -qq -y')

    # c.sudo('timedatectl set-timezone Europe/Berlin')
    c.sudo('systemctl enable docker.service')

    swarmnode = c.sudo('docker info | grep Swarm | awk \'{print $2}\'').stdout.strip() == "active"
    if not swarmnode:
        c.sudo('docker swarm init --advertise-addr 127.0.0.1')
        c.sudo('systemctl restart docker.service')

    if int_images:
        tempfile_l = c.local("tempfile -s .tar", hide="both").stdout.strip()
        tempfile_r = c.local("tempfile -s .tar", hide="both").stdout.strip()
        c.local("docker image save -o %s %s" % (
            tempfile_l,
            " ".join(int_images),
        ))
        c.put(tempfile_l, tempfile_r)
        c.sudo("docker image load -i %s -q" % tempfile_r)
        c.local("rm %s" % tempfile_l)
        c.sudo("rm %s" % tempfile_r)

    for image in ext_images:
        c.sudo("docker image pull -q %s" % image)

    copy_file(c, "docker-compose.yaml", "/root/mail.yaml")
    c.sudo('docker stack deploy -c /root/mail.yaml mail')


def copy_file(c, source, target, user="root", group="root", mod="644"):
    tempfile = c.run("tempfile", hide="both").stdout.strip()
    with c.cd(DIR):
        c.put(source, tempfile)
    c.sudo('chown %s:%s %s' % (user, group, tempfile), hide='both')
    c.sudo('chmod %s %s' % (mod, tempfile), hide='both')
    c.sudo('mv %s %s' % (tempfile, target), hide='both')
