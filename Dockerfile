FROM oraclelinux:6
RUN yum clean all && \
  yum -y update && \
  yum -y upgrade && \
  yum -y install wget which git rsync yum-utils tar libXtst libXrender passwd sudo openjdk java-1.8.0-openjdk java-1.8.0-openjdk-devel xclock xorg-x11-utils

ENV DISPLAY :0
ENV XSOCK /tmp/.X11-unix
ENV XAUTH /tmp/.docker.xauth
ENV XAUTHORITY $XAUTH
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.65-0.b17.el6_7.x86_64

RUN /usr/sbin/groupadd -g 1000 human
RUN /usr/sbin/groupadd -g 999  shared
RUN /usr/sbin/useradd -u 1000 -g 1000 -G shared,root human
RUN /usr/bin/passwd -f -u human
RUN echo "human ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN /usr/bin/install -o 1000 -g 0 -m 0770 -d /Siebel_Install_Image

USER human
WORKDIR /mnt
ADD ./files/my_response_file.txt /tmp/my_response_file.txt
ADD ./files/bashrc /home/human/.bashrc
CMD /bin/bash

