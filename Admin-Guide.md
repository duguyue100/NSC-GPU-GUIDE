# Admin Guide

This guide is intended for helping current and future machine administrators.

__To future admin: DO NOT RECORD SECURITY INFO HERE.__

[![Ubuntu Version](https://img.shields.io/badge/Ubuntu-yellowgreen.svg)](https://launchpad.net/ubuntu/+mirror/releases.ubuntu.csg.uzh.ch-releases)
[![CUDA Version](https://img.shields.io/badge/CUDA-blue.svg)](https://developer.nvidia.com/cuda-downloads)
[![cuDNN Version](https://img.shields.io/badge/cuDNN-blue.svg)](https://developer.nvidia.com/cuda-downloads)
[![miniconda](https://img.shields.io/badge/miniconda-blue.svg)](https://docs.conda.io/en/latest/miniconda.html)

## Setup the machine

Before you start, ask yourself if you've backup the machine.

1. Download Ubuntu from the [website](https://ubuntu.com/#download). If you don't have a strong preference, download the latest LTS release.
2. Burn a bootable CD or flash disk by following the instructions.
3. Configure BIOS settings for booting order.
4. (Optional) Make sure you switch off the UEFI secure boot or enable driver compatibility so that 3rd party drivers can be installed properly.
5. Install the OpenSSH server if you are asked during the installation. Otherwise, install it after installation.
6. Install the system by following the rest of the instructions and restart the machine.

In principle, the SSH connection should work now.

## After Installation

1. Update the system

```bash
$ sudo apt update
$ sudo apt upgrade
```

__Reboot the machine__ after the upgrade.

2. Install build tools

```bash
$ sudo apt install build-essential binutils
```

__Reboot the machine__ after installation.

3. Install Utilities

    + CMake:

    ```bash
    $ sudo apt install cmake
    ```
    + (Optional) SSH

    ```bash
    $ sudo apt install openssh-server
    ```

    + Install the latest Git

    ```bash
    $ sudo apt-add-repository ppa:git-core/ppa
    $ sudo apt update
    $ sudo apt install git
    ```

    + (Optional) Docker Support (only for special purposes on servers). Docker is a runtime container system.

    Follow the guide [here](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository)

    + (Optional) Small utilities

    ```bash
    $ sudo apt install unzip
    $ sudo apt install exfat-fuse exfat-utils
    ```

Reboot the machine after installation.

## Install NVIDIA Graphics Driver

```bash
$ sudo add-apt-repository ppa:graphics-drivers/ppa
$ sudo apt update
$ sudo apt install nvidia-driver-xxx  # choose the driver version you need.
$ sudo apt install nvidia-modprobe  # for nvidia-docker
```

__Reboot the machine__ after installation.

_Note: There are a number of reasons that the driver installation doesn't works, you need to debug it case-by-case._

_Note: You can install the driver from the file that is available on the official website. However, play with caution._

## Install CUDA from `conda` (Recommended)

If you need CUDA, most likely you would like to some Deep Learning frameworks such as PyTorch.
And the easiest way possible to install the right CUDA version alongside PyTorch is to use
the `conda` package manager. Install `miniconda` from [here](https://docs.conda.io/en/latest/miniconda.html)

Then, just choose the version of PyTorch you would like to install
from [here](https://pytorch.org/get-started/previous-versions/).

## Install CUDA Manually

You could also install the CUDA manually from the official website.
The disadvantage of this approach is the cost of manual labor.
However, the advantage of this approach is that you can have a system-wide CUDA installation.
This could be useful when you want to compile some CUDA related projects.

Download Ubuntu __runfiles__ from [this link](https://developer.nvidia.com/cuda-toolkit-archive)

__DO NOT DOWNLOAD THE DEB__

```
$ sudo sh cuda_x.x.x_x.x.x_linux.run 
```

__NOTE__: Do not install the Nvidia driver again while installing CUDA because you've done the driver installation in the previous step.

### Install cuDNN

See [this link](https://developer.nvidia.com/rdp/form/cudnn-download-survey). Membership is required for download.

```bash
$ tar -zxvf cudnn-10.2-linux-x64-vx.x.x.x.tgz  # for cuda 10.2
$ cd cuda
$ sudo cp include/* /usr/local/cuda/include/
$ sudo cp lib64/* /usr/local/cuda/lib64/
```
