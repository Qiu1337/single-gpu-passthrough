#!/bin/bash
set -x

killall hyprland
# sudo systemctl stop sddm.service

sleep 1

sudo modprobe -r nvidia_drm
sudo modprobe -r nvidia_uvm
sudo modprobe -r nvidia_modeset
sudo modprobe -r nvidia

echo 0 | sudo tee /sys/class/vtconsole/vtcon0/bind
echo 0 | sudo tee /sys/class/vtconsole/vtcon1/bind

echo efi-framebuffer.0 | sudo tee /sys/bus/platform/drivers/efi-framebuffer/unbind

sleep 1

sudo virsh nodedev-detach pci_0000_01_00_0
sudo virsh nodedev-detach pci_0000_01_00_1
sudo virsh nodedev-detach pci_0000_01_00_2
sudo virsh nodedev-detach pci_0000_01_00_3

sudo modprobe vfio-pci
# sudo modprobe vfio
# sudo modprobe vfio_iommu_type1
