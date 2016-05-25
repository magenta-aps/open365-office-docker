FROM    open365-base-with-dependencies

ADD     libreoffice-l10n-es_5.1.0~rc3-0ubuntu1~wily0_all.deb /root/libreoffice-l10n-es_5.1.0_all.deb
ADD     libreoffice-l10n-it_5.1.0_rc3.deb /root/libreoffice-l10n-it_5.1.0_rc3.deb
RUN     set -x ; \
        export DEBIAN_FRONTEND=noninteractive ; \
        apt-get update && apt-get install --no-install-recommends -y unzip curl

RUN     export DEBIAN_FRONTEND=noninteractive ; apt-get install --no-install-recommends -y libreoffice libreoffice-l10n-da && \
        dpkg -i /root/libreoffice-l10n-es_5.1.0_all.deb /root/libreoffice-l10n-it_5.1.0_rc3.deb

RUN     export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get -y autoremove \
            curl \
            g++ \
            gcc \
            netcat \
            netcat-openbsd \
            netcat-traditional \
            ngrep \
            strace \
            wget \
            && \
            apt-get clean && \
            rm -rf /car/lib/apt/lists/*

COPY    scripts/* /usr/bin/
COPY    libreoffice /etc/.skel/.config/libreoffice

# Install theme
COPY    Breeze-gtk.zip /root/
RUN     mkdir -p /usr/share/themes && cd /usr/share/themes && unzip /root/Breeze-gtk.zip && mv theme/Breeze-gtk ./ && rm -rf theme
COPY    gtk3Settings.ini /etc/gtk-3.0/settings.ini
COPY    disable-file-locking.xcd /usr/lib/libreoffice/share/registry/disable-file-locking.xcd
