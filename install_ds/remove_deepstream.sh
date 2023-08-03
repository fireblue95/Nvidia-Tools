USE_SUDO=1
if [ $(dpkg -l | grep -c sudo) -eq 0 ]; then
    USE_SUDO=0
fi

if [ "${1}" == "-h" ] || [ "${1}" == "--help" ]; then
    echo "Usage:"
    echo "       bash remove_deepstream.sh <option>"
    echo "option - "
    echo "       --tensorrt - To remove the TensorRT 8.5.2.2."
    exit 0
fi

DS_EXISTS=$(dpkg -l | grep -c deepstream*)

if [ ${USE_SUDO} -eq 1 ]; then
    if [ ${DS_EXISTS} -ne 0 ]; then
       sudo apt remove --purge --autoremove -y deepstream-6.2
    fi

    sudo rm -rf \
        /usr/bin/deepstream* \
        /usr/local/deepstream \
        /opt/nvidia/deepstream \
        /usr/local/lib/librdkafka* \
        /opt/nvidia/deepstream/deepstream* \
        /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libgstnv* \
        /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libnvdsgst* \
        /usr/lib/x86_64-linux-gnu/gstreamer-1.0/deepstream* \
        /usr/lib/x86_64-linux-gnu/libv41/plugins/libcuvidv4l2_plugin.so
    
    if [ "${1}" == "--tensorrt" ]; then
        sudo apt-get remove --autoremove --purge -y \
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
else
    if [ ${DS_EXISTS} -ne 0 ]; then
        apt remove --purge --autoremove -y deepstream-6.2
    fi

    rm -rf \
        /usr/bin/deepstream* \
        /usr/local/deepstream \
        /opt/nvidia/deepstream \
        /usr/local/lib/librdkafka* \
        /opt/nvidia/deepstream/deepstream* \
        /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libgstnv* \
        /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libnvdsgst* \
        /usr/lib/x86_64-linux-gnu/gstreamer-1.0/deepstream* \
        /usr/lib/x86_64-linux-gnu/libv41/plugins/libcuvidv4l2_plugin.so
    
    if [ "${1}" == "--tensorrt" ]; then
        apt-get remove --autoremove --purge -y \
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
fi

echo "==============================="
echo "Remove Deepstream successfully."