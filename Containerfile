FROM ghcr.io/ublue-os/kinoite-main:latest

LABEL org.opencontainers.image.title="LuhoodOS"
LABEL org.opencontainers.image.description="LuhoodOS Atomic KDE gaming image scaffold"
LABEL org.opencontainers.image.vendor="LuhoodOS"

COPY build_files /tmp/build_files

RUN bash /tmp/build_files/build.sh && rm -rf /tmp/build_files

RUN bootc container lint
