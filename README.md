[![noswpatv3](http://zoobab.wdfiles.com/local--files/start/noupcv3.jpg)](https://ffii.org/donate-now-to-save-europe-from-software-patents-says-ffii/)
A static screen for coreos
==========================

This is screen compiled statically for CoreOS. CoreOS does not have screen, so
it is a bit painfull to have long lasting jobs **without** using a
container, which many disadvantages.

You can build the whole thing with ./build.sh, and you should end up with a
static binary in:

    $ file bin/screen 
    bin/screen: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=1e30fe78feb9d9893cbec412e2d9a176a5d2501c, not stripped

How to run it
=============

As user core, download the screen binary:

    $ whoami
    core
    $ pwd
    /home/core
    $ wget https://github.com/zoobab/screen-static-coreos/raw/master/bin/screen

Then make it executable:

    $ chmod +x screen

Then you can run:

    $ ./screen -dm ping 127.0.0.1

List the sessions:

    $ ./screen -ls

SSHD kills processes
====================

Somehow SSHD or SystemD kills the processes once you leave the SSH session.

This is due to the "ClientAliveInterval" SSHD parameter in /etc/ssh/sshd_config:
    
    $ sudo cat /etc/ssh/sshd_config 
    # Use most defaults for sshd configuration.
    UsePrivilegeSeparation sandbox
    Subsystem sftp internal-sftp
    ClientAliveInterval 180
    UseDNS no

If you remove it (CoreOS is read-only :-) and just run an SSH server on another
port without this option, my experience shows that screen sessions are not killed.

Another solution
================

If sudo allows it, you can run systemd-run (see examples for screen here: https://www.freedesktop.org/software/systemd/man/systemd-run.html):

    $ sudo systemd-run --scope  /home/core/screen bash

Then detach with CTRL+A+D.

To list the sessions:

    $ sudo systemd-run --scope  /home/core/screen -ls
    Running scope as unit run-27936.scope.
    There is a screen on:
        27817.pts-0.hostname (Detached)
    1 Socket in /tmp/screens/S-root.

You can also launch a session directly as core user instead of root:

    $ sudo systemd-run --scope  /home/core/screen bash -c "su - core"
    Update Strategy: No Reboots
    core@registry00-k8s1 ~ $ whoami
    core
    core@registry00-k8s1 ~ $
