# Dockerfile to build container with MRI tools
#
# $ docker image build -t <image_name>[:<tag>] .
# $ docker run -ti <image_name>[:<tag>]
# $ docker tag <image_name> <dockerhub_account>/<image_name>
# $ docker push <dockerhub_account>/<image_name>

FROM ubuntu:latest
MAINTAINER Maximilian N. Diefenbach <maximilian.diefenbach@tum.de>

# Set environment variables.
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Define default command.
CMD ["bash"]

# Define working directory.
WORKDIR /root

# apt
RUN apt-get update
RUN apt-get install -y apt-utils

RUN apt-get install -y build-essential \
        gcc make cmake

RUN apt-get install -y curl wget

# git
RUN apt-get install -y git

# emacs
RUN apt-get install -y emacs

# vim
RUN apt-get install -y vim

# bashrc
ADD ./root/bashrc.sh ~/.bashrc

# python (anaconda3)
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH
RUN apt-get update --fix-missing && apt-get install -y wget bzip2 \
        ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 \
        git mercurial subversion

RUN wget --quiet \
        https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh -O \
        ~/anaconda.sh && \
        /bin/bash ~/anaconda.sh -b -p /opt/conda && \
        rm ~/anaconda.sh && \
        ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
        echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
        echo "conda activate base" >> ~/.bashrc

# update python packages
RUN conda update --all

# install useful python packages
RUN pip install pydicom nibabel SimpleITK matplotlib2tikz
# RUN tensorflow keras # wait for tersorflow 2.0 compatible with python 3.7

# ismrmrd
ADD root/install_ismrmrd.sh /root/
RUN ./install_ismrmrd.sh

# ismrmrd-python
RUN git clone https://github.com/ismrmrd/ismrmrd-python ismrmrd-python && \
        cd ismrmrd-python && \
        pip install pyxb && \
        pip install . && \
        cd ..

# ismrmrd-python-tools
RUN git clone https://github.com/ismrmrd/ismrmrd-python-tools ismrmrd-python-tools && \
        cd ismrmrd-python && \
        pip install . && \
        cd ..

# philips_to_ismrmrd
RUN git clone https://github.com/ismrmrd/philips_to_ismrmrd && \
        cd philips_to_ismrmrd  && \
        mkdir build && \
        cd build && \
        cmake .. && \
        make install && \
        cd .. && \
        rm -rf build

# bart
ADD root/install_bart.sh /root/
RUN ./install_bart.sh

# dcm2niix
RUN apt-get install -y dcm2niix
