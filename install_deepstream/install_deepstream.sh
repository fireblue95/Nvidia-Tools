# Check nouveau status.

if [ $(lsmod | grep nouveau | wc -l) -ne 0 ]; then
    echo "nouveau is using, please run disable_nouveau.sh at first."
    exit 1
fi

# Install Dependencies

sudo apt install -y \
    libssl1.1 \
    libgstreamer1.0-0 \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    libgstreamer-plugins-base1.0-dev \
    libgstrtspserver-1.0-0 \
    libjansson4 \
    libyaml-cpp-dev \
    libjsoncpp-dev \
    protobuf-compiler \
    gcc \
    make \
    git \
    python3

# Install CUDA

sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt-get update
sudo apt-get install cuda-toolkit-11-8

# Install CUDA Driver

DRIVER_NAME=NVIDIA-Linux-x86_64-525.85.12.run

if [ ! -f ${DRIVER_NAME} ] || [ $(wc -c ${DRIVER_NAME} | awk '{print $1}') -ne 414496999 ]; then
    sudo rm -rf ${DRIVER_NAME}
    wget https://us.download.nvidia.com/tesla/525.85.12/${DRIVER_NAME}
fi

chmod 755 ${DRIVER_NAME}
sudo ./${DRIVER_NAME} --no-cc-version-check
sudo rm -rf ${DRIVER_NAME}

# Install TensorRT

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

# Install librdkafka (to enable Kafka protocol adaptor for message broker)

sudo rm -rf librdkafka
git clone https://github.com/edenhill/librdkafka.git
cd librdkafka
./configure
make -j$(nproc)
sudo make install

sudo mkdir -p /opt/nvidia/deepstream/deepstream-6.2/lib
sudo cp /usr/local/lib/librdkafka* /opt/nvidia/deepstream/deepstream-6.2/lib

# Install DeepStream SDK

DS_NAME=deepstream-6.2_6.2.0-1_amd64.deb

if [ ! -f ${DS_NAME} ] || [ $(wc -c ${DS_NAME} | awk '{print $1}') -ne 761429268 ]; then
    sudo rm -rf ${DS_NAME}
    wget https://developer.download.nvidia.com/assets/Deepstream/DeepStream_6.2/${DS_NAME}
fi

sudo apt-get install -y ./${DS_NAME}
sudo rm -rf ${DS_NAME}

echo "================================================================"
echo "Check path /opt/nvidia/deepstream/"
ls /opt/nvidia/deepstream/

echo "Installation finished."