MAIN_DIR=$(pwd)
USE_SUDO=1
if [ $(dpkg -l | grep sudo | wc -l) -eq 0 ]; then
    USE_SUDO=0
fi

if [ ${USE_SUDO} -eq 1 ]; then
    sudo apt-get install -y \
        libgirepository1.0-dev \
        libgstreamer1.0-dev \
        libglib2.0-dev-bin \
        python3-gst-1.0 \
        build-essential \
        libglib2.0-dev \
        python-gi-dev \
        libcairo2-dev \
        python3.8-dev \
        python3-pip \
        python3-dev \
        python-dev \
        python3-gi \
        autoconf \
        automake \
        libtool \
        python3 \
        cmake \
        git \
        g++ \
        m4
else
    apt-get install -y \
        libgirepository1.0-dev \
        libgstreamer1.0-dev \
        libglib2.0-dev-bin \
        python3-gst-1.0 \
        build-essential \
        libglib2.0-dev \
        python-gi-dev \
        libcairo2-dev \
        python3.8-dev \
        python3-pip \
        python3-dev \
        python3-gi \
        python-dev \
        autoconf \
        automake \
        libtool \
        python3 \
        cmake \
        git \
        g++ \
        m4
fi

DS_MAIN_PATH=/opt/nvidia/deepstream/deepstream
DS_PY_PATH=${DS_MAIN_PATH}/sources/deepstream_python_apps

cd ${DS_MAIN_PATH}/sources

if [ ${USE_SUDO} -eq 1 ]; then
    sudo git clone https://github.com/NVIDIA-AI-IOT/deepstream_python_apps.git
else
    git clone https://github.com/NVIDIA-AI-IOT/deepstream_python_apps.git
fi

cd ${DS_PY_PATH}

if [ ${USE_SUDO} -eq 1 ]; then
    sudo git submodule update --init
else
    git submodule update --init
fi

# Installing Gst-python

if [ ${USE_SUDO} -eq 1 ]; then
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates
    
    sudo update-ca-certificates
else
    apt-get install -y \
        apt-transport-https \
        ca-certificates
    
    update-ca-certificates
fi

cd 3rdparty/gst-python/
./autogen.sh
make

if [ ${USE_SUDO} -eq 1 ]; then
    sudo make install
else
    make install
fi

# Build DeepStreamSDK python bindings

cd ${DS_PY_PATH}/bindings

if [ ${USE_SUDO} -eq 1 ]; then
    sudo git submodule update --init
    sudo rm -rf build
    sudo mkdir build
else
    git submodule update --init
    rm -rf build
    mkdir build
fi

cd build

if [ ${USE_SUDO} -eq 1 ]; then
    sudo cmake .. \
        -DPYTHON_MAJOR_VERSION=3 \
        -DPYTHON_MINOR_VERSION=8 \
        -DPIP_PLATFORM=linux_x86_64 \
        -DDS_PATH=/opt/nvidia/deepstream/deepstream

    sudo make -j$(nproc)
else
    cmake .. \
        -DPYTHON_MAJOR_VERSION=3 \
        -DPYTHON_MINOR_VERSION=8 \
        -DPIP_PLATFORM=linux_x86_64 \
        -DDS_PATH=/opt/nvidia/deepstream/deepstream

    make -j$(nproc)
fi

pip3 install --upgrade pip
pip3 install pyds*.whl

# Testing

echo "#####################################################"
echo "Testing..."
cd ${DS_PY_PATH}/apps/deepstream-test1
python3 deepstream_test_1.py ${DS_MAIN_PATH}/samples/streams/sample_720p.h264