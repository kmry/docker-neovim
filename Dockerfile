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
      curl \
      python-dev \
      python-pip \
      python3-dev \
      python3-pip \
      git \
      php5

# Install Neovim
RUN add-apt-repository ppa:neovim-ppa/unstable -y
RUN apt-get update && apt-get install -y \
      neovim

#####################################
# Python Linting
#####################################

# Install the neovim python plugins
RUN pip install neovim flake8 flake8-docstrings flake8-import-order flake8-quotes pep8 pep8-naming pep257
RUN pip3 install neovim

# Download my Neovim Repo
RUN git clone https://github.com/thornycrackers/.nvim.git /root/.config/nvim

# Install neovim Modules
RUN nvim +PlugInstall +qa
RUN nvim +UpdateRemotePlugins +qa

#####################################
# Javscript Linting
#####################################

# Install nodejs 6
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y \
      nodejs

# Install JS linting modules
# The reason for the version specifications is an 'Unmet peerDependancy error'
# https://github.com/airbnb/javascript/issues/952
RUN npm install -g eslint@\^2.10.2 eslint-config-airbnb eslint-plugin-import eslint-plugin-react eslint-plugin-jsx-a11y@\^1.2.2

# Install the eslintrc.json
ADD eslintrc.json /root/.eslintrc.json

#####################################
# PHP Linting
#####################################

# Download composer and move it to new location
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Composer install Code Sniff
RUN composer global require "squizlabs/php_codesniffer=*"
# Install Symfony 2 coding standard
RUN composer global require --dev escapestudios/symfony2-coding-standard:~2.0

# Update the path to include composer bins
ENV PATH "$PATH:/root/.composer/vendor/bin"

# Add Symfony 2 coding standard to the phpcs paths
RUN phpcs --config-set installed_paths /root/.composer/vendor/escapestudios/symfony2-coding-standard

# Install custom linting
ADD PEARish.xml /root/PEARish.xml
