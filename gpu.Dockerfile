ARARG ML_ARCHITECTURE_VERSION=latest

FROM ubuntu:20.04 as base_build
FROM nvidia/cuda:11.2.1-base-ubuntu20.04

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHON_VERSION="3.8"
ENV CUDNN_VERSION=8.1.0.77
ENV TF_TENSORRT_VERSION=7.2.2
ENV CUDA=11.2
ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH

ARG ML_ARCHITECTURE_VERSION_GIT_BRANCH=master
ARG ML_ARCHITECTURE_VERSION_GIT_COMMIT=HEAD

LABEL maintainer=ronaldsonbellande@gmail.com
LABEL ml_architecture_github_branchtag=${ML_ARCHITECTURE_VERSION_GIT_BRANCH}
LABEL ml_architecture_github_commit=${ML_ARCHITECTURE_VERSION_GIT_COMMIT}

# Ubuntu setup
RUN apt-get update -y
RUN apt-get upgrade -y

# RUN workspace and sourcing
WORKDIR ./
COPY requirements.txt .

 # Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        apt-utils \
        automake \
        build-essential \
        ca-certificates \
        curl \
        git \
        python3-pip \
        libcurl3-dev \
        libfreetype6-dev \
        libpng-dev \
        libtool \
        libzmq3-dev \
        mlocate \
        openjdk-8-jdk\
        openjdk-8-jre-headless \
        pkg-config \
        python-dev \
        software-properties-common \
        swig \
        unzip \
        wget \
        zip \
        zlib1g-dev \
        python3-distutils \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Install python 3.8 and make primary 
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && apt-get install -y \
    python3.8 python3.8-dev python3-pip python3.8-venv && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1

# pip install 
RUN pip3 install --upgrade pip

RUN curl -fSsL -O https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py


# Install python libraries
RUN pip --no-cache-dir install -r requirements.txt


RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub && \
    apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        cuda-command-line-tools-11-2 \
        cuda-nvrtc-${CUDA/./-} \
        libcublas-11-2 \
        libcublas-dev-11-2 \
        libcufft-11-2 \
        libcurand-11-2 \
        libcusolver-11-2 \
        libcusparse-11-2 \
        libcudnn8=${CUDNN_VERSION}-1+cuda${CUDA} \
        libgomp1 \
        build-essential \
        curl \
        libfreetype6-dev \
        pkg-config \
        software-properties-common \
        unzip

# We don't install libnvinfer-dev since we don't need to build against TensorRT
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/7fa2af80.pub && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64 /"  > /etc/apt/sources.list.d/tensorRT.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends libnvinfer7=${TF_TENSORRT_VERSION}-1+cuda11.0 \
      libnvinfer-plugin7=${TF_TENSORRT_VERSION}-1+cuda11.0 \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*;

