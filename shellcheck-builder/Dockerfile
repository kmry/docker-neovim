FROM rdeavila/docker-shellcheck:latest

# Get shellcheck binary
RUN mkdir -p /package/bin/
RUN cp ~/.cabal/bin/shellcheck /package/bin/

# Get shared libraries
RUN mkdir -p /package/lib/
RUN ldd ~/.cabal/bin/shellcheck | grep "=> /" | awk '{print $3}' | xargs -I '{}' cp -v '{}' /package/lib/

# Copy shellcheck package out to mounted directory
CMD ["cp", "-avr", "/package", "/mnt/"]
