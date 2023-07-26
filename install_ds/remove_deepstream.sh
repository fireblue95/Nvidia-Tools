USE_SUDO=1
if [ $(dpkg -l | grep sudo | wc -l) -eq 0 ]; then
    USE_SUDO=0
fi

if [ ${USE_SUDO} -eq 1 ]; then
    if [ $(dpkg -l | grep deepstream* | wc -l) -ne 0 ]; then
       sudo apt remove --purge --autoremove -y deepstream-6.2
    fi

    sudo rm -rf /usr/local/deepstream \
        /usr/bin/deepstream* \
        /opt/nvidia/deepstream \
        /opt/nvidia/deepstream/deepstream* \
        /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libgstnv* \
        /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libnvdsgst* \
        /usr/lib/x86_64-linux-gnu/gstreamer-1.0/deepstream* \
        /usr/lib/x86_64-linux-gnu/libv41/plugins/libcuvidv4l2_plugin.so
else
    if [ $(dpkg -l | grep deepstream* | wc -l) -ne 0 ]; then
        apt remove --purge --autoremove -y deepstream-6.2
    fi

    rm -rf /usr/local/deepstream \
        /usr/bin/deepstream* \
        /opt/nvidia/deepstream \
        /opt/nvidia/deepstream/deepstream* \
        /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libgstnv* \
        /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libnvdsgst* \
        /usr/lib/x86_64-linux-gnu/gstreamer-1.0/deepstream* \
        /usr/lib/x86_64-linux-gnu/libv41/plugins/libcuvidv4l2_plugin.so
fi

echo "==============================="
echo "Remove Deepstream successfully."