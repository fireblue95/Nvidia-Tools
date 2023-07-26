lsmod | grep nouveau

cat <<EOF | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
blacklist nouveau
options nouveau modeset=0
EOF

sudo update-initramfs -u

echo "###############################################################"
echo "!!! Disable nouveau successfully. Please reboot the system. !!!"
echo "###############################################################"
