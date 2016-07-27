FROM ubuntu:14.04
MAINTAINER Cody Hiar <codyfh@gmail.com>

# Fix upstart errors
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# This prevents a bunch of errors during build
ENV DEBIAN_FRONTEND noninteractive

# Avoid ERROR: invoke-rc.d: policy-rc.d denied execution of start.
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

# Install packages
RUN apt-get update && apt-get install -y \
      software-properties-common \
      python-dev \
      python-pip \
      python3-dev \
      git \
      python3-pip

# Install Neovim
RUN add-apt-repository ppa:neovim-ppa/unstable -y
RUN apt-get update && apt-get install -y \
      neovim

# Install the neovim python plugins
RUN pip install neovim flake8 flake8-docstrings flake8-import-order flake8-quotes pep8 pep8-naming pep257
RUN pip3 install neovim

# Download my Neovim Repo
RUN git clone https://github.com/thornycrackers/.nvim.git /root/.config/nvim

# Install neovim Modules
RUN nvim +PlugInstall +qa
RUN nvim +UpdateRemotePlugins +qa

