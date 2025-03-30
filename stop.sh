#!/bin/bash
set -x

sudo modprobe -r vfio_pci
# modprobe -r vfio
# modprobe -r vfio_iommu_type1

sudo virsh nodedev-reattach pci_0000_01_00_0
sudo virsh nodedev-reattach pci_0000_01_00_1
sudo virsh nodedev-reattach pci_0000_01_00_2
sudo virsh nodedev-reattach pci_0000_01_00_3

echo 0000:01:00.0 | sudo tee /sys/bus/pci/drivers/vfio-pci/unbind
echo 0000:01:00.1 | sudo tee /sys/bus/pci/drivers/nvidia/bind

sudo modprobe nvidia
sudo modprobe nvidia_modeset
sudo modprobe nvidia_uvm
sudo modprobe nvidia_drm

echo 1 | sudo tee /sys/class/vtconsole/vtcon0/bind
# echo 1 > /sys/class/vtconsole/vtcon1/bind

# echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/bind
