# DOCKER-VERSION 0.10.0
FROM base/archlinux:2018.05.01

# Configuration of the barebones system.
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm curl wget iproute2 supervisor tor
RUN useradd -m -U -s /bin/false tor

# Install and configure docker-gen.
ENV DOCKER_HOST unix:///tmp/docker.sock
ENV DOCKER_GEN_VERSION 0.7.1

EXPOSE 9001

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
&& rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

# Configure the system.
ADD torrc /etc/torrc
ADD torrc.docker-gen.tmpl /app/torrc.docker-gen.tmpl
ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD run.sh /app/bin/run.sh
RUN chmod 0755 /app/bin/run.sh

VOLUME ["/var/lib/tor/hidden_services"]

WORKDIR /app

ENTRYPOINT ["/app/bin/run.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
