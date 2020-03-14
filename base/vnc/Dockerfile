ARG FROM_IMAGE
FROM "${FROM_IMAGE}"

ENV TERM=xterm-256color

# Install TigerVNC and Xfce
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
        apt-get install -y \
            tigervnc-standalone-server \
            tigervnc-xorg-extension \
            openssl \
            sudo \
            xfce4 \
            xfce4-goodies \
    && apt-get purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Change x-terminal-emulator to /usr/bin/xfce4-terminal.wrapper so that we
# avoid "input/output error" when attempting to open a terminal in a VNC
# session.
RUN rm -f \
        $(which x-terminal-emulator) \
        /etc/alternatives/x-terminal-emulator \
    && ln -s \
        /usr/bin/gnome-terminal.wrapper \
        /usr/bin/x-terminal-emulator

# Add convenience scripts
COPY add-vnc-user.sh /usr/bin/add-vnc-user

# Create a new user to run the VNC server
RUN useradd -b /home -m -s /bin/bash myuser \
    && add-vnc-user myuser vncpass

# Add config files
RUN mkdir /etc/vnc
COPY xstartup /etc/vnc/
COPY vnc.conf /etc/vnc.conf
RUN chmod -R a-w /etc/vnc/
ADD x11 /etc/x11

# Expose VNC ports
EXPOSE 5901

USER myuser
WORKDIR /home/myuser
COPY --chown=myuser:myuser run.sh .

CMD [ "./run.sh" ]
