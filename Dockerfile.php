FROM thornycrackers/neovim:python
MAINTAINER Cody Hiar <codyfh@gmail.com>

# Install packages
RUN apt-get update && apt-get install -y \
      curl \
      php5
      
# Download composer and move it to new location
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Update the path to include composer bins
ENV PATH "$PATH:/root/.composer/vendor/bin"

# Composer install Code Sniff
RUN composer global require "squizlabs/php_codesniffer=*"
# Install Symfony 2 coding standard
RUN composer global require --dev escapestudios/symfony2-coding-standard:~2.0

# Add Symfony 2 coding standard to the phpcs paths
RUN phpcs --config-set installed_paths /root/.composer/vendor/escapestudios/symfony2-coding-standard

# Install custom linting
ADD PEARish.xml /root/PEARish.xml
