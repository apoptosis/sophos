FROM ubuntu:latest

MAINTAINER Renzo Kottmann <rkottman@mpi-bremen.de>

RUN apt-get update && \
    apt-get install --assume-yes \
       emacs-nox \
       emacs-goodies-el \
       git

# copying init file
COPY etc/build.el /etc/build.el
COPY src/core /src/core
COPY src/plugins /src/plugins

RUN mkdir -p /sophos/sophoslib

RUN /usr/bin/emacs --batch -q -l /etc/build.el --eval "(build-all \"/sophos/sophoslib/\")"

WORKDIR /sophos

COPY etc/boot.el /sophos/boot.el
COPY startup.el /sophos/startup.el

VOLUME "/root/.emacs.d/"

CMD ["/usr/bin/emacs", "--script", "boot.el"]
