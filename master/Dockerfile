# ##################################################################################################
# Basic docker build of SDL_Core. Totally not stolen from https://github.com/smartdevicelink/sdl_core
# ##################################################################################################

# This image is based of debian with curl preinstalled
FROM buildpack-deps:jessie-curl

MAINTAINER Chris Rokita version:0.1

ENV SDL_CORE_BRANCH master
ENV SDL_CORE_NETWORK_INTERFACE eth0

# Create our working directory and Download SDL Core from github   
RUN mkdir /usr/sdl/ \
    && curl -sSL https://github.com/smartdevicelink/sdl_core/archive/$SDL_CORE_BRANCH.tar.gz \
    | tar -v -C /usr/sdl -xz --strip-components 1

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \ 
        cmake \
        libavahi-client-dev \
        libavahi-common-dev \
        libbluetooth-dev \
        libudev-dev \
        libusb-1.0-0-dev \
        libsqlite3-dev \
        libssl-dev \
        python \
        sudo \
        sqlite3     

# Change directory to the unpacked SDL Core sourcecode
WORKDIR /usr/sdl/

# Generate our Makefile, compile it and install
RUN cmake . \
    && make \
    && make install
    
# Copy required key and certification
RUN cp bin/mykey.pem src/appMain \ 
    && cp bin/mycert.pem src/appMain

# Change directory to the main folder for SDL Core
WORKDIR src/appMain/

# Copy SDL Core start script into container
COPY setup.sh setup.sh

ENV LD_LIBRARY_PATH /usr/sdl/bin/

# Configure logger
RUN ldconfig

# Expose the following ports
#   8087:  Expose SDL Core's Web Socket port. Used to comunicate with the HMI
#   12345: Expose SDL Core's primary port. Used to communicate with the SDL Core instance over TCP
#   5050: Expose video streaming port
#   5080: Expose audio streaming port
#   8090: Expose time testing port
EXPOSE 8087 12345 5050 5080 8090

# Run the start script that will launch SDL Core!
CMD ["/bin/bash", "setup.sh"]
