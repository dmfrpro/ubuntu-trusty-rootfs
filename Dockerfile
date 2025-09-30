FROM ubuntu:bionic

RUN dpkg --add-architecture i386 \
    && apt-get --assume-yes update \
    && apt-get --yes --force-yes dist-upgrade \
    && apt-get --assume-yes clean

RUN apt-get --assume-yes update \
    && apt-get --assume-yes install \
        software-properties-common \
    && dpkg-divert --local --add /etc/init.d/systemd-logind \
    && ln -s /bin/true /etc/init.d/systemd-logind \
    && add-apt-repository ppa:openjdk-r/ppa \
    && apt-get --assume-yes update \
    && apt-get --assume-yes install \
        openjdk-8-jdk \
        imagemagick \
        unicode \
        libswitch-perl \
        python-crypto \
        libncurses5-dev:i386 \
        libx11-dev:i386 \
        libreadline6-dev:i386 \
        libgl1-mesa-glx:i386 \
        zlib1g-dev:i386 \
        build-essential \
        schedtool \
        libssl-dev \
        bsdmainutils \
        vim \
        rsync \
        g++-multilib \
        gcc-multilib \
        git \
    && apt-get --assume-yes clean


RUN echo "ALL ALL=NOPASSWD: ALL" | tee /etc/sudoers \
    && sed -i 's/jdk.tls.disabledAlgorithms=SSLv3, /jdk.tls.disabledAlgorithms=/' \
    /etc/java-8-openjdk/security/java.security
