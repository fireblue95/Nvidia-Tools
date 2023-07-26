# Check nouveau status.

if [ $(lsmod | grep nouveau | wc -l) -ne 0 ]; then
    echo "nouveau is using, please run disable_nouveau.sh at first."
    exit 1
fi

if [ "${1}" != "--out-dir" ] || [ "${2}" == "" ]; then
    echo "Please give parameter --out-dir"
    exit 1
fi

MAIN_DIR=${2}

if [ ! -d "${MAIN_DIR}" ]; then
    mkdir -p ${MAIN_DIR}
fi

cd ${MAIN_DIR}

USE_SUDO=1
if [ $(dpkg -l | grep sudo | wc -l) -eq 0 ]; then
    USE_SUDO=0
fi

# Install Dependencies

if [ ${USE_SUDO} -eq 1 ]; then
    sudo apt-get install -y \
        libgstreamer-plugins-base1.0-dev \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-ugly \
        gstreamer1.0-plugins-bad \
        libgstrtspserver-1.0-0 \
        gstreamer1.0-tools \
        gstreamer1.0-libav \
        libgstreamer1.0-0 \
        protobuf-compiler \
        libyaml-cpp-dev \
        libjsoncpp-dev \
        libjansson4 \
        libssl1.1 \
        python3 \
        make \
        gcc \
        git \
    
    sudo apt-get install -y \
        software-properties-common \
        wget
else
    apt-get install -y \
        libgstreamer-plugins-base1.0-dev \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-ugly \
        gstreamer1.0-plugins-bad \
        libgstrtspserver-1.0-0 \
        gstreamer1.0-tools \
        gstreamer1.0-libav \
        libgstreamer1.0-0 \
        protobuf-compiler \
        libyaml-cpp-dev \
        libjsoncpp-dev \
        libjansson4 \
        libssl1.1 \
        python3 \
        make \
        gcc \
        git \
    
    apt-get install -y \
        software-properties-common \
        wget
fi

# Install CUDA

if [ ${USE_SUDO} -eq 1 ]; then
    sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
    sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
    sudo apt-get update
    sudo apt-get install -y cuda-toolkit-11-8
else
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
    add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
    apt-get update
    apt-get install -y cuda-toolkit-11-8
fi

echo "export PATH=/usr/local/cuda-11.8/bin:\$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda-11.8/targets/x86_64-linux/lib/:\${LD_LIBRARY_PATH}" >> ~/.bashrc

# Install CUDA Driver

DRIVER_NAME=NVIDIA-Linux-x86_64-525.85.12.run

if [ ! -f ${DRIVER_NAME} ] || [ $(wc -c ${DRIVER_NAME} | awk '{print $1}') -ne 414496999 ]; then
    if [ ${USE_SUDO} -eq 1 ]; then
        sudo rm -rf ${DRIVER_NAME}
    else
        rm -rf ${DRIVER_NAME}
    fi
    wget https://us.download.nvidia.com/tesla/525.85.12/${DRIVER_NAME}
fi

if [ ${USE_SUDO} -eq 1 ]; then
    sudo chmod 755 ${DRIVER_NAME}
    sudo ./${DRIVER_NAME} --no-cc-version-check
    sudo rm -rf ${DRIVER_NAME}
else
    chmod 755 ${DRIVER_NAME}
    ./${DRIVER_NAME} --no-cc-version-check
    rm -rf ${DRIVER_NAME}
fi

# Install TensorRT

if [ ${USE_SUDO} -eq 1 ]; then
    sudo apt-get install -y \
        libnvinfer8=8.5.2-1+cuda11.8 \
        libnvinfer-plugin8=8.5.2-1+cuda11.8 \
        libnvinfer-bin=8.5.2-1+cuda11.8 \
        libnvinfer-dev=8.5.2-1+cuda11.8 \
        libnvinfer-plugin-dev=8.5.2-1+cuda11.8 \
        libnvinfer-samples=8.5.2-1+cuda11.8 \
        libnvparsers8=8.5.2-1+cuda11.8 \
        libnvparsers-dev=8.5.2-1+cuda11.8 \
        libnvonnxparsers8=8.5.2-1+cuda11.8 \
        libnvonnxparsers-dev=8.5.2-1+cuda11.8 \
        libcudnn8=8.7.0.84-1+cuda11.8 \
        libcudnn8-dev=8.7.0.84-1+cuda11.8 \
        python3-libnvinfer=8.5.2-1+cuda11.8 \
        python3-libnvinfer-dev=8.5.2-1+cuda11.8
else
    apt-get install -y \
        libnvinfer8=8.5.2-1+cuda11.8 \
        libnvinfer-plugin8=8.5.2-1+cuda11.8 \
        libnvinfer-bin=8.5.2-1+cuda11.8 \
        libnvinfer-dev=8.5.2-1+cuda11.8 \
        libnvinfer-plugin-dev=8.5.2-1+cuda11.8 \
        libnvinfer-samples=8.5.2-1+cuda11.8 \
        libnvparsers8=8.5.2-1+cuda11.8 \
        libnvparsers-dev=8.5.2-1+cuda11.8 \
        libnvonnxparsers8=8.5.2-1+cuda11.8 \
        libnvonnxparsers-dev=8.5.2-1+cuda11.8 \
        libcudnn8=8.7.0.84-1+cuda11.8 \
        libcudnn8-dev=8.7.0.84-1+cuda11.8 \
        python3-libnvinfer=8.5.2-1+cuda11.8 \
        python3-libnvinfer-dev=8.5.2-1+cuda11.8
fi

# Install librdkafka (to enable Kafka protocol adaptor for message broker)

if [ ${USE_SUDO} -eq 1 ]; then
    sudo rm -rf librdkafka
else
    rm -rf librdkafka
fi

git clone https://github.com/edenhill/librdkafka.git
cd librdkafka
./configure
make -j$(nproc)

if [ ${USE_SUDO} -eq 1 ]; then
    sudo make install

    sudo mkdir -p /opt/nvidia/deepstream/deepstream-6.2/lib
    sudo cp /usr/local/lib/librdkafka* /opt/nvidia/deepstream/deepstream-6.2/lib
else
    make install

    mkdir -p /opt/nvidia/deepstream/deepstream-6.2/lib
    cp /usr/local/lib/librdkafka* /opt/nvidia/deepstream/deepstream-6.2/lib
fi

cd ${MAIN_DIR}

# Install DeepStream SDK

DS_NAME=deepstream-6.2_6.2.0-1_amd64.deb

if [ ! -f ${DS_NAME} ] || [ $(wc -c ${DS_NAME} | awk '{print $1}') -ne 761429268 ]; then
    if [ ${USE_SUDO} -eq 1 ]; then
        sudo rm -rf ${DS_NAME}
    else
        rm -rf ${DS_NAME}
    fi
    wget https://developer.download.nvidia.com/assets/Deepstream/DeepStream_6.2/${DS_NAME}
fi

if [ ${USE_SUDO} -eq 1 ]; then
    sudo apt-get install -y ./${DS_NAME}
    sudo rm -rf ${DS_NAME}
else
    apt-get install -y ./${DS_NAME}
    rm -rf ${DS_NAME}
fi

echo "================================================================"
echo "Check path /opt/nvidia/deepstream/"
ls /opt/nvidia/deepstream/

echo "Installation finished."