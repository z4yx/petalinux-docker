FROM ubuntu:16.04

MAINTAINER z4yx <z4yx@users.noreply.github.com>

# build with docker build --build-arg PETA_VERSION=2018.1 --build-arg PETA_RUN_FILE=petalinux-v2018.1-final-installer.run -t petalinux:2018.1 .

#install dependences:
RUN sed -i.bak s/archive.ubuntu.com/mirror.tuna.tsinghua.edu.cn/g /etc/apt/sources.list && \
  dpkg --add-architecture i386 && apt-get update && apt-get install -y \
  tree \
  build-essential \
  bc \
  sudo \
  tofrodos \
  iproute2 \
  gawk \
  net-tools \
  expect \
  libncurses5-dev \
  tftpd \
  libssl-dev \
  flex \
  bison \
  libselinux1 \
  gnupg \
  wget \
  socat \
  gcc-multilib \
  libglib2.0-dev \
  lib32z1-dev \
  zlib1g:i386 \
  diffstat \
  gzip \
  unzip \
  cpio \
  chrpath \
  autoconf \
  lsb-release \
  libtool \
  libtool-bin \
  locales \
  kmod \
  git

ARG PETA_VERSION
ARG PETA_RUN_FILE

RUN locale-gen en_US.UTF-8 && update-locale

#make a Vivado user
RUN adduser --disabled-password --gecos '' vivado && \
  usermod -aG sudo vivado && \
  echo "vivado ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY accept-eula.sh ${PETA_RUN_FILE} /

# run the install
RUN chmod a+x /${PETA_RUN_FILE} && \
  mkdir -p /opt/Xilinx && \
  chmod 777 /tmp /opt /opt/Xilinx && \
  cd /tmp && \
  sudo -u vivado /accept-eula.sh /${PETA_RUN_FILE} /opt/Xilinx; \
  sudo -u vivado /opt/Xilinx/tools/yocto-sdk/petalinux-glibc-x86_64-buildtools-* -y -d /opt/Xilinx/tools/yocto-sdk

RUN rm -f /${PETA_RUN_FILE} /accept-eula.sh 

USER vivado
ENV HOME /home/vivado
ENV LANG en_US.UTF-8
RUN mkdir /home/vivado/project
WORKDIR /home/vivado/project

#add vivado tools to path
RUN echo "source /opt/Xilinx/settings.sh" >> /home/vivado/.bashrc

