# ##################################################################################################
# Basic docker build of SDL_Core for use with Manticore:  https://github.com/smartdevicelink/sdl_core
# ##################################################################################################

# This image is based of debian with git preinstalled
FROM buildpack-deps:jessie-curl

MAINTAINER Chris Rokita version:1.0

ENV CORE_BRANCH=master \
    CORE_NETWORK_INTERFACE=eth0 

# Download SDL Core from github
WORKDIR /usr

RUN mkdir /usr/sdl_core \
    && curl -sSL https://github.com/smartdevicelink/sdl_core/archive/$CORE_BRANCH.tar.gz | tar -v -C /usr/sdl_core -xz --strip-components 1

RUN mkdir /usr/build

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \ 
        cmake \
        libudev-dev \
        libsqlite3-dev \
        libssl-dev \
        nginx \
        python \
        sudo \
        supervisor \
        sqlite3     

# Work inside the build folder
WORKDIR /usr/build

# Generate our Makefile, compile it and install
# Remove everything but what's inside the bin folder of the build directory to save space
RUN cmake -DBUILD_AVAHI_SUPPORT=OFF -DBUILD_USB_SUPPORT=OFF -DBUILD_BT_SUPPORT=OFF -DEXTENDED_MEDIA_MODE=OFF -DENABLE_HMI_PTU_DECRYPTION=OFF ../sdl_core \
    && make \
    && make install \
    && mv bin /usr/tmpbin \
    && rm -rf * \
    && mv /usr/tmpbin bin 
    
# Go to created bin directory
WORKDIR /usr/build/bin

# Copy SDL Core start script into container
COPY setup.sh setup.sh

ENV LD_LIBRARY_PATH /usr/build/bin/

# Configure logger
RUN ldconfig

# Delete default nginx configuration
RUN rm -v /etc/nginx/nginx.conf

# Copy new nginx configuration
COPY nginx.conf /etc/nginx

# Copy supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose the following ports
#   3001: Expose SDL Core's file system
#   8087:  Expose SDL Core's Web Socket port. Used to comunicate with the HMI
#   12345: Expose SDL Core's primary port. Used to communicate with the SDL Core instance over TCP
#   5050: Expose video streaming port
#   5080: Expose audio streaming port
#   8090: Expose time testing port
EXPOSE 3001 8087 12345 5050 5080 8090

# Run the start script that will launch SDL Core!
CMD ["/bin/bash", "setup.sh"]
