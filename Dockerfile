FROM ubuntu:latest
MAINTAINER Maximilian N. Diefenbach <maximilian.diefenbach@tum.de>

## Install Dependencies
RUN apt-get update \
        && apt-get install -y build-essential \
        cmake \
        libboost-all-dev \
        fftw-dev \
        libhdf5-serial-dev \
        hdf5-tools \
        libxml2-dev \
        libxslt1-dev \
        unzip

RUN apt-get install -y git
RUN apt-get install -y emacs

# # Add files.
ADD root/install_bart.sh /root/install_bart.sh
# RUN cd /root && ./install_bart.sh

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root


# Define default command.
CMD ["bash"]
