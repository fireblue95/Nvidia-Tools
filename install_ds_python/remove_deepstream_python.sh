USE_SUDO=1
if [ $(dpkg -l | grep -c sudo) -eq 0 ]; then
    USE_SUDO=0
fi

DS_PY_PATH=/opt/nvidia/deepstream/deepstream/sources/deepstream_python_apps

if [ ${USE_SUDO} -eq 1 ]; then
    sudo rm -rf ${DS_PY_PATH}
    sudo apt remove --purge --autoremove -y apt-transport-https
else
    rm -rf ${DS_PY_PATH}
    apt remove --purge --autoremove -y apt-transport-https
fi

pip3 uninstall pyds