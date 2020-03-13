#!/bin/sh

vncserver \
    -xstartup /etc/vnc/xstartup \
    -localhost no
tail -f /dev/null
