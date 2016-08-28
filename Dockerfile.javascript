FROM thornycrackers/neovim:php
MAINTAINER Cody Hiar <codyfh@gmail.com>

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
