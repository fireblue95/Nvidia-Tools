lsmod | grep nouveau

cat <<EOF | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
blacklist nouveau
options nouveau modeset=0
EOF

sudo update-initramfs -u

# sudo service gdm stop
# sudo service lightdm stop
# sudo pkill -9 Xorg

echo "###############################################################"
echo "!!! Disable nouveau successfully. Please reboot the system. !!!"
echo "###############################################################"
