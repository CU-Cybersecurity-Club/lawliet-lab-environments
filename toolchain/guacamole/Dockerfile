FROM guacamole/guacamole:latest

ARG GUACAMOLE_VERSION=1.1.0
ENV GUACAMOLE_HOME=/etc/guacamole

RUN mkdir -p "${GUACAMOLE_HOME}"

# Add 2FA extension to Guacamole
#RUN cd /tmp \
#    && wget "https://ftp.wayne.edu/apache/guacamole/1.1.0/binary/guacamole-auth-duo-${GUACAMOLE_VERSION}.tar.gz" \
#        --progress=bar:force \
#    && tar xf "guacamole-auth-duo-${GUACAMOLE_VERSION}.tar.gz" \
#    && mkdir -p "${GUACAMOLE_HOME}/extensions" \
#    && cd "guacamole-auth-duo-${GUACAMOLE_VERSION}" \
#    && mv "guacamole-auth-duo-${GUACAMOLE_VERSION}.jar" "${GUACAMOLE_HOME}/extensions" \
#
# Cleanup
#    && rm -rf guacamole*
