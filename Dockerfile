FROM seniocaires/ubuntu-base

ENV DEBIAN_FRONTEND noninteractive

ENV DISPLAY=:1 \
    PORTA=5901 \
    HOME=/root \
    TERM=xterm \
    PATH_ENTRYPOINT=/start \
    COL_DEPTH=24 \
    RESOLUCAO=1280x1024 \
    SENHA=ubuntu-vnc \
    VIEW_ONLY=false

WORKDIR /$HOME

ADD start /start


RUN apt-get update && \
     apt-get install xubuntu-desktop wget nano curl wget gnome-system-monitor firefox flashplugin-installer -y && \
     wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.8.0.x86_64.tar.gz | tar xz --strip 1 -C / && \
     chmod +x /start/entrypoint.sh && \
     apt-get clean && \
     apt-get autoclean && \
     apt-get autoremove -y && \
     rm -rf /build && \
     rm -rf /tmp/* /var/tmp/* && \
     rm -rf /var/lib/apt/lists/* && \
     rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup


ADD [".config", "$HOME/.config"]


ENTRYPOINT ["/start/entrypoint.sh"]

EXPOSE $PORTA
